" This must be first, because it changes other options as a side effect.
set nocompatible

" On Windows use '.vim' instead of 'vimfiles' to make sync easier
let s:ms_win = (has('win16') || has('win32') || has('win64'))
if s:ms_win
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    set shell=/bin/sh
endif

" -------
" Plugins
" -------
"filetype off
" vim-plug used to manage plugins. Can be installed/updated like follows:
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

" NOTE comments after Plugin command are not allowed...
" ------------------
" Plugins. Interface
" ------------------
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'ervandew/supertab'

Plug 'vim-scripts/IndexedSearch'

Plug 'mattn/emmet-vim'

Plug 'mhinz/vim-startify'

" UltiSnips supports nested placeholders, tabstops and outperforms snipMate
" in several other cases. Needs Python 2.6+ or 3
"Plug 'vim-scripts/UltiSnips'

" Runs ag (grep like tool) from Vim and shows result in a split
" $ sudo apt-get install silversearcher-ag
Plug 'rking/ag.vim'

" ---------------------
" Plugins. Text editing
" ---------------------
Plug 'kana/vim-textobj-user'

" Text objects for entire buffer, yae == Yank All Entire. Needs vim-textobj-user
Plug 'kana/vim-textobj-entire'

Plug '907th/vim-auto-save'

" Enables transparent pasting into vim, no more :set paste!
Plug 'ConradIrwin/vim-bracketed-paste'

Plug 'scrooloose/nerdcommenter'

" Syntastic runs external syntax checkers and displays all results in vim
Plug 'scrooloose/syntastic'

" Nice status/tabline inspired on powerline
"Plug 'bling/vim-airline'

" Nice status/tabline inspired on powerline but without fancy chars
" TODO show trailing whitespace error in status line
Plug 'itchyny/lightline.vim'

" Treesome allows conflict resolution using tree-way merge. Needs Python 2.5+
Plug 'sjl/splice.vim'

Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'

" Show git status (added, modified and removed lines) next to the line numbers
Plug 'airblade/vim-gitgutter'

Plug 'Shougo/unite.vim'

" Interactive command execution. Unite needs it
" $ cd ~/.vim/plugin/vimproc.vim && make -f make_unix.mak
"Plug 'Shougo/vimproc.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Shows most recent updated files in Unite
Plug 'Shougo/neomru.vim'

" Shows outline for vim buffer like Eclipse/Outline or IDEA/Structure
Plug 'Shougo/unite-outline'

" Shows tags in a window, ordered by scope
" $ sudo apt-get install exuberant-ctags
Plug 'majutsushi/tagbar'

" Keyword completion system. Lua
" TODO enabled autocompletion sometimes add artifacts in line
" In general this plugin looks like best avaiable option
" Plug 'Shougo/neocomplete.vim'


"Plugin "neocomplcache"
"Plugin "neocomplcache-snippets-complete"

" Set of defaults that everyone can agree on
" TODO it sets shell to bash. consider use zsh as shell for vim
Plug 'tpope/vim-sensible'

" ------------------
" Plugins. Movements
" ------------------
" Jumps to any location specified by two characters
"Plug 'justinmk/vim-sneak'

" --------------------
" Code display plugins
" --------------------
" Visually display indent levels. Vim 7.2+
Plug 'nathanaelkane/vim-indent-guides'

" Highlights all trailing whitespaces and provides :StripWhitespace function
" TODO does editorconfig will highlight trailing whitespace?
Plug 'ntpeters/vim-better-whitespace'

" -------------------------
" Language support plugins
" -------------------------
" Use settings from .editorconfig file. Needs Python or editorconfig-core
" FIXME Do not forget to call :EditorConfigRelad after each conf change
Plug 'editorconfig/editorconfig-vim'

Plug 'marijnh/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }

Plug 'rollxx/vim-antlr'

Plug 'PotatoesMaster/i3-vim-syntax'

"TODO: evaluate this plugin
Plug 'PProvost/vim-ps1'

"TODO: evaluate this plugin
Plug 'mutewinter/nginx.vim'

Plug 'ekalinin/Dockerfile.vim'
"TODO: check also this alternative
"Plug 'honza/dockerfile.vim'

" Python language. Integrates pylint, rope, pydoc, etc
" Required Vim with Python support: vim --version | grep [+-]python
"Plug 'klen/python-mode'

" Go language. Integrates gocode, gofmt, godef, godoc, goimports, golint, etc
" TODO run :GoInstallBinaries in post update hook
Plug 'fatih/vim-go', { 'for': 'go' }

" Wisely add closing 'fi/esac/done' in Bash, Ruby, VimL, VB, Lua
Plug 'tpope/vim-endwise'

" Different colors for attrbutes and values, folding, syntax warnings.
" JSON, CSON and JSONP are supported
Plug 'elzr/vim-json'

Plug 'mustache/vim-mustache-handlebars'

" Highlight syntax in markdown code block
Plug 'joker1007/vim-markdown-quote-syntax'

" Highlight syntax and fix indentation for Ansible's dialect of YAML
Plug 'chase/vim-ansible-yaml'

Plug 'cespare/vim-toml'

" ----------------------
" Plugins. Color schemes
" ----------------------
" Use this color scheme for Python
Plug 'nanotech/jellybeans.vim'

" TODO Double check this is the best for Golang
Plug 'fatih/molokai'
Plug 'morhetz/gruvbox'

" All of your Plugins must be declared before the following line
call plug#end()

" ----------------
" General settings
" ----------------
set autowrite " automatically write a file when leaving a modified buffer
set shortmess+=I " Do not show welcome screen (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore " allow for cursor beyond last character

"set spell " TOOD consider enable spell checking

" -----------------------
" Backup/restore settings
" -----------------------
set backup " backups are nice ...
set undofile " so isersistent undo ...
set undolevels=1000 " number of changes that can be undone
set undoreload=10000 " number lines to save for undo on a buffer reload
" InitializeDirectories call below will ensure that required dirs exists

" Make Vim save/load view (state) - folds, cursor, etc
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" TODO combine this settings with au BufWinLeave/Enter from spf13-vim
" Load last edit session
"set viminfo='10,\"100,:20,%,n~/.viminfo
" Put cursor into text line from last edit session
"au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" ------------------
" Interface settings
" ------------------
" set nonumber " Do not show line numbers. Line numbers are always shown in
             " status line; moreover ':N' command allows quckly navigate
             " into specified line
scriptencoding utf-8
"TODO sensible set utf-8 but with some conditional
set encoding=utf-8 " Character encoding used inside Vim.
set fileencodings=utf-8,cp1251,cp866,koi8-r,latin1 " File encoding detection.
set wildmode=list:longest,full " zsh-like command autocompletion.
set wildignore+=.hg,.git,.svn,.bzr " Version control
set wildignore+=*.DS_Store         " Apple OS X
set wildignore+=Thumbs.db          " Windows
set wildignore+=*.pyc              " Python
set title " Window title will be set to the value of 'titlestring'
          " (if it is not empty), or to: filename [+=-] (path) - VIM
" Autocompletion options
set completeopt=longest,menuone

