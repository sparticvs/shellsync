execute pathogen#infect()

filetype plugin indent on
syntax on

" Yea, I am a fan
colorscheme acidcupcake

set number

" Proper spacing
set tabstop=4
set expandtab
set shiftwidth=4
set backspace=2

" Unless you are HTML...
autocmd FileType html setlocal shiftwidth=2 tabstop=2 

" Sane window wrapping
set textwidth=79

" I like to show the directory tree by default
" Uncomment if NERDTree is installed
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" I like unicode chars in tagbar
" Uncomment if Tagbar is installed
"let g:tagbar_iconchars = ['▸', '▾']

" Change tab and space to different characters
set listchars=tab:»\ ,eol:¶,trail:·

" Set all key mappings : : leader => \
map <silent> <leader>d :NERDTreeToggle<CR>
map <silent> <leader>n :set nu<CR>
map <silent> <leader>N :set nonu<CR>
"nnoremap <silent> <leader>t :TagbarToggle<CR>
map <silent> <leader>s :set list!<CR>

" Auto complete braces (I am not the biggest fan of this)
"imap ( ()<Esc>:let leavechar=")"<CR>i
"imap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
"imap { {}<Esc>:let leavechar="}"<CR>i
"imap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
"imap [ []<Esc>:let leavechar="]"<CR>i
"imap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
"imap < <><Esc>:let leavechar=">"<CR>i
"imap <expr> >  strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"

" Show the status lines
set laststatus=2

" If in a git repo, what branch am I in?
set statusline=%{GitBranch()}\ %f\ %y\ %r%=%(%l,%c%)

" Set Screen title (haven't converted this to TMUX yet)
let &titleold = system('whoami') . "@" . hostname()
let &titlestring = system('whoami') . "@" . hostname() . "(" . expand("%:t") . ")"
" In Ubuntu, TMUX sets "term" to screen
let really_screen=0
if &term == "screen" && !exists("$TMUX")
    set t_ts=^[k
    set t_fs=^[\
    let really_screen=1
endif

" Set the Title of the Window if it's screen, xterm
if really_screen == 1 || &term == "xterm"
    set title
endif

" If I am quitting, and NERD is the last thing open, close it (makes NERD insignificant)
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()

" Setup 256 Color Support
set t_Co=256

command -nargs=0 Convert :%s/\t/    /g
command -nargs=0 CheckStyle :!pep8 %:p
command -nargs=0 Pylint :rightb :15sview .pylintresults | setlocal buftype=nofile noswapfile bufhidden=delete | silent :r !pylint #
