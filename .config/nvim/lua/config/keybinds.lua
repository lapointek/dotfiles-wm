-- Set leader key to space
vim.g.mapleader = " "

-- Exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })

-- File explorer
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)


vim.keymap.set("n", "<leader>m", "<CMD>NvimTreeFocus<CR>", {desc = "Focus on file explorer"})
vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", {desc = "Toggle file explorer"})

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Clear search highlight
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Move line down and up in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

-- Stay centered in search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste selection without losing clipboard content
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Prevent pasting replacing clipboard content in visual mode
vim.keymap.set("v", "p", '"_dp', opts)

-- Delete without copying
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Delete line without affecting line break and copying
vim.keymap.set({ "n", "v" }, "<leader>D", [["_D]])

-- Prevent deleted character from copying to clipboard
vim.keymap.set("n", "x", '"_x', opts)

-- Search and replace word globally
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word the cursor is on globally" })

-- Make file executable inside Nvim
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Tabs
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")   -- Open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>") -- Close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")     -- Go to next
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")     -- Go to pre
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>") -- Open current tab in new tab

-- Split window vertically
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- Split window horizontally
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- Make splits equal size
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
-- Close current split window
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Move focus in window splits with ctrl + h,j,k,l
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
