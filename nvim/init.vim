set number
set expandtab ts=4 sw=4 ai
setlocal foldmethod=syntax
set mouse=a

inoremap (; ();<left><left>
inoremap [; [];<left><left>
inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>
"inoremap /* /**/<left><left>

inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ``` ```<cr>```<esc>


set numberwidth=1
set expandtab
set clipboard=unnamedplus
set showcmd
set ruler
set encoding=utf-8
set showmatch
set laststatus=2
set noshowmode

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'htm']}
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'romgrk/barbar.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'https://gitlab.com/verticallity/spwn-vim'
Plug 'andweeb/presence.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'luochen1990/rainbow'

call plug#end()


let g:rainbow_active = 1
let g:deoplete#enable_at_startup = 1
set background=dark
" colorscheme nord   
colorscheme onedark
let mapleader=" "
lua require('lualine').setup()

vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>t  :sp<CR>:term<CR><C-w>J:resize -10<CR>i

nmap <leader>l  :vert resize +1<CR>
nmap <leader>h :vert resize -1<CR>
nmap <leader>j :resize +1<CR>
nmap <leader>k :resize -1<CR>
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>cl :noh<cr>
nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
" let g:nvim_tree_side = 'right' "left by default
" let g:nvim_tree_width = 40 "30 by default, can be width_in_columns or 'width_in_percent%'
" let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
" let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
" let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ] "empty by default, don't auto open tree on specific filetypes.
" let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
" let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
" let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
" let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
" let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
" let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
" let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
" let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
" let g:nvim_tree_auto_resize = 0 "1 by default, will resize the tree to its saved width when opening a file
" let g:nvim_tree_disable_netrw = 0 "1 by default, disables netrw
" let g:nvim_tree_hijack_netrw = 0 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
" let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
" let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
" let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
" let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
" let g:nvim_tree_hijack_cursor = 0 "1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
" let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
" let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
" let g:nvim_tree_update_cwd = 1 "0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen and NvimTreeClose are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nmap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
nnoremap <silent> <C-s>    :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw :BufferOrderByWindowNumber<CR>
let g:user_emmet_leader_key='<C-z>'
let extension = expand('%:e')
""if extension == "spwn"
""  set syntax=rust
""endif

