local scheme_path = vim.fn.stdpath("data") .. "/last_colorscheme.txt"

-- Save the current colorscheme
local function save_colorscheme(scheme)
  local f = io.open(scheme_path, "w")
  if f then
    f:write(scheme)
    f:close()
  end
end

-- Load last colorscheme, or fallback to 'default'
local function load_last_colorscheme()
  local f = io.open(scheme_path, "r")
  if f then
    local scheme = f:read("*l")
    f:close()
    if scheme and scheme ~= "" then
      local ok, err = pcall(vim.cmd.colorscheme, scheme)
      if not ok then
        vim.cmd.colorscheme("default")
        vim.notify("Failed to load colorscheme '" .. scheme .. "': " .. err, vim.log.levels.WARN)
      end
    else
      vim.cmd.colorscheme("default")
    end
  else
    vim.cmd.colorscheme("default")
  end
end

-- Hook into :colorscheme to remember user’s choice
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function(args)
    save_colorscheme(args.match)
  end
})

-- Call AFTER plugin manager loads themes
vim.defer_fn(load_last_colorscheme, 0)

