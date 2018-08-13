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
BACKGROUND_COLOR=$d020

; address of border color
BORDER_COLOR=$d021

; first address of color ram
COLOR_RAM=$d800

;placeholder for various temp parameters
TEMP1=$03

; address where program is loaded
*=$0801

jsr main

main:
    ; clear screen
    jsr $e544

    lda #$00             ; A = 0f
    sta BACKGROUND_COLOR ; store A (0f) in background color address
    lda #$00
    sta BORDER_COLOR     ; store A (0f) in border color address

    ldx #$00             ; X = 0

hello:
    ; add 1 to x so the char color isn't black (0)
    txa                  ; A = X
    ldy #$01
    sty TEMP1
    adc TEMP1
    sta COLOR_RAM,x      ; set text color to A

    ; $0400 is first address of screen memory
    ; 40 col x 25 row = 1000 bytes
    lda text,x           ; load first byte of text string into A
    sta $0400,x          ; store A in memory address

    ; display the charrom number below the string
    txa
    sta $0400+40,x

    inx
    cpx #11              ; length of text
    bne hello            ; loop until x == 11
    jsr wait
    jsr end

; infinite loop so text remains on screen
wait:
    jsr wait

end:

text:
    !scr "hello world"