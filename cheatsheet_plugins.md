# Neovim Installed Plugins & Keymaps Cheatsheet

This cheatsheet covers the customized keymaps and usage for the plugins installed in your Neovim environment.

---

## Quick Map Discoverer (Which-Key)
*   Press **`<leader>?`** to open the full list of all keybindings in a searchable popup.
*   Whenever you type a prefix (like `<leader>f`, `<leader>g`, or `g`), Which-Key will show a list of valid next keys and their descriptions after a small delay.

---

## Cheatsheets
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>cm` | Vim Motions Cheatsheet | Open the core motion/editing cheatsheet in a vertical split. |
| `<leader>cp` | Plugin Cheatsheet | Open this plugin/keymap cheatsheet in a vertical split. |

---

## 1. File Tree (Neo-tree)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>e` | Toggle Neo-tree (Root) | Opens/closes tree explorer at project CWD and reveals active file. |
| `<leader>ge` | Git Status Explorer | Opens Neo-tree showing only changed files. |
| `<leader>be` | Buffer Explorer | Opens Neo-tree listing active open buffers. |

---

## Pane Navigation (vim-tmux-navigator)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<C-h>` | Navigate Left | Move to the Neovim split or tmux pane on the left. |
| `<C-j>` | Navigate Down | Move to the Neovim split or tmux pane below. |
| `<C-k>` | Navigate Up | Move to the Neovim split or tmux pane above. |
| `<C-l>` | Navigate Right | Move to the Neovim split or tmux pane on the right. |

---

## 2. Searching & Finding (Telescope)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>ff` | Find Files | Search for files in the project. |
| `<leader>fg` | Live Grep | Search for text pattern across all project files. |
| `<leader>fb` | Find Buffers | Search and switch between open buffers. |
| `<leader>fh` | Help Tags | Search the Neovim/Vim documentation. |
| `<leader>pp` | Pick Project | Open project selector list. |
| `<leader>pf` | Frecent Files | Search files ordered by frequency and recency. |

---

## 3. Command Palette (legendary.nvim)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<space><space>` | Command Palette | Open VS Code-style Command Palette with shortcut hints |
| `<leader>P` | Command Palette | Open VS Code-style Command Palette |
| `<C-p>` | Command Palette | Open VS Code-style Command Palette |

---

## 4. Symbol Navigation (vim-illuminate)
*   **Automatic Highlighting**: Cursor automatically highlights all occurrences of the word/symbol under cursor.
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `]r` | Next Symbol Reference | Jump to next occurrence of symbol under cursor |
| `[r` | Prev Symbol Reference | Jump to previous occurrence of symbol under cursor |

---

## 5. Buffer Management (Bufferline)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<Tab>` / `]b` | Next Buffer | Jump to the next open buffer in the tabline. |
| `<S-Tab>` / `[b` | Previous Buffer | Jump to the previous open buffer in the tabline. |
| `<leader>bp` | Pick Buffer | Pick a buffer directly by typing its visible overlay letter. |
| `<leader>bd` | Delete Buffer | Delete the current active buffer safely without closing window splits. |
| `<leader>bn` | New Buffer | Create a new blank file buffer. |
| `<leader>bc` | Close Buffer (Raw) | Close the current buffer via raw `:bdelete` command. |
| `<leader>bl` | Next Buffer (Raw) | Jump to the next open buffer via raw `:bnext` command. |
| `<leader>bh` | Previous Buffer (Raw)| Jump to the previous buffer via raw `:bprevious` command. |

---

## 4. Language Server (LSP) & Navigation
These keymaps are registered automatically on buffers where a Language Server is attached.

### Code Actions & Details
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `K` | Hover Doc | View signature and docs for symbol under cursor. |
| `<leader>lk` | Signature Help | View parameter hints for functions. |
| `<leader>rn` | Rename Symbol | Rename all occurrences of variable/function across project. |
| `<leader>ca` | Code Action | Run quickfixes/suggestions for diagnostic errors. |
| `<leader>cf` | Format Buffer | Format the current file using `conform.nvim` (LSP/Prettier). |

### Diagnostics (Errors & Warnings)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>cd` | Open Float | View full error details for current line in floating window. |
| `[d` | Previous Diagnostic | Jump to the previous error/warning. |
| `]d` | Next Diagnostic | Jump to the next error/warning. |

### Jumps & References (Telescope-integrated)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `gd` | Go to Definition | Jump to where the symbol is defined. |
| `gD` | Go to Declaration | Jump to where the symbol is declared. |
| `gr` | List References | List all files referencing this symbol. |
| `gI` | Go to Implementation | Jump to interface implementations. |
| `gy` | Type Definition | Jump to type definition. |
| `grr` | References (Telescope) | Search references in a Telescope dialog. |
| `grd` | Definition (Telescope) | Search definition in a Telescope dialog. |
| `gri` | Implementation (Telescope)| Search implementations in Telescope. |
| `grt` | Type Def (Telescope) | Search type definitions in Telescope. |
| `gO` | Document Symbols | View all functions, classes, and variables in current file. |
| `gW` | Workspace Symbols | Search for any symbol across the workspace. |

---

## 5. Diagnostics Panel (Trouble)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>xx` | Workspace Diagnostics | Toggle listing of all project errors/warnings in lower pane. |
| `<leader>xX` | Buffer Diagnostics | Toggle list of errors/warnings in current file. |
| `<leader>xe` | Workspace Errors | Toggle listing of only Errors (excluding warnings) in project. |
| `<leader>xE` | Buffer Errors | Toggle listing of only Errors in current file. |
| `<leader>xq` | Quickfix List | Toggle quickfix panel. |
| `<leader>xl` | Location List | Toggle location list panel. |
| `<leader>xs` | Symbols | Toggle list of symbols in file. |
| `<leader>xr` | LSP References | Toggle list of references under cursor. |
| `<leader>xd` | LSP Definitions | Toggle definitions list. |

---

## 6. Project-Wide Search & Replace (Spectre)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>sr` | Search/Replace Project | Search word under cursor across all project files. |
| `<leader>sR` | Search Current File | Search word under cursor inside the current file only. |
| `<leader>sw` | Search Visual Selection| Search for selected text (use inside Visual mode). |
| `<leader>sA` | Apply Changes | Execute replace on matching lines after setting values. |
| `<leader>sl` | Resume Search | Open Spectre panel with last search query populated. |

---

## 7. Git Integration

