local function printWindowSize()
  local ui = vim.api.nvim_list_uis()[1]

  -- Define the size of the floating window
  local win_width = math.floor(ui.width * 0.8)
  local win_height = math.floor(ui.height * 0.8)
  local win_col = (ui.width / 2) - (win_width / 2)
  local win_row = (ui.height / 2) - (win_height / 2)

  -- Create the scratch buffer displayed in the floating window
  local buf = vim.api.nvim_create_buf(false, true)

  -- Create the border floating window
  local border_opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    col = win_col,
    row = win_row,
    anchor = "NW",
    focusable = false,
    style = "minimal"
  }
  local top = "╭" .. string.rep("-", win_width - 2) .. "╮"
  local mid = "|" .. string.rep(" ", win_width - 2) .. "|"
  local bot = "╰─" .. string.rep("-", win_width - 3) .. "╯"
  local lines = {top}
  for i = 1, 100 do
    lines[#lines + 1] = mid
  end
  lines[#lines + 1] = bot
  local border_bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(border_bufnr, 0, -1, true, lines)
  local border_winid = vim.api.nvim_open_win(border_bufnr, true, border_opts)

  -- Create the edit floating window
  local editor_opts = {
    relative = "editor",
    width = win_width - 4,
    height = win_height - 2,
    col = win_col + 2,
    row = win_row + 1,
    anchor = "NW",
    focusable = true,
    style = "minimal"
  }
  local editor_winid = vim.api.nvim_open_win(buf, 1, editor_opts)
  -- Do setup for new floating window
  vim.api.nvim_win_set_option(winId, "winhighlight", "Normal:Normal")
  vim.api.nvim_win_set_option(winId, "winhighlight", "Normal:Normal")
  vim.api.nvim_command("edit ~/Nextcloud/Obsidian/OBSNotes/Daily/" .. os.date("%Y-%m-%d") .. ".md")
  vim.api.nvim_command("lcd ~/Nextcloud/Obsidian/OBSNotes")
end

return {
  printWindowSize = printWindowSize
}
