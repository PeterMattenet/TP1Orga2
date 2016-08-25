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
 
section .text

; =====================================
; void ct_new(ctTree** pct);
ct_new:
		push rbp		;guardo el fondo de la pila
		push r12		;guardo r12

		mov rbp, rsp	;defino nuevo stack
		sub rsp, 8		;alineo stack

		mov r12, rdi	;guardo el puntero a tree
		xor rdi, rdi	;cleareo rdi
		mov rdi, 12		;pongo 12 bytes en el rdi para malloc
		call malloc		

		mov [rbx], rax 	;pongo la direccion de el nuevo tree en los primeros 8 bytes del puntero del tree parametro
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

		mov rbp, rsp
		xor r12, r12

        ret

; ; =====================================
; ; void ct_aux_print(ctNode* node);
ct_aux_print:
        ret

; ; =====================================
; ; void ct_print(ctTree* ct);
ct_print:
        ret

; =====================================
; ctIter* ctIter_new(ctTree* ct);
ctIter_new:
        ret

; =====================================
; void ctIter_delete(ctIter* ctIt);
ctIter_delete:
        ret

; =====================================
; void ctIter_first(ctIter* ctIt);
ctIter_first:
        ret

; =====================================
; void ctIter_next(ctIter* ctIt);
ctIter_next:
        ret

; =====================================
; uint32_t ctIter_get(ctIter* ctIt);
ctIter_get:
        ret

; =====================================
; uint32_t ctIter_valid(ctIter* ctIt);
ctIter_valid:
        ret



