org 100h

.data
    msg_input  db 'Masukkan jumlah jam: $'
    msg_menit  db 13,10,'Jumlah menit = $'
    msg_detik  db 13,10,'Jumlah detik = $'

    jam    dw ?
    menit  dw ?
    detik  dw ?

.code
start:

    ; tampilkan pesan input
    mov ah, 09h
    lea dx, msg_input
    int 21h

    ; input angka jam (0-99)
    call input_angka
    mov jam, ax

    ; hitung menit = jam * 60
    mov ax, jam
    mov bx, 60
    mul bx
    mov menit, ax

    ; hitung detik = jam * 3600
    mov ax, jam
    mov bx, 3600
    mul bx
    mov detik, ax

    ; tampilkan hasil menit
    mov ah, 09h
    lea dx, msg_menit
    int 21h

    mov ax, menit
    call tampilkan_angka

    ; tampilkan hasil detik
    mov ah, 09h
    lea dx, msg_detik
    int 21h

    mov ax, detik
    call tampilkan_angka

    ; keluar program
    mov ah, 4Ch
    int 21h

; ===============================
; Prosedur input angka (0–99)
; ===============================
input_angka proc
    xor ax, ax

    input_loop:
        mov ah, 01h
        int 21h
        cmp al, 13        ; ENTER?
        je selesai_input
        sub al, '0'
        mov bl, al
        mov cx, ax
        mov ax, 10
        mul cx
        add ax, bx
        jmp input_loop

    selesai_input:
        ret
input_angka endp

; ===============================
; Prosedur tampilkan angka
; ===============================
tampilkan_angka proc
    mov bx, 10
    xor cx, cx

ulang:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz ulang

cetak:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop cetak
    ret
tampilkan_angka endp

end start
