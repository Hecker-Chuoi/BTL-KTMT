.Model Small
.Stack 100h
.Data
    operator db 0
    operand1 dw 0    
    operand2 dw 0
    res dw 0
    remainder dw 0
    is_res_overflow db 0
    is_restart_selected db 0  
    is_res_signed db 0
    is_divided_by_0 db 0
    
    screen_str1 db '--------------------<MINI CALCULATOR>-----------------', '$'
    screen_str2 db '|1. Cong     2. Tru         |                        |', '$'
    screen_str3 db '|3. Nhan     4. Chia        |                        |', '$'
    screen_str4 db '|Trang thai:                                         |', '$'
    screen_str5 db '|Gia tri nhap:              |Toan tu:                |', '$'
    screen_str6 db '|Ket qua:                   |Toan hang 1:            |', '$'
    screen_str7 db '|So du:                     |Toan hang 2:            |', '$'
    screen_str8 db '------------------------------------------------------', '$'
   
    blank_noti_label db '                                        ', '$'        
    noti_pos_x db 8
    noti_pos_y db 26     
    operator_input_noti db 'Vui long nhap phep tinh', '$'   
    operand1_input_noti db 'Vui long nhap so hang thu nhat', '$' 
    operand2_input_noti db 'Vui long nhap so hang thu hai', '$'   
    overflow_num_noti db 'So vuot qua gioi han, hay nhap lai', '$'
    wrong_format_num_noti db 'So sai dinh dang, hay nhap lai', '$'    
    divided_by_0_noti db 'Khong the thuc hien chia cho 0', '$'
    restart_noti db '     Ban co muon thuc hien lai? 1.Co 2.Khong', '$' 
    
    
    blank_input_label db '             ', '$'     
    input_pos_x db 9
    input_pos_y db 28
 
    blank_operator_label db '           ', '$'    
    operator_pos_x db 9
    operator_pos_y db 51
    
    blank_operand_label db '           ', '$'
    operand1_pos_x db 10
    operand1_pos_y db 55 

    operand2_pos_x db 11
    operand2_pos_y db 55

    blank_res_label db '             ', '$'
    res_pos_x db 10
    res_pos_y db 23    
    
    blank_remainder_label db '                   ', '$'    
    remainder_pos_x db 11
    remainder_pos_y db 21

    blank_restart_noti_label db '                                                  ', '$'
    restart_noti_pos_x db 13
    restart_noti_pos_y db 13
    
.Code    
Main proc        
       mov ax, @Data
       mov ds, ax 
       call init_ui   
    start:   
       call clear_data
       call input_operator_selection
       call input_operand1
       call input_operand2    
       call calculate_process      
       call print_res
       call input_restart_selection
       cmp is_restart_selected, 1
       jne end_main
       jmp start
    end_main:     
       call clear_screen 
       mov ah, 4ch
       int 21h
Main endp

init_ui proc
        mov ah, 02h
        mov bh, 0
        mov dh, 5
        mov dl, 13  
        int 10h
        lea dx, screen_str1
        mov ah, 9
        int 21h
       
        mov ah, 02h
        mov bh, 0
        mov dh, 6
        mov dl, 13  
        int 10h
        lea dx, screen_str2
        mov ah, 9
        int 21h
         
        mov ah, 02h
        mov bh, 0
        mov dh, 7
        mov dl, 13  
        int 10h
        lea dx, screen_str3
        mov ah, 9
        int 21h


        mov ah, 02h
        mov bh, 0
        mov dh, 8
        mov dl, 13  
        int 10h
        lea dx, screen_str4
        mov ah, 9
        int 21h


        mov ah, 02h
        mov bh, 0
        mov dh, 9
        mov dl, 13  
        int 10h
        lea dx, screen_str5
        mov ah, 9
        int 21h
       
        mov ah, 02h
        mov bh, 0
        mov dh, 10
        mov dl, 13
        int 10h
        lea dx, screen_str6
        mov ah, 9
        int 21h


        mov ah, 02h
        mov bh, 0
        mov dh, 11
        mov dl, 13  
        int 10h
        lea dx, screen_str7
        mov ah, 9
        int 21h  
       
        mov ah, 02h
        mov bh, 0
        mov dh, 12
        mov dl, 13  
        int 10h
        lea dx, screen_str8
        mov ah, 9
        int 21h
       
               
init_ui endp

clear_data proc
        mov is_res_overflow, 0
        mov is_restart_selected, 0      
        mov is_res_signed, 0
        mov is_divided_by_0, 0
        
        call clear_remainder_label
        call clear_noti_label  
        call clear_res_label
        call clear_operand1_label
        call clear_operand2_label
        call clear_operator_label
        call clear_input_label  
        call clear_restart_noti
        ret
clear_data endp    


clear_remainder_label proc
        mov ah, 02h
        mov bh, 0
        mov dh, remainder_pos_x
        mov dl, remainder_pos_y
        int 10h
        mov ah, 9
        lea dx, blank_remainder_label
        int 21h
        ret  
clear_remainder_label endp


clear_noti_label proc
        mov ah, 02h
        mov bh, 0
        mov dh, noti_pos_x
        mov dl, noti_pos_y
        int 10h
        mov ah, 9
        lea dx, blank_noti_label
        int 21h
        ret  
clear_noti_label endp  

clear_res_label proc
        mov ah, 02h
        mov bh, 0
        mov dh, res_pos_x
        mov dl, res_pos_y
        int 10h
        mov ah, 9
        lea dx, blank_res_label
        int 21h
        ret  
clear_res_label endp


clear_input_label proc
        mov ah, 02h            
        mov bh, 0              
        mov dh, input_pos_x    
        mov dl, input_pos_y    
        int 10h                
        mov ah, 9              
        lea dx, blank_input_label
        int 21h                
        ret                    
clear_input_label endp        


clear_operand1_label proc
        mov ah, 02h              
        mov bh, 0                
        mov dh, operand1_pos_x      
        mov dl, operand1_pos_y      
        int 10h                  
        mov ah, 9                
        lea dx, blank_operand_label
        int 21h                  
        ret
clear_operand1_label endp


clear_operand2_label proc
        mov ah, 02h              
        mov bh, 0                
        mov dh, operand2_pos_x      
        mov dl, operand2_pos_y      
        int 10h                  
        mov ah, 9                
        lea dx, blank_operand_label
        int 21h                  
        ret
clear_operand2_label endp


clear_operator_label proc          
        mov ah, 02h                
        mov bh, 0                  
        mov dh, operator_pos_x    
        mov dl, operator_pos_y    
        int 10h                    
        mov ah, 9                  
        lea dx, blank_operator_label
        int 21h                    
        ret                        
clear_operator_label endp


clear_restart_noti proc
        mov ah, 02h                
        mov bh, 0                  
        mov dh, restart_noti_pos_x    
        mov dl, restart_noti_pos_y    
        int 10h                    
        mov ah, 9                  
        lea dx, blank_restart_noti_label
        int 21h                    
        ret          
clear_restart_noti endp

clear_screen proc
        mov ah, 0
        mov al, 3
        int 10h
        ret
clear_screen endp    


input_operator_selection proc
        call print_operator_input_noti  
    input_operator_start:
        call clear_input_label    
        mov ah, 02
        mov bh, 0
        mov dh, input_pos_x
        mov dl, input_pos_y
        int 10h
   
        mov ah, 1
        int 21h
        cmp al,'1'
        je plus_operator
        cmp al, '2'
        je subtract_operator
        cmp al, '3'
        je multiply_operator
        cmp al, '4'
        je divide_operator
        call print_wrong_format_noti
        jmp input_operator_start
    plus_operator:
        mov operator, '+'
        jmp input_operator_end  
    subtract_operator:  
        mov operator, '-'  
        jmp input_operator_end
    multiply_operator:  
        mov operator, '*'
        jmp input_operator_end
    divide_operator:  
        mov operator, '/'
    input_operator_end:  
         
        call print_operator
        ret
input_operator_selection endp 

input_number proc
;dau vao: bx-> dia chi bien can nhap
;dau ra: bien duoc cap nhat theo gia tri nhap
    init_input_number:  
        push bx;
        call clear_input_label  
        mov ah, 02h
        mov bh, 0
        mov dh, input_pos_x
        mov dl, input_pos_y
        int 10h      
        pop bx
     
        mov ax, 0; 
        mov [bx], ax
    input_char:
        mov ah, 1
        int 21h
        cmp al, ' '
        je input_end
        sub al, '0'; 
        cmp al, 0
        jl input_wrong_format
        cmp al, 9
        jg input_wrong_format
        mov dl, al; 
        mov dh, 0
        
        push dx
        mov ax, [bx]
        mov dx, 10
        mul dx
        cmp dx, 0
        pop dx  
        jne input_overflow
       
        add ax, dx
        mov [bx], ax
        jmp input_char
    input_overflow:    
        push bx
        call print_overflow_num_noti
        pop bx    
        jmp init_input_number
    input_wrong_format:
        push bx                    
        call print_wrong_format_noti
        pop bx                      
        jmp init_input_number    
    input_end:
        ret  
input_number endp  


input_operand1 proc
        call print_operand1_input_noti
        lea bx, operand1
        call input_number
        call clear_input_label
        call print_operand1
        ret  
input_operand1 endp  

input_operand2 proc
        call print_operand2_input_noti
        lea bx, operand2    
        call input_number  
        call clear_input_label     
        call print_operand2
        ret
input_operand2 endp 

print_operand1 proc	
        mov ah, 02h	
        mov bh, 0		
        mov dh, operand1_pos_x	
        mov dl, operand1_pos_y	
        int 10h	
        lea bx, operand1
        call print_number  
        ret		
print_operand1 endp

print_operand2 proc	
        mov ah, 02h	
        mov bh, 0		
        mov dh, operand2_pos_x	
        mov dl, operand2_pos_y 	
        int 10h				
        lea bx, operand2
        call print_number  
        ret
print_operand2 endp

print_operand1_input_noti proc
        call clear_noti_label
        mov ah, 02h
        mov bh, 0
        mov dh, noti_pos_x
        mov dl, noti_pos_y
        int 10h
        lea dx, operand1_input_noti
        mov ah, 9
        int 21h
        ret
print_operand1_input_noti endp

print_operand2_input_noti proc
        call clear_noti_label
        mov ah, 02h
        mov bh, 0
        mov dh, noti_pos_x
        mov dl, noti_pos_y
        int 10h
        lea dx, operand2_input_noti
        mov ah, 9
        int 21h
        ret
print_operand2_input_noti endp

print_operator_input_noti proc
        mov ah, 02h
        mov bh, 0
        mov dh, noti_pos_x
        mov dl, noti_pos_y
        int 10h
        lea dx, operator_input_noti
        mov ah, 9
        int 21h
        ret    
print_operator_input_noti endp  

print_wrong_format_noti proc
        call clear_noti_label
        mov ah, 02h
        mov bh, 0
        mov dh, noti_pos_x
        mov dl, noti_pos_y
        int 10h
        lea dx, wrong_format_num_noti
        mov ah, 9
        int 21h
        ret
print_wrong_format_noti endp

print_overflow_num_noti proc
        call clear_noti_label
        mov ah, 02h
        mov bh, 0
        mov dh, noti_pos_x
        mov dl, noti_pos_y
        int 10h
        lea dx, overflow_num_noti
        mov ah, 9
        int 21h
        ret  
print_overflow_num_noti endp  

print_divided_by_0_noti proc
        call clear_noti_label
        mov ah, 02h
        mov bh, 0
        mov dh, noti_pos_x
        mov dl, noti_pos_y
        int 10h
        lea dx, divided_by_0_noti
        mov ah, 9
        int 21h
        ret    
print_divided_by_0_noti endp

print_restart_noti proc
        call clear_restart_noti
        mov ah, 02h
        mov bh, 0
        mov dh, restart_noti_pos_x
        mov dl, restart_noti_pos_y
        int 10h
        lea dx, restart_noti
        mov ah, 9
        int 21h
        ret          
print_restart_noti endp

print_operator proc
        mov ah, 02h      
        mov bh, 0        
        mov dh, operator_pos_x    
        mov dl, operator_pos_y    
        int 10h  
        mov dl, operator
        mov ah, 2
        int 21h        
        ret
print_operator endp

