.model small

;Вариант 1.
;if (a > b) and (c < d):
;    print((a - b) * c + d)
;else:
;    if ((d + a) > (b - c)) or (a == b):
;        print((d + a) - (b - c))
;    else:
;        print(b * a - c * d + 4)

.data
varA dw 4
varB dw 2
varC dw 2
varD dw 4
char dw 0

.code
main:
	mov ax, @data
	mov ds, ax

    mov ax, varA
    cmp ax, varB
    jle firstElse
    mov ax, varC
    cmp ax, varD
    jge firstElse

;print((a - b) * c + d)
    mov ax, varA
    sub ax, varB
    mul varC
    add ax, varD
    mov char, ax
    call printNum
    jmp toEnd

firstElse:
    mov ax, varD
    add ax, varA
    mov bx, varB
    sub bx, varC
    cmp ax, bx
    jg print2
    mov ax, varA
    cmp ax, varB
    je print2

;print(b * a - c * d + 4)
    mov ax, varB
    mul varA
    mov bx, ax
    mov ax, varC
    mul varD
    mov char, bx
    sub char, ax
    add char, 4
    call printNum
    jmp toEnd

print2:
;print((d + a) - (b - c))
    mov ax, varD
    add ax, varA
    sub ax, varB
    add ax, varC
    mov char, ax
    call printNum
    jmp toEnd

printNum:
    mov ax, char
    cmp ax, 0
    je printZero
    jg printPos
    mov dl, 45
    push ax
    mov ah, 02h
    int 21h
    pop ax
    neg ax

printPos:
    cmp ax, 0
    je return
    mov dx, 0
    mov bx, 10
    div bx
    add dx, 48
    push dx
    call printPos
    pop dx
    push ax
    mov ah, 02h
    int 21h
    pop ax

return:
    ret

printZero:
    mov ah, 02h
    mov dl, 48
    int 21h
    ret

toEnd:
    mov ah, 04Ch
    mov al, 0
    int 21h
end main