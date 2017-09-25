" ~/.vim/.vimrc.plug

" 参考 {{{
"

" 搜索vim文件
" :t_SI filetype:vim

" F1键
" 在gnome中F1键启用term，它截获了vim中F1的响应，所以应该禁用term的F1功能
" https://askubuntu.com/questions/58147/how-do-i-disable-the-help-f1-key/244786#244786

" 在一个映射之后不能直接加入注释，
" 因为“字符”也会被认为是映射的一部分。
" 可以通过|”绕过这一限制
" :map <space> W |   “这是注释
" }}}

" 一般性配置: {{{1

" 常规与外观 {{{
"

" VIM与Vi不完全兼容，因此要设置此选项
set nocompatible

" 1. 启用文件类型检测
" 2. 使用文件类型相关插件
" 3. 根据文件类型使用缩进文件
filetype plugin indent on

" " 基于语法的自动补全
" set omnifunc=syntaxcomplete#Complete

" 这指明在插入模式下在哪里允许 <BS>
" 删除光标前面的字符。逗号分隔的三个值分别指:
" 行首的空白字符，换行符和插入模式开始处之前的字符。
set backspace=indent,eol,start

" 显示行号
set number

" 启用鼠标支持
set mouse=a

" 中文编码方式
" vim内部采用utf-8编码方式
scriptencoding utf-8
set encoding=utf-8

" 由于vim内部采用utf-8编码方式，所以如果想要编辑16位unicode文件，必须 将其转换。
" vim会尝试着检查fileencodings选项中的编码文件，检测你需要使用哪种编码
set fencs=utf-8,gb2132,gbk

" 当写入文件的时候，会比较 fileencoding 与 encoding 的数值，如果他们的数值不相
" 同，文本会被转换
set fenc=utf-8

" 终端识别的字符编码
set termencoding=utf-8

set autoread "Automatically read file again which has been changed outside of Vim
" Tab，拖尾空白和行尾（eol）显示的字符。对非文本字符和特殊字符
" 按照灰色显示。
set listchars=tab:▸\ ,eol:¬
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" 当前选择行高亮显示
set cursorline

" 配置foldcolumn，使得最左边出现1个空白列
" set foldcolumn=2
" highlight foldcolumn=bg

" 这一项非常重要,平时开着左右屏幕浏览代码的时候,可以让代码自动折行
set wrap

" Command模式时，加强命令补全功能。
" 例如：使用find命令时，可以显示所有找到的匹配的文件名称，用tab键可进行选择
set wildmenu

" 在 Vim 窗口右下角，标尺的右边显示未完成的命令。例如，当你输入 "2f"，Vim 在等
" 你输入要查找的字符并且显示 "2f"。当你再输入 w，"2fw" 命令被执行，"2f" 自动消
" 失。
set showcmd

" 总是显示标签页，如果不配置该选项，将看不到标签页，不便于跳转
set showtabline=2

" 键入一个右括号 ) 时，如果能知道它匹配哪个左括号 (
" 问题是，会有一个很小的时间延迟
" set showmatch

" 在命令行不显示 <-- 插入--> 这样的字符串
set noshowmode
"set showmode

" Normal模式下，向下滚动时，光标会位于最后一行，不方便阅读。
" 这个配置，让阅读位置总是距离最低端有4行的距离。
set scrolloff=4

" 最后一个窗口何时有状态行。2=总是有状态行，0=永不，1=至少有两个窗口
set laststatus=2

" 重定向临时交换文件的保存位置
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" 关闭viualbell，出错时没有声音，没有闪烁
set novisualbell

" 设置path路径
" **表示在当前文件夹下对子文件夹递归查找
set path+=~/Documents/hxzdiary,~/.vim/,**

