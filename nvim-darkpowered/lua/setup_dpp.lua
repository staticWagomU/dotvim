local M = {}

local _cache_path = vim.fn.stdpath('cache')
local cache_path = _cache_path[1] or _cache_path

local _config_path = vim.fn.stdpath('config')
local config_path = _config_path[1] or _config_path


local dpp_base = vim.fs.joinpath(cache_path, 'dpp')
local ts_path = vim.fs.joinpath(config_path, 'ts', 'dpp.ts')
local plugins_path = vim.fs.joinpath(dpp_base, 'repos', 'github.com')
local augroup = vim.api.nvim_create_augroup('MyConfig', { clear = true })

local preppendPlugins = {
	'Shougo/dpp.vim',
	'Shougo/dpp-ext-lazy',
}

local appendPlugins = {
	'vim-denops/denops.vim',
	'Shougo/dpp-ext-installer',
	'Shougo/dpp-protocol-git',
	'Shougo/dpp-ext-toml',
	'Shougo/dpp-ext-local',
	'staticWagomU/dpp-ext-lua',
}


local function clone(_plugins_path, repos)
	for _, repo in ipairs(repos) do
		local repo_path = vim.fs.joinpath(_plugins_path, repo)
		if not vim.uv.fs_stat(repo_path) then
			local clone_cmd = { 'git', 'clone', 'https://github.com/' .. repo, vim.fs.joinpath(_plugins_path, repo) }
			vim.cmd.echo('"Clone `' .. repo .. '`" | redraw')
			vim.fn.system(clone_cmd)
		end
	end
end

function M.setup()
	if not vim.uv.fs_stat(dpp_base) then
		vim.fn.mkdir(dpp_base, 'p')
	end

	clone(plugins_path, preppendPlugins)
	for _, repo in ipairs(preppendPlugins) do
		local repo_path = vim.fs.joinpath(plugins_path, repo)
		vim.opt.runtimepath:prepend(repo_path)
	end
	local dpp = require('dpp')


	if dpp.load_state(dpp_base) then
		clone(plugins_path, appendPlugins)
		for _, repo in ipairs(appendPlugins) do
			local repo_path = vim.fs.joinpath(plugins_path, repo)
			vim.opt.runtimepath:append(repo_path)
		end

		vim.api.nvim_create_autocmd({ 'User' }, {
				pattern = 'DenopsReady',
				group = augroup,
				callback = function()
					dpp.make_state(dpp_base, ts_path)
				end})


		vim.api.nvim_create_autocmd({ 'User' }, {
				pattern = 'Dpp:makeStatePost',
				group = augroup,
				callback = function()
					vim.cmd.echo('"dpp make_state() is done" | redraw')
				end})
	end
end


return M
