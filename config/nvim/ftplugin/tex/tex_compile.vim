" Settings for compiling LaTeX documents

" Only load this plugin it has not yet been loaded for this buffer
" Note that using b:did_ftplugin would disable vimtex
if exists("b:did_mytexplugin_compile")
  finish
endif
let b:did_mytexplugin_compile = 1

" paths to shell scripts used for compilation
let s:tex_scripts_dir = "$HOME/.config/nvim/personal/tex-scripts/"
let s:compile_script_path = s:tex_scripts_dir . "compile.sh"
let s:compile_show_script_path = s:tex_scripts_dir . "compile-show.sh"
let s:forward_show_script = "$HOME/.config/nvim/personal/forward-show.sh"

" used to toggle latexmk and shell-escape compilation on and off
let b:tex_compile_use_latexmk = 0
let b:tex_compile_use_shell_escape = 0


" Enable b:tex_compile_use_shell_escape if the minted package is detected in the tex file's preamble
" --------------------------------------------- "
silent execute '!sed "/\\begin{document}/q" ' . expand('%') . ' | grep "minted" > /dev/null'
if v:shell_error  " 'minted' not found in preamble
  let b:tex_compile_use_shell_escape = 0  " disable shell escape
else  " 'minted' found in preamble
  let b:tex_compile_use_shell_escape = 1  " enable shell escape
endif
" --------------------------------------------- "


" BEGIN FUNCTIONS
" ------------------------------------------- "
" function for toggling latexmk
function! s:TexToggleLatexmk() abort
  if b:tex_compile_use_latexmk  " turn off latexmk
    let b:tex_compile_use_latexmk = 0
  else  " turn on latexmk
    let b:tex_compile_use_latexmk = 1
  endif
endfunction

" function for toggling shell escape
function! s:TexToggleShellEscape() abort
  if b:tex_compile_use_shell_escape  " turn off shell escape
    let b:tex_compile_use_shell_escape = 0
  else  " turn on shell escape
    let b:tex_compile_use_shell_escape = 1
  endif
endfunction

function! s:TexCompile() abort
  update
  execute "AsyncRun sh " . expand(s:compile_script_path) . 
        \ " $(VIM_RELDIR)" . " $(VIM_FILENOEXT) " . 
        \ expand(b:tex_compile_use_latexmk) . " " . 
        \ expand(b:tex_compile_use_shell_escape)
endfunction

function! s:TexForwardShow() abort
  " TLDR: AsyncRun sh forward_show_script line pdf_file tex_file OS_name
  execute "AsyncRun sh " . expand(s:forward_show_script) . " " .
        \ line('.') .
        \ " $(VIM_RELDIR)/$(VIM_FILENOEXT).pdf " .
        \ " $(VIM_RELDIR)/$(VIM_FILENOEXT).tex " .
        \ expand(g:os_current)
endfunction
" ------------------------------------------- "
" END FUNCTIONS


" BEGIN MAPPINGS
" ------------------------------------------- "
" TexToggleLatexmk
nmap <leader>tl <Plug>TexToggleLatexmk
nnoremap <script> <Plug>TexToggleLatexmk <SID>TexToggleLatexmk
noremap <SID>TexToggleLatexmk :call <SID>TexToggleLatexmk()<CR>

" TexToggleShellEscape
nmap <leader>te <Plug>TexToggleShellEscape
noremap <script> <Plug>TexToggleShellEscape <SID>TexToggleShellEscape
noremap <SID>TexToggleShellEscape :call <SID>TexToggleShellEscape()<CR>

" TexCompile
nmap <leader>r <Plug>TexCompile
noremap <script> <Plug>TexCompile <SID>TexCompile
noremap <SID>TexCompile :call <SID>TexCompile()<CR>

" TexForwardShow
nmap <leader>v <Plug>TexForwardShow
noremap <script> <Plug>TexForwardShow <SID>TexForwardShow
noremap <SID>TexForwardShow :call <SID>TexForwardShow()<CR>
" ------------------------------------------- "
" END MAPPINGS