" 不进入 */git , */svn 等目录
" 忽略 *.o, *.obj文件
"
" wildignore   File      File       Dir      Dir       Dir + File
" Pattern      "foo"     "a/foo"    "foo"    "a/foo"   "a/foo/b"
" ---------------------------------------------------------------
" `foo`          match     match      miss     miss      miss
" `foo/`         miss      miss       miss     miss      miss
" `foo/*`        miss      miss       miss     miss      miss
" `*/foo`        match     match      match    match     match
" `*/foo/`       miss      miss       match    miss      miss
" `*/foo/*`      miss      miss       match    match     match
"
set wildignore+=*/.git,*/.svn,*/.tmp
set wildignore+=*.o,*.obj
set wildignore+=*.aux,*._aux,*._log,*.log,*.out,*.synctex.gz,*.toc,*.tex.project.vim

" 启动界面
set shortmess=atI

" 提高esc的反应时间
set ttimeoutlen=10

" 为了方便进行 :cn 和 :cp 操作
set hidden
" }}}

" 语法和缩进 {{{

" expandtab，把制表符转换为多个空格，具体空格数量参考 tabstop 和 shiftwidth 变量；
" tabstop 与 shiftwidth 是有区别的。tabstop 指定我们在插入模式下输入一个制表符占据的空格数量
" ，linux 内核编码规范建议是 8，看个人需要；shiftwidth 指定在进行缩进格式化源码时制表符占据的
" 空格数。所谓缩进格式化，指的是通过 vim 命令由 vim 自动对源码进行缩进处理，比如其他人的代码不
" 满足你的缩进要求，你就可以对其进行缩进格式化。缩进格式化，需要先选中指定行，要么键入 = 让
" vim 对该行进行智能缩进格式化，要么按需键入多次 < 或 > 手工缩进格式化；
"
" softtabstop，如何处理连续多个空格。因为 expandtab 已经把制表符转换为空格，当你要删除制表符
" 时你得连续删除多个空格，该设置就是告诉 vim 把连续数量的空格视为一个制表符，即，只删一个字符
" 即可。通常应将这tabstop、shiftwidth、softtabstop 三个变量设置为相同值；
"
" 另外，你总会阅读其他人的代码吧，他们对制表符定义规则与你不同，这时你可以手工执行 vim 的
" retab 命令，让 vim 按上述规则重新处理制表符与空格关系。

" 打开语法高亮功能
syntax enable

" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 延续上一行的缩进方式
set autoindent

" 没有缩进文件的可用编程语言采用这种缩进方式
set smartindent

" 将制表符扩展为空格，原来以为这个配置很有用，其实完全没有必要配置的
" 问题是会导致原本存储1个<tab>二进制代码的空间
" 现在必须存储8个空格的二进制代码，存储空间变为了原来的8倍
" 其实，只要理解了tabstop是为了兼容其他编辑器而设定的固定值
" 就知道在vim中应该只改变softtabstop的数值了
set expandtab

" 使用retab时，vim使用8个空格，这个定义不要改变
" 如果确实需要改变，改动softtabstop的数值！
set tabstop=8

" 当使用[>]缩进命令时，空格数
set shiftwidth=4
set cindent shiftwidth=4

" 在insert模式下，按一下<tab>键，产生4个空格，而不是8个
set softtabstop=4

" 自动保存内容
set autowriteall
" }}}

" 性能优化 {{{
"

" 宏和不是输入文本的操作，均延迟重画界面
" 也就是说，只有输入文字的时候时刻重新绘制界面，让输入的文字能及时显示到屏幕上
" 除此之外的操作，延迟一会儿重绘界面，问题不大
set lazyredraw

" 设置快速终端
set ttyfast

" 设置语法同步
autocmd BufWinEnter,Syntax * syn sync minlines=300 maxlines=500
" }}}

" Search {{{
" 开启实时搜索功能
set incsearch

" 对查找结果高亮显示
set hlsearch

" 搜索时忽略大小写
set ignorecase

" 如果在单词中有大写字母就自动按照大小写敏感查找
set smartcase

" 配置man.vim的查找路径，在vim中可以直接查看man手册
source $VIMRUNTIME/ftplugin/man.vim
" }}}

" 扩大窗口显示区域 {{{
" 在Ubuntu下按F11键，全屏。
" 禁止光标闪烁
set gcr=a:block-blinkon0

" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" 扩大窗口
set winminwidth=0                                   " default=1
set winminheight=0                                  " default=1

" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T
" }}}

" 自定义快捷键映射 {{{

let g:mapleader=';'

nmap Q gqap
vmap Q gq

" 避免中文符号
" inoremap 《 <
" inoremap  》<
" inoremap 【 [
" inoremap  】]
" inoremap  “ "

" Move easily between ^ and $
noremap <C-h> ^
noremap <C-l> $
noremap j gj
noremap k gk

cnoreabbrev ag Ag!

" 映射source
nnoremap <silent> <leader>so :source %<CR>

" 显示/隐藏不可显示字符
nmap <silent> <leader>ns :set nolist!<CR>

" 关闭查找高亮，其实是清空了查找寄存器"/
nnoremap <silent> <leader>nl  :let @/=''<CR>

" 修改当前目录
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" 保存当前文件修改内容。需要在.bashrc文件中添加stty -ixon这条语句，关闭bash的
" ctrl-s快捷功能。
nnoremap <leader>w  :w<CR>

" 退出整个vim
nnoremap <leader>qa :qa<CR>
" 左右两边的窗口相互调换
nnoremap <leader>x :<c-u>wincmd x<CR>
" 重新映射<c-^>
nnoremap <leader>o <c-^>

" 映射切换到shell的快捷键
nnoremap <silent> <leader>sh :<c-u>sh<CR>

" <C-J>的映射已经被latex-suite占用
nnoremap <silent> <leader>j :wincmd j<CR>
nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <silent> <leader>l :wincmd l<CR>
nnoremap <silent> <leader>k :wincmd k<CR>

" 在1号窗口中打开新文件
" nnoremap <silent> <C-w> :1wincmd w<CR>:enew<CR>

noremap <Up> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <Down> <NOP>

" 加快viewport的滚动
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" 默认加载vim的快捷键
nmap  <silent> <leader>vim :e ~/.vim/vimrc<cr>

" 默认打开cheat40.txt快捷键
nmap  <silent> <leader>ch :e ~/.vim/cheat40.txt<cr>

" 映射netrw的开关
map <silent> <F2> :NERDTreeToggle<CR>

" 重置到一行开始和结束的快捷键
" 由于L是到达屏幕最低端的快捷键，所以当映射LB之后，按下L键响应变的慢了
" 正是由于上述原因，所以取消了映射。
" nmap LB 0
" nmap LE $

" 删除所有行末尾的空格
nnoremap <silent> <leader><space> :%s/\s\+$//<cr>:let @/=''<CR>

" 打开剪贴板历史记录
nnoremap <silent> <leader>ya :Yanks<CR>

" 移动阅读窗口
nnoremap <c-9>  :call Tools_PreviousCursor(6)<CR>
inoremap <c-9>  :call Tools_PreviousCursor(6)<CR>
nnoremap <c-0>  :call Tools_PreviousCursor(7)<CR>
inoremap <c-0>  :call Tools_PreviousCursor(7)<CR>

" 阅读参考代码模式
" nnoremap <silent> <leader>rc :call Tools_ReadRefMode()<CR>

" 运行profile测试
nnoremap <silent> <F12> :ProfileStart<CR>
nnoremap <silent> <S-F12> :ProfileEnd<CR>

" 切换buffer快捷键
nnoremap <silent> H :<c-u>bp<CR>
nnoremap <silent> L :<c-u>bn<CR>

" 启动剖视
nnoremap  <F12>        :<C-U>profile start profile.log<CR>:profile func *<CR>:profile file *<CR>
nnoremap  <S-F12>        :<C-U>profile pause<CR>:noautocmd quitall!<CR>

" 重新定义:bd
nnoremap ZZ :Bdelete<CR>
nnoremap ZQ :q<CR>

" 修改帮助文件的默认选项,以方便保存
nnoremap <leader>nmr :set noreadonly<CR>:set modified<CR>

" 打开UltiSnipEdit
nnoremap <leader>sn :UltiSnipsEdit<CR>
" }}}

" 插件中的快捷键映射 {{{

" LaTeX Suite 快捷键
" 与UltiSnippets的向下跳转冲突
imap <C-,> <Plug>IMAP_JumpForward

