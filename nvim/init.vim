" 解决退格键不生效的问题
set nocompatible
set backspace=indent,eol,start

" 打开 24 位真彩色支持
set termguicolors
" 高亮光标所在行
set cursorline

" 退出插入模式指定类型的文件自动保存
au InsertLeave *.go,*.sh,*.php write

" 自动跳转上次退出的位置
autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$")
      \ |   exe "normal! g`\""
      \ | endif

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

" Enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif


" 插件设置，这里使用了 vim-plug
call plug#begin('~/.vim/plugged')

" 安装插件只需要把 github 地址放到这里重启后执行 :PlugInstall 就好了
" 启动页
Plug 'mhinz/vim-startify'

" 目录树
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'

" 主题
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

" 屏内快速定位
Plug 'easymotion/vim-easymotion'

" 模糊搜索
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" 批量搜索替换
Plug 'brooth/far.vim'

" vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" vim-php
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

" 自动括号
Plug 'jiangmiao/auto-pairs'

" 查看当前代码文件中的变量和函数列表
Plug 'majutsushi/tagbar'

" 可以在 vim 中使用 tab 补全
Plug 'vim-scripts/SuperTab'

" 注释 gc/gcc
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-surround'

" 代码补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 报错
Plug 'dense-analysis/ale'

" 文件解析，展示tag
" 依赖brew tap universal-ctags/universal-ctags
" brew install --HEAD universal-ctags
Plug 'majutsushi/tagbar'


call plug#end()

" 插件相关配置

" nerdtree
let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 24
nmap ,v :NERDTreeFind<cr>
nmap ,g :NERDTreeToggle<cr>

" material
let g:material_terminal_italics = 1
let g:material_theme_style = 'lighter'
let g:airline_theme = 'material'
colorscheme material


" fzf
nmap <Leader>f :Files<CR>
nmap <Leader>b :History<CR>

" rg
let g:ag_cli = 'rg'

" easymotion 
nmap ss <Plug>(easymotion-s2)

" vim-go
let g:go_fmt_command = 'goimports'
let g:go_autodetect_gopath = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>
augroup go
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

" ale
" ale-setting {{{
let g:ale_set_highlights = 1
let g:ale_set_quickfix = 1
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"打开文件时不进行检查
let g:ale_lint_on_enter = 1
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
" nmap <Leader>l :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>


" tagbar
nnoremap <leader>t :TagbarToggle<cr>

set updatetime=300
