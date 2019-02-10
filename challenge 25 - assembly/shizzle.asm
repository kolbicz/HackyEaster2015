.686P
MODEL FLAT, STDCALL
JUMPS
LOCALS

UNICODE=0

INCLUDE C:\TASM\W32.INC

.DATA

szLibrary	db "libhe2015_Lizzle.dll",0
szFizzle	db "Fizzle",0
szShizzle	db "Shizzle",0
szFound		db "Success!!",0
szStart		db "0000000000000000",0
szInput		db 16 dup (2fh), 0
szEncrypted	db "v3O] pmWm<Y(0=21",0
szResult	db 16 dup (?),0

;jadnIdal0vecod3n

.DATA?

hLib	dd ?
Fizzle	dd ?
Shizzle	dd ?

.CODE

Start: 

	call 	LoadLibrary, offset szLibrary
	mov		hLib, eax
	call	GetProcAddress, hLib, offset szShizzle
	mov 	Shizzle, eax
	call	GetProcAddress, hLib, offset szFizzle
	mov 	Fizzle, eax
	xor edi, edi
	.WHILE !edi==16	
		call findchar, edi
		mov byte ptr [szResult+edi], al
		inc edi
	.ENDW
	call	MessageBox, NULL, offset szResult, offset szFound, MB_ICONINFORMATION
	call	copy, offset szResult ; copy text to the clipboard
	call 	ExitProcess, NULL
	
findchar	PROC	index:DWORD ; try to get a char for given index
LOCAL	c:BYTE
uses edi
	mov c, 2fh
	mov edi, index
	mov bl, byte ptr [szEncrypted+edi]
	.WHILE !byte ptr [szInput+edi]==bl ; check if byte matched
		inc c
		mov al, c
		mov byte ptr [szInput+edi], al
		call encrypt, offset szInput
	.ENDW
	mov al, c
	ret
findchar	ENDP

encrypt	PROC str_in:DWORD
LOCAL count:DWORD
LOCAL str_out[17]:BYTE
uses ebx
	mov count, 0
	lea	esi, str_out
	.WHILE !count==10 ; loop 10 times
		call	bizzle, str_in
		call	Shizzle, str_in, esi
		add		esp, 2*4 ; adjust stack
		call	rizzle, esi
		call	Fizzle, esi, str_in
		add		esp, 2*4 ; adjust stack
		inc		count
	.ENDW
	ret
encrypt ENDP
	
rizzle	PROC, str_in:DWORD ;invert case
uses esi
	mov 	esi, str_in
	.WHILE !byte ptr [esi]==0
		.IF byte ptr [esi]>="A" && byte ptr [esi]<="Z"
			add byte ptr [esi], 20h
		.ELSEIF byte ptr [esi]>="a" && byte ptr [esi]<="z"
			sub byte ptr [esi], 20h
		.ENDIF
		inc esi
	.ENDW
	ret
rizzle	ENDP	

bizzle	PROC, str_in:DWORD ;increment characters
uses esi
	mov 	esi, str_in
	.WHILE !byte ptr [esi]==0
		.IF byte ptr [esi]>="a" && byte ptr [esi]<"z"
			inc byte ptr [esi]
		.ELSEIF byte ptr [esi]=="z"
			mov byte ptr [esi], "a"
		.ELSEIF byte ptr [esi]>="A" && byte ptr [esi]<"Z"
			inc byte ptr [esi]
		.ELSEIF byte ptr [esi]=="Z"
			mov byte ptr [esi], "A"
		.ENDIF		
		inc esi
	.ENDW
	ret
bizzle	ENDP	

copy	PROC input:DWORD
LOCAL hMem:DWORD, pMem:DWORD, sLen:DWORD
	call lstrlen, input
	mov sLen, eax
	inc eax
    call GlobalAlloc, GMEM_MOVEABLE+GMEM_DDESHARE+GMEM_ZEROINIT, eax
    mov hMem, eax
    call GlobalLock, hMem                      ; lock memory
    mov pMem, eax
    call lstrcpyn, pMem, input, sLen
    call OpenClipboard, NULL                   ; open clipboard
    call EmptyClipboard
    call SetClipboardData, CF_TEXT, pMem        ; write data to it
    call CloseClipboard                       ; close clipboard
    call GlobalUnlock, hMem                    ; unlock memory
    call GlobalFree, hMem                      ; deallocate memory
    ret
copy 	ENDP
	
End Start