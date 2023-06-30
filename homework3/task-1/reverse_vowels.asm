section .data
	; declare global vars here

section .text
	global reverse_vowels

;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
reverse_vowels:

	push ebp
	push esp
	pop ebp

;	vom retine stringul in registrul eax
	xor eax, eax
	or eax, dword [ebp + 8]
	
;	ecx va fi folosit drept contor, ca sa stim
;	la al catelea caracter din string ne aflam
	xor ecx, ecx

;	vom parcurge stringul caracter cu caracter
;	ca sa gasim vocalele si sa le dam push
gasire_vocale:
;	in edx vom retine caracterul curent din string
	xor edx, edx
	or dl, [eax + ecx]

;	verificam daca ne aflam la o vocala
;	in cazul in care suntem la o vocala, ii vom da push
	cmp dl, 'a'
	je vocala
	cmp dl, 'e'
	je vocala
	cmp dl, 'i'
	je vocala
	cmp dl, 'o'
	je vocala
	cmp dl, 'u'
	je vocala

;	cazul in care nu avem de a face cu o vocala
	jmp consoana

vocala:
;	dam push la vocale in ordinea in care apar in string
	push edx

consoana:
;	trecem la urmatorul caracter din string
	inc ecx
	add eax, ecx
	xor edx, edx
	or dl, [eax]
	sub eax, ecx

;	verificam daca am ajuns la terminatorul de sir
;	in cazul in care nu am ajuns, ne intoarcem in loop
	cmp dl, 0
	jne gasire_vocale	


;	egalam pe ecx cu 0 inca o data pentru ca vom
;	parcurge string-ul din nou inspre a face modificarile
;	necesare
;	parcurgerea va fi tot de la cap la coada
	xor ecx, ecx

schimbare_vocale:
	xor edx, edx
	or dl, [eax + ecx]

;	verificam daca ne aflam la o vocala
	cmp dl, 'a'
	je vocala2
	cmp dl, 'e'
	je vocala2
	cmp dl, 'i'
	je vocala2
	cmp dl, 'o'
	je vocala2
	cmp dl, 'u'
	je vocala2

	jmp consoana2

vocala2:
;	in cazul in care ne aflam la o vocala,
;	dam pop si punem valoarea obtinuta 
;	in pozitia curenta din string
	xor edx, edx
	or dl, [eax + ecx]
	xor [eax + ecx], dl
	xor edx, edx
	pop edx
	or [eax + ecx], dl

consoana2:
;	trecem la urmatorul caracter din string
	inc ecx
	xor edx, edx
	or edx, [eax + ecx]

;	verificam daca am ajuns la terminatorul de sir
;	in cazul in care nu am ajuns, ne intoarcem in loop
	cmp dl, 0
	jne schimbare_vocale

	pop ebp
	ret