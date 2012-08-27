"------------------------------------------------------------------
" this file is japanese, euc encoding.
" これはUFT-8日本語ファイルです
" (vimの日本語自動判別用の文字列)
" setting by 18hb 2011.12
"------------------------------------------------------------------
"set nocompatible
"filetype plugin indent off
"
"if has('vim_starting')
"  set runtimepath+=~/.vim/bundle/neobundle.vim
"  call neobundle#rc(expand('~/.vim/bundle'))
"endif
"
"NeoBundle 'Shougo/neobundle.vim'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/vimproc'
"NeoBundle 'Shougo/vimshell'
"NeoBundle 'Shougo/vimfiler'
"NeoBundle 'thinca/vim-quickrun'         " [\r] to run
"NeoBundle 'thinca/vim-ref'              " [K] to show reference
"NeoBundle 'jimsei/winresizer'
"NeoBundle 'surround.vim'
"
"filetype plugin indent on
"------------------------------------------------------------------

if filereadable(expand('~/.vimrc.jp'))
  source ~/.vimrc.jp
endif

syntax on
set list
"set listchars=tab:>.,eol:^
set listchars=tab:>.,trail:_
set nu
set tabstop=4
set shiftwidth=4
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

set t_Co=256
"colorscheme wombat256mod
colorscheme molokai


nmap <ESC><ESC> :nohlsearch<CR><ESC>
"nmap ,b :Unite buffer<CR>
"nmap ,f :VimFilerBufferDir<CR>
"nmap ,f :UniteWithBufferDir -buffer-name=files file<CR>
"nmap ,b :ls<CR>:buf 
"nmap ,f :e %:p:h<CR>
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

let g:quickrun_config = {}
let g:quickrun_config['_'] = {
    \ 'split' : '',
    \ 'runner' : 'vimproc:500'
\ }
set splitbelow

let g:quickrun_config['php.phpunit'] = {}
let g:quickrun_config['php.phpunit']['command'] = 'phpunit'
let g:quickrun_config['php.phpunit']['exec'] = '%c %o %s'

augroup QuickRunPHPUnit
   autocmd!
   autocmd BufWinEnter,BufNewFile *Test.php set filetype=php.phpunit
augroup END

"let g:unite_enable_start_insert=1
let g:ref_phpmanual_path = expand('~/doc/phpmanual')
let g:ref_phpmanual_cmd = 'w3m -dump %s'


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