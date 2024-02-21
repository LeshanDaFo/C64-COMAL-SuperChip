; ###############################################################
; #                                                             #
; #  keyboard package for                                       #
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

ptKeyboard
    !pet $10,"disable'keyboard"
    !word phDisablekeyboard
    !pet $0F,"enable'keyboard"
    !word phEnablekeyboard
    !pet $05,"shift"
    !word phShift
    !pet $0A,"repeatkeys"
    !word phRepeatkeys
    !pet $0E,"lock'uppercase"
    !word phLock_upercase
    !pet $0E,"lock'lowercase"
    !word phLock_lowercase
    !pet $0B,"unlock'case"
    !word phUnlockcase
    !pet $09,"clearkeys"
    !word phClearkeys
    !pet $08,"fillkeys"
    !word phFillkeys
    !pet $10,"version'keyboard"
    !word phVersKeyboard
    !by $00


;
;-- PROC Disablekeyboard
;
phDisablekeyboard
    !by PROC
    !word ProcDisablekeyboard   ; proc code address
    !by $00                     ; count of params
    !by ENDPRC


;
;-- PROC Enablekeyboard
;
phEnablekeyboard
    !by PROC
    !word ProcEnablekeyboard    ; proc code address
    !by $00                     ; count of params
    !by ENDPRC


;
;-- FUNC Shift
;
phShift
    !by FUNC
    !word FuncShift             ; func code address
    !by $00                     ; count of params
    !by ENDFNC


;
;-- PROC Repeatkeys(a#)
;
phRepeatkeys
    !by PROC
    !word ProcRepeatkeys        ; proc code address
    !by $01                     ; count of params
    !by VALUE + INT             ; integer value (switch)
    !by ENDPRC


;
;-- PROC Lock_upercase
;
phLock_upercase
    !by PROC
    !word ProcLock_upercase     ; proc code address
    !by $00                     ; count of params
    !by ENDPRC


;
;-- PROC Lock_lowercase
;
phLock_lowercase
    !by PROC
    !word ProcLock_lowercase    ; proc code address
    !by $00                     ; count of params
    !by ENDPRC


;
;-- FUNC Unlockcase
;
phUnlockcase
    !by PROC
    !word ProcUnlockcase        ; func code address
    !by $00                     ; count of params
    !by ENDPRC


;
;-- PROC Clearkeys
;
phClearkeys
    !by PROC
    !word ProcClearkeys         ; proc code address
    !by $00                     ; count of params
    !by ENDPRC


;
;-- PROC Fillkeys(a$)
;
phFillkeys
    !by PROC
    !word ProcFillkeys          ; proc code address
    !by $01                     ; count of params
    !by VALUE + STR             ; a - str value
    !by ENDPRC


;
;-- FUNC VersKeyboard$
;
phVersKeyboard
    !by FUNC + STR
    !word VersKeyboard          ; proc code address
    !by $00                     ; count of params
    !by ENDFNC

ProcDisablekeyboard
    LDA #$00
    STA $0289
    RTS
---------------------------------
ProcEnablekeyboard
    LDA #$0A
    STA $0289
    RTS
---------------------------------
FuncShift
    LDA $028D
    AND #$01
    TAX
    LDA #$00
    JSR PSHINT                  ; Float & pushinteger
    RTS
---------------------------------
ProcRepeatkeys
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDA #$00
    STA $028A
    LDY #$01
    LDA (COPY1),Y
    BEQ LA536
    LDA #$80
    STA $028A
LA536
    RTS
---------------------------------
ProcLock_upercase
    LDA $D018
    AND #$FD
    STA $D018
    LDA #$80
    STA $0291
    RTS
---------------------------------
ProcLock_lowercase
    LDA $D018
    ORA #$02
    STA $D018
    LDA #$80
    STA $0291
    RTS
---------------------------------
ProcUnlockcase
    LDA #$00
    STA $0291
    RTS
---------------------------------
ProcClearkeys
    LDA #$00
    STA $C6
    RTS
---------------------------------
ProcFillkeys
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$02
    LDA (COPY1),Y
    BNE LA590
    INY
    LDA (COPY1),Y
    BEQ LA590
    SEC
    SBC #$0B
    BCS LA590
    LDA (COPY1),Y
    TAX
    TAY
    DEY
    CLC
    LDA COPY1
    ADC #$04
    STA COPY1
    LDA COPY1+1
    ADC #$00
    STA COPY1+1
LA585
    LDA (COPY1),Y
    STA $0277,Y
    DEY
    BPL LA585
    STX $C6
    RTS
---------------------------------
LA590
    LDX #$05
    JMP RUNERR                  ; go to comal error handler
---------------------------------
VersKeyboard
    LDA #$28
    JSR EXCGST                  ; allocate local storage
    LDY #$00
-   LDA Keybvermsg,Y
    STA (COPY2),Y
    INY
    CPY #$26
    BNE -                       ; loop
    LDA #$00
    STA (COPY2),Y
    LDA #$26
    INY
    STA (COPY2),Y
    RTS
---------------------------------
Keybvermsg
    !pet " 1.20 keyboard package by Richard Bain"
