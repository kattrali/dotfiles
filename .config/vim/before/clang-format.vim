" Format C-family code
function! s:ClangFormat()
    let source = join(getline(1, '$'), "\n")
    let formatted = system('clang-format', source)
    if v:shell_error != 0
      echoerr formatted
      return
    endif
    let current_pos = getpos('.')
    let winview = winsaveview()
    let splitted = split(formatted, '\n', 1)

    silent! undojoin
    if line('$') > len(splitted)
      execute len(splitted) .',$delete' '_'
    endif
    call setline(1, splitted)
    call winrestview(winview)
    call setpos('.', current_pos)
endfunction

" Format C code
autocmd BufWritePre *.c,*.h,*.cpp,*.cxx,*.m,*.hpp :call s:ClangFormat()