" Tagbar 快捷键
" 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag
nnoremap <leader>tb :TagbarToggle<CR>

" }}}

" autocmd {{{
augroup vimrc
    autocmd!
augroup END

" 帮助窗口在右边垂直打开
" 相当于是重新定义了Help命令
" 使用的时候，输入大写 Help
command! -nargs=* -complete=help Help vertical belowright help <args>

" 根据文件类型设置折叠方案
autocmd vimrc BufNewFile,BufRead *.cpp,*.h set foldmethod=syntax

" 如果是 *.txt 配置折叠方式
autocmd vimrc BufNewFile,BufRead *.txt set foldmethod=marker

" 更加智能的当前行高亮
autocmd vimrc VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd vimrc VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd vimrc WinLeave * setlocal nocursorline

" 让insert和normal状态与airline的状态栏保持一直
autocmd vimrc InsertEnter * highlight! CursorLine ctermfg=229 ctermbg=24
autocmd vimrc VimLeave,WinLeave,BufWinLeave,InsertLeave * highlight! CursorLine ctermfg=235 ctermbg=148
autocmd vimrc VimEnter,WinEnter,BufEnter *  highlight! Visual term=bold ctermfg=130 ctermbg=229
" hi clear CursorLine
" hi clear Visual
" highlight! CursorLine ctermfg=229 ctermbg=24

" 总是在右边打开help文件
autocmd vimrc FileType help nested call Tools_HelpToTheRight()

" 让help文件也能参与到buflist中,这其实是没有必要的!一开始的想法是可以通过:bp 和
" :bn 找到 刚才打开的 Help 文件. 通过 jumplist 照样可以做到这一点! 所以,还是保持
" help 文件为 unlisted 的吧!
" autocmd vimrc FileType help setlocal buflisted


" python的代码格式配置
autocmd vimrc FileType python setlocal
              \ foldmethod=indent
              \ tabstop=4
              \ shiftwidth=4
              \ softtabstop=4
              \ textwidth=79
              \ expandtab
              \ autoindent
              \ fileformat=unix

" python格式化
autocmd vimrc FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>

" 保存视图
autocmd vimrc BufWinLeave * if expand("%") != "" | mkview | endif
autocmd vimrc BufWinEnter * if expand("%") != "" | loadview | endif" }}}
" }}}2

" userline {{{2
let g:status_var = ""
set statusline=\ %<%F[%0*%M%*%n%R%H]\ %{''.g:status_var}%=\ %y\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %v:%l/%L%)
" }}}2

" }}}1

" Plugin: {{{1

" Plugin Management: {{{2
" 配置plug存放插件的文件夹
" - 避免使用vim预留的文件夹名称，如'plugin'
"https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

if filereadable(expand('~/.vim/.vimrc.plug'))
  	source ~/.vim/.vimrc.plug
endif

call plug#end()            " required
" }}}2

" gruvbox 颜色 {{{2
"

" 要将 ~/.vim/plugged/gruvbox/gruvbox_256palette.sh
" 放到.bashrc文件中，否则terminal显示不正确

" 在gnome的term中显示斜体
let g:gruvbox_italic=1

" 默认就是256颜色
let g:gruvbox_termcolors=256

let g:gruvbox_invert_indent_guides=1

let g:gruvbox_invert_selection=1

" 针对C语言的语法增强功能
let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1

" set background=dark
set background=dark

colorscheme gruvbox

" 在tmux中总是有背景颜色
" 参考:https://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmuxhttps://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux
if $COLORTERM == 'gnome-terminal'
      set t_Co=256
endif
set t_ut=

" }}}2

" ATP_VIM latex {{{2

let b:atp_TexCompiler="xelatex"
let b:atp_BibCompiler="bibtex"
let b:atp_TexOptions="-synctex=1"
let b:atp_auruns=5
let b:atp_running=1

" 允许折叠
" 重新折叠方法 :filetype detect
"  g:atp_fold_environments = [] 一般不配置，折叠环境变量
" 会导致vim的速度明显下降
let g:atp_folding=0

