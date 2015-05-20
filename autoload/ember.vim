" autoload/ember.vim
" Author: Alex LaFroscia

if exists('g:autoloaded_ember') || &cp
  finish
endif
let g:autoloaded_ember = 1

" Utility Functions {{{1

function! s:makeAndSwitch(command, ...)
  let default_makeprg = &makeprg
  let args = join(a:000, " ")

  " Run command with arguments
  if !len(a:000)
    let &makeprg = a:command
  else
    let &makeprg = a:command . " " . args
  endif

  echom &makeprg

  " Execute the command
  if exists(':Make') == 2
    exe 'Make'
  else
    exe 'make'
  endif

  " Restore previous behavior
  let &makeprg = default_makeprg
endfunction

let s:generator_types = [
  \ 'acceptance-test',
  \ 'adapter',
  \ 'adapter-test',
  \ 'addon',
  \ 'addon-import',
  \ 'app',
  \ 'blueprint',
  \ 'component',
  \ 'component-addon',
  \ 'component-test',
  \ 'controller',
  \ 'controller-test',
  \ 'helper',
  \ 'helper-addon',
  \ 'helper-test',
  \ 'http-mock',
  \ 'http-proxy',
  \ 'in-repo-addon',
  \ 'initializer',
  \ 'initializer-addon',
  \ 'initializer-test',
  \ 'lib',
  \ 'mixin',
  \ 'mixin-test',
  \ 'model',
  \ 'model-test',
  \ 'resource',
  \ 'route',
  \ 'route-test',
  \ 'serializer',
  \ 'serializer-test',
  \ 'server',
  \ 'service',
  \ 'service-test',
  \ 'template',
  \ 'test-helper',
  \ 'transform',
  \ 'transform-test',
  \ 'util',
  \ 'util-test',
  \ 'view',
  \ 'view-test'
  \ ]

" Break getting the generator types out into a separate function so that it can
" eventually be made dynamic without having to re-write other parts of the code
function! s:get_generator_types()
  return s:generator_types
endfunction

" Given a type, return the directory name associated with it
function! s:get_directory_for_type(type)
  return a:type . 's'
endfunction

" Given a type, return a list of the names of all the files of that type
"   Example: arg -> 'controller'
"   Return:  ['users/user']
function! s:get_files_for_type(type)
  let path = b:ember_root . '/app/' . s:get_directory_for_type(a:type)
  let files = split(globpath(path, '**/*.js'), '\n')
  let relative_files = []
  for file in files
    let relative_files += [file[strlen(path . '/') : -strlen('.js') - 1]]
  endfor
  return relative_files
endfunction

" Filter a list for completion results | Shamelessly borrowed from rails.vim
" https://github.com/tpope/vim-rails/blob/12addfcaf5ce97632adbb756bea76cb970dea002/autoload/rails.vim#L2522-L2543
function! s:completion_filter(results, A, ...) abort
  let results = s:uniq(sort(type(a:results) == type("") ? split(a:results,"\n") : copy(a:results)))
  call filter(results,'v:val !~# "\\~$"')
  if a:A =~# '\*'
    let regex = s:gsub(a:A,'\*','.*')
    return filter(copy(results),'v:val =~# "^".regex')
  endif
  let filtered = filter(copy(results),'s:startswith(v:val,a:A)')
  if !empty(filtered) | return filtered | endif
  let prefix = s:sub(a:A,'(.*[/]|^)','&_')
  let filtered = filter(copy(results),"s:startswith(v:val,prefix)")
  if !empty(filtered) | return filtered | endif
  let regex = s:gsub(a:A,'[^/]','[&].*')
  let filtered = filter(copy(results),'v:val =~# "^".regex')
  if !empty(filtered) | return filtered | endif
  let regex = s:gsub(a:A,'.','[&].*')
  let filtered = filter(copy(results),'v:val =~# regex')
  return filtered
endfunction

" Remove duplicates from list | Shamelessly borrowed from rails.vim
" https://github.com/tpope/vim-rails/blob/12addfcaf5ce97632adbb756bea76cb970dea002/autoload/rails.vim#L44-L59
function! s:uniq(list) abort
  let i = 0
  let seen = {}
  while i < len(a:list)
    if (a:list[i] ==# '' && exists('empty')) || has_key(seen,a:list[i])
      call remove(a:list,i)
    elseif a:list[i] ==# ''
      let i += 1
      let empty = 1
    else
      let seen[a:list[i]] = 1
      let i += 1
    endif
  endwhile
  return a:list
endfunction

" Does some string start with some prefix? | Shamelessly borrowed from rails.vim
" https://github.com/tpope/vim-rails/blob/12addfcaf5ce97632adbb756bea76cb970dea002/autoload/rails.vim#L36-L38
function! s:startswith(string,prefix)
  return strpart(a:string, 0, strlen(a:prefix)) ==# a:prefix
endfunction

" sub | Shamelessly borrowed from rails.vim
" https://github.com/tpope/vim-rails/blob/12addfcaf5ce97632adbb756bea76cb970dea002/autoload/rails.vim#L28-L30
function! s:sub(str,pat,rep)
  return substitute(a:str,'\v\C'.a:pat,a:rep,'')
endfunction

" gsub | Shamelessly borrowed from rails.vim
" https://github.com/tpope/vim-rails/blob/12addfcaf5ce97632adbb756bea76cb970dea002/autoload/rails.vim#L32-L34
function! s:gsub(str,pat,rep)
  return substitute(a:str,'\v\C'.a:pat,a:rep,'g')
endfunction

" }}}1
" Completion Functions {{{1

" Completion function for Ember types
function! ember#complete_class(ArgLead, CmdLine, CursorPos)
  let types = s:get_generator_types()
  return s:completion_filter(types, a:ArgLead)
endfunction

" Completion function for Ember types and, if the prompt already contains the
" type, the file names associated with that type
function! ember#complete_class_and_name(ArgLead, CmdLine, CursorPos)
  let types = s:get_generator_types()
  let type = get(split(a:CmdLine, ' '), 1, '')
  if index(types, type) >= 0
    let files = s:get_files_for_type(type)
    return s:completion_filter(files, a:ArgLead)
  endif
  return s:completion_filter(types, a:ArgLead)
endfunction

" }}}1
" User Functions {{{1

function! ember#Generate(type, name)
  call s:makeAndSwitch('ember generate', a:type, a:name)
endfunction

function! ember#Destroy(type, name)
  call s:makeAndSwitch('ember destroy', a:type, a:name)
endfunction

function! ember#Test(bang, ...)
  if a:bang
    call s:makeAndSwitch('ember test --serve')
  else
    call s:makeAndSwitch('ember test')
  endif
endfunction

function! ember#Server(...)
  if len(a:000)
    call s:makeAndSwitch('ember server', join(a:000, ' '))
  else
    call s:makeAndSwitch('ember server')
  endif
endfunction

function! ember#Build(...)
  if len(a:000)
    call s:makeAndSwitch('ember build', join(a:000, ' '))
  else
    call s:makeAndSwitch('ember build')
  endif
endfunction

function! ember#InstallAddon(name)
  call s:makeAndSwitch('ember install', a:name)
endfunction

function! ember#NpmInstall(...)
  call s:makeAndSwitch('npm install')
endfunction
" }}}1

