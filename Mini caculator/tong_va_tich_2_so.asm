.model small
.stack 100h
.data
  tb1 db "nhap vao so thap phan thu nhat: $"
  tb2 db 10, 13, "ket qua la: $" 
  tb3 db 10,13, "nhap vao so thap phann thu 2: $"
x dw ?
y dw ?
z dw ?
t dw ?  
.code
main proc
    mov ax, @data
    mov ds,ax
    ;nhap so thu nhat
    mov ah,9
    lea dx,tb1
    int 21h
    
    call nhap_so
    mov ax,x
    mov z,ax
    
    ; nhap so thu hai
    mov ah,9
    lea dx,tb3
    int 21h
    
    call nhap_so
    mov ax,x
    mov t,ax
    
    ;cong 2 so
    mov ah,9
    lea dx,tb2
    int 21h
    
    mov ax,z
    add ax,t
    
    
    mov x,ax
    call print
    
    ;tich 2 so
    mov ah,9
    lea dx,tb2
    int 21h
    
    mov ax,z
    mov bx,t
    mul bx
    mov x,ax
    call print
    
    mov ah,4
    int 21h
    
main endp
;ham con

;nhap so
nhap_so proc
    mov x,0
    mov y,0
    mov bx,10
    
    nhap:
        mov ah,1
        int 21h
        cmp al,13
        je nhapxong
        sub al,30h
        xor ah,ah
        mov y,ax
        mov ax,x
        mul bx
        add ax,y
        mov x,ax
        jmp nhap
        
    nhapxong:
        ret    
nhap_so endp
;hien thi
print proc
    mov ax,x
    mov bx,10
    mov cx,0
    
    chia:
        mov dx,0
        div bx
        push dx
        inc cx
        cmp ax,0
        je hienthi
        jmp chia
        
    hienthi:
        pop dx
        add dl,30h
        mov ah,2
        int 21h
        dec cx
        cmp cx,0
        jne hienthi
        ret

print endp

end main