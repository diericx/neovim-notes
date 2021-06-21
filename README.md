# Neovim-notes

This plugin aims to make editing notes a breeze while in vim.

## Config

There are two global vars to set

`g:NotesRoot` is the root directory for your notes
`g:NotesDailyDir` is the sub directory within your notes root dir for daily notes

Here is an exmample vimrc config:

```
let g:NotesRoot = '~/Notes'
let g:NotesDailyDir = '/Daily'
nnoremap <C-n> <cmd>DailyNotePopup<cr>
```

And a bashrc alias for opening notes from anywhere

```
alias 'nvim -c "GoToNotes"'
```
