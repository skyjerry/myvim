" 解决退格键不生效的问题
set nocompatible
set backspace=indent,eol,start

" 系统剪贴板
set clipboard=unnamed

" 设置行号
set nu 
" F2 进入粘贴模式
set pastetoggle=<F2>
" 语法高亮
syntax on 
" 高亮搜索
set hlsearch
" 增量式搜索
set incsearch
" 不区分大小写,除非含有大写字母
set ignorecase
set smartcase
" 设置折叠方式
" set foldmethod=indent

" 在右下角显示部分命令
set showcmd
" 命令可以用tab补全,并设置匹配规则
set wildmenu
set wildmode=list:longest,full

" 距窗口边缘还有多少行时滚动窗口
set scrolloff=8

" 显示标尺,提示一行代码不要超过80个字符
set ruler
set colorcolumn=120

" 一些方便的映射
let mapleader=','
let g:mapleader=','

" 使用 jj 进入 normal 模式
inoremap jj <Esc>`^

" 使用 leader+w 直接保存
inoremap <leader>w <Esc>:w<cr>
noremap <leader>w :w<cr>

" 切换buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> [n :bnext<CR>

" 窗口切换
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" json格式化
com! FormatJSON %!python3 -m json.tool

" tab 缩进
set tabstop=4 " 设置Tab长度为4空格
set shiftwidth=4 " 设置自动缩进长度为4空格
set autoindent " 继承前一行的缩进方式，适用于多行注释


" 插件设置，这里使用了 vim-plug
call plug#begin('~/.vim/plugged')

" 安装插件只需要把 github 地址放到这里重启后执行 :PlugInstall 就好了
" 启动页
Plug 'mhinz/vim-startify'

" 目录树
Plug 'scrooloose/nerdtree'

" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'

" 主题
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

" 文件快速切换
Plug 'ctrlpvim/ctrlp.vim'

" 屏内快速定位
Plug 'easymotion/vim-easymotion'

" 模糊搜索
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" 批量搜索替换
Plug 'brooth/far.vim'

" vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


call plug#end()

" 插件相关配置

" nerdtree
nmap ,v :NERDTreeFind<cr>
nmap ,g :NERDTreeToggle<cr>

" material
set t_Co=256
let g:material_terminal_italics = 1
let g:material_theme_style = 'lighter'
let g:airline_theme = 'material'
colorscheme material

" ctrlp
let g:ctrlp_map = '<c-p>'


" easymotion 
nmap ss <Plug>(easymotion-s2)
