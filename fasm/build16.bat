for %%i in (..\x16\*.asm) do (
	start /wait "" "fasm.exe" "%%~fi"
)