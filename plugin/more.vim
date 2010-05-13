

set showcmd
fun! GetMoreText()
  set shellredir=>
  let out = system('curl -q http://more.handlino.com/sentences.json')
  let obj = eval(out)
  let sentences = obj.sentences
  set shellredir&
  return join(sentences,' ')
endf

fun! AppendMoreText()
  cal append(line('.'),  GetMoreText() )
endf
inoremap <expr> more  GetMoreText()

" cal GetMoreText()
