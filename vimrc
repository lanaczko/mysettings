set nocompatible
" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
set number
set ts=4 sw=4
"set lines=50 columns=100
set cmdheight=2 " do not prompt for enter

autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
set foldlevelstart=20
set foldcolumn=2     " the number of columns to use for folding display at the left

set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set smartindent
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab
set hidden
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup
set noswapfile

"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.

set pastetoggle=<F2>

set mouse=a

cmap w!! w !sudo tee % >/dev/null

nmap <silent> ,/ :nohlsearch<CR>

filetype plugin on
filetype plugin indent on
"TlistAddFiles /opt/cscope/ufo/tags

" change the mapleader from \ to ,
let mapleader=","
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

noremap <C-left> :bprev<CR>
noremap <C-right> :bnext<CR>

imap <F4> <ESC>:NERDTreeToggle<CR>
map <F4> :NERDTreeToggle<CR>

" if filereadable("/opt/cscope/android3.1/cscope.out")
"     cs add /opt/cscope/android3.1/cscope.out
" endif
set nocscopeverbose
if filereadable("./cscope.out")
    cs add ./cscope.out
else
if filereadable("/opt/cscope/android4/cscope.out")
    cs add /opt/cscope/android4/cscope.out
endif
if filereadable("/opt/cscope/ufo/cscope.out")
    cs add /opt/cscope/ufo/cscope.out
endif
endif

if has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
"  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
"  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif

set guifont=Monospace\ 12
