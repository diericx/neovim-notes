local api = vim.api
local buf, win

local function go_to_notes(notes_root)
  vim.api.nvim_command("lcd " .. notes_root)
  vim.api.nvim_command("edit " .. notes_root)
end

local function open_window(notes_root, dir, note)
  buf = api.nvim_create_buf(false, true)
  local border_buf = api.nvim_create_buf(false, true)

  api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  api.nvim_buf_set_option(buf, "filetype", "whid")

  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")

  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local border_opts = {
    style = "minimal",
    relative = "editor",
    width = win_width + 2,
    height = win_height + 2,
    row = row - 1,
    col = col - 1
  }

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }

  local border_lines = {"╔" .. string.rep("═", win_width) .. "╗"}
  local middle_line = "║" .. string.rep(" ", win_width) .. "║"
  for i = 1, win_height do
    table.insert(border_lines, middle_line)
  end
  table.insert(border_lines, "╚" .. string.rep("═", win_width) .. "╝")
  api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

  local border_win = api.nvim_open_win(border_buf, true, border_opts)
  win = api.nvim_open_win(buf, true, opts)
  vim.cmd(
    replace_vars {
      [[
    augroup Notes
      autocmd!
      au WinClosed {win_id} silent bwipeout! {buf} 
    augroup END
  ]],
      buf = border_buf,
      win_id = win
    }
  )

  api.nvim_win_set_option(win, "cursorline", true) -- it highlight line with the cursor on it

  -- we can add title already here, because first line will never change
  api.nvim_buf_add_highlight(buf, -1, "WhidHeader", 0, 0, -1)

  vim.api.nvim_command("lcd " .. notes_root)
  vim.api.nvim_command("edit " .. notes_root .. dir .. note)
end

function replace_vars(str, vars)
  -- Allow replace_vars{str, vars} syntax as well as replace_vars(str, {vars})
  if not vars then
    vars = str
    str = vars[1]
  end
  return (string.gsub(
    str,
    "({([^}]+)})",
    function(whole, i)
      return vars[i] or whole
    end
  ))
end

return {
  open_window = open_window,
  go_to_notes = go_to_notes
}
