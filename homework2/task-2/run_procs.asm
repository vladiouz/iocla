%include "../include/io.mac"

    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;

struc avg
    .quo: resw 1
    .remain: resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    ;; un loop, astfel incat trecem prin toate
    ;; elementele vectorului procs
loop:
    dec ebx

    ;; in prio_result stochez numarul de procese
    ;; in functie de prioritate, iar in time_result
    ;; stochez suma timpurilor necesare ca procesele
    ;; de fiecare prioritate sa fie rulate
    add ecx, ebx
    xor edx, edx
    mov dl, [ecx + 4 * ebx + proc.prio]
    dec dl
    mov edi, prio_result
    add dword [edi + 4 * edx], 1
    mov edi, time_result
    add edi, edx
    add edi, edx
    add edi, edx
    add edi, edx
    xor edx, edx
    mov dx, [ecx + 4 * ebx + proc.time]
    add dword [edi], edx
    sub ecx, ebx

    cmp ebx, 0
    jg loop

    ;; vom trece prin fiecare prioritate
    ;; si ebx va fi contorul
    mov ebx, 0
    mov edi, time_result
    mov esi, prio_result
    mov edx, eax
    push ecx

loop_2:
    mov eax, [edi]
    xor ecx, ecx
    mov ecx, [esi]

    cmp ecx, 0
    je zero

    ;; cazul in care exista minim un proces
    ;; care sa aiba prioritatea actuala
    push edi
    mov edi, edx
    push edx
    xor edx, edx
    div ecx
    mov [edi + 4 * ebx + avg.quo], ax
    mov [edi + 4 * ebx + avg.remain], dx
    pop edx
    pop edi
zero:

    add edi, 4
    add esi, 4

    inc ebx
    cmp ebx, 5
    jge done
    jmp loop_2

done:
    mov eax, edx
    pop ecx
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY