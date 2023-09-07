@echo off
for %%i in (..\x16\*.asm) do (
    "fasm.exe" "%%~fi"
    if errorlevel 1 (
        echo Error assembling "%%~fi"
        pause
    )
)