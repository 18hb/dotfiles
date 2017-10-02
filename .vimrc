"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Required:
execute 'set runtimepath+=' . s:dein_repo_dir

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_repo_dir)

  " Add or remove your plugins here:
  " call dein#add('Shougo/neosnippet.vim')
  " call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/denite.nvim')
  call dein#add('nanotech/jellybeans.vim')
  call dein#add('w0ng/vim-hybrid')

  " You can specify revision/branch/tag.
  " call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"syntax on
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
set cursorline

"set t_Co=256
colorscheme jellybeans
"colorscheme hybrid

nmap <ESC><ESC> :nohlsearch<CR><ESC>
"nmap ,f :e %:p:h<CR>
"nnoremap <silent> ,f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"nnoremap <silent> ,f :<C-u>DeniteBufferDir<CR>
nnoremap <silent> ,f :<C-u>Denite file_rec<CR>
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

hi ZenkakuSpace cterm=underline ctermfg=white ctermbg=blue
au BufRead,BufNew * match ZenkakuSpace /　/

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
