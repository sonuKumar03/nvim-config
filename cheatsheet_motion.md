# Vim Motion & Editing Cheatsheet

This cheatsheet covers the core Vim motions, operators, text objects, and navigation commands to help you build muscle memory.

---

## 1. Core Navigation

### Basic Movements
| Key | Action | Description / Tip |
| :---: | :--- | :--- |
| `h` | Move Left | Use this instead of arrow keys. |
| `j` | Move Down | Think of it as pointing downwards. |
| `k` | Move Up | Think of it as pointing upwards. |
| `l` | Move Right | Move one character to the right. |

### Word-wise Movements
| Key | Action | Description / Tip |
| :---: | :--- | :--- |
| `w` | Next word (start) | Moves to the start of the next alphanumeric word. |
| `W` | Next word (start, space-separated) | Moves to the start of the next WORD (stops only at spaces). |
| `e` | Next word (end) | Moves to the end of the current or next alphanumeric word. |
| `E` | Next word (end, space-separated) | Moves to the end of the current or next WORD (space-separated). |
| `b` | Previous word (start) | Moves backward to the start of the word. |
| `B` | Previous word (start, space-separated)| Moves backward to the start of the WORD (space-separated). |
| `ge` | Previous word (end) | Moves backward to the end of the previous word. |

### Line Navigation
| Key | Action | Description / Tip |
| :---: | :--- | :--- |
| `0` | Beginning of line | Moves to the absolute first column of the line (column 0). |
| `^` | First non-blank character | Moves to the first visible character on the current line. |
| `$` | End of line | Moves to the last character of the current line. |
| `g_` | Last non-blank character | Moves to the last non-space character of the current line. |
| `f{char}` | Find next `{char}` | Jumps directly to the next occurrence of `{char}` on the current line. |
| `F{char}` | Find previous `{char}` | Jumps backward to the previous occurrence of `{char}`. |
| `t{char}` | Till next `{char}` | Jumps to the character *before* the next occurrence of `{char}`. |
| `T{char}` | Till previous `{char}` | Jumps to the character *after* the previous occurrence of `{char}`. |
| `;` | Repeat find | Repeats the last `f`/`F`/`t`/`T` search in the forward direction. |
| `,` | Repeat find reverse | Repeats the last `f`/`F`/`t`/`T` search in the backward direction. |

### Vertical Navigation
| Key | Action | Description / Tip |
| :---: | :--- | :--- |
| `gg` | Go to start of file | Jumps to the very first line of the file. |
| `G` | Go to end of file | Jumps to the very last line of the file. |
| `{line}G` or `{line}gg` | Go to line | Jumps to the specified line number (e.g., `45G`). |
| `%` | Jump matching brace | Jumps between matching brackets: `()`, `{}`, `[]`. |
| `}` | Next paragraph | Jumps forward to the next blank line. |
| `{` | Previous paragraph | Jumps backward to the previous blank line. |

---

## 2. Screen Scrolling
| Key | Action | Description / Tip |
| :---: | :--- | :--- |
| `Ctrl + d` | Scroll down half screen | Smooth scroll downwards. |
| `Ctrl + u` | Scroll up half screen | Smooth scroll upwards. |
| `Ctrl + f` | Scroll down full screen | Jump a full screen down. |
| `Ctrl + b` | Scroll up full screen | Jump a full screen up. |
| `H` | High | Move cursor to the top line visible on screen. |
| `M` | Middle | Move cursor to the middle line visible on screen. |
| `L` | Low | Move cursor to the bottom line visible on screen. |
| `zt` | Center Top | Scroll screen so the cursor line is at the top of the window. |
| `zz` | Center Middle | Scroll screen so the cursor line is in the middle of the window. |
| `zb` | Center Bottom | Scroll screen so the cursor line is at the bottom of the window. |

---

## 3. The Power Formula: Operator + Motion

Vim commands are sentences structured as: **[operator] [number/modifier] [motion]**
*Example:* `d2w` = **d**elete **2** **w**ords.

### Operators
| Key | Action | Description / Tip |
| :---: | :--- | :--- |
| `d` | Delete (Cut) | Deletes text. Double it (`dd`) to delete the current line. |
| `c` | Change | Deletes text and starts Insert mode. Double it (`cc`) to change current line. |
| `y` | Yank (Copy) | Copies text to registry. Double it (`yy`) to copy the current line. |
| `v` | Visual | Starts character-wise Visual mode. |
| `V` | Visual Line | Starts line-wise Visual mode. |
| `Ctrl + v` | Visual Block | Starts column/block selection. |
| `>` | Shift right | Indents selected text or motion. |
| `<` | Shift left | Un-indents selected text or motion. |
| `=` | Auto-indent | Formats code layout. |

### Powerful Combinations
*   `dw` - Delete from cursor to the start of the next word.
*   `d$` or `D` - Delete from cursor to the end of the line.
*   `c$` or `C` - Change from cursor to the end of the line.
*   `y$` or `Y` - Yank from cursor to the end of the line.
*   `df{char}` - Delete everything from cursor up to and including `{char}`.
*   `dt{char}` - Delete everything from cursor up to (but not including) `{char}`.

---

## 4. Text Objects

Text objects allow you to operate on structured code blocks (like quotes, parentheses, tags, or words) regardless of where your cursor is inside them.

**Formula: [operator] + [i (inner) / a (around/outer)] + [object]**
*   `i` (inner): Selects/operates only on the contents inside the boundaries.
*   `a` (around): Selects/operates on the contents AND the boundary/whitespace.

| Object Key | Description | Examples |
| :---: | :--- | :--- |
| `w` | Word | `diw` (delete inner word), `caw` (change around word) |
| `p` | Paragraph | `dip` (delete paragraph), `yap` (copy paragraph) |
| `s` | Sentence | `cis` (change sentence) |
| `"`, `'`, \` | Quotes | `ci"` (change inside double quotes), `ya'` (yank quote with quotes) |
| `(`, `)`, `b` | Parentheses | `di(` (delete inside parens), `ca(` (change parens and content) |
| `{`, `}`, `B` | Braces | `ci{` (change code inside block), `ya{` (yank curly braces block) |
| `[`, `]` | Brackets | `di[` (delete inside brackets) |
| `t` | HTML/XML Tag | `cit` (change content inside tag), `dat` (delete entire tag element) |

### Treesitter Code Objects

These mappings work in supported languages with a Treesitter parser installed.

| Key | Action | Description / Tip |
| :---: | :--- | :--- |
| `vif` | Select inside function | Select the function body without the function declaration. |
| `vaf` | Select entire function | Select the function, including its declaration. |
| `vic` | Select inside class | Select the class contents without the class declaration. |
| `vac` | Select entire class | Select the class, including its declaration. |

### Surround Editing (nvim-surround)

| Key | Action | Description / Tip |
| :---: | :--- | :--- |
| `ys{motion}{char}` | Add surrounding | Surround the text covered by a motion. Example: `ysiw]` wraps the word in `[]`. |
| `yss{char}` | Surround line | Surround the entire current line. |
| `S{char}` | Surround selection | In Visual mode, select text and press `S`, then the surrounding character. |
| `cs{old}{new}` | Change surrounding | Replace one surrounding pair with another. Example: `cs([` changes `(...)` to `[...]`. |
| `ds{char}` | Delete surrounding | Remove a surrounding pair. Example: `ds(` removes parentheses. |

---

## 5. Search & Replace

| Key | Action | Description / Tip |
| :---: | :--- | :--- |
| `/{pattern}` | Search forward | Finds `{pattern}` forward. Press `Enter` to search. |
| `?{pattern}` | Search backward | Finds `{pattern}` backward. |
| `n` | Repeat search forward | Jumps to the next search match. |
| `N` | Repeat search backward | Jumps to the previous search match. |
| `*` | Search current word forward | Jumps to the next occurrence of the word under cursor. |
| `#` | Search current word backward | Jumps to the previous occurrence of the word under cursor. |
| `:%s/old/new/g` | Substitute global | Replaces `old` with `new` in the entire file. |
| `:%s/old/new/gc` | Substitute with confirm | Replaces `old` with `new` globally but prompts you for each match. |

---

## 6. Jumps & Marks

Vim keeps a history of places your cursor has jumped (e.g. using search, `G`, line jumps).

| Key | Action | Description / Tip |
| :---: | :--- | :--- |
| `Ctrl + o` | Jump backward | Takes you back to where you were before your last jump. |
| `Ctrl + i` | Jump forward | Takes you forward in your jump history. |
| `m{a-z}` | Set local mark | Places a marker named `{a-z}` at the current cursor position. |
| `'{a-z}` | Jump to mark line | Jumps to the first non-blank character of the line of mark `{a-z}`. |
| `` `{a-z} `` | Jump to mark exactly | Jumps to the exact row and column of mark `{a-z}`. |
| `''` (two single quotes) | Jump back | Return to the line before your last jump. |
| `` `` `` (two backticks) | Jump back exact | Return to the exact position before your last jump. |

---

## 7. Efficient Editing Workflows

### Inserting Text
*   `i` / `a`: Insert before cursor / Append after cursor.
*   `I` / `A`: Insert at start of line / Append at end of line.
*   `o` / `O`: Insert new line below current line / Insert new line above current line.

### Moving Lines
*   `Alt + j`: Move the current line, or Visual-mode selection, down.
*   `Alt + k`: Move the current line, or Visual-mode selection, up.

### Deleting & Replacing
*   `x`: Delete character under cursor.
*   `r{char}`: Replace the character under the cursor with `{char}` (remains in Normal mode).
*   `R`: Enter Replace Mode (overwrites characters as you type).
*   `~`: Toggle case of the character under the cursor.

### Undo & Redo
*   `u`: Undo last action.
*   `Ctrl + r`: Redo last action.
*   `.` (dot): Repeat the last editing change (extremely powerful!).