calculate_process proc
        call addition_process 
        call multiplication_process 
        call subtraction_process 
        call divide_process 
        ret  
calculate_process endp   

addition_process proc
        cmp operator, '+'	
        jne end_addition_process 
 
        mov ax, operand1	
        add ax, operand2	
        jnc store_addition_res  
        mov is_res_overflow, 1  
        jmp end_addition_process
    store_addition_res:    
        mov res, ax	
    end_addition_process:
        ret  
   
addition_process endp

multiplication_process proc
        cmp operator, '*'	
        jne end_multiplication_process	
         
        mov ax, operand1
        mov bx, operand2
        mul bx			
        jnc store_multiplication_res    
        mov is_res_overflow, 1	
        jmp end_multiplication_process	
    store_multiplication_res:
        mov res, ax	
    end_multiplication_process:
        ret            
multiplication_process endp  

subtraction_process proc
        cmp operator, '-'
        jne end_subtraction_process
       
        mov ax,operand1 
        mov bx,operand2 
        cmp ax, bx 
        jl mark_signed:
        sub ax, operand2  
        jmp store_subtraction_res 
    mark_signed:  
        mov is_res_signed, 1 
        mov ax,operand2 
        sub ax,operand1         
    store_subtraction_res: 
        mov res,ax  
    end_subtraction_process: 
        ret 
subtraction_process endp  

divide_process proc
        cmp operator, '/' 
        jne end_divide_process
        mov ax,operand1 
        mov bx,operand2 
        cmp bx, 0 
        je mark_divided_by_0
        mov dx,0 
        div bx 
        mov res ,ax 
        mov remainder, dx
        jmp end_divide_process
       
    mark_divided_by_0:
        mov is_divided_by_0, 1     
    end_divide_process:
        ret 
divide_process endp    

print_res proc
        cmp is_res_overflow, 1 
        je overflow_res        
       
        cmp is_res_signed, 1 
        je signed_res            
       
        cmp is_divided_by_0, 1 
        je divided_by_0  
       
        mov ah, 02h 
        mov bh, 0 
        mov dh, res_pos_x 
        mov dl, res_pos_y 
        int 10h
        lea bx, res 
        call print_number 
        call print_remainder
        jmp end_print_res 
       
    signed_res:
        mov ah, 02h      
        mov bh, 0      
        mov dh, res_pos_x 
        mov dl, res_pos_y 
        int 10h
       
        mov ah, 2 
        mov dl, '-' 
        int 21h    
        lea bx, res 
        call print_number  
        jmp end_print_res    
       
    overflow_res:
        call print_overflow_num_noti 
        jmp end_print_res 
       
    divided_by_0:
        call print_divided_by_0_noti 
       
       
    end_print_res:
        ret 
print_res endp

print_number proc
    ;Dau vao: bx-> dia chi bien can in   
    ;Dau ra: bien can in co gia tri moi
    mov ax, [bx]	
    mov bx, 10	
    mov cx, 0	
   
    divide:
        mov dx, 0	
        div bx	
        push dx	
        inc cx	
        cmp ax, 0	
        je print_char
        jmp divide	
       
    print_char:
        pop dx	
        add dl, 30h	
        mov ah, 2	
        int 21h
        dec cx		
        cmp cx, 0	
        jne print_char 	
        ret			
print_number endp

print_remainder proc
        cmp operator, '/'   
        jne end_print_remainder
        mov ah, 02h 
        mov bh, 0 
        mov dh, remainder_pos_x 
        mov dl, remainder_pos_y 
        int 10h
        lea bx, remainder  
        call print_number 
    end_print_remainder:
        ret 
print_remainder endp   

input_restart_selection proc  
        call print_restart_noti
    init_input_restart_selection:    
        mov ah, 02
        mov bh, 0
        mov dh, input_pos_x
        mov dl, input_pos_y
        int 10h
        mov ah, 1
        int 21h
        cmp al, '1'
        je restart
        cmp al, '2'
        je terminate  
        call print_wrong_format_noti
        jmp init_input_restart_selection
    restart:
        mov is_restart_selected, 1
        jmp end_input_restart
    terminate:
        mov is_restart_selected, 0
    end_input_restart:
        ret            
input_restart_selection endp    




                                   
 
   
   







