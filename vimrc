" ============ "
" global stuff "
" ============ "
if system('uname -s') != "Linux\n"
    echom "Error: the current operating system won't support my Vim config"
endif
let g:python3_host_prog = '/usr/bin/python3'
let g:os_current = "Linux\n"
set clipboard=unnamedplus
let mapleader=" "
map , <Plug>(easymotion-prefix)


" ============= "
" General stuff "
" ============= "
set nocompatible		" use vim and not vi
set mouse=a				" use mouse
filetype on            	" enable filetype detection
filetype plugin on     	" load file-specific plugins
filetype indent on     	" load file-specific indentation
set cursorline         	" highlight current line
set wrap linebreak     	" wrap long lines and break lines at words
set encoding=UTF-8
set nu					" show the current linenumber
set rnu					" show relative linenumbers
set ruler				" shows cursor position in bottom line
syntax enable
set nohlsearch		 	" don't highlight search result
set noincsearch			" don't jump to search result as string is being typed
set autoread			" autoread a buffer that changed from outside of vim
set autowriteall		" write current buffer when moving buffers
set nofoldenable		" don't fold text by default when opening files
"set foldlevel=999		" hacky replacement of the option above
set foldmethod=syntax	" fold based on syntax
set showcmd				" show partially typed commands
set noshowmode			" Hide the mode you are in (the last line).
set showmatch			" Show matching words during a search.
compiler gcc			" C Compiler and error ignore with :make

set viminfo=%,<800,'10,/50,:100,h,f0,n~/.cache/.viminfo
"           | |    |   |   |    | |  + viminfo file path
"           | |    |   |   |    | + file marks 0-9,A-Z 0=NOT stored
"           | |    |   |   |    + disable 'hlsearch' loading viminfo
"           | |    |   |   + command-line history saved
"           | |    |   + search history saved
"           | |    + files marks saved
"           | + lines saved each register (new name for ", vi6.2)
"           + save/restore buffer list

" "overridden per filetype?
set textwidth=80
set scrolloff=3
set tabstop=4
set shiftwidth=4


" ====================== "
" True color in terminal " 
" ====================== "
if (has("termguicolors"))
  " Force true color; see https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
  if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
  set termguicolors
endif

colorscheme sorbet          " set colorscheme
set background=dark			" just in case a colorscheme has white bg


" =============== "
" Clipboard stuff "
" =============== "
" Make Y work like D or C (not vi compatible)
noremap Y y$

" stop cc, x, and s from overwriting default register
nnoremap cc "_cc
nnoremap x "_x
nnoremap s "_s

" clipboard after leaving vim, CAREFUL with sensitive data
autocmd VimLeave * call system("xsel -ib", getreg('+'))


" ========== "
" Navigation "
" ========== "
" useful for jumping to end of nested snippets
" the silly jump to the line start via ^ is a hack to ensure cursor exits a possible UltiSnips snippet scope
inoremap <C-L> <ESC>^$a

" mappings for navigating wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap I g^i

" navigate to line start and end from home row
" note that this overrides H and L to move the cursor to page top and page bottom
noremap H g^
noremap L g$

" Center cursor after various movements
noremap '' ''zz
noremap <C-O> <C-O>zz
noremap <C-I> <C-I>zz
noremap <C-]> <C-]>zz
noremap <C-D> <C-D>zz
noremap <C-U> <C-U>zz

" mappings for faster split window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" mappings for navigating buffers
noremap <Leader>n :bnext<CR>
noremap <Leader>N :bprevious<CR>

" go back to end of previous word instead of xi/cl and cc
nnoremap S gE
vnoremap S gE
nnoremap s ge
vnoremap s ge


" ============= "
" Miscellaneous "
" ============= "
" For macro playback. This overrides Ex mode
nnoremap Q @q

" global substitute
nnoremap <Leader>s :%s/
vnoremap <Leader>s :s/

" toggle linenumbers
nnoremap <Leader>l :set rnu!<Enter>:set nu!<Enter>
"
" disable highlight (enable with n or N)
nnoremap <Leader>h :nohls<Enter>

" vertical split:
nnoremap <C-W>gf <C-W>vgf<CR>
nnoremap <C-W>] <c-W>v<c-]><CR>
"nnoremap <C-W>gf :exec "vert norm <C-W>gf"<CR>
"nnoremap <C-W>] :exec "vert norm <C-W>]"<C-]><CR>


" ======================= "
" Global plugins Vim-Plug "
" ======================= "
call plug#begin('~/.vim/plugged')
""" Some adhd ts:
"Plug 'junegunn/goyo.vim'
"nnoremap <Leader>g :Goyo<CR>
"Plug 'junegunn/limelight.vim'
"Plug 'itchyny/lightline.vim'
"let g:lightline = {
"      \ 'colorscheme': 'sorbet',
"      \ 'component_function': {
"      \   'fileformat': 'LightlineFileFormat',
"      \   'filetype': 'LightlineFiletype',
"      \   'fileencoding': 'LightlineFileEncoding',
"      \ },
"      \ }
"" Hide file format for window widths below 70 cols
"function! LightlineFileFormat()
"  return winwidth(0) > 70 ? &fileformat : ''
"endfunction
"" Hide file encoding for window widths below 70 cols
"function! LightlineFileEncoding()
"  return winwidth(0) > 70 ? &fileencoding : ''
"endfunction
"" Hide file type for window widths below 60 cols
"function! LightlineFiletype()
"  return winwidth(0) > 60 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
"endfunction

" Plug inside plug to update plug:
Plug 'junegunn/vim-plug'

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "jk"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips'] " ~/.vim/UltiSnips/
nnoremap <leader>U :call UltiSnips#RefreshSnippets()<CR>

Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'
" automatically open QuickFix menu with the given number of rows
let g:asyncrun_open = 8
" remove empty lines from QuickFix list
let g:asyncrun_trim = 1
noremap <silent><leader>q :call asyncrun#stop('')<cr>
noremap <silent><leader>p :AsyncTask project-build-serve<cr>

Plug 'tpope/vim-commentary'
" gc{motion}              Comment or uncomment lines that {motion} moves over.
" gcc                     Comment or uncomment [count] lines.
" {Visual}gc              Comment or uncomment the highlighted lines.
" gc                      Text object for a comment (operator pending mode only.)
" gcgc  gcu               Uncomment the current and adjacent commented lines.
" :[range]Commentary      Comment or uncomment [range] lines

Plug 'tpope/vim-dispatch'
let g:dispatch_no_maps = 1 " Disable vim-dispatch's default key mappings

Plug 'tpope/vim-fugitive', { 'on': 'Git' }


Plug 'tpope/vim-git'

Plug 'tpope/vim-repeat'

Plug 'tpope/vim-surround'

Plug 'easymotion/vim-easymotion'
"nnoremap <Leader> <Plug>(easymotion-prefix)
" Default Mapping      | Details
" ---------------------|----------------------------------------------
" <Leader>f{char}      | Find {char} to the right. See |f|.
" <Leader>F{char}      | Find {char} to the left. See |F|.
" <Leader>t{char}      | Till before the {char} to the right. See |t|.
" <Leader>T{char}      | Till after the {char} to the left. See |T|.
" <Leader>w            | Beginning of word forward. See |w|.
" <Leader>W            | Beginning of WORD forward. See |W|.
" <Leader>b            | Beginning of word backward. See |b|.
" <Leader>B            | Beginning of WORD backward. See |B|.
" <Leader>e            | End of word forward. See |e|.
" <Leader>E            | End of WORD forward. See |E|.
" <Leader>ge           | End of word backward. See |ge|.
" <Leader>gE           | End of WORD backward. See |gE|.
" <Leader>j            | Line downward. See |j|.
" <Leader>k            | Line upward. See |k|.
" <Leader>n            | Jump to latest "/" or "?" forward. See |n|.
" <Leader>N            | Jump to latest "/" or "?" backward. See |N|.
" <Leader>s            | Find(Search) {char}. |f| and |F| combined.

Plug 'kshenoy/vim-signature'
" mx           Toggle mark 'x' and display it in the leftmost column
" dmx          Remove mark 'x' where x is a-zA-Z
" m,           Place the next available mark
" m.           If no mark on line, place the next available mark.
" 					Otherwise, remove (first) existing mark.
" m-           Delete all marks from the current line
" m<Space>     Delete all marks from the current buffer
" ]`           Jump to next mark
" [`           Jump to prev mark
" ]'           Jump to start of next line containing a mark
" ['           Jump to start of prev line containing a mark
" `]           Jump by alphabetical order to next mark
nnoremap `] ]`
" `[           Jump by alphabetical order to prev mark
nnoremap `[ [`
" ']           Jump by alphabetical order to start of next line having a mark
" '[           Jump by alphabetical order to start of prev line having a mark
" m/           Open location list and display marks from current buffer
" m[0-9]       Toggle the corresponding marker !@#$%^&*()
" m<S-[0-9]>   Remove all markers of the same type
" ]-           Jump to next line having a marker of the same type
" [-           Jump to prev line having a marker of the same type
" ]=           Jump to next line having a marker of any type
" [=           Jump to prev line having a marker of any type
" m?           Open location list and display markers from current buffer
" m<BS>        Remove all markers
""" some vim-signature keybinds are colliding with my make/quickfix window
nnoremap ma :make all<CR>
nnoremap mt :make tests<CR>
nnoremap md :make docs<CR>
nnoremap mf :make fclean<CR>
nnoremap mr :make run<CR>
nnoremap mo :copen<CR>
nnoremap mc :cclose<CR>
nnoremap mn :cnext<CR>
nnoremap mp :cprev<CR>