### Git Dashboards
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>gg` | LazyGit | Open the terminal Git UI from Snacks. |

### Git Hunks (Gitsigns)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `]h` | Next Hunk | Jump to the next changed Git hunk. |
| `[h` | Previous Hunk | Jump to the previous changed Git hunk. |
| `<leader>gs` | Stage Hunk | Stage the current changed hunk. |
| `<leader>gr` | Reset Hunk | Reset the current changed hunk. |
| `<leader>gS` | Stage Buffer | Stage all changes in the current buffer. |
| `<leader>gR` | Reset Buffer | Reset all changes in the current buffer. |
| `<leader>gu` | Undo Stage Hunk | Undo staging for the current hunk. |
| `<leader>gp` | Preview Hunk | Preview the current hunk in a floating window. |
| `<leader>gP` | Preview Hunk Inline | Preview the current hunk inline. |
| `<leader>gb` | Toggle Blame | Show/hide current line Git blame. |
| `<leader>gd` | Diff This | Open a diff for the current buffer. |
| `<leader>gq` | Hunks to Quickfix | Send changed hunks to the quickfix list. |
| `<leader>gQ` | Hunks to Location List | Send changed hunks to the location list. |

### Code Diffs (Diffview)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>gv` | Open Diffview | Open side-by-side git diff interface for the repo. |
| `<leader>gC` | Close Diffview | Close the diff view and return to standard editor layout. |
| `<leader>gF` | File History | Open commit history search for the repository. |
| `<leader>gH` | Current File History | Open commit history specifically for the current active file. |

### Git Conflict Markers
*   Automatic merge conflict highlighting with navigation keys:
    *   `[x` / `]x` - Jump to previous / next conflict marker.
    *   `<leader>ct` - Choose **t**heir change.
    *   `<leader>co` - Choose **o**ur change.
    *   `<leader>cb` - Choose **b**oth changes.
    *   `<leader>cn` - Choose **n**one.

## 8. Python LeetCode Helpers

| Command | Action | Description |
| :--- | :--- | :--- |
| `:LCP [name]` | Python Scratch | Open a Python file with a `Solution` class and `__main__` harness. |
| `:LCPR` | Run Python File | Save and run the current Python file from its directory. |

---

## 9. Terminal
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>ot` | Toggle Terminal | Open/close the Snacks terminal. |
| `<C-\>` | Toggle Terminal | Fast terminal toggle from Normal or Terminal mode. |

---

## 10. Session Management (Persistence)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>qs` | Restore Session (CWD) | Restores the saved workspace layout and files for current directory. |
| `<leader>ql` | Restore Last Session | Restores the last active session globally. |
| `<leader>qd` | Stop Saving Session | Disables automatic saving of the current session state. |

---

## 11. Toggles & Options (Snacks Toggles)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>ud` | Toggle Diagnostics | Dynamically show/hide inline code linting and error warnings. |
| `<leader>us` | Toggle Spelling | Turn on/off inline spelling checker. |
| `<leader>uw` | Toggle Wrap | Toggle line wrapping on/off for long files. |

---

## 12. Notes / Obsidian Note-Taking
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>nn` | New Note | Create a new Obsidian note file. |
| `<leader>ns` | Search Text | Fuzzy search for content/text inside all notes. |
| `<leader>no` | Open in App | Open the active note in the Obsidian desktop application. |
| `<leader>nt` | Today's Daily Note | Open or create today's daily journal note. |
| `<leader>ny` | Yesterday's Daily Note | Open or create yesterday's daily journal note. |
| `<leader>nf` | Follow Link | Follow/open the markdown hyperlink under the cursor. |
| `<leader>ni` | Insert Template | Insert a custom note template (such as daily template). |
| `<leader>nb` | Backlinks | View notes that link back to the current active note. |

*   **Wiki-Link Completion**: Type `[[` inside any note to search and autocomplete links to other notes in your vault.
*   **Markdown Snippets**: Type helpers like `tbl` (table), `link` (hyperlink), or `code` (code block) and press `Enter` to expand them. Use `Tab` to jump through the parameters.
*   **Document LSP**: Runs `marksman` to provide auto-completions, lint headers, and enable header definition lookups.

---

## 13. Minor Workflow Helpers & Previews
*   **Wilder (Floating Cmdline)**: Pressing `:`, `/`, or `?` triggers a floating fuzzy-completion command palette with devicons and scrollbar.
*   **SchemaStore**: Injects JSON & YAML schema autocompletion and validation for `package.json`, `tsconfig.json`, GitHub Actions, Kubernetes, etc.
*   **Dropbar**: Press **`<leader>;`** to pick symbols from the winbar. Use **`[;`** to jump to the current context start and **`];`** to select the next context.
*   **Blink.cmp**: Autocomplete triggers automatically as you type. Use `Tab` / `Shift+Tab` or `Up` / `Down` to navigate, `Enter` or `Space` to accept.
*   **Smear Cursor**: Adds a subtle animated cursor trail in terminal Neovim.
*   **Todo Comments**: Annotations like `TODO:`, `FIXME:`, `NOTE:`, `WARNING:` in code comments are syntax-highlighted in custom colors.
*   **HTML Auto-tag**: In `.html`, `.tsx`, `.vue` files, changing an opening tag automatically updates its closing tag counterpart.
*   **Colorizer**: CSS hexadecimal colors (like `#ff0055`) show their true color block inline.
*   **Sticky Code Context**: Pins function/class declarations to the top of your screen as you scroll.

---

## 14. Smart Commenting (Comment.nvim)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `gcc` | Toggle Line Comment | Comment/uncomment the current line. |
| `gbc` | Toggle Block Comment | Block comment/uncomment the current line. |
| `gc` | Comment Selection | Comment/uncomment selection (Visual Mode). |
| `gb` | Block Comment Selection | Block comment/uncomment selection (Visual Mode). |

---
