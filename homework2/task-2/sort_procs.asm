%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs

sort_procs:
    ;; DO NOT MOediFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MOediFY

    ;; Your code starts here


    ;; voi face o structura de for in for
    ;; contorul pentru for-ul exterior este esi,
    ;; iar pentru cel interior edi
    xor esi, esi

primul_loop:

    mov edi, esi
    inc edi

al_doilea_loop:

    cmp edi, eax
    jge inc_esi

    ;; verific daca doua elemente sunt
    ;; pozitionate bine unul fata de celalalt
    xor ebx, ebx
    xor ecx, ecx
    add edx, esi
    mov bl, [edx + 4 * esi + proc.prio]
    sub edx, esi
    add edx, edi 
    mov cl, [edx + 4 * edi + proc.prio]
    sub edx, edi
    cmp bl, cl
    jg swap_procs
    jl continua

    xor ebx, ebx
    xor ecx, ecx
    add edx, esi
    mov bx, [edx + 4 * esi + proc.time]
    sub edx, esi
    add edx, edi 
    mov cx, [edx + 4 * edi + proc.time]
    sub edx, edi
    cmp bx, cx
    jg swap_procs
    jl continua


    xor ebx, ebx
    xor ecx, ecx
    add edx, esi
    mov bx, [edx + 4 * esi + proc.pid]
    sub edx, esi
    add edx, edi 
    mov cx, [edx + 4 * edi + proc.pid]
    sub edx, edi
    cmp bx, cx
    jg swap_procs
    jmp continua

    ;; da swap la doua elemente care nu sunt
    ;; pozitionate corespunzator
swap_procs:
    add edx, esi
    mov bx, [edx + 4 * esi + proc.pid]
    push ebx
    mov bl, [edx + 4 * esi + proc.prio]
    push ebx
    mov bx, [edx + 4 * esi + proc.time]
    push ebx
    sub edx, esi

    add edx, edi
    mov bx, [edx + 4 * edi + proc.pid]
    push ebx
    mov bl, [edx + 4 * edi + proc.prio]
    push ebx
    mov bx, [edx + 4 * edi + proc.time]
    push ebx
    sub edx, edi

    add edx, esi
    add edx, esi
    add edx, esi
    add edx, esi
    add edx, esi
    pop ebx
    mov [edx + proc.time], bx
    pop ebx
    mov [edx + proc.prio], bl
    pop ebx
    mov [edx + proc.pid], bx
    sub edx, esi
    sub edx, esi
    sub edx, esi
    sub edx, esi
    sub edx, esi

    add edx, edi
    add edx, edi
    add edx, edi
    add edx, edi
    add edx, edi
    pop ebx
    mov [edx + proc.time], bx
    pop ebx
    mov [edx + proc.prio], bl
    pop ebx
    mov [edx + proc.pid], bx
    sub edx, edi
    sub edx, edi
    sub edx, edi
    sub edx, edi
    sub edx, edi
continua:

    inc edi
    jmp al_doilea_loop

    ;; trece la urmatorul pas in
    ;; loop-ul exterior
inc_esi:
    inc esi
    cmp esi, eax
    jl primul_loop

done:

    ;; Your code ends here
    
    ;; DO NOT MOediFY
    popa
    leave
    ret
    ;; DO NOT MOediFY