fun! Notes()
  " don't forget to remove this...
  lua for k in pairs(package.loaded) do if k:match("^notes") then package.loaded[k] = nil end end
  lua require("notes").open_window()
endfun

augroup Notes 
  autocmd!
augroup END
