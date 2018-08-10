; C64 hello world

; 0    $00  black
; 1    $01  white
; 2    $02  red
; 3    $03  cyan
; 4    $04  purple
; 5    $05  green
; 6    $06  blue
; 7    $07  yellow
; 8    $08  orange
; 9    $09  brown
; 10   $0A  pink
; 11   $0B  dark grey
; 12   $0C  grey
; 13   $0D  light green
; 14   $0E  light blue
; 15   $0F  light grey

;  $00 == memory address 0
; #$00 == constant 0

; address of background color
BACKGROUND=$d020

; address of border color
BORDER=$d021

; address where program is loaded
*=$0801

jsr main

main:
    ; clear screen
    jsr $e544

    ; set backgroun and border to black
    lda #$00
    sta BACKGROUND ; store A (00) in background color address
    lda #$00
    sta BORDER     ; store A (00) in border color address

    ldx #$00

hello:
    lda text,x
    ; $0400 is first address of screen memory
    ; 40 col x 25 row = 1000 bytes
    sta $0400,x
    inx
    cpx #11     ; length of text
    bne hello   ; loop until x == 11
    jsr wait
    jsr end

; infinite loop so text remains on screen
wait:
    jsr wait

end:

text:
    !scr "hello world"