" Instead of closing the window on exit, switch to previous buffer and close
" the terminal.
" Skip for fzf commands, which do something weird with floating windows
" This emulates actual vim's behavior on exiting a process

function! s:ClosePreviousBuffer()
  let num = bufnr('%')
  bprev " Go to previous buffer
  " Force close as otherwise term buffers refuse as potentially still running
  execute "bdelete! " . num
endfunction

if has("nvim")
  autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd TermOpen * startinsert
  autocmd TermLeave * stopinsert
  autocmd TermClose * if &ft != "fzf" | call s:ClosePreviousBuffer() | endif
endif
