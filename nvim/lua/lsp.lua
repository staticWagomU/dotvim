local M = {}

local USERPROFILE = os.getenv('USERPROFILE')

M.deno_path = require('utils').joinpath(USERPROFILE, '.deno/bin/deno.exe')

return {}
