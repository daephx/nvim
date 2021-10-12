" ensure black is installed
if executable('black')
	" set formatprg
	setlocal formatprg='black --line-length=102 -'
	" ensure we set formatprg isntaed of formatexpr
	setlocal formatexpr
endif
