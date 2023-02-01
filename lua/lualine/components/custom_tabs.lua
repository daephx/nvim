local custom_tabs = require("lualine.components.tabs")
local Tab = require("lualine.components.tabs.tab")
local modules = require("lualine_require").lazy_require({
  highlight = "lualine.highlight",
  utils = "lualine.utils.utils",
})

-- This function is duplicated in buffers
---returns the proper hl for tab in section. Used for setting default highlights
---@param section string name of section tabs component is in
---@param is_active boolean
---@return string hl name
local function get_hl(section, is_active)
  local suffix = is_active and "_normal" or "_inactive"
  local section_redirects = {
    lualine_x = "lualine_c",
    lualine_y = "lualine_b",
    lualine_z = "lualine_a",
  }
  if section_redirects[section] then
    section = modules.highlight.highlight_exists(section .. suffix) and section
      or section_redirects[section]
  end
  return section .. suffix
end

local default_options = {
  max_length = 0,
  mode = 0,
  tabs_color = {
    active = nil,
    inactive = nil,
  },
}

-- Initialize new component metatable
---@param options table
function custom_tabs:init(options)
  custom_tabs.super.init(self, options)
  default_options.tabs_color = {
    active = get_hl("lualine_" .. options.self.section, true),
    inactive = get_hl("lualine_" .. options.self.section, false),
  }
  self.options = vim.tbl_deep_extend("keep", self.options or {}, default_options)
  self.options.component_separators = { left = "", right = "" }
  self.options.section_separators = { left = "", right = "" }
  self.highlights = {
    active = self:create_hl(self.options.tabs_color.active, "active"),
    inactive = self:create_hl(self.options.tabs_color.inactive, "inactive"),
  }
end

---returns rendered tab
---@return string
function Tab:render()
  local name = self:label()
  if self.options.fmt then
    name = self.options.fmt(name or "")
  end
  if self.ellipse then -- show ellipsis
    name = "..."
  else
    -- different formats for different modes
    if self.options.mode == 0 then
      name = tostring(self.tabnr)
      local ok, label = pcall(vim.api.nvim_tabpage_get_var, self.tabId, "tabname")
      if ok and label and label ~= "" then
        name = label
      end
    elseif self.options.mode == 1 then
      name = name
    else
      name = string.format("%s %s", tostring(self.tabnr), name)
    end
  end
  name = self.apply_padding(name, self.options.padding)
  self.len = vim.fn.strchars(name)

  -- setup for mouse clicks
  local line = string.format("%%%s@LualineSwitchTab@%s%%T", self.tabnr, name)
  -- apply highlight
  line = modules.highlight.component_format_highlight(
    self.highlights[(self.current and "active" or "inactive")]
  ) .. line

  -- apply separators
  if self.options.self.section < "x" and not self.first then
    local sep_before = self:separator_before()
    line = sep_before .. line
    self.len = self.len + vim.fn.strchars(sep_before)
  elseif self.options.self.section >= "x" and not self.last then
    local sep_after = self:separator_after()
    line = line .. sep_after
    self.len = self.len + vim.fn.strchars(sep_after)
  end
  return line
end

function custom_tabs:update_status()
  local data = {}
  local tabs = {}
  for nr, id in ipairs(vim.api.nvim_list_tabpages()) do
    tabs[#tabs + 1] =
      Tab({ tabId = id, tabnr = nr, options = self.options, highlights = self.highlights })
  end
  -- mark the first, last, current, before current, after current tabpages
  -- for rendering
  local current = vim.fn.tabpagenr()
  tabs[1].first = true
  tabs[#tabs].last = true
  if tabs[current] then
    tabs[current].current = true
  end
  if tabs[current - 1] then
    tabs[current - 1].beforecurrent = true
  end
  if tabs[current + 1] then
    tabs[current + 1].aftercurrent = true
  end

  local max_length = self.options.max_length
  if type(max_length) == "function" then
    max_length = max_length(self)
  end

  if max_length == 0 then
    max_length = math.floor(vim.o.columns / 3)
  end
  local total_length
  for i, tab in pairs(tabs) do
    if tab.current then
      current = i
    end
  end
  local current_tab = tabs[current]
  -- start drawing from current tab and draw left and right of it until
  -- all tabpages are drawn or max_length has been reached.
  if current_tab == nil then -- maybe redundant code
    local t = Tab({
      tabId = vim.api.nvim_get_current_tabpage(),
      tabnr = vim.fn.tabpagenr(),
      options = self.options,
      highlights = self.highlights,
    })
    t.current = true
    t.last = true
    data[#data + 1] = t:render()
  else
    data[#data + 1] = current_tab:render()
    total_length = current_tab.len
    local i = 0
    local before, after
    while true do
      i = i + 1
      before = tabs[current - i]
      after = tabs[current + i]
      local rendered_before, rendered_after
      if before == nil and after == nil then
        break
      end
      -- draw left most undrawn tab if fits in max_length
      if before then
        rendered_before = before:render()
        total_length = total_length + before.len
        if total_length > max_length then
          break
        end
        table.insert(data, 1, rendered_before)
      end
      -- draw right most undrawn tab if fits in max_length
      if after then
        rendered_after = after:render()
        total_length = total_length + after.len
        if total_length > max_length then
          break
        end
        data[#data + 1] = rendered_after
      end
    end
    -- draw ellipsis (...) on relevant sides if all tabs don't fit in max_length
    if total_length > max_length then
      if before ~= nil then
        before.ellipse = true
        before.first = true
        table.insert(data, 1, before:render())
      end
      if after ~= nil then
        after.ellipse = true
        after.last = true
        data[#data + 1] = after:render()
      end
    end
  end

  return table.concat(data)
end

return custom_tabs
