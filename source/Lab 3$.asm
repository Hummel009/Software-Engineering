org 100h

start:
        mov ah, 09h
        mov dx, writeln
        int 21h

        mov ah, 02h
        mov dl, 10
        int 21h

        mov ah, 02h
        mov dl, 13
        int 21h

initLoop:
        mov dx, 7     ;the quantity of elements in array
        mov ax, 0     ;the quantity of duplicates
        mov bx, nums  ;put the array into the bx

startIteration:
        mov cx, [bx]  ;put I value. Start value is +0
        cmp cx,[bx+2] ;compare I and I+1 values. Next value is +2

        jne finishIteration

hasDuplicate:
        add ax, 2     ;duplicate++

        mov ah, 09h
        mov dx, eql   ;show that there is a duplicate
        int 21h

finishIteration:
        dec dx        ;dec loop parameter
        add bx, 2     ;new iteration will compate I+1 and I+2, etc
        cmp dx, 7     ;should break loop?
        jne startIteration

        cmp ax, 1
        jng skipForgottenComparison
        inc ax        ;first two duplicates had +1 instead of +2

skipForgottenComparison:

        mov ah, 08h
        int 21h

ret

writeln: db "Array: 34,  45,  56,  67,  75, 89,  67$"
eql: db "Equal$"
nums dw  1,  1,  3,  4,  5, 6,  7 