# Neovim Installed Plugins & Keymaps Cheatsheet

This cheatsheet covers the customized keymaps and usage for the plugins installed in your Neovim environment.

---

## Quick Map Discoverer (Which-Key)
*   Press **`<leader>?`** to open the full list of all keybindings in a searchable popup.
*   Whenever you type a prefix (like `<leader>f`, `<leader>g`, or `g`), Which-Key will show a list of valid next keys and their descriptions after a small delay.

---

## 1. File Tree (Neo-tree)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>e` | Toggle Neo-tree (Root) | Opens/closes tree explorer at project CWD and reveals active file. |
| `<leader>ge` | Git Status Explorer | Opens Neo-tree showing only changed files. |
| `<leader>be` | Buffer Explorer | Opens Neo-tree listing active open buffers. |

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

## 3. Buffer Tabs Management (Barbar)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>bn` | New Buffer | Create a new blank buffer/file. |
| `<S-l>` | Next Buffer | Jump to the next open buffer tab. |
| `<S-h>` | Previous Buffer | Jump to the previous open buffer tab. |
| `<leader>bc` | Close Buffer | Close/unload the current active buffer. |

---

## 4. Language Server (LSP) & Navigation
These keymaps are registered automatically on buffers where a Language Server is attached.

### Code Actions & Details
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `K` | Hover Doc | View signature and docs for symbol under cursor. |
| `<C-k>` | Signature Help | View parameter hints for functions. |
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
| `<leader>gg` | Neogit | Open interactive Magit-like Git client inside Neovim. |
| `<leader>gf` | Git Fugitive | Open Vim-Fugitive status window. |
| `<leader>gB` | Git Blame | Display inline commit info for current file lines. |

### Code Diffs (Diffview)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>gO` | Open Diffview | Open side-by-side git diff interface for the repo. |
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

---

## 8. Testing (Neotest)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>tr` | Run Nearest | Run the test block closest to the cursor. |
| `<leader>tf` | Run File | Run all tests in the current file. |
| `<leader>ts` | Run Suite | Run the entire test suite in project workspace. |
| `<leader>td` | Debug Nearest | Start debugger attached to the nearest test block. |
| `<leader>tt` | Stop Test | Stop running tests. |
| `<leader>to` | Output Hover | Show output of the test under cursor in hover window. |
| `<leader>tO` | Toggle Output Panel | Open/close full terminal output pane at the bottom. |
| `<leader>tS` | Toggle Summary | Open/close side panel showing passing/failing test tree. |

---

## 9. Debugging (DAP - Debug Adapter Protocol)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>db` | Toggle Breakpoint | Place/remove debug breakpoint on current line. |
| `<leader>dB` | Conditional Breakpoint | Prompt for conditional logic to trigger breakpoint. |
| `<leader>dc` | Debug Continue | Start debugging or continue execution to next breakpoint. |
| `<leader>dr` | Debug REPL | Open the debugging console. |
| `<leader>du` | Toggle Debug UI | Open/close full panels (Variables, Watches, Call Stack, etc.). |
| `<leader>dt` | Terminate Session | Stop the debugging process. |
| `<leader>di` | Step Into | Step inside function under cursor. |
| `<leader>do` | Step Over | Step onto the next statement in execution. |
| `<leader>dO` | Step Out | Execute up to the end of the current function. |
| `<leader>dl` | Debug Last Run | Re-execute the last debug run. |

---

## 10. Terminals & Tasks
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>ot` | Toggle Terminal | Open/close floating command terminal. |
| `<leader>oo` | Overseer Open | Open task list panel (compilation/runner tasks). |
| `<leader>oO` | Overseer Toggle | Toggle the task panel visibility. |
| `<leader>or` | Overseer Run | Open task runner template menu to choose a template. |

---

## 11. Session Management (Persistence)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>qs` | Restore Session (CWD) | Restores the saved workspace layout and files for current directory. |
| `<leader>ql` | Restore Last Session | Restores the last active session globally. |
| `<leader>qd` | Stop Saving Session | Disables automatic saving of the current session state. |

---

## 12. File Pinning (Harpoon)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>ha` | Add File | Pins the current active file buffer to the Harpoon selection list. |
| `<leader>hh` | Toggle Menu | Opens the interactive floating list window of pinned files. |
| `<leader>h1` - `4` | Go to File 1 - 4 | Instantly jumps to the corresponding pinned file in the list. |

---

## 13. Toggles & Options (Snacks Toggles)
| Keymap | Action | Description |
| :--- | :--- | :--- |
| `<leader>ud` | Toggle Diagnostics | Dynamically show/hide inline code linting and error warnings. |
| `<leader>us` | Toggle Spelling | Turn on/off inline spelling checker. |
| `<leader>uw` | Toggle Wrap | Toggle line wrapping on/off for long files. |

---

## 14. Minor Workflow Helpers & Previews
*   **Markdown Preview**: Press **`<leader>mp`** to toggle real-time documentation browser rendering in your browser.
*   **Blink.cmp**: Autocomplete triggers automatically as you type. Use `Tab` / `Shift+Tab` or `Up` / `Down` to navigate, `Enter` or `Space` to accept.
*   **Todo Comments**: Annotations like `TODO:`, `FIXME:`, `NOTE:`, `WARNING:` in code comments are syntax-highlighted in custom colors.
*   **HTML Auto-tag**: In `.html`, `.tsx`, `.vue` files, changing an opening tag automatically updates its closing tag counterpart.
*   **Colorizer**: CSS hexadecimal colors (like `#ff0055`) show their true color block inline.
*   **Package Info**: In `package.json`, checks latest version dependencies from npm registry and renders info in virtual text.
*   **Sticky Code Context**: Pins function/class declarations to the top of your screen as you scroll.

