org 100h

	mov ah, 09h
	mov dx, str1
	int 21h

	mov ah, 0ah
	mov dx, str2
	int 21h

	mov ah, 02h
	mov dx, 10
	int 21h

	mov ah, 02h
	mov dx, 13
	int 21h

	mov al, [str2+9]
	mov bl, [str2+10]
	mov [str2+9], bl
	mov [str2+10], al

	mov al, [str2+2]
	mov bl, [str2+5]
	mov cl, [str2+8]
	sub al, bl
	add al, cl
	mov [str2+4], al

	mov ah, 09h
	mov dx, str2+2
	int 21h

	mov ah, 08h
	int 21h

	ret
str1: db "Enter the text: $"
str2: db 255 dup "$"