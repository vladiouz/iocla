section .data
section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

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
    mov byte [ecx + edx], 1
    sub edx, 7

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
    mov byte [ecx + edx], 1
    sub edx, 9

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
    mov byte [ecx + edx], 1
    add edx, 9

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
    mov byte [ecx + edx], 1
    add edx, 7

gata:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY