filetype off
filetype plugin indent off

" {{{ options
set fileencodings=iso-2022-jp,ucs-bom,sjis,utf-8,euc-jp,cp932,default,latin1
set fileformats=unix,dos,mac
scriptencoding utf-8
set number
set helplang=ja
set signcolumn=yes 
set hidden
set laststatus=2
set mouse=a
set clipboard=unnamed,autoselect
set directory=~
set backupdir=~
set undodir=~
set title
let &g:titlestring =
      \ "%{expand('%:p:~:.')} %<\(%{fnamemodify(getcwd(), ':~')}\)%(%m%r%w%)"
" }}}

" {{{ plugins
call plug#begin()

Plug 'vim-jp/vimdoc-ja'
Plug 'vim-denops/denops.vim'
Plug 'cohama/lexima.vim'
Plug 'mattn/vim-sonictemplate'
Plug 'machakann/vim-sandwich'
Plug 'mattn/emmet-vim'
Plug 'lambdalisue/gin.vim'
Plug 'simeji/winresizer'
Plug 'thaerkh/vim-workspace'
Plug 'skanehira/translate.vim'

" {{{ lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-lsp-icons'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
" }}}

" {{{ fern
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
" }}}

" {{{ golang
Plug 'mattn/vim-goimports'
Plug 'mattn/vim-gomod'
" }}}

" {{{ airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" }}}

" {{{ colorscheme
Plug 'arcticicestudio/nord-vim'
" }}}

"{{{ ddu
Plug 'Shougo/ddu.vim'
Plug 'Shougo/ddu-ui-ff'
Plug 'Shougo/ddu-source-file'
Plug 'Shougo/ddu-source-register'
Plug 'kuuote/ddu-source-mr'
Plug 'lambdalisue/mr.vim'
Plug 'shun/ddu-source-buffer'
Plug 'Shougo/ddu-filter-matcher_substring'
Plug 'Shougo/ddu-commands.vim'
Plug 'Shougo/ddu-kind-file'
"}}}

call plug#end()
" }}}

" {{{ keymaps
let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>

nmap s <Nop>
xmap s <Nop>

inoremap <silent> jj <ESC>


" expand path
cmap <C-x> <C-r>=expand('%:p:h')<CR>\
" expand file (not ext)
cmap <C-z> <C-r>=expand('%:p:r')<CR>

nnoremap <Leader>ls :<C-u>ls<CR>
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>bn :<C-u>bn<CR>
nnoremap <Leader>bp :<C-u>bp<CR>
nnoremap <Leader>bd :<C-u>bd<CR>

" }}}

" {{{ plugin config

" {{{ fern
nnoremap <silent> <Leader>e :<C-u>Fern . -drawer <CR>
nnoremap <silent> <Leader>E :<C-u>Fern . -drawer -toggle<CR>
let g:fern#default_hidden=1

function! s:fern_settings() abort
  nmap <silent> <buffer> <C-S-d> <Plug>(fern-action-new-dir)
  setlocal signcolumn=no
  setlocal nonumber
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END
" }}}

" {{{ lsp
if empty(globpath(&rtp, 'autoload/lsp.vim'))
  finish
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <f2> <plug>(lsp-rename)
    nmap <buffer> <leader>ac <plug>(lsp-code-action)
    nmap <buffer> <leader>cl <plug>(lsp-code-lens)
    nmap <buffer> <leader>df <plug>(lsp-definition)
    nmap <buffer> <leader>dd <plug>(lsp-document-diagnostics)
    nmap <buffer> <leader>im <plug>(lsp-implementation)
    nmap <buffer> <leader>pdf <plug>(lsp-peek-definition)
    nmap <buffer> <leader>sm <plug>(lsp-document-symbol-search)
    nmap <buffer> <leader>Sm <plug>(lsp-workspace-symbol-search)
    nmap <buffer> <leader>rf <plug>(lsp-references)
    nmap <buffer> <leader>td <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>en <plug>(lsp-next-error)
    nmap <buffer> <leader>ep <plug>(lsp-previous-error)
    nmap <buffer> <leader>ho <plug>(lsp-hover)

    let g:lsp_format_sync_timeout = 500
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 0


" }}}

" {{{ vim-workspace
nnoremap <leader>s :ToggleWorkspace<CR>
" }}}

" {{{ airline
let g:airline_theme = 'nord'
let g:airline_powerline_fonts = 1
set t_Co=256
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.crypt = '🔒'
" }}}

" {{{ translate.vim
let g:translate_source = "en"
let g:translate_target = "ja"
" }}}

"{{{ ddu
call ddu#custom#patch_global({
    \   'ui': 'ff',
    \   'sources': [{'name':'file','params':{}},{'name':'mr'},{'name':'register'},{'name':'buffer'}],
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   },
    \   'kindOptions': {
    \     'file': {
    \       'defaultAction': 'open',
    \     },
    \   },
    \ })
autocmd FileType ddu-ff call s:ddu_my_settings()

function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()

function! s:ddu_filter_my_settings() abort
  inoremap <buffer><silent> <CR>
  \ <Esc><Cmd>close<CR>
  nnoremap <buffer><silent> <CR>
  \ <Cmd>close<CR>
  nnoremap <buffer><silent> q
  \ <Cmd>close<CR>
endfunction

nnoremap <SID>[ug] <Nop>
nmap ,u <SID>[ug]

nnoremap <silent> <SID>[ug]m :<C-u>Ddu mr<CR>
nnoremap <silent> <SID>[ug]b :<C-u>Ddu buffer<CR>
nnoremap <silent> <SID>[ug]r :<C-u>Ddu register<CR>
nnoremap <silent> <SID>[ug]n :<C-u>Ddu file -source-param-new -volatile<CR>
nnoremap <silent> <SID>[ug]f :<C-u>Ddu file<CR>
"}}}

" }}}

" {{{ commands
augroup restore-cursor
  autocmd!
  autocmd BufReadPost *
        \ : if line("'\"") >= 1 && line("'\"") <= line("$")
        \ |   exe "normal! g`\""
        \ | endif
  autocmd BufWinEnter *

        \ : if empty(&buftype) && line('.') > winheight(0) / 2
        \ |   execute 'normal! zz'
        \ | endif
augroup END

autocmd FileType vim setlocal foldmethod=marker
" }}}

" {{{ other

colorscheme nord
cd ~
filetype plugin indent on
" }}}