" plugin/ember.vim
" Author: Alex LaFroscia

" Detection {{{1

function! s:EmberCliDetect(...) abort
  if exists('b:ember_root')
    return 1
  endif
  let file = findfile('.ember-cli', '.;')
  if !empty(file) && isdirectory(fnamemodify(file, ':p:h') . '/app')
    let b:ember_root = fnamemodify(file, ':p:h')
    return 1
  endif
endfunction

" }}}1
" Initialization {{{1

if !s:EmberCliDetect()
  finish
endif

if !exists('g:loaded_projectionist')
  runtime! plugin/projectionist.vim
endif

" }}}1
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
" Public Functions {{{1

function! EmberCliGenerate(type, name)
  call s:makeAndSwitch('ember generate', a:type, a:name)
endfunction

function! EmberCliDestroy(type, name)
  call s:makeAndSwitch('ember destroy', a:type, a:name)
endfunction

function! EmberCliTest(bang, ...)
  if a:bang
    call s:makeAndSwitch('ember test --serve')
  else
    call s:makeAndSwitch('ember test')
  endif
endfunction

function! EmberCliAddonInstall(name)
  call s:makeAndSwitch('ember install', a:name)
endfunction

function! NpmInstall(...)
  call s:makeAndSwitch('npm install')
endfunction

" }}}1
" Public API {{{1
command -nargs=+ EmberGen call EmberCliGenerate(<f-args>)
command -nargs=+ EmberDestroy call EmberCliDestroy(<f-args>)
command -nargs=0 -bang EmberTest call EmberCliTest(<bang>0)
command -nargs=1 EmberInstall call EmberCliAddonInstall(<f-args>)
command -nargs=0 NpmInstall call NpmInstall()
" }}}1
