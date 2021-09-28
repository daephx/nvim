# Neo(Vim) Configurations

At a certain point of playing around with both these configuration, I ended up breaking things quite
often.
so now, I aim to make this it's own repository until the time comes where I am saticfied and decided
to merge it with my main [dotfiles](https://github.com/daephx/dotfiles) -- Currently Private.

One of the issues I have run into was making things cross-platform,
My main machine runs Windows 10 with WSL in the background, while I primarlity use ubunuty on my laptop.
The issue was simply that I did not understand VimL at all what-so-ever; so passing around variables
instead of hardcoding paths was a bit troublesome.
> However, further testing is still needed

The next issue I forsee, is that much the of the neovim community is heavily adopting lua script for
their configuration language. Great, another language to learn...
I have somewhat used lua for ConEmu and ComputerCraft and but I'm not well-versed in it's syntax.

Next and following the previous point on lua, am interested in this destinction between the languages
for configuration; so I wonder if it would be possible to have a minimal `init.vim` for compatability
between legacy Vim and Vi, while also applying the bulk of my configuration for NeoVim in lua?
