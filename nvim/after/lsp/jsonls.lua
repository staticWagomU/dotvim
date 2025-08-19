local schemas = require('wagomu-box.plugin-config.schema-catalog').schemas
return {
	filetypes = { 'json', 'jsonc' },
	extra_filetypes = { 'jsonc', 'json' },
	settings = {
		json = {
			schemas = schemas,
		},
	},
}