" TODO use nowrap by default + add shortcut to toggle wrap modes
set nowrap
"set wrap " Soft wrapping for long lines (http://vimcasts.org/episodes/soft-wrapping-text/)
if version >= 703
    set colorcolumn=80 " Highlight ruler for 80th column
end
"set textwidth=80
"set formatoptions-=o    " Do not continue comments when pushing o/O
set linebreak           " Перенос не разрывая слов
set smartindent         " Enable smart in addition to auto indents
" Conflicts with EditorConfig?
"set expandtab
"set shiftwidth=4        " Размер сдвига при нажатии на клавиши << и >>
"set tabstop=4           " 4 chars for both soft- and hard-tabs
"set softtabstop=4
set linespace=1         " add some line space for easy reading
set cursorline          " Highlight line under cursor
set guioptions=         " Hide all GUI elements. ,g toggles visibility
set gcr=n:blinkon0      " Disable cursor bilinking in graphic mode
set guicursor=
set splitbelow          " :sp commend will open new split below the current one
set splitright          " :vsp command will open new vertical split on the right side
"set mouse=a " Mouse is always enabled
set mouseshape=s:udsizing,m:no " turn to a sizing arrow over the status lines
"set mousehide " Hide the mouse when typing text

" Turn off both visual and sound bell.
" TODO novisualbell enables sound bell for some reason
"    set visualbell
"    set t_vb=

" Show ↪ at the beginning of wrapped lines
    if has('linebreak')
        let &sbr = nr2char(8618).' '
    endif

" Menu for switching file encoding
"        menu Encoding.UTF-8        :e ++enc=utf-8<CR>
"        menu Encoding.Windows-1251 :e ++enc=cp1251<CR>
"        menu Encoding.cp866        :e ++enc=cp866<CR>
"        menu Encoding.KOI8-R       :e ++enc=koi8-r<CR>
"        menu Encoding.KOI8-U       :e ++enc=koi8-u<CR>

"        set wcm=<Tab>
"        map <F8> :emenu Encoding.<TAB>

" Search
" TODO vim-sensible maps :hohlsearch to <C-L>, consider use <Esc><Esc>
set hlsearch    " Highlight finded text
set ignorecase  " Make search case insensitive
set smartcase   " Override the 'ignorecase' if the search pattern contains
                " upper case characters
set gdefault    " Enable flag g in replace commands, like :%s/a/b/

" ------------------
" Keyboard shortcuts
" ------------------
" Map <leader> on Space instead of backslash \ or comma ,
let mapleader = "\<Space>"

" TODO consider remove this. Use vim-autosave-instead
" <leader>w saves file - a lot faster than :w<Enter>
"nnoremap <leader>w :w<CR>

" <leader>l toogles `set list` in normal mode
nmap <leader>l :set list!<CR>

if isdirectory(expand("~/.vim/plugged/vim-fugitive/"))
    nnoremap <silent> <leader>gws :Gstatus<CR>
    nnoremap <silent> <leader>gwd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    "nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Gitush<CR>
    "nnoremap <silent> <leader>gr :Gread<CR>
    "nnoremap <silent> <leader>gw :Gwrite<CR>
    "nnoremap <silent> <leader>ge :Gedit<CR>
endif

" TODO consider remove. Use vim-bracketed-paste instead
" <leader>p toggles auto-indenting for codepaste (i.e. text reformat)
"set pastetoggle=<leader>p

" ,f NOT WORKING. Original implementation were using Ack instead grep.
    " Fast grep
    " грепает в текущей директории по слову, на котором стоит курсор
    "map <leader>f :execute "Ack " . expand("<cword>") <Bar> cw<CR>
    "map <leader>f :execute "grep --binary-files=without-match -e " . expand("<cword>") . " " <Bar> cwindow<CR>
    " Run :Ag then switch focus into original split and then switch back
    " into original buffer
    map <leader>f :Ag -i <C-R>=expand("<cword>")<CR> <CR>:wincmd k<CR>:bprev<CR>

" Перемещение строк
    " переместить одну строку
    nmap <C-S-k> ddkP
    nmap <C-S-j> ddp
    " переместить несколько выделенных строк http://www.vim.org/scripts/script.php?script_id=1590
    vmap <C-S-k> xkP'[V']
    vmap <C-S-j> xp'[V']

" TODO consider remove those shortuts because C-l conflicts with vim-sensible
" Switch splits using simpler shortcuts
"    nmap <C-h> <C-W>h
"    nmap <C-j> <C-W>j
"    nmap <C-k> <C-W>k
"    nmap <C-l> <C-W>l

" n and N will show current search result entry in the center of the screen
    nmap n nzz
    nmap N Nzz
    nmap * *zz
    nmap # #zz
    nmap g* g*zz
    nmap g# g#zz

" ,b
"    vmap <leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>


