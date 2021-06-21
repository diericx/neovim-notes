command DailyNotePopup lua require("notes").open_window(vim.g["NotesRoot"], vim.g["NotesDailyDir"], "/" .. os.date("%Y-%m-%d") .. ".md")
command GoToNotes lua require("notes").go_to_notes(vim.g["NotesRoot"])