let b:atp_TexFlavor="tex"
let g:askforoutdir=1
let b:atp_OpentViewer=1

" 按下<F6>键，删除所有中间文件
let g:atp_delete_output=1

" 显示Progress Bar
let g:atp_ProgressBar=1

" 显示错误信息
let g:atp_signs=1

" 在状态栏显示tex是否运行了
let g:atp_statusNotify=1

" 在omnifunc时使用tab补全
let g:atp_tab_map=1

" 添加amsmath自动补全功能
let g:atp_amsmath=1

" 只有处于math环境时候才自动补全
let g:atp_check_if_math_mode = 1
" }}}2

" Nerd Comment  {{{2
" 默认leader为"\"
" \cc  --  注释
" \cu  --  取消注释
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" }}}2

" NERDTree {{{2
" 文件按照数字大小排序
let g:NERDTreeNaturalSort=1

" 采用WildIgnore中配置的忽略选项
let g:NERDTreeRespectWildIgnore=1

" 显示Bookmark收藏的文件夹
let g:NERDTreeShowBookmarks=1

" 显示隐藏文件夹
let g:NERDTreeShowHidden=1

" 显示行号
let g:NERDTreeShowLineNumbers=1

" 位于左边还是右边
let g:NERDTreeWinPos="left"

" 窗口大小
let g:NERDTreeWinSize=35

" =1 不显示’Press ？ for help'文本信息
let g:NERDTreeMinimalUI=0

" 选择文件后自动关闭窗口
let NERDTreeQuitOnOpen=1
" }}}2

" UltiSnips  {{{2
"

" 自定义snippets所在目录
let g:UltiSnipsSnippetDirectories=['mysnippets','UltiSnips']

" 自定义snippets的具体路径，不能写错了，写错就会导致程序失效
let g:UltiSnipsSnippetsDir = '~/.vim/plugged/ultisnips/mysnippets'

" 重定义tab展开自动补全的方式
" let g:UltiSnipsExpandTrigger = "<c-j>"
" 这种方法已经不再适用了，直接在YCM中可以定义<tab>键与 supertab 和 ultisnipets
" 的兼容性。
" }}}2

" Tagbar  {{{2
"
" 设置 tagbar 子窗口的位置出现在主编辑区的左边
let g:tagbar_left=1

" 设置标签子窗口的宽度
let g:tagbar_width=32

" tagbar 子窗口中不显示冗余帮助信息
let g:tagbar_compact=1

" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0',
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }
" }}}2

" Easy-align  {{{2
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}2

" limelight  {{{2
"

" Limelight [0.0 ~ 1.0]
"     Turn Limelight on
" Limelight!
"     Turn Limelight off
" Limelight!! [0.0 ~ 1.0]
"     Toggle Limelight

" 显示颜色
let g:limelight_conceal_ctermfg = 'gray'

" 透明度
let g:limelight_default_coefficient = 0.7

" 上下包含几个段落
let g:limelight_paragraph_span = 1

" 对10个高亮搜索结果使用此方案
let g:limelight_priority = 0

" 段落开始和结束位置
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
" }}}2

" Cusor Shape {{{2
" 使用光标形状指示I和N状态

" 参考
" 1. 代码参考 http://vim.wikia.com/wiki/Configuring_the_cursor
"             https://github.com/guns/haus/blob/master/etc/vim/local/tty.vim
" 2. 转义序列 https://ttssh2.osdn.jp/manual/en/usage/tips/vim.html
" 3. The Termcap Library http://www.delorie.com/gnu/docs/termcap/termcap_toc.html

" 命令:
" 1.查看termcap的定义 :set termcap?
" 2.vim中键盘标识符的含义 :h key-notation
" 3.查看某个按键的转义 $sed -n l

" 1 or 0 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> solid underscore
" 5 -> blinking vertical bar
" 6 -> solid vertical bar