" best lsp/autocompletion:
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Really nice multicursor plugin:
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"" To not lose your accidental deletions:
Plug 'mbbill/undotree'

" auto completing delimiters in insert mode:
Plug 'Raimondi/delimitMate'
let g:delimitMate_expand_cr = 1

" ===================== "
" File specific plugins "
" ===================== "
Plug 'jeetsukumaran/vim-pythonsense', {}

Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
autocmd FileType tex set encoding=utf-8

Plug 'chrisbra/csv.vim'
" Disable csv.vim's key bindings
let g:no_csv_maps = 1

Plug 'mzlogin/vim-markdown-toc'

call plug#end()

" ============== "
" Some old stuff "
" ============== "

""optional plugins:
""I tried some but didnt like very much
	" Plug 'vim-airline/vim-airline'
	" Plug 'junegunn/fzf.vim'
	" Plug 'airblade/vim-gitgutter'
	" Plug 'ludovicchabant/vim-gutentags'
	" Plug 'cscope.sourceforge.net/cscope_maps.vim'
	" Plug 'michaeljsmith/vim-indent-object'
	" Plug 'preservim/nerdcommenter'
	" Plug 'ctrlpvim/ctrlp.vim'
	"	let g:ctrlp_working_path_mode = 'ra'
	" Plug 'vimwiki/vimwiki'
	" "unicode search:
	" Plug 'chrisbra/unicode.vim'
	" "replace surrounding characters:
	" Plug 'tpope/vim-surround'
"" linter :
	" Plug 'w0rp/ale'
	" Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
""has to be last:
	" Plug 'ryanoasis/vim-devicons'
" source ~/.vim/wiki.vim
	" set errorformat^=%-G%f:%l:\ warning:%m
	" set errorformat^=%-G%f:%l:\ warning:%m
	" set errorformat^=%.%#\ at\ %.%#\ in\ %f:line\ %l
"set viminfo='20,<1000
" "Time out, when a key that has multiple next keys :
" set timeout
" set timeoutlen=1500
" set cmdheight=0 "for vim <8 this was a buggy way to remove vim's cmdline
" 
" "Colorscheme :
" colorscheme sorbet
" hi QuickFixLine ctermbg=25
" highlight Normal guibg=black guifg=white
" set background=dark

"EOF
