; FUNCIONES de C
  extern malloc
  extern free
  extern fprintf
   
; FUNCIONES
  global ct_new
  global ct_delete
  global ct_print
  global ctIter_new
  global ctIter_delete
  global ctIter_first
  global ctIter_next
  global ctIter_get
  global ctIter_valid

%define NULL 0

%define offset_root 0
%define offset_size 8

 

%define offset_padre 0
%define offset_valor1 8
%define offset_valor2 12
%define offset_valor3 16
%define offset_len 20
%define offset_child1 21
%define offset_child2 29
%define offset_child3 37
%define offset_child4 45

%define offset_tree 0
%define offset_node 8
%define offset_current 16
%define offset_count 17

section .data
	msg: db '%i', 10
 
section .text

; =====================================
; void ct_new(ctTree** pct);
ct_new:
		push rbp		;guardo el fondo de la pila
		push r12		;guardo r12

		mov rbp, rsp	;defino nuevo stack
		sub rsp, 8		;alineo stack

		mov r12, rdi	;guardo el puntero a tree
		mov rdi, 12		;pongo 12 bytes en el rdi para malloc
		call malloc		

		mov [r12], rax 	;pongo la direccion de el nuevo tree en los primeros 8 bytes del puntero del tree parametro
		mov qword [rax + offset_root], NULL
		mov qword [rax + offset_size], NULL

		add rsp, 8		;rearreglo la pila
		pop r12
		pop rbp

        ret

; =====================================
; void ct_delete(ctTree** pct);
ct_delete:
		push rbp
		push r12

		mov rbp, rsp  ;creo stack frame
		sub rsp, 8    ;alineo a 16 la pila
    mov r12, [rdi]  ;guardo el puntero a la raiz 

    .ciclo:

      .hijo1:
        cmp qword [r12 + offset_child1], NULL     ;comparo si hijo1 es null
        je .hijo2                           ;si lo es, paso al siguiente
        lea r12, [r12 + offset_child1]      ;pongo en r12 la direccion de donde esta el nuevo puntero a borrar
        mov r12, [r12]                      ;pongo en r12 el puntero a borrar
        jmp .ciclo

      .hijo2:
        cmp qword [r12 + offset_child2], NULL     ;comparo si hijo2 es null
        je .hijo3                           ;si lo es, paso al siguiente
        lea r12, [r12 + offset_child2]      ;pongo en r12 la direccion de donde esta el nuevo puntero a borrar
        mov r12, [r12]                      ;pongo en r12 el puntero a borrar
        jmp .ciclo

      .hijo3:
        cmp qword [r12 + offset_child3], NULL     ;comparo si hijo3 es null
        je .hijo4                           ;si lo es, paso al siguiente
        lea r12, [r12 + offset_child3]      ;pongo en r12 la direccion de donde esta el nuevo puntero a borrar
        mov r12, [r12]                      ;pongo en r12 el puntero a borrar
        jmp .ciclo

      .hijo4:
        cmp qword [r12 + offset_child4], NULL     ;comparo si hijo1 es null
        je .estallameElNodo                 ;si lo es, vamos a eliminar el nodo
        lea r12, [r12 + offset_child4]      ;pongo en r12 la direccion de donde esta el nuevo puntero a borrar
        mov r12, [r12]                      ;pongo en r12 el puntero a borrar
        jmp .ciclo

      .estallameElNodo:
        mov rdi, r12                        ;pongo en rdi la direccion del nodo a liberar
        mov r12, [r12]                      ;pongo en r12 el puntero al padre del nodo a liberar
        cmp r12, NULL                       ;comparo padre con null
        je .fin                             ;si es null entonces termino todo
        call free                           ;libero el nodo
        jmp .ciclo                          ;repetimo'

    .fin:
      add rsp, 8
      pop r12
      pop rbp
      ret

; ; =====================================
; ; void ct_aux_print(ctNode* node, FILE *pFile);
ct_aux_print:
		push rbp
		push rcx
		push r12
		push r9

		xor r9, r9 				;cleareo r9				
		mov r9d, esi 			;gurdo el pfile
		mov rbp, rsp 			;creo stack frame
    sub rsp, 8
		xor rcx, rcx

		mov r12, rdi 			;guardo el nodo en r12
		cmp rdi, NULL 			;me fijo si el nodo es null
		je .fin
		mov cl, 0				;me guardo el largo del nodo en cl
		.ciclo:
			cmp cl, [r12 + offset_len]		;comparo a ver si es 0
			je .casifin 					;voy a imprimir el child 3, si esnull no hace nada
			lea rdi, [r12 + offset_child1 + rcx*8]	;guardo en rdi la direccion del primer hij
			mov rdi, [r12]							;guado en rdi el puntero a este nodo hijo
			mov rsi, r9 							;guardo en rsi  el puntero a pfile
			call ct_aux_print
			lea rdx, [r12 + offset_valor1 + rcx*4]	;pongo en rdx la direccion del value 
			mov edx, [rdx] 							;leo los primeros 4 bytes y lospongo en edx
			mov rsi, msg
			mov rdi, r9 
			call fprintf
			inc cl
			jmp .ciclo
		.casifin:
			mov rsi, r9
			mov rdi, [r12 + offset_child3]
			call ct_aux_print
		.fin:
      add rsp, 8
      pop r9
			pop r12
			pop rcx
			pop rbp
			ret

; ; =====================================
; ; void ct_print(ctTree* ct, FILE *pFile);
ct_print:
		mov rdi, [rdi + offset_node]
		call ct_aux_print
        ret

