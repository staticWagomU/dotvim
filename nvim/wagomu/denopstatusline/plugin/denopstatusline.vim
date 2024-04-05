if exists('g:loaded_denopstatusline')
  finish
endif
let g:loaded_denopstatusline = 1

augroup  loaded_denopstatusline
  autocmd!
  autocmd User DenopsPluginPost:denopstatusline
    \ call denops#notify('denopstatusline', 'init', [])
augroup END
