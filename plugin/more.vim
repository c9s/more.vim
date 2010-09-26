set showcmd
fun! GetMoreText(n)
  let n = !!a:n ? a:n : 1
  set shellredir=>
  let out = system('curl -q http://more.handlino.com/sentences.json?n=' . n)
  let obj = eval(out)
  let sentences = obj.sentences
  set shellredir&
  return join(sentences,"\n")
endf

fun! AppendMoreText(...)
    if a:0==0
        let n = 1
    else
        let n = str2nr(a:1)
    endif
    call append(line('.'), GetMoreText(n))
    call setpos(".", [0, line(".")+1, col(".")])
    " can not append multi-line.
    "call setpos(".", [0, line(".")+n, col(".")])
endfunction

inoremap <expr> `more GetMoreText(1)
" range error.
nmap <leader>more :call AppendMoreText(v:count1)<cr>
nmap `more :call AppendMoreText(v:count1)<cr>
command -nargs=? AppendMoreText :call AppendMoreText(<args>)
command -nargs=? MoreText :call AppendMoreText(<args>)

" cal GetMoreText()
