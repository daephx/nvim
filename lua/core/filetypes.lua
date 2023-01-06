-- Enable lua-based filetype plugin
vim.g.do_filetype_lua = 1
-- Disable filetype plugins
vim.g.did_load_ftplugin = 0

-- Custom filetypes
vim.filetype.add({
  extension = {
    babelrc = "json",
    eslintrc = "json",
    frag = "glsl",
    log = "log",
    md = "markdown",
    mdown = "markdown",
    mdx = "markdown",
    mjml = "html",
    mkd = "markdown",
    mkdn = "markdown",
    pandoc = "pandoc",
    pde = "processing",
    prettierrc = "json",
    scm = "scheme",
    stylelintrc = "json",
    tex = "tex",
    tp = "type",
    vert = "glsl",
  },
  filename = {
    Brewfile = "ruby",
    Vagrantfile = "ruby",
    [".Rprofile"] = "r",
    [".envrc"] = "bash",
    [".gitattributes"] = "conf",
    [".gitignore"] = "conf",
    [".luacheckrc"] = "lua",
    [".stylelintrc"] = "json",
    ["poetry.lock"] = "toml",
    ["yup.lock"] = "yaml",
  },
  pattern = {
    [".*%.env.*"] = "sh",
    [".*ignore"] = "conf",
    [".*tmux.*conf$"] = "tmux",
    [".aliases"] = "sh",
    ["Dockerfile.*"] = "dockerfile",
    ["^(log[^%.]+)$"] = "log",
    ["requirements*.txt"] = "python",
  },
})
