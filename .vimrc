"------------------------------------------------------------------
" setting by 18hb 2014.06
"------------------------------------------------------------------
source ~/.vim/encode.vim

"------------------------------------------------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'sudo.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"------------------------------------------------------------------

syntax on
set ambiwidth=double
set list
"set listchars=tab:>.,eol:^
set listchars=tab:>.,trail:_
set nu
set tabstop=2
set shiftwidth=2
set laststatus=2
set expandtab
set scrolloff=5
set incsearch
set nowrapscan
set smartindent
set ignorecase
set smartcase
set hid
set hlsearch
set backspace=indent,eol,start

set t_Co=256
colorscheme jellybeans
"colorscheme wombat256mod
"colorscheme molokai

set tags=tags;

nmap <ESC><ESC> :nohlsearch<CR><ESC>
"nmap ,f :e %:p:h<CR>
"nmap ,f :VimFilerBufferDir<CR>
"nmap ,f :UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,r :<C-u>Unite file_mru<CR>
nnoremap <silent> ,b :<C-u>Unite buffer<CR>
nmap <SPACE>w 
nmap <SPACE>n :bn<CR>
nmap <SPACE>p :bp<CR>
nnoremap j gj
nnoremap k gk

if winwidth(0) >= 120
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=\ %l,%c%V%8P
  "set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=\ %l,%c%V%8P
endif

"augroup InsertHook
"autocmd!
"autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
"autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
"augroup END

hi ZenkakuSpace cterm=underline ctermfg=white ctermbg=blue
au BufRead,BufNew * match ZenkakuSpace /　/

autocmd BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
\|  endif


function! GetB()
    let c = matchstr(getline('.'), '.', col('.') - 1)
    let c = iconv(c, &enc, &fenc)
    return String2Hex(c)
endfunction
" help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
    let n = a:nr
    let r = ""
    while n
        let r = '0123456789ABCDEF'[n % 16] . r
        let n = n / 16
    endwhile
    return r
endfunc
" The function String2Hex() converts each character in a
" string to a two
" character Hex string.
func! String2Hex(str)
    let out = ''
    let ix = 0
    while ix < strlen(a:str)
        let out = out . Nr2Hex(char2nr(a:str[ix]))
        let ix = ix + 1
    endwhile
    return out
endfunc

" git-diff-aware version of gf commands.
nnoremap <expr> gf  <SID>do_git_diff_aware_gf('gf')
"nnoremap <expr> gF  <SID>do_git_diff_aware_gf('gF')
"nnoremap <expr> <C-w>f  <SID>do_git_diff_aware_gf('<C-w>f')
"nnoremap <expr> <C-w><C-f>  <SID>do_git_diff_aware_gf('<C-w><C-f>')
"nnoremap <expr> <C-w>F  <SID>do_git_diff_aware_gf('<C-w>F')
"nnoremap <expr> <C-w>gf  <SID>do_git_diff_aware_gf('<C-w>gf')
"nnoremap <expr> <C-w>gF  <SID>do_git_diff_aware_gf('<C-w>gF')

function! s:do_git_diff_aware_gf(command)
  let target_path = expand('<cfile>')
  if target_path =~# '^[ab]/'  " with a peculiar prefix of git-diff(1)?
    if filereadable(target_path) || isdirectory(target_path)
      return a:command
    else
      " BUGS: Side effect - Cursor position is changed.
      let [_, c] = searchpos('\f\+', 'cenW')
      return c . '|' . 'v' . (len(target_path) - 2 - 1) . 'h' . a:command
    endif
  else
    return a:command
  endif
endfunction

let g:unite_enable_start_insert = 1
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  "ESCでuniteを終了
  "nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  "imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "nmap <silent><buffer> <ESC> q
endfunction"}}}
