"set showcmd
fun! GetMoreText(n)
  let n = !!a:n ? a:n : 1
  setlocal shellredir=>
  let out = system('curl -q http://more.handlino.com/sentences.json?n=' . n)
  let obj = eval(out)
  let sentences = obj.sentences
  setlocal shellredir&
  return sentences
endf

fun! JoinMoreText(n)
    return join(GetMoreText(a:n), "\n")
endfunction

fun! AppendMoreText(...)
    let n = a:0==0 ? 1 : str2nr(a:1)
    call append(line('.'), GetMoreText(n))
    call setpos(".", [0, line(".")+n, col(".")])
endfunction

inoremap <expr> `more JoinMoreText(1)
nmap <leader>more :<C-U>call AppendMoreText(v:count1)<cr>
nmap `more :<C-U>call AppendMoreText(v:count1)<cr>
command -nargs=? AppendMoreText :call AppendMoreText(<args>)
command -nargs=? MoreText :call AppendMoreText(<args>)
