" Paste system pasteboard contents into copy register
function! SendSystemClipboardToCopyRegister()
  if has("mac")
    call setreg("", system("pbpaste"))
  elseif has("wsl")
  elseif has("win64")
  else
    call setreg("", system("xclip -o -selection clipboard"))
  endif
endfunction

" Copy yanked text to system pasteboard
function! SendCopyRegisterToSystemClipboard()
  if has("mac")
    call system("pbcopy", getreg(""))
  elseif has("wsl")
  elseif has("win64")
  else
    call system("xclip -i -selection clipboard", getreg(""))
  endif
endfunction