; =====================================
; ctIter* ctIter_new(ctTree* ct);
ctIter_new:
        push rbp
        push r12
        push rcx
        mov rbp, rsp        ;creo nuevo stack frame
        

        mov r12, rdi        ;guardo el puntero al arbol
        mov rdi, 21         ;cantidad de bytes para malloc
        call malloc   

        mov [rax + offset_tree], r12    ;ubico en el struct de malloc en los primeros 8 bytes la direccion del arbol parametro
        mov qword [rax + offset_node], NULL      ;pongo en 0 el nodo actual
        mov byte [rax + offset_current], NULL   ;pongo en 0 el current
        mov dword [rax + offset_count], NULL    ;pongo en 0 el count

        pop rcx
        pop r12
        pop rbp
        ret

; =====================================
; void ctIter_delete(ctIter* ctIt);
ctIter_delete:
        jmp free

; =====================================
; void ctIter_first(ctIter* ctIt);
ctIter_first:
        push rbp
        push r12
        mov rbp, rsp
        

        mov r12, [rdi]      ;muevo a r12 el puntero al cuatree que deberia haber en los primeros 8 bytes del iterador al que rdi apunta
        mov r12, [r12]      ;ubico en r12 el puntero que deberia estar en los primeros 8 bytes del cuatree 
        .ciclo:
          cmp qword [r12 + offset_child1], NULL
          je .fin
          mov r12, [r12 + offset_child1]
          jmp .ciclo

        .fin:
          mov qword [rdi + offset_node], r12
          mov dword [rdi + offset_count], 1

          pop r12
          pop rbp
          ret

; =====================================
; void ctIter_next(ctIter* ctIt);
ctIter_next:
        push rbp
        push r12
        push rcx

        mov rbp, rsp
        xor rcx, rcx

        mov r12, [rdi + offset_tree]      ;pongo en r12 el puntero al arbol
        mov r12d, [r12 + offset_size]     ;ubico en los ultimos 4 bytes del registro el tamaño del arbol
        cmp r12d, [rdi + offset_count]    ;comparo el tamaño con el numero de elemento del iterador
        je .invalido                      ;jump al final porque el siguiente elemento no existe

        mov cl, [rdi + offset_current]    ;tomo el numero de elemento del iterador
        mov r12, [rdi + offset_node]      ;muevo a r12 el puntero al nodo sobre el que estoy iterando

        lea rax, [r12 + offset_child2]    ; ubico en rax la direccion del segundo elemento del arreglo de punteros hijos
        lea rax, [rax + rcx*8]             ;le incremento segun el current

        cmp qword [rax], NULL             ;si el puntero hijo es null nos movemos o al siguiente valor del nodo, o subimos
        je .siguienteDelNodo

        mov rax, [rax]                    ;ubico en rax el puntero al que apunta rax
        .cicloMinimo:
          mov rcx, [rax + offset_child1]  ;ubico en rcx el primero hijo del nodo en rax
          cmp rcx, NULL
          je .encontreElMinimo
          mov rax, rcx
          jmp .cicloMinimo

        .encontreElMinimo:
          mov [rdi + offset_node], rax    ;pongo en el struct del iterador pasado como parametro el nodo en cual freno la busqueda
          mov byte [rdi + offset_current], 0  ;pongo el current en 0
          inc dword [rdi + offset_count]
          jmp .fin

        .siguienteDelNodo:
          mov cl, [r12 + offset_len]         ;pongo en cl el largo del nodo
          sub cl, 1                          ;le resto 1 porque soy un idiota que cuenta el largo de 1 al 3 en vez de 0 al 2
          cmp cl, [rdi + offset_current]     ;comparo el current con cl
          jne .tomoElSiguiente

          mov rcx, [r12]                     ;muevo el puntero al padre del nodo a rcx
          lea rax, [rcx + offset_child1]     ;pongo en rax la direccion del primer hijo
          mov sil, 0                         ;creo un contador para ver el numero de hijo

          .buscoEnQueHijoEstoy:
            cmp [rax], r12                   
            je .encontreMiHijo
            inc sil
            add rax, 8
            jmp .buscoEnQueHijoEstoy

          .encontreMiHijo:
            cmp sil, 3
            jne .eligoElNodo
            mov r12, rcx
            mov rcx, [r12]
            lea rax, [rcx + offset_child1]     ;pongo en rax la direccion del primer hijo
            mov sil, 0 
            jmp .buscoEnQueHijoEstoy

        .eligoElNodo:
          mov [rdi + offset_node], rcx
                                                ;inc sil, en que momento esto te parecio una buena idea?
          mov [rdi + offset_current], sil
          inc dword [rdi + offset_count]
          jmp .fin

        .tomoElSiguiente:
          inc byte [rdi + offset_current]        ;incremento el valor de current
          inc dword [rdi + offset_count]          ;incremento el valor del count
          jmp .fin

        .invalido:
          mov qword [rdi + offset_node], NULL
        
        .fin:
          pop rcx
          pop r12
          pop rbp
          ret

; =====================================
; uint32_t ctIter_get(ctIter* ctIt);
ctIter_get:
        push rbp
        push r12
        xor r12, r12
        xor rax, rax

        mov r12, [rdi + offset_node]      ;obtengo la direccion del nodo en el iterador
        lea r12, [r12 + offset_valor1]    ;muevo r12 hasta la direccion donde esta el primer valor
        mov al, [rdi + offset_current]    ;muevo a al el numero de current del iterador

        lea r12, [r12 + rax*4 ]            ;pongo en r12 la direccion de donde deberia estar el valor indicado
        mov eax, [r12]                    ;muevo a eax el valor dentro de dicha direccion

        pop r12
        pop rbp
        ret

; =====================================
; uint32_t ctIter_valid(ctIter* ctIt);
ctIter_valid:
        mov eax, 0
        cmp qword [rdi + offset_node], NULL
        je .fin
        mov eax, 1
        .fin:
          ret



