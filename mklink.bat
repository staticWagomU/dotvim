@echo off
setlocal enabledelayedexpansion

REM nvimのシンボリックリンクを作成
del %LOCALAPPDATA%\nvim
del %LOCALAPPDATA%\nvim-sub
del %LOCALAPPDATA%\nvim-mini
del %LOCALAPPDATA%\nvim-tmp
mklink /D %LOCALAPPDATA%\nvim %USERPROFILE%\dotvim\nvim
mklink /D %LOCALAPPDATA%\nvim-sub %USERPROFILE%\dotvim\nvim-sub
mklink /D %LOCALAPPDATA%\nvim-mini %USERPROFILE%\dotvim\nvim-mini
mklink /D %LOCALAPPDATA%\nvim-tmp %USERPROFILE%\dotvim\nvim-tmp
mklink /D %LOCALAPPDATA%\nvim-writing %USERPROFILE%\dotvim\nvim-writing

REM vimのシンボリックリンクを作成
REM dir /B /A:Dでディレクトリのシンボリックリンクを作成する
for /f %%i in ('dir /B /A:D %USERPROFILE%\dotvim\vim') do (
  if not %%i == .git (
    mklink /D %USERPROFILE%\vimfiles\%%i %USERPROFILE%\dotvim\vim\%%i
  )
)

REM dir /B /A-Dでファイルのシンボリックリンクを作成する
for /f %%i in ('dir /B /A-D %USERPROFILE%\dotvim\vim') do (
  mklink %USERPROFILE%\vimfiles\%%i %USERPROFILE%\dotvim\vim\%%i
)
