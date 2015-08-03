" plugin/ember.vim
" Author: Alex LaFroscia

" Initialization {{{1

augroup emberPluginDetect
  autocmd!
  autocmd VimEnter * call ember#detect_cli_project()
  autocmd BufEnter *.js,*.json,*.hbs call ember#detect_cli_project()
  autocmd BufEnter *hbs set omnifunc=ember#HandlebarsComplete
augroup END

" }}}1
" Globally Available Public API {{{1
command -nargs=+ -complete=customlist,ember#complete_type_and_files EmberGen call ember#Generate(<f-args>)
command -nargs=+ -complete=customlist,ember#complete_type_and_files EmberDestroy call ember#Destroy(<f-args>)
command -nargs=0 -bang EmberTest call ember#Test(<bang>0)
command -nargs=0 EmberTestModule call ember#TestModule()
command -nargs=* EmberServe call ember#Server(<f-args>)
command -nargs=* EmberBuild call ember#Build(<f-args>)
command -nargs=1 EmberInstall call ember#InstallAddon(<f-args>)
command -nargs=0 NpmInstall call ember#NpmInstall()
" }}}1
