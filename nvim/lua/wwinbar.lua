local excluded_filetypes = {
  'ddu-ff'
}

local function is_uri(filename)
  -- URIのスキームパターン
  local uri_scheme_pattern = "^%w+://"
  -- ファイル名がnilでないことを確認
  if filename == nil then
    return false
  end
  -- URIスキームパターンにマッチするか確認
  if string.match(filename, uri_scheme_pattern) then
    return true
  end
  -- ファイルシステムパスの特徴を持つかチェック
  local path_separators = "/\\"  -- UNIXとWindowsのパス区切り文字
  if string.find(filename, "^[" .. path_separators .. "]") or
     string.find(filename, "^%a:[" .. path_separators .. "]") then
    return false
  end
  -- その他の場合はURIと見なす
  return true
end

local function get_unique_path(bufnr, other_bufnrs)
  local function split_path(path)
    local parts = {}
    for part in string.gmatch(path, "[^/\\]+") do
      table.insert(parts, part)
    end
    return parts
  end

  local function get_common_prefix(paths)
    if #paths == 0 then return {} end
    local prefix = {}
    local first = paths[1]
    for i = 1, #first do
      local part = first[i]
      for _, path in ipairs(paths) do
        if i > #path or path[i] ~= part then
          return prefix
        end
      end
      table.insert(prefix, part)
    end
    return prefix
  end

  local current_path = split_path(vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':p'))
  local all_paths = {current_path}
  for _, other_bufnr in ipairs(other_bufnrs) do
    if other_bufnr ~= bufnr then
      table.insert(all_paths, split_path(vim.fn.fnamemodify(vim.fn.bufname(other_bufnr), ':p')))
    end
  end

  local common_prefix = get_common_prefix(all_paths)
  local unique_parts = {}
  for i = #common_prefix + 1, #current_path do
    table.insert(unique_parts, current_path[i])
  end

  -- 最低でも2つのディレクトリ要素を含めるようにする
  if #unique_parts < 3 and #current_path > #common_prefix + 2 then
    table.insert(unique_parts, 1, current_path[#common_prefix])
  end

  return table.concat(unique_parts, '/')
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'BufEnter', 'BufModifiedSet', 'WinEnter', 'WinLeave' }, {
  group = WagomuBox.MyAuGroup,
  pattern = '*',
  callback = function()
    local buflist = {}
    for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
      -- popup windowは無視
      if vim.fn.win_gettype(buf.bufnr) == 'popup' then
        goto continue
      end

      if is_uri(buf.name) then
        goto continue
      end

      -- ファイル名が空の場合は無視
      local filename = vim.fs.basename(buf.name)
      if filename == '' then
        goto continue
      end
      -- filetypeが除外リストに含まれている場合は無視
      if vim.tbl_contains(excluded_filetypes, vim.fn.getbufvar(buf.bufnr, '&filetype')) then
        goto continue
      end

      if not buflist[filename] then
        buflist[filename] = {}
      end

      table.insert(buflist[filename], buf.bufnr)

      ::continue::
    end

    for _, bufnrs in pairs(buflist) do
      if #bufnrs > 1 then
        for _, bufnr in ipairs(bufnrs) do
          local unique_path = get_unique_path(bufnr, bufnrs)
          local winid = vim.fn.bufwinid(bufnr)
          if winid ~= -1 then
            vim.fn.setwinvar(winid, '&winbar', unique_path)
          end
        end
      else
        local winid = vim.fn.bufwinid(bufnrs[1])
        if winid ~= -1 then
          vim.fn.setwinvar(winid, '&winbar', vim.fs.basename(vim.fn.bufname(bufnrs[1])))
        end
      end
    end
  end,
})