" Ctrl+t opens and Ctrl+w closes tab in both Normal/Insert modes
    nnoremap <C-t> :tabnew<CR>
    inoremap <C-t> <Esc>:tabnew<CR>
    nnoremap <C-w> :tabclose<CR>
    inoremap <C-w> <Esc>:tabclose<CR>

    " These following maps should be already working, but are not
    " on my console!  Using Ctrl-V to send exact char.
    " These are for urxvt NOT WORKING IN XTERM
    map  [5^   :tabn<CR>   " C-PageUp
    map  [6^   :tabp<CR>   " C-PageDown

    " Again, on virtual terminal using GNU Screen NOT WORKING IN XTERM
    map  [5~   :tabn<CR>   " C-PageUp
    map  [6~   :tabp<CR>   " C-PageDown

" Tab and Shift-Tab switches opened tabs in normal mode
    nmap <Tab> gt
    nmap <S-Tab> gT

" TODO Remove backup settings because spf13-vim approach was used
" Backup and swap files
"    set nobackup   " Disable backup file creation
"    set noswapfile " Disable swap file creation
    "set backupdir=~/.vimi/bac//,/tmp " Directory for storing backup files
    "set directory=~/.vimi/swp//,/tmp " Directory for storing swap files

" Apply configuration from .vimrc file right after saving it
if has("autocmd")
    autocmd! BufWritePost $MYVIMRC nested source $MYVIMRC
endif

" GUI Font
if has('gui_gtk2')
    set guifont=Inconsolata\ for\ Powerline\ 16
elseif has('gui_win32')
    set guifont=DejaVu\ Sans\ Mono:h11:cDEFAULT
endif

" Plugin configuration

" Appearance. Tab-Name shows tab numbers in tab line
"    Plug 'vim-scripts/Tab-Name'

" --------------------
" Color theme settings
" --------------------
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
endif

" JellyBeans theme
"let g:jellybeans_background_color = "080808" " 151515 by default
"colorscheme jellybeans
colorscheme gruvbox
set background=dark
"colorscheme molokai
"let g:rehash256 = 1
"let g:molokai_original = 1

" Enable transparent background
autocmd ColorScheme * highlight Normal ctermbg=None
autocmd ColorScheme * highlight NonText ctermbg=None

" ----------------
" Airline settings
" ----------------
set noshowmode " Hide default mode text (e.g. --INSERT-- ) below statusline
"let g:airline_theme = 'dark'
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#virtualenv#enabled = 1

" Remove all fancy symbols in vim-airline
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = '|'
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = '|'
"let g:airline_branch_prefix     = ''
"let g:airline_readonly_symbol   = ''
"let g:airline_linecolumn_prefix = ''
" TODO investigate why Airline does not shown after vimrc update
" branch: BR, readonly: RO, FT: FT, line symbol: LN
" TODO consider use | delimiter

" ------------------
" Lightline settings
" ------------------
let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
    \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive',
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ }
\}

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

"augroup AutoSyntastic
"  autocmd!
"  autocmd BufWritePost *.c,*.cpp call s:syntastic()
"augroup END

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" Vim Better Whitespace. Disable plugin for unite buffers
let g:better_whitespace_filetypes_blacklist = ['unite']

" Indent Guides. Use skinny indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" UltiSnips
"let g:UltiSnipsExpandTrigger='<tab>'
"let g:UltiSnipsJumpForwardTrigger='<tab>'
"let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" Replace pdb to ipdb
iab ipdb import ipdb; ipdb.set_trace()

" Syntastic. PyLint checker requires additional configuration on target OS
"let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['pylint']
" Remove this workaround
"let g:syntastic_python_pylint_exec = '/home/alexey/code/pywinrm/env/bin/pylint'

" Use jscs linter only if .jscsrc exists; otherwise tool will show an error
" FIXME error code 1
"autocmd FileType javascript let b:syntastic_checkers = findfile('.jscsrc','.;') != '' ? ['jscs'] : ['jshint']

" ---------------
" Settings. Unite
" ---------------
call unite#filters#matcher_default#use(['matcher_fuzzy'])

"let g:unite_split_rule = 'botright'
let g:unite_winheight = 10

"let g:unite_source_history_yank_enable = 1
"nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
"nnoremap <C-p> :Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<CR>
"inoremap <C-p> <Esc>:Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<CR>

nnoremap <leader>f :<C-u>Unite -buffer-name=files -start-insert file_rec/async<cr>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -buffer-name=outline -start-insert outline<cr>

"nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
"nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Play nice with supertab
    let b:SuperTabDisabled=1
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" ---------------------
" Settings. Neocomplete
" ---------------------
" TOOD investigate is interface artifacts related to this plugin
"let g:neocomplete#enable_at_startup = 1

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

" -----------------
" Utility functions
" -----------------
function! InitializeDirectories()
    let separator = '.'
    let parent = $HOME
    let prefix = '.vim'
    let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory',
        \ 'undo': 'undodir' }
    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . '/' . dirname . '/'
        if exists('*mkdir')
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo 'Warning: Unable to create backup directory: ' . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()

" <leader>ff shows list for relative jump
nmap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>


"let g:EditorConfig_exclude_patterns = ['fugitive://.*']
"let g:EditorConfig_verbose=1
"let g:EditorConfig_core_mode = 'external_command'
"let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

let g:auto_save = 1  " enable AutoSave on Vim startup
"let g:auto_save_no_updatetime = 1  " do not change the 'updatetime' option
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
let g:auto_save_silent = 1  " do not display the auto-save notification
"let g:auto_save_postsave_hook = 'TagsGenerate'  " this will run :TagsGenerate after each save

" -----------------
" Credits and honor
" -----------------
" How to boost your Vimroductivity
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

" spf13-vim - the ultimate vim distribution
" https://github.com/spf13/spf13-vim/blob/master/.vimrc

" Slava Oliyanchuk's vimrc
" https://github.com/miripiruni/vimi/blob/master/.vimrc

" Dmitriy Grachjev's vimrc
" https://github.com/dimasg/vim/blob/master/.vimrc
