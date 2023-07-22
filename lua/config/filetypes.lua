-- Enable lua-based filetype plugin
vim.g.do_filetype_lua = 1
-- Disable filetype plugins
vim.g.did_load_ftplugin = 0

-- Custom filetypes
vim.filetype.add({
  extension = {
    babelrc = "json",
    conf = "conf",
    csx = "cs",
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
    prettierrc = "jsonc",
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
    [".luacheckrc"] = "lua",
    [".markdownlintrc"] = "json",
    [".stylelintrc"] = "json",
    ["poetry.lock"] = "toml",
    ["yup.lock"] = "yaml",
  },
  pattern = {
    [".*%.env.*"] = "sh",
    [".*tmux.*conf$"] = "tmux",
    [".aliases"] = "sh",
    ["Dockerfile.*"] = "dockerfile",
    ["^(log[^%.]+)$"] = "log",
    ["requirements*.txt"] = "python",
  },
})
