for %%i in (..\x64\*.asm) do (
	start /wait "" "fasm.exe" "%%~fi"
)