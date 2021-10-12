# Theme configurations

In this directory, you can define all the custom settings for your particular colorschemes!

One option could be rolling your own `colors/molokai_custom`, and completely modifying the
original theme to suite your preferences.

but lets say you just want to put in a few overrides, or your colorschemes come with a number of
options via `let g:theme_option`, If you like to switch themes a lot or want to modularize certain
settings without packing them all into one file? Just drop a new script in here that has the same name
as your colorscheme of choice!

You can then prevent the settings from being loaded by adding a guard-clause.

Example:

```vim
if g:color_name != 'MYTHEME'
  finish
endif

let g:MYTHEME_style = 'dark'
let g:MYTHEME_transparency = 1
```