" 似乎在判断term时出现了问题,导致t_SI无法正确配置
" 需要知道gnome的term名称
" if &term =~"xterm"
"   " 开始插入模式t_SI，underline red
"   let &t_SI = "\<Esc>]12;rgb:FF/15/00\x7"
"   " 结束插入模式t_EI，green
"   let &t_EI = "\<Esc>]12;rgb:10/D3/02\x7"
"   " solid underscore
"   let &t_SI .= "\<Esc>[3 q"
"   " solid block
"   let &t_EI .= "\<Esc>[2 q"
"   "  :so % 命令之后，重置光标为Normal下green颜色
"   silent !echo -ne "\033]12;rgb:10/D3/02\007"
"   " reset cursor when vim exits
"   autocmd vimrc VimLeave * silent !echo -ne "\033]112;gray\007"
"   " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
" endif


" let g:togglecursor_insert='blinking_line'
" let g:togglecursor_default='blinking_block'
" let g:loaded_togglecursor = 0

"
" if has("autocmd")
"   au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
"   au InsertEnter,InsertChange *
"     \ if v:insertmode == 'i' |
"     \   silent execute '!echo -ne "\e[6 q"' | redraw! |
"     \ elseif v:insertmode == 'r' |
"     \   silent execute '!echo -ne "\e[4 q"' | redraw! |
"     \ endif
"   au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
" endif
" }}}2

" You Complete Me {{{2
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" 让Vim的补全菜单行为与一般IDE一致
set completeopt=longest,menu

" 不用每次提示加载.ycm_extra_conf.py文件
let g:ycm_confirm_extra_conf = 0

" 关闭ycm的syntastic
let g:ycm_show_diagnostics_ui = 0

" 评论中也应用补全
let g:ycm_complete_in_comments = 1

" 两个字开始补全
let g:ycm_min_num_of_chars_for_completion = 2

" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files=1

" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0

" 关键字补全
let g:ycm_seed_identifiers_with_syntax = 1

""上下左右键的行为 会显示其他信息
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-k>\<C-j>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-k>\<C-j>" : "\<PageUp>"

let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_semantic_triggers =  {'c' : ['->', '.'], 'objc' : ['->', '.'], 'ocaml' : ['.', '#'], 'cpp,objcpp' : ['->', '.', '::'], 'php' : ['->', '::'], 'cs,java,javascript,vim,coffee,python,scala,go' : ['.'], 'ruby' : ['.', '::']}

" autocmd BufRead *.py nnoremap <C-]> :YcmCompleter GoTo<CR>
" autocmd BufRead *.js nnoremap <C-]> :TernDef<CR>
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

let g:ycm_filetype_blacklist= {
    \'tex':1,
    \'txt':1
    \}
" }}}2

"  Netrw {{{2

"  关闭上半部分的提示信息栏
let g:netrw_banner=0

" 等同于P，打开前次窗口
let g:netrw_browse_split=4

" 分割后的新窗口出现在右边
let g:netrw_altv=1

" 默认为Treelist
let g:netrw_liststyle=3

" 决定使用哪种方法处理特殊应用程序
let g:netrw_browsex_viewer= "gnome-open"
" http://coderschool.cn/1853.html

" 目录和文件的显示顺序不同
let g:netrw_sort_sequence = '[\/]$,*'

" 控制Lexplore的大小，35表示占用屏幕35%的大小
let g:netrw_winsize=35
" }}}2

" Calendar {{{2
" 颜色
let g:calendar_frame = 'default'

" 标题
let g:calendar_message_prefix="日历"

" 让光标定位在今天日期上
let g:calendar_focus_today = 1

let g:calendar_mruler = '一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月'
let g:calendar_wruler = '日 一 二 三 四 五 六'
let g:calendar_navi_label = '往前,今日,往后'

let g:calendar_view="week"

" 链接google服务器
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" }}}2

" AG {{{2
" 配置参考
" http://kkpattern.github.io/2015/05/09/Wonderful-Vim-Plugins.html

" 高亮搜索结果
let g:ag_highlight=1
let g:ag_apply_lmappings=1
let g:ag_qhandler="copen 10"
let g:ag_mapping_message=1
" 官方建议配置
let g:ackprg = 'ag --vimgrep --smart-case'
" }}}2

" Cheat40 {{{2
" 不使用默认的cheat40.txt
let g:cheat40_use_default = 0
" }}}2

" Command-T {{{2
" Command-T 设计理念是假设使用者大致知道自己文件放在什么位置，
" 与NERDTree 的设计理念不同，后者假设使用者对文件夹的目录层次
" 一无所知。因此，Command-T 最有效率的查找方式是 'path-centric'
" 而不是按照 ‘filename-centric' 的方式查找
"
" lib/third-party/adapters/restful-services/foobar/foobar-manager.js
"
" 效率低下: foobar-manager.js
" 效率高效: librestfoofooman 可以逐步确认所在文件夹的层次
"
" 使用当前的 pwd 配置进行扫描
let g:CommandTTraverseSCM='pwd'

" 默认情况下，不扫描dot开头的文件夹，例如：~/.vim 是不扫描的
" 如果不开启，必须 :cd ~/.vim，然后执行 :CommandT
let g:CommandTScanDotDirectories=1

" 只在查找列表中显示 30 个结果，能保证效率
let g:CommandTMaxHeight = 30

" 在复杂目录结构中，可能文件数量很多，调高文件数量上限
let g:CommandTMaxFiles = 500000

" 即时查找的响应速度
let g:CommandTInputDebounce = 50

" 最多在内存中缓冲10个不同的目录
let g:CommandTMaxCachedDirectories = 10

" 根据大小写进行智能匹配
let g:CommandTSmartCase = 1

" 超过50000个文件，不用此配置
let g:CommandTRecursiveMatch = 0

" }}}2

" h-insearch {{{2
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" 查找完毕后自动关闭结果高亮
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" }}}2

" ale {{{2
"
  let g:ale_sign_error = '>>'
  let g:ale_sign_warning = '--'
  let g:ale_fix_on_save = 1
  let g:ale_sign_column_always = 0
  let g:ale_vim_vint_show_style_issues=1
  let g:ale_linters={'vim':['vint'],'python':['pylint']}
" }}}2

" jedi {{{2
"
let g:jedi#goto_assignments_command = '<C-]>'
let g:jedi#usages_command = '<C-u>'
let g:jedi#documentation_command = '<C-g>'
" }}}2

" pydict {{{2
"
let g:pydiction_location = '~/.vim/plugged/Pydiction/complete-dict'
let g:pydiction_menu_height = 30
" }}}2

" asynrun {{{2
"
    autocmd vimrc FileType python nnoremap <buffer> <F5> :update<Bar>execute 'AsyncRun! python '.shellescape(@%, 1)<CR>
    autocmd vimrc FileType python nnoremap <buffer> <LocalLeader>cc :update<Bar>execute 'AsyncRun! python '.shellescape(@%, 1)<CR>
    autocmd vimrc FileType python nnoremap <buffer> <LocalLeader>cs :update<Bar>execute 'AsyncStop!'<CR>
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(10, 1)

    " 打开输出窗口
    noremap <silent> <F9> :call asyncrun#quickfix_toggle(10,1)<cr>

    " 关闭输出窗口
    noremap <silent> <F10> :call asyncrun#quickfix_toggle(10,0)<cr>

" }}}2

" easy-clipboard {{{2

" 单行粘贴和多行粘贴都将光标放在末尾处
let g:EasyClipAlwaysMoveCursorToEndOfPaste=1

" vim默认复制一段文字之后，将光标放在这段文字起始的位置。
" 这项配置保证复制文字之后，光标停留在原来的位置。
let g:EasyClipPreserveCursorPositionAfterYank=1

" vim不允许两个vim进程共享剪贴板的内容。开启此选项后
" 1. 两个vim就能够共享剪贴板数据了
" 2. 还可以保证下次启动VIM自动恢复50条剪贴板数据
" 3. 必须首先在$HOME目录下先建立1个.easyclip文件
let g:EasyClipShareYanks=1

" 原来的复制的数据如果有indent，则粘贴的数据自动去掉indent
let g:EasyClipAutoFormat=1

" 开启替换模式
let g:EasyClipUseSubstituteDefaults=1

" 插入模式下的粘贴方式
imap <c-v> <plug>EasyClipInsertModePaste

map <silent> gs <plug>SubstituteOverMotionMap
nmap gss <plug>SubstituteLine
xmap gs <plug>XEasyClipPaste

" 命令行模式下粘贴
cmap <c-v> <plug>EasyClipCommandModePaste

" 使用系统的clipboard
set clipboard=unnamedplus
" }}}2

" bufexplorer {{{2

let g:bufExplorerDefaultHelp=0      " Do not show default help.
let g:bufExplorerDetailedHelp=0     " Do not show detailed help.
let g:bufExplorerSortBy='mru'       " Sort by most recently used.
let g:bufExplorerShowTabBuffer=0    " No.
let g:bufExplorerShowNoName=1
let g:bufExplorerShowRelativePath=0 " Show absolute paths.
let g:bufExplorerSplitOutPathName=1 " Split the path and file name.

let g:bufExplorerSplitRight=1       " Split right.
let g:bufExplorerSplitBelow=1       " Split new window below current.
let g:bufExplorerSplitRight=1       " Split right.
let g:bufExplorerSplitHorzSize=40   " New split window is n rows high.
let g:bufExplorerVertSize=40        " New split window is n columns wide.

let g:bufExplorerDisableDefaultKeyMapping=1    " Disable mapping.
nnoremap <silent> <leader>bu :ToggleBufExplorer<CR>
" }}}

" 输入法的问题 {{{2

" 中文输入法切换。需要修改fcitx的源代码，源代码中从Normal状态进入到
" Insert状态时，自动切换到了中文输入法，这不符合我的习惯，在源代码
" 中找到类似于下面的代码，注释即可
" autocmd InsertEnter * call Fcitx2zh()
" 另外，我还修改了 InsertEnter 的行为，在进入 Normal 的时候准备状态是
" 英文输入法。
" Noraml ---> Insert(英文输入) ---> Normal (英文输入)
"             按1次shift，中文      命令状态，英文输入
" 这个方案实在是完美！！！
" }}}

" BBye {{{2

nnoremap <Leader>q :Bdelete<CR>
" }}}

" notes {{{2
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.txt'

" }}}2
" }}}1

" Functions: {{{1

" Redir {{{
" 在类似于scriptname,highlight命令的结果中搜索
function! RedirTofile(vcmd)
     redir @a
     silent execute a:vcmd
     redir END
     enew
     put! a
     silent w! ~/.vim/.stemp
endfunction
command! -nargs=+ -complete=command Redir :call RedirTofile(<f-args>)
" }}}

" previous_cursour {{{2
" 0:up, 1:down, 2:pgup, 3:pgdown, 4:top, 5:bottom
function! Tools_PreviousCursor(mode)
    if winnr('$') <= 1
	return
    endif
    noautocmd silent! 2wincmd w
    if a:mode == 0
	exec "normal! \<c-y>"
    elseif a:mode == 1
	exec "normal! \<c-e>"
    elseif a:mode == 2
	exec "normal! ".winheight('.')."\<c-y>"
    elseif a:mode == 3
	exec "normal! ".winheight('.')."\<c-e>"
    elseif a:mode == 4
	normal! gg
    elseif a:mode == 5
	normal! G
    elseif a:mode == 6
	exec "normal! \<c-u>"
    elseif a:mode == 7
	exec "normal! \<c-d>"
    elseif a:mode == 8
	exec "normal! k"
    elseif a:mode == 9
	exec "normal! j"
    endif
    noautocmd silent! wincmd p
endfunc
" }}}

function! Tools_HelpToTheRight()
    if !exists('w:to_right') || w:to_right != 'right'
	let w:to_right = 'right'
	wincmd L
    endif
endfunction

function! Tools_ReadRefMode()
    if winnr('$')<=1 || winnr()==2
	return
    endif
    let bname=bufname(winbufnr(1))
    noautocmd silent! 2wincmd w
    exec "edit ".bname
    noautocmd silent! 1wincmd w
    exec "normal! \<c-^>"
endfunction
" }}}1

" vim: tw=80:ts=8:foldmethod=marker:filetype=vim:fo-=or:fo+=m:
