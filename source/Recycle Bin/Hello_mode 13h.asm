        org 100h

Start:
        mov     ah, $0F
        int     10h
        mov     [bOldMode], al
        mov     [bOldPage], bh

        mov     ax, $0013
        int     10h

        push    $A000
        pop     es
;        xor     di, di
;        mov     al, $2
;        mov     cx, 320 * 200
;        rep stosb

;        xor     di, di
;        mov     cx, 200
;.RowLoop:
;        push    cx
;
;        mov     cx, 256
;        xor     al, al
;.ColLoop:
;        stosb
;        inc     al
;        loop    .ColLoop
;
;        add     di, 320 - 256
;        pop     cx
;        loop    .RowLoop

        mov     cx, 320 * 200
        xor     di, di
        mov     si, 320
.DrawLoop:
        xor     dx, dx
        mov     ax, di
        div     si
        sub     ax, 4
        push    dx ax
        sub     dx, 160
        sub     ax, 100
        imul    dx, dx
        imul    ax, ax
        add     dx, ax
        cmp     dx, 8000
        pop     ax dx
        ja      @F
        xor     ax, dx
        and     al, $51
        jmp     .PutPixel
@@:
        xor     al, dl
        and     al, $40
.PutPixel:
        stosb
        loop    .DrawLoop

        mov     ax, $0C08
        int     21h
        test    al, al
        jnz     @F
        mov     ah, $08
        int     21h
@@:

        movzx   ax, [bOldMode]
        int     10h
        mov     ah, $05
        mov     al, [bOldPage]
        int     10h
        ret

bOldMode        db      ?
bOldPage        db      ?