local check_external_reqs = function()
  for _, exe in ipairs { 'git', 'make', 'unzip', 'rg' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format("Found executable: '%s'", exe))
    else
      vim.health.warn(string.format("Could not find executable: '%s'", exe))
    end
  end
end

return {
  check = function()
    vim.health.start 'nvim config'

    local uv = vim.uv or vim.loop
    vim.health.info('System Information: ' .. vim.inspect(uv.os_uname()))
    vim.health.ok(string.format("Neovim version: '%s'", tostring(vim.version())))

    check_external_reqs()
  end,
}
