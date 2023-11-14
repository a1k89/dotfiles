local setup, autosave = pcall(require, "auto-save")
if not setup then return end

autosave.setup()
