finish    MACRO  p1

      mov dx, offset exit
      mov ah, 09h
      int 21h
      mov ah,1
      int 21h
      mov ah,4Ch
      int 21h
      ret
     

ENDM

startcalc    MACRO  p1

      mov grade, p1
      
      mov dx, offset CrLf
      mov ah, 09h
      int 21h
      
      ; if it is greater than 100, write a wrong message
      mov ax, grade
      cmp ax, 100
      ja wrong

      ; grade A (90 - 100)
      mov ax, grade
      cmp ax, 90
      jae grade_A
      
      ; grade B (80 - 89)
      mov ax, grade
      cmp ax, 80
      jae grade_B

      ; grade C (70 - 79)
      mov ax, grade
      cmp ax, 70
      jae grade_C

      ; grade D (60 - 69)
      mov ax, grade
      cmp ax, 60
      jae grade_D

      ; grade F (0 - 59)
      jmp grade_F
     

ENDM


org 100h
                                                                                       
.model small 

.stack 100h

.data

info:      DB 0Dh,0Ah,"- Grade Calculator -",0Dh,0Ah
           DB "=====================",0Dh,0Ah
           DB "=====================",0Dh,0Ah,0Dh,0Ah
           DB " Range          Grade",0Dh,0Ah
           DB "90 - 100          A",0Dh,0Ah 
           DB "80 - 89           B",0Dh,0Ah
           DB "70 - 79           C",0Dh,0Ah
           DB "60 - 69           D",0Dh,0Ah
           DB " 0 - 59           F",0Dh,0Ah,0Dh,0Ah
           DB "Please enter your grade (0 .. 100) and press enter: ",'$'

wrong_msg: DB 0Dh,0Ah,"Wrong grade. Please enter between 0 and 100",0Dh,0Ah,'$'

exit:      DB 0Dh,0Ah,"Press Enter to exit",0Dh,0Ah,'$'

vvvgood:   DB 0Dh,0Ah,"Your grade is A ",0Dh,0Ah,'$'
vvgood:    DB 0Dh,0Ah,"Your grade is B ",0Dh,0Ah,'$'
vgood:     DB 0Dh,0Ah,"Your grade is C ",0Dh,0Ah,'$'
good:      DB 0Dh,0Ah,"Your grade is D ",0Dh,0Ah,'$'
bad:       DB 0Dh,0Ah,"Your grade is F ",0Dh,0Ah,'$'

CrLf     db 13,10,'$'  ; newline
        
grade        DD 0

.code

begin:
      mov ax,@data
      mov ds,ax
  
start:
        
      mov dx, offset info
      mov ah, 09h
      int 21h

      ; get the input
      mov bx, 0
      mov di,10
  inputloop:
      mov ah,1
      int 21h
      cmp al, 13  ; enter?
      jne convertion
      startcalc bx 

    convertion:
      sub al, 48
      mov ah, 0   ; Getline
      mov cx, ax 
      mov ax, bx       
      mul di          
      add ax, cx       
      mov bx, ax
      jmp inputloop

      startcalc bx
            

grade_A:
        
      mov dx, offset vvvgood
      mov ah, 09h
      int 21h
      finish dx
      ret
      
grade_B:
        
      mov dx, offset vvgood
      mov ah, 09h
      int 21h
      finish dx
      ret
      
grade_C:
        
      mov dx, offset vgood
      mov ah, 09h
      int 21h
      finish dx
      ret
      
grade_D:
        
      mov dx, offset good
      mov ah, 09h
      int 21h
      finish dx
      ret
      
grade_F:
        
      mov dx, offset bad
      mov ah, 09h
      int 21h
      finish dx
      ret
      
wrong:
        
      mov dx, offset wrong_msg
      mov ah, 09h
      int 21h
      jmp start
      