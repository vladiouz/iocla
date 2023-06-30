section .data

section .text
    global bonus

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ;; calculam pozitia damei la momentul de fata
    ;; pozitia va fi stocata in edx
    xor edx, edx
    mov edx, eax
    imul edx, 8
    add edx, ebx

    ;; verificam daca dama se poate
    ;; deplasa in directia stanga sus

    ;; pentru cazul in care ne aflam pe prima coloana
    cmp ebx, 0
    je verificare_dreapta_sus
    
    ;; pentru cazul in care ne aflam pe prima linie
    cmp eax, 7
    je verificare_dreapta_sus

    ;; pentru cazul in care dama se poate deplasa
    ;; in directia stanga sus
    add edx, 7
    cmp edx, 32
    jge st_sus_board_de_zero

    ;; adaugam in board[1]
    xor esi, esi    
    mov esi, 1
    xor edi, edi
    mov edi, edx

loop_1:
    cmp edi, 0
    jle loop_1_done
    dec edi
    imul esi, 2
    jmp loop_1

loop_1_done:
    add [ecx + 4], esi
    sub edx, 7
    jmp verificare_dreapta_sus

st_sus_board_de_zero:
    ;; adaugam in board[0]
    sub edx, 32
    xor esi, esi    
    mov esi, 1
    xor edi, edi
    mov edi, edx

loop_2:
    cmp edi, 0
    jle loop_2_done
    dec edi
    imul esi, 2
    jmp loop_2

loop_2_done:
    add [ecx], esi
    add edx, 25

verificare_dreapta_sus:
    ;; verificam daca dama se poate
    ;; deplasa in directia dreapta sus

    ;; pentru cazul in care ne aflam pe ultima coloana
    cmp ebx, 7
    je verificare_stanga_jos
    
    ;; pentru cazul in care ne aflam pe prima linie
    cmp eax, 7
    je verificare_stanga_jos

    ;; pentru cazul in care dama se poate deplasa
    ;; in directia dreapta sus
    add edx, 9
    cmp edx, 32
    jge dr_sus_board_de_zero

    ;; adaugam in board[1]
    xor esi, esi    
    mov esi, 1
    xor edi, edi
    mov edi, edx

loop_3:
    cmp edi, 0
    jle loop_3_done
    dec edi
    imul esi, 2
    jmp loop_3

loop_3_done:
    add [ecx + 4], esi
    sub edx, 9
    jmp verificare_stanga_jos

dr_sus_board_de_zero:
    ;; adaugam in board[0]
    sub edx, 32
    xor esi, esi    
    mov esi, 1
    xor edi, edi
    mov edi, edx

loop_4:
    cmp edi, 0
    jle loop_4_done
    dec edi
    imul esi, 2
    jmp loop_4

loop_4_done:
    add [ecx], esi
    add edx, 23

verificare_stanga_jos:
    ;; verificam daca dama se poate
    ;; deplasa in directia stanga jos

    ;; pentru cazul in care ne aflam pe prima coloana
    cmp ebx, 0
    je verificare_dreapta_jos
    
    ;; pentru cazul in care ne aflam pe ultima linie
    cmp eax, 0
    je verificare_dreapta_jos

    ;; pentru cazul in care dama se poate deplasa
    ;; in directia stanga jos
    sub edx, 9
    cmp edx, 32
    jge st_jos_board_de_zero

    ;; adaugam in board[1]
    xor esi, esi    
    mov esi, 1
    xor edi, edi
    mov edi, edx

loop_5:
    cmp edi, 0
    jle loop_5_done
    dec edi
    imul esi, 2
    jmp loop_5

loop_5_done:
    add [ecx + 4], esi
    add edx, 9
    jmp verificare_dreapta_jos

st_jos_board_de_zero:
    ;; adaugam in board[0]
    sub edx, 32
    xor esi, esi    
    mov esi, 1
    xor edi, edi
    mov edi, edx

loop_6:
    cmp edi, 0
    jle loop_6_done
    dec edi
    imul esi, 2
    jmp loop_6

loop_6_done:
    add [ecx], esi
    add edx, 41

verificare_dreapta_jos:
    ;; verificam daca dama se poate
    ;; deplasa in directia dreapta jos

    ;; pentru cazul in care ne aflam pe ultima coloana
    cmp ebx, 7
    je gata
    
    ;; pentru cazul in care ne aflam pe ultima linie
    cmp eax, 0
    je gata

    ;; pentru cazul in care dama se poate deplasa
    ;; in directia dreapta jos
    sub edx, 7
    cmp edx, 32
    jge dr_jos_board_de_zero

    ;; adaugam in board[1]
    xor esi, esi    
    mov esi, 1
    xor edi, edi
    mov edi, edx

loop_7:
    cmp edi, 0
    jle loop_7_done
    dec edi
    imul esi, 2
    jmp loop_7

loop_7_done:
    add [ecx + 4], esi
    add edx, 7
    jmp gata

dr_jos_board_de_zero:
    ;; adaugam in board[0]
    sub edx, 32
    xor esi, esi    
    mov esi, 1
    xor edi, edi
    mov edi, edx

loop_8:
    cmp edi, 0
    jle loop_8_done
    dec edi
    imul esi, 2
    jmp loop_8

loop_8_done:
    add [ecx], esi
    add edx, 39

gata:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY