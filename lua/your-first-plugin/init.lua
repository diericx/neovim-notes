local function printWindowSize()
  local ui = vim.api.nvim_list_uis()[1]

  -- Define the size of the floating window
  local win_width = math.floor(ui.width * 0.8)
  local win_height = math.floor(ui.height * 0.8)

  -- Create the scratch buffer displayed in the floating window
  local buf = vim.api.nvim_create_buf(false, true)

  -- Create the floating window
  local opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    col = (ui.width / 2) - (win_width / 2),
    row = (ui.height / 2) - (win_height / 2),
    anchor = "NW",
    border = "single"
  }
  local winId = vim.api.nvim_open_win(buf, 1, opts)
  -- Do setup for new floating window
  vim.api.nvim_win_set_option(winId, "winhighlight", "Normal:Normal")
  vim.api.nvim_command("edit ~/Nextcloud/Obsidian/OBSNotes/Daily/" .. os.date("%Y-%m-%d") .. ".md")
  vim.api.nvim_command("lcd ~/Nextcloud/Obsidian/OBSNotes")
end

return {
  printWindowSize = printWindowSize
}
