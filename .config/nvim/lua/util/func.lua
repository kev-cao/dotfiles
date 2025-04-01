--- @module 'util.func'
--- Offers utility functions

local M = {}

function M.check_global_var(var, expected, default)
  local actual = vim.g[var]
  if actual == nil and default ~= nil then
    actual = default
  end
  return actual == expected
end

function M.is_plugin_loaded(plugin)
  return vim.tbl_get(require("lazy.core.config"), "plugins", plugin, "_", "loaded")
end

function M.get_plugin_if_loaded(plugin)
  if M.is_plugin_loaded(plugin) then
    return true, require(plugin)
  end
  return  false, nil
end

function string.capitalize(str)
    if str=="" then return end
    local first = str:sub(1,1)
    local last = str:sub(2)
    return first:upper()..last:lower()
end

return M
