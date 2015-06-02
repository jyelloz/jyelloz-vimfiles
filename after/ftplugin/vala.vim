let b:NERDCommenterDelims = { 'left': '//', 'right': '', 'leftAlt': '/*', 'rightAlt': '*/' }
setlocal cindent ts=2 sts=2 sw=2 et
let &tags = &tags . ',~/valatags'
setlocal cino=t0,(0,W2,m1
