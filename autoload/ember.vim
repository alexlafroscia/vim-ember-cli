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

  " Execute the command
  if exists(':Make') == 2
    exe 'Make'
  else
    exe 'make'
  endif

  " Restore previous behavior
  let &makeprg = default_makeprg
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

function! ember#InstallAddon(name)
  call s:makeAndSwitch('ember install', a:name)
endfunction

function! ember#NpmInstall(...)
  call s:makeAndSwitch('npm install')
endfunction
" }}}1

