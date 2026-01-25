" Misc
filetype indent on
syntax on

" Interface
set number
"set relativenumber
set cc=80
set showmatch
set list listchars=tab:»·,trail:·
set scrolloff=10
set wildmenu

" Indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
autocmd Filetype make setlocal noexpandtab

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <C-l> :noh<CR> " Hide search result with C-l

" Save
set autowrite
set autoread

" Load Vim Git settings
let git_settings = system("git config --get vim.settings")
if strlen(git_settings)
    exe "set" git_settings
endif

" Jumps back where you left the cursor when reopening a file
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   execute "normal! g`\"" |
  \ endif

" Better display when using termdebug
let g:termdebug_wide=1
