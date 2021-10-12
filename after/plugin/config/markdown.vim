" --- Markdown ---

" Add the following line to your .vimrc to disable default key mappings:
let g:vim_markdown_no_default_key_mappings = 0

" Disabling conceal for code fences requires an additional setting:
let g:vim_markdown_conceal_code_blocks = 0

" Strikethrough uses two tildes. ~~Scratch this.~~
let g:vim_markdown_strikethrough = 1

" In that case, you probably also want to set the new list item indent to 0 as well,
" or you will have to remove an indent each time you add a new list item:
let g:vim_markdown_new_list_item_indent = 1

" Automatically inserting bulletpoints can lead to problems when wrapping text
" (see issue #232 for details), so it can be disabled:
let g:vim_markdown_auto_insert_bullets = 1

" Used as $x^2$, $$x^2$$, escapable as \$x\$ and \$\$x\$\$.
let g:vim_markdown_math = 1

" Highlight YAML front matter as used by Jekyll or Hugo.
let g:vim_markdown_frontmatter = 1

" You can use filetype name as fenced code block languages for syntax highlighting.
" If you want to use different name from filetype, you can add it in your .vimrc like so:
let g:vim_markdown_fenced_languages = [
                \'bash=sh',
                \'c++=cpp',
                \'ini=dosini',
                \'viml=vim'
                \]
