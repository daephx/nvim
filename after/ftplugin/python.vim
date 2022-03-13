" ensure black is installed
if executable('black')
	" set formatprg
	setlocal formatprg='black --line-length=102 -'
	" Ensure we set formatprg instead of formatexpr
	setlocal formatexpr
endif
