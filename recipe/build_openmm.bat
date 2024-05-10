@echo on
setlocal EnableDelayedExpansion

rmdir /s /q dist
%PYTHON% -m pip wheel . --wheel-dir=dist -vv
if errorlevel 1 exit 1

dir
dir dist

for %%f in (dist\*.whl) do (
  copy %%f %RECIPE_DIR%\..\build_artifacts\pypi_wheels\
  if errorlevel 1 exit 1
  %PYTHON% -m pip install %%f
)
