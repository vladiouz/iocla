%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
    
cifru:

    ;; golesc registrul eax si decrementez ecx
    ;; pentru a ma muta la alta pozitie din plain
    xor eax, eax
    dec ecx

    ;; al va retine litera la care ne aflam in urma encriptiei
    mov al, [esi + ecx]
    add al, dl
    
    ;; verificam daca am iesit in afara alfabetului
    cmp al, 'Z'
    jle nu_trece_de_z

    sub al, 26

nu_trece_de_z:
    
    ;; punem litera criptata in enc_string
    mov [edi + ecx], al
    
    ;; verific daca am parcurs tot string-ul
    cmp ecx, 0
    jg cifru

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
