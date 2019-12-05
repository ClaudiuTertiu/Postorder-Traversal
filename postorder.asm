%include "/home/student/Documents/Tema1/skel/includes/io.inc"

extern getAST
extern freeAST

section .bss
    ; La aceasta adresa, scheletul stocheaza radacina arborelui
    root: resd 1
    array: resd 10000
    end_array: resd 1
    length: resd 1
section .text
global main

treeParse:  
; -> parcurge tot arborele
    push ebp
    mov ebp, esp
    mov ebx, dword[ebp + 8] ; -> ebx contine nodul
    
    cmp ebx, 0 ; -> verific daca e capat de arbore
    je exit_call_array
    mov edx, [ebx]
    ; mov edx, [edx]
    mov dword[array + ecx*4], edx ; -> adaug tot in vector
    inc ecx
    
    push dword [ebx + 4] ; -> il urc ca argument pe stiva
    call treeParse ; -> apel recursiv pe fiul stang
    mov ebx, dword[ebp + 8] ; -> iau primul argument
    push dword [ebx + 8] ; -> apel recursiv pe fiul drept
    call treeParse
    jmp exit_call
         
result:
    xor ebx,ebx
    lea ebx, [array+4*ecx]
    mov ebx, [ebx]
    cmp ecx, 0
    jl exit_call_result
    
    dec ecx
    push ecx
    
    cmp byte[ebx], '*'; inmultire '*'
    je inmultire
    
    cmp byte[ebx], '+'; adunare '+'
    je adunare
    
    cmp dword[ebx], '-'; scadere '-'
    je scadere
    
    cmp byte[ebx], '/'; impartire '/'
    je impartire

    ; -> Inseamna ca am dat de un numar
    ; pe care vreau sa il convertesc cu atoi
    push ebx
    call atoi_parse
    ; PRINT_DEC 4, eax
    pop ecx
    pop ecx
    push eax
    jmp result
    
exit_call_result:
    pop eax
    PRINT_DEC 4, eax
    leave
    ret
    
exit_call_array:
    mov dword[length], ecx ; -> memorez dimensiunea vectorului 
    leave
    ret

adunare:
    pop ecx
    xor eax,eax
    pop eax
    pop edx
    ; xor edx, edx
    ; pop edx
    add eax, edx
    push eax
    jmp result
    
scadere:
    pop ecx
    xor eax,eax
    pop eax
    pop edx
    ; xor edx,edx
    ; pop edx
    sub eax, edx
    push eax
    jmp result
    
impartire:
    pop ecx
    xor eax,eax
    pop eax
    pop ebx
    xor edx,edx
    ;pop ebx
    cdq
    idiv ebx
    push eax
    
    jmp result
    
inmultire:
    pop ecx
    xor eax,eax
    pop eax
    pop edx
    ;xor edx,edx
    ;pop edx
    imul edx
    push eax
    jmp result
    
atoi_parse:
    push ebp
    mov ebp, esp
    xor edx, edx
    xor ebx, ebx   
    mov ebx, dword[ebp + 8]   
    mov esi, ebx; in ebx am adresa root-ului
    xor ebx, ebx
    ;mov esi, [esi]
    mov bl, 10; o sa inmultesc cu 10
    cmp byte[esi], '-' ; verific daca vine cu un -
    je negativeSign ; muta semnul negativ in bh
    jmp number ; nu are minus
        
negativeSign:
    mov cl, byte[esi] ; memorez minusul
    inc esi ; parcurg string ul, sar peste -

number:
    xor eax,eax
    mov dl, byte[esi]
    sub dl, 48 ; transform in ascii 
    mov al, dl     
convert_loop:
    inc esi ; avansez in string
    cmp byte[esi], 0 ;vad daca s-a terminat string ul
    je check_neg
    mul ebx
    mov dl, byte [esi] ;iau caracter cu caracter
    sub dl, 48 ;convertesc in ascii
    add eax, edx
    jmp convert_loop   
check_neg:
    cmp cl, '-'
    je transform_neg
    jmp exit_call   
transform_neg:
    not eax
    inc eax
    jmp exit_call
exit_call:
    leave
    ret
  
main:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp; for correct debugging
    xor ecx,ecx
    mov ecx, 1
    call getAST
    mov [root], eax
    push dword [root]
    call treeParse; -> parcurgerea arborelui    
    xor ecx, ecx
    mov ecx, dword[length] 
    xor ebx,ebx
    dec ecx;-> dimensiunea vectorului fara terminator
    call result 
    PRINT_DEC 4, eax
    push dword[root]
    call freeAST
    xor eax,eax

    leave
    ret
