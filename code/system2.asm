; ###############################################################
; #                                                             #
; #  system2 package for                                        #
; #  C64 COMAL80 SUPER CHIP EXTENSION SOURCE CODE               #
; #  Version 1.30 (2024.02.21)                                  #
; #  Copyright (c) 2023 Claus Schlereth                         #
; #                                                             #
; #  This version of the source code is under MIT License       #
; #                                                             #
; #  This source code can be found at:                          #
; #  https://github.com/LeshanDaFo/C64-COMAL-SuperChip          #
; #                                                             #
; ###############################################################

ptSystem2
    !pet $0A,"hidescreen"
    !word phHidescreen
    !pet $0A,"showscreen"
    !word phShowscreen
    !pet $0B,"scroll'down"
    !word phScrolldown
    !pet $08,"hideaway"
    !word phHideaway
    !pet $06,"reveal"
    !word phReveal
    !pet $05,"pause"
    !word phPause
    !pet $0C,"current'page"
    !word phCurrentpage
    !pet $04,"host"
    !word phHost
    !pet $06,"simons"
    !word phSimons
    !pet $0F,"version'system2"
    !word phVersSystem2
    !by $00


;
;-- PROC Hidescreen
;
phHidescreen
    !by PROC
    !word Hidescreen            ; proc code address
    !by $00                     ; count of params
    !by ENDPRC


;
;-- PROC Showscreen
;
phShowscreen
    !by PROC
    !word Showscreen            ; proc code address
    !by $00                     ; count of params
    !by ENDPRC


;
;-- PROC Scrolldown
;
phScrolldown
    !by PROC
    !word Scrolldown            ; proc code address
    !by $00                     ; count of params
    !by ENDPRC


;
;-- PROC Hideaway
;
phHideaway
    !by PROC
    !word Hideaway              ; proc code address
    !by $01                     ; count of params
    !by VALUE + INT
    !by ENDPRC


;
;-- PROC Reveal
;
phReveal
    !by PROC
    !word Reveal                ; proc code address
    !by $00                     ; count of params
    !by ENDPRC


;
;-- PROC Pause
;
phPause
    !by PROC
    !word Pause                 ; proc code address
    !by $01                     ; count of params
    !by VALUE + REAL
    !by ENDPRC


;
;-- FUNC CurrentPage
;
phCurrentpage
    !by FUNC
    !word Currentpage           ; func code address
    !by $00                     ; count of params
    !by ENDFNC


;
;-- FUNC Host$
;
phHost
    !by FUNC + STR
    !word Host                  ; func code address
    !by $00                     ; count of params
    !by ENDFNC


;
;-- PROC Simons
;
phSimons
    !by PROC
    !word Simons                ; proc code address
    !by $01                     ; count of params
    !by VALUE + INT
    !by ENDPRC


;
;-- FUNC VersSystem2$
;
phVersSystem2
    !by FUNC + STR
    !word VersSystem2           ; proc code address
    !by $00                     ; count of params
    !by ENDFNC


Hidescreen
    LDA $D011
    AND #$EF
    STA $D011
    RTS
---------------------------------
Showscreen
    LDA $D011
    ORA #$10
    STA $D011
    RTS
---------------------------------
LAA98  
    !by $98,$07,$C0,$07,$98,$DB,$C0,$DB

Scrolldown
    LDY #$07
LAAA2
    LDA LAA98,Y
    STA $003B,Y
    DEY
    BPL LAAA2
    CLC
    LDA $0288
    ADC #$03
    STA Q1+1
    STA Q2+1
    LDA $0288
    STA COPY2
    DEC COPY2
LAABC
    LDY #$27
LAABE
    LDA (Q1),Y
    STA (Q2),Y
    LDA (Q3),Y
    STA (Q4),Y
    DEY
    BPL LAABE
    LDA Q1
    STA Q2
    STA Q4
    LDA Q1+1
    STA Q2+1
    LDA Q3+1
    STA Q4+1
    SEC
    LDA Q1
    SBC #$28
    STA Q1
    STA Q3
    BCS LAABC
    DEC Q3+1
    DEC Q1+1
    LDA Q1+1
    CMP COPY2
    BNE LAABC
    LDA #$00
    STA COPY1
    LDA $0288
    STA COPY1+1
    LDA #$20
    LDY #$27
LAAF9
    STA (COPY1),Y
    DEY
    BPL LAAF9
    LDY #$18
LAB00
    LDA $00D9,Y
    ORA #$80
    STA $00D9,Y
    DEY
    BNE LAB00
    RTS
---------------------------------
Hideaway
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    STA COPY2
    INY
    LDA (COPY1),Y
    STA COPY2+1
    CLC
    LDA COPY2+1
    ADC #$10
    STA COPY2+1
    LDA COPY2
    ADC #$27
    STA COPY2
    LDA $16
    STA COPY1
    LDA $17
    STA COPY1+1
LAB31
    LDY #$02
    LDA (COPY1),Y
    BEQ LAB5A
    STA Q1
    SEC
    DEY
    LDA COPY2+1
    SBC (COPY1),Y
    DEY
    LDA COPY2
    SBC (COPY1),Y
    BCC LAB5A
    LDA #$00
    STA (COPY1),Y
    INY
    STA (COPY1),Y
    CLC
    LDA COPY1
    ADC Q1
    STA COPY1
    BCC LAB31
    INC COPY1+1
    BCS LAB31
LAB5A
    RTS
---------------------------------
Reveal
    LDA $16
    STA COPY1
    LDA $17
    STA COPY1+1
    LDA #$27
    STA COPY2
    LDA #$10
    STA COPY2+1
LAB6B
    LDY #$02
    LDA (COPY1),Y
    BEQ LAB94
    STA Q1
    CLC
    LDY #$01
    LDA COPY2+1
    ADC #$05
    STA COPY2+1
    STA (COPY1),Y
    DEY
    LDA COPY2
    ADC #$00
    STA COPY2
    STA (COPY1),Y
    CLC
    LDA COPY1
    ADC Q1
    STA COPY1
    BCC LAB6B
    INC COPY1+1
    BCS LAB6B
LAB94
    DEY
    LDA COPY2+1
    STA (COPY1),Y
    DEY
    LDA COPY2
    STA (COPY1),Y
    RTS
---------------------------------
Pause
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDA COPY1
    LDY COPY1+1
    JSR LDAC1                   ; load ac1
    JSR MUL10                   ; multiply ac1 by 10.0
    JSR FPINTA                  ; convert ac1 into integer (0 .. 65535)
LABB1
    LDA $DC08
LABB4
    LDY $C5
    CPY #$3F
    BEQ LABCF
    CMP $DC08
    BEQ LABB4
    DEC $65
    LDA $65
    CMP #$FF
    BNE LABB1
    DEC $64
    LDA $64
    CMP #$FF
    BNE LABB1
LABCF
    RTS
---------------------------------
Currentpage
    LDX PPAGE                   ; overlay to peek/poke/sys
    LDA #$00
    JMP PSHINT                  ; Float & pushinteger
---------------------------------
LABD8
    !pet "c128",$00,$04
LABDE
    !pet "c64",$00,$03

Host
    LDA $D600
    BEQ LABFA
    LDA #$06
    JSR EXCGST                  ; allocate local storage
    LDY #$00
LABEF
    LDA LABD8,Y
    STA (COPY2),Y
    INY
    CPY #$06
    BNE LABEF
    RTS
---------------------------------
LABFA
    LDA #$05
    JSR EXCGST                  ; allocate local storage
    LDY #$00
LAC01
    LDA LABDE,Y
    STA (COPY2),Y
    INY
    CPY #$05
    BNE LAC01
    RTS
---------------------------------
LAC0C
    !pet "BASIC"

Simons
    LDA #$01
    STA NOREST                  ; <> 0: disable stop/restore
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    STA $A1
    INY
    LDA (COPY1),Y
    STA $A2
    EOR $A1
    STA $A1
    STA $66
    JSR FPRND                   ; compute pseudo-random number (range 0 to 1)
    LDX #$00
    DEY
LAC30
    LDA $A1,X
    STA ($63),Y
    INX
    INY
    CPX #$05
    BNE LAC30
    LDX $A2
    TXS
    JMP $00A0
---------------------------------
    JMP PUSHA1                  ; push ac1
---------------------------------
VersSystem2
    LDA #$27
    JSR EXCGST                  ; allocate local storage
    LDY #$00
-   LDA Sys2vermsg,Y
    STA (COPY2),Y
    INY
    CPY #$25
    BNE -                       ; loop
    LDA #$00
    STA (COPY2),Y
    LDA #$25
    INY
    STA (COPY2),Y
    RTS
---------------------------------
LAC5E
Sys2vermsg
    !pet " 1.20 system2 package by Richard Bain"
