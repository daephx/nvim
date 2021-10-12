" Description: File detection for python files

" Highlighting for pip requirements.txt
autocmd! BufNewFile,BufRead requirements*.txt setlocal syntax=python
