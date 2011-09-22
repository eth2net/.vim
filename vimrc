"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>General
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
call pathogen#runtime_append_all_bundles("addons")
call pathogen#helptags()

"colorscheme delek
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

if has('gui_running')
  set guifont=Monaco\ 12
endif

" iautoscroll.vim
let g:IAutoScrollMode="on"

highlight WhiteSpaceEOL ctermbg=darkgreen
match WhiteSpaceEOL /\s\+$/
set t_Co=256
set background=dark
colorscheme solarized
"colorscheme torte
"colorscheme mydesert
"colorscheme desert
"let g:solarized_termcolors=256

"Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

"set mouse=a
"set selection=exclusive
"set selection=inclusive
"set selectmode=mouse,key

" 寄存器和系统剪贴板共享
" share system clipboard.
"set clipboard+=unnamed

" Search
set hlsearch
set incsearch
nmap <leader><space> :noh<cr>

" Sets how many lines of history VIM has to remember
set history=300

" Set fileencodings
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Set statusline
set statusline=%F%m%r%h%w\ [Branch=%{GitBranch()}]\ [POS=%04lL,%04vC][%p%%\ OF\ %L]\ %=[FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=0x\%02.2B]
set laststatus=2

" Enable filetype plugin
filetype on
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd bufwritepost *vimrc* source ~/.vimrc

"Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>

" Setting path
set path=.,/usr/include,,/usr/share/vim/vim72/**

" Moving
set whichwrap=s,<,>,[,] " 光标从行首和行末可以跳到另一行

" Setting seesionoptions
"set sessionoptions-=curdir
"set sessionoptions+=sesdir

"Switch FlieTab
"When edit a new file,switch to new tab
function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" => Files and backups
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>User Interface
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
syntax enable "代码高亮
set showcmd
set showmatch " 括号匹配 Show matching brackets.
set matchtime=5 " 匹配时间 time=0.1s
set smartcase " Do smart case matching
set mouse=a " Enable mouse usage (all modes)

set fdm=manual " foldmethod代码折叠(manual,indent,expr,syntax,diff,maker)
set number " 显示行号
set autoindent " 自动缩进

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>Tab indent related
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
set tabstop=4 "Tab宽度
set expandtab "Tab转换为空格
set shiftwidth=4 "缩进宽度
set smarttab "智能删除Tab

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>Maps
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
inoremap jj <ESC>

"indent
"noremap <silent> <S-Tab> @='<<'<CR>
"noremap <Tab> @='>>'<CR>
nmap <tab> v>
nmap <s-tab> v<

" Tag List Open/Close
map <silent> <F9> :TlistToggle<cr>

" Netrw Open
" nmap <silent> <leader>fe :Sexplore!<cr>
" NERDTree
map <F2> :NERDTreeToggle<cr>

" Open BufExplorer
"nmap <silent> <C-b> <leader>be

" Paste mode
nmap <F3> :set pastetoggle<CR>

" 选中一段文字并全文搜索这段文字
" via http://hotoo.googlecode.com/svn-history/r297/vimwiki/Vim.html#toc_1.4.3
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"vnoremap $q <esc>`>a'<esc>`<i'<esc>
"vnoremap $e <esc>`>a"<esc>`<i"<esc>

" python_fn
map ;c ]#
map ;u ]u

" windows
nmap <C-h> :bp<cr>
nmap <C-l> :bn<cr>

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>Tab control
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"map <leader>tn :tabnew %<cr>
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove

" PHP
"autocmd FileType php set tabstop=8 | set expandtab | set shiftwidth=8 | set smarttab

" Python
autocmd BufRead *.py nmap <F6> :w !clear;python % 
autocmd BufNewFile *.py 0r ~/.vim/skeleton/skeleton.py

" Shell
autocmd BufNewFile *.sh 0r ~/.vim/skeleton/skeleton.sh

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>Omni Complete
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
set completeopt=longest,menu

inoremap <expr> <CR> pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J> pumvisible()?"\<C-N>":"\<C-X><C-O>"
inoremap <expr> <C-K> pumvisible()?"\<C-P>":"\<C-K>"
inoremap <expr> <C-U> pumvisible()?"\<C-E>":"\<C-U>"

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>Ctags
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"set tags = tags
"nmap <F3> :!ctags -R

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>Tag List
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
let Tlist_Ctags_Cmd = '/usr/bin/ctags' "设定linux系统中ctags程序的位置
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
let Tlist_File_Fold_Auto_Close = 1 "taglist只显示当前文件tag，其它文件的tag都被折叠起来
let Tlist_GainFocus_On_ToggleOpen = 1 "使用:TlistToggle打开taglist窗口时，输入焦点在taglist窗口中

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>pydiction
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"let g:pydiction_location = '/home/york/.vim/addons/pydiction/complete-dict'
"let g:pydiction_menu_height = 20

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>netrw setting 文件管理器
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
let g:netrw_winsize = 30
nmap <silent> <leader>fe :Sexplore!<cr>

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>SuperTab
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-x><C-u>"
"let g:SuperTabDefaultCompletionType="context"

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>NeoComplCache
"http://sinolog.it/?p=1399
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
let g:neocomplcache_disable_auto_complete = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_smart_case = 1
"imap <slient><C-l> (neocomplcache_snippets_expand)
"smap <slient><C-l> (neocomplcache_snippets_expand)

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>AutoComplPop
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"let g:acp_enableAtStartup = 0

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>BufExplorer
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
let g:bufExplorerDefaultHelp=0 " Do not show default help.
let g:bufExplorerShowRelativePath=1 " Show relative paths.
let g:bufExplorerSortBy='mru' " Sort by most recently used.
let g:bufExplorerSplitRight=0 " Split left.
let g:bufExplorerSplitVertical=1 " Split vertically.
let g:bufExplorerSplitVertSize = 30 " Split width
let g:bufExplorerUseCurrentWindow=1 " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>miniBufExpl
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
let g:miniBufExplTabWrap = 1
let g:miniBufExplMapWindowNavVim = 1 " 可以使用<C-h,j,k,l> 切换到上下左右窗口
let g:miniBufExplMapWindowNavArrows = 1 " 可以使用<C-箭头键>切换到上下左右窗口
let g:miniBufExplForceSyntaxEnable = 1

" <C-Tab>    向前循环切换到每个buffer 上,并在当前窗口打开
" <C-S-Tab>   向后循环切换到每个buffer 上,并在当前窗口打开
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>surround
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" html#django
autocmd FileType html let g:surround_{char2nr("j")} = "{{ \r }}"
autocmd FileType html let g:surround_{char2nr("f")} = "{% \r %}"

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>winmanager
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"let g:winManagerWindowLayout = \"BufExplorer,FileExplorer|TagList\"
"let g:winManagerWindowLayout = \"FileExplorer\"
"let g:winManagerWidth = 30
"let g:defaultExplorer = 0
"nmap <silent> <leader>wm :WMToggle<cr>
"nmap <C-W><C-F> :FirstExplorerWindow<cr>
"nmap <C-W><C-B> :BottomExplorerWindow<cr>

"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"=>Vimwiki
"'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
let g:vimwiki_use_mouse = 1
let g:vimwiki_CJK_length = 1
let g:vimwiki_list = [{'path': '~/vimwiki/wikifile',
            \ 'path_html': '~/vimwiki',
            \ 'auto_export': 1,
            \ 'html_header': '~/vimwiki/header.tpl',
            \ 'html_footer': '~/vimwiki/footer.tpl',}]

set mouse=
set clipboard+=unnamed
