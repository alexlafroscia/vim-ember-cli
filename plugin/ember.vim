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
" Globally Available Public API {{{1
command -nargs=+ -complete=customlist,ember#complete_class EmberGen call ember#Generate(<f-args>)
command -nargs=+ -complete=customlist,ember#complete_class_and_file EmberDestroy call ember#Destroy(<f-args>)
command -nargs=0 -bang EmberTest call ember#Test(<bang>0)
command -nargs=* EmberServe call ember#Server(<f-args>)
command -nargs=* EmberBuild call ember#Build(<f-args>)
command -nargs=1 EmberInstall call ember#InstallAddon(<f-args>)
command -nargs=0 NpmInstall call ember#NpmInstall()
" }}}1
