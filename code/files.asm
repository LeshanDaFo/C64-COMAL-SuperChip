; ###############################################################
; #                                                             #
; #  files package for                                          #
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

ptFiles
    !pet $0B,"file'exists"
    !word phFileExists          ; proc header
    !pet $05,"bload"
    !word phBload
    !pet $05,"bsave"
    !word phBsave
    !pet $07,"collect"
    !word phCollect
    !pet $06,"drive8"
    !word phDrive8
    !pet $06,"drive9"
    !word phDrive9
    !pet $06,"saveit"
    !word phSaveIt
    !pet $0C,"current'file"
    !word phCurrentFile
    !pet $04,"type"
    !word phType
    !pet $05,"getsp"
    !word phGetsp
    !pet $07,"countsp"
    !word phCountsp
    !pet $0D,"version'files"
    !word phVersionFiles

    !by $00

;
;-- FUNC FileExists(filnam$) -----
;
phFileExists
    !by FUNC + REAL
    !word FuncFileExists        ; func code address
    !by $01                     ; count of params
    !by VALUE + STR             ; filnam$
    !by ENDFNC

;
;-- PROC bload(p$) -----
;
phBload
    !by PROC
    !word ProcBload             ; proc code address
    !by $01                     ; count of params
    !by VALUE + STR             ; p$()
    !by ENDPRC

;
;-- PROC bsave(filnam$,fromAddr,toAddr) -----
;
phBsave
    !by PROC
    !word ProcBsave             ; proc code address
    !by $03                     ; count of params
    !by VALUE + STR             ; p$()
    !by VALUE + REAL
    !by VALUE + REAL
    !by ENDPRC

;
;-- PROC Collect -----
;
phCollect
    !by PROC
    !word ProcCollect           ; proc code address
    !by $00                     ; count of params
    !by ENDPRC

;
;-- PROC Drive8 -----
;
phDrive8
    !by PROC
    !word ProcDrive8            ; proc code address
    !by $00                     ; count of params
    !by ENDPRC


;
;-- PROC Drive8 -----
;
phDrive9
    !by PROC
    !word ProcDrive9            ; proc code address
    !by $00                     ; count of params
    !by ENDPRC

;
;-- PROC SaveIt -----
;
phSaveIt
    !by PROC
    !word ProcSaveIt            ; proc code address
    !by $00                     ; count of params
    !by ENDPRC

;
;-- FUNC current'file$ -----
;
phCurrentFile
    !by FUNC + STR
    !word FuncCurFile           ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;
;-- PROC Type(filnam$) -----
;
phType
    !by PROC
    !word ProcType              ; proc code address
    !by $01                     ; count of params
    !by VALUE + STR             ; filnam$
    !by ENDPRC

;
;-- FUNC Getsp() -----
;
phGetsp
    !by FUNC + STR
    !word FuncGetsp             ; proc code address
    !by $02                     ; count of params
    !by VALUE + INT             ; 
    !by VALUE + INT             ; 
    !by ENDFNC


;
;-- FUNC Countsp() -----
;
phCountsp
    !by FUNC
    !word FuncCountsp           ; proc code address
    !by $00                     ; count of params
    !by ENDFNC


;
;-- FUNC Version'Files$
;
phVersionFiles
    !by FUNC + STR
    !word VersFiles             ; func code address
    !by $00                     ; count of params
    !by ENDFNC




LA068
    LSR
    AND #$03
    ORA #$08
LA06D
    STA $0263
    LDY $0259
    BNE LA09C
    LDY $98
    BEQ LA09C
    LDA $B8
    STA Q3
    LDA $B9
    STA Q3+1
    LDX #$00
    JSR $FFC9
    BCS LA097
    JSR CCLRCH                  ; clear channel
    JSR LA0A1
    LDA Q3
    STA $B8
    LDA Q3+1
    STA $B9
    RTS
---------------------------------
LA097
    LDX #$D0
    JMP RUNERR                  ; go to comal error handler
---------------------------------
LA09C
    LDX #$33
    JMP RUNERR                  ; go to comal error handler
---------------------------------
LA0A1
    LDX #$00
    JSR $FFC6
    JSR $FFCF
    STA Q1
    JSR $FFCF
    STA Q1+1
LA0B0
    JSR $FFCF
    CMP #$0D
    BNE LA0B0
    JSR CCLRCH                  ; clear channel
    LDA Q1
    CMP #$30
    BNE LA0C9
    LDA Q1+1
    CMP #$30
    BNE LA0C9
    LDA #$00
    RTS
---------------------------------
LA0C9
    LDA #$01
    RTS
---------------------------------
LA0CC
    STY Q4
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    CLC
    LDA COPY1
    ADC #$04
    STA $BB
    LDA COPY1+1
    ADC #$00
    STA $BC
    LDY #$03
    LDA (COPY1),Y
    STA $B7
    LDA #$FC
    STA $B8
    LDA Q4
    JMP CFNAME                  ; parse & copy file name
---------------------------------
FuncFileExists
    LDY #$21
    JSR LA0CC
    LDA $BA
    JSR LA06D
    LDA #$FC
    LDX $BA
    LDY $B9
    JSR $FFBA
    LDA $B7
    LDX $BB
    LDY $BC
    JSR $FFBD
    JSR $FFC0
    JSR LA0A1
    BEQ LA11F
    LDA Q1
    CMP #$36
    BNE LA131
    LDA Q1+1
    CMP #$34
    BNE LA131
LA11F
    LDA #$01
    STA Q1
LA123
    LDA #$FC
    STA $B8
    JSR CCLOSE                  ; close File
    LDA #$00
    LDX Q1
    JMP PSHINT                  ; Float & pushinteger
---------------------------------
LA131
    LDA #$00
    STA Q1
    BEQ LA123

ProcBload
    LDY #$11
    JSR LA0CC
    LDA #$01
    STA $B9
    LDA $BA
    JSR LA06D
    LDA #$00
    STA $9D
    LDY #$FF
    LDX #$FF
    JSR $FFD5
    LDA $BA
    JSR LA06D
    JSR LA0A1
    BNE LA15B
    RTS
---------------------------------
LA15B
    LDX #$DB
    JMP RUNERR                  ; go to comal error handler
---------------------------------
ProcBsave
    LDA #$03
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDA COPY1
    LDY COPY1+1
    JSR LDAC1                   ; load ac1
    LDA #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDA COPY1
    STA Q1
    LDY COPY1+1
    STY Q1+1
    JSR FPCOM                   ; compare number t o acl
    BMI LA1D4
    JSR FPINTA                  ; convert ac1 into integer (0 .. 65535)
    JSR C1T2                    ; copy ac1 to ac2
    LDA Q1
    LDY Q1+1
    JSR LDAC1                   ; load ac1
    JSR FPINTA                  ; convert ac1 into integer (0 .. 65535)
    LDY #$12
    JSR LA0CC
    JSR COPEN                   ; open File
    LDA PPAGE                   ; overlay to peek/poke/sys
    STA $09
    LDX #$FC
    JSR CCKOUT                  ; select output File
    LDA $65
    STA $07
    JSR CWRT                    ; write character
    LDA $64
    STA $08
    JSR CWRT                    ; write character
    LDY #$00
LA1B0
    JSR LOAD                    ; load from pagex
    JSR CWRT                    ; write character
    LDA $07
    CMP $6D
    BNE LA1C2
    LDA $08
    CMP $6C
    BEQ LA1CA
LA1C2
    INC $07
    BNE LA1B0
    INC $08
    BNE LA1B0
LA1CA
    JSR CCLRCH                  ; clear channel
    LDA #$FC
    STA $B8
    JMP CCLOSE                  ; close File
---------------------------------
LA1D4
    LDX #$05
    JMP RUNERR                  ; go to comal error handler
---------------------------------
ProcCollect
    LDA DFUNIT                  ; default unit (power up value: .byte '0')
    JSR LA068
    LDX #$00
    JSR $FFC9
    LDA #$56
    JSR $FFD2
    LDA DFUNIT                  ; default unit (power up value: .byte '0')
    AND #$31
    JSR $FFD2
    JSR LA0A1
    BNE LA1F7
    RTS
---------------------------------
LA1F7
    LDX #$D2
    JMP RUNERR                  ; go to comal error handler
---------------------------------
LA1FC
    !pet "m-w",$77,$00,$02,$28,$48
LA204
    !pet "m-w",$77,$00,$02,$29,$49

ProcDrive8
    LDA #<LA1FC
    STA COPY1
    LDA #>LA1FC
    STA COPY1+1
    LDA #$09
    BNE LA222
ProcDrive9
    LDA #<LA204
    STA COPY1
    LDA #>LA204
    STA COPY1+1
    LDA #$08
LA222
    JSR LA06D
    LDX #$00
    JSR $FFC9
    LDY #$00
LA22C
    LDA (COPY1),Y
    JSR $FFD2
    INY
    CPY #$08
    BNE LA22C
    JMP CCLRCH                  ; clear channel
---------------------------------
LA239
    !pet $22,"ETELED"           ; 'DELETE'
LA240
    !pet $22,"  EVAS"           ; '  SAVE'

LA247
    LDY #$06
LA249
    LDA (COPY1),Y
    JSR CWRT                    ; write character
    DEY
    BPL LA249
    LDY #$00
LA253
    LDA ($BB),Y
    JSR CWRT                    ; write character
    INY
    CPY $B7
    BNE LA253
    LDA #$22
    JSR CWRT                    ; write character
    LDA #$0D
    JSR CWRT                    ; write character
    RTS
---------------------------------
LA268
    LDA $B7
    BEQ LA296
    LDY #$00
    LDA ($BB),Y
    CMP #$40
    BNE LA27E
    DEC $B7
    BEQ LA296
    INC $BB
    BNE LA27E
    INC $BC
LA27E
    LDY #$00
    LDA ($BB),Y
    AND #$FE
    CMP #$30
    BNE LA296
LA288
    LDA ($BB),Y
    CMP #$2C
    BEQ LA293
    INY
    CPY $B7
    BNE LA288
LA293
    STY $B7
    RTS
---------------------------------
LA296
    LDX #$04
    JMP RUNERR                  ; go to comal error handler
---------------------------------
ProcSaveIt
    JSR LA268
    SEC
    LDA $B7
    SBC #$03
    BCC LA296
    LDY #$01
    LDA ($BB),Y
    CMP #$3A
    BNE LA296
    JSR CCLRCH                  ; clear channel
    LDA #$0D
    JSR CWRT                    ; write character
    LDA #<LA239
    STA COPY1
    LDA #>LA239
    STA COPY1+1
    JSR LA247
    LDA #<LA240
    STA COPY1
    LDA #>LA240
    STA COPY1+1
    JSR LA247
    LDA #$91
    JSR CWRT                    ; write character
    LDA #$91
    JMP CWRT                    ; write character
---------------------------------
FuncCurFile
    JSR LA268
    CLC
    LDA $B7
    ADC #$02
    JSR EXCGST                  ; allocate local storage
    LDY #$00
LA2E2
    LDA ($BB),Y
    STA (COPY2),Y
    INY
    CPY $B7
    BNE LA2E2
    LDA #$00
    STA (COPY2),Y
    LDA $B7
    INY
    STA (COPY2),Y
    RTS
---------------------------------
LA2F5
    CMP #$0D
    BNE LA2FF
    JSR CRLF                    ; output cr and lf
    JMP LA302
---------------------------------
LA2FF
    JSR CWRT                    ; write character
LA302
    LDA $02A1
    LSR
    BCS LA302
    RTS
---------------------------------
ProcType
    LDY #$21
    JSR LA0CC
    JSR COPEN                   ; open File
LA311
    LDX #$FC
    JSR CCHKIN                  ; select input file
    LDA #$00
    STA $90
    JSR CRDT                    ; read character
    TAY
    JSR $FFB7
    BNE LA358
    LDA DEFOUT                  ; select output Flag
    BEQ LA32D
    LDX #$FF
    JSR CCKOUT                  ; select output File
LA32D
    TYA
    JSR LA2F5
    JSR CCLRCH                  ; clear channel
    LDA $C5
    CMP #$3C
    BEQ LA340
    CMP #$3F
    BEQ LA358
    BNE LA311
LA340
    LDA $C5
    CMP #$3C
    BEQ LA340
LA346
    LDA $C5
    CMP #$3F
    BEQ LA358
    CMP #$3C
    BNE LA346
LA350
    LDA $C5
    CMP #$3C
    BEQ LA350
    BNE LA311
LA358
    CMP #$40
    BNE LA36A
    LDA DEFOUT                  ; select output Flag
    BEQ LA366
    LDX #$FF
    JSR CCKOUT                  ; select output File
LA366
    TYA
    JSR LA2F5
LA36A
    JSR CCLRCH                  ; clear channel
    LDA #$FC
    STA $B8
    JSR CCLOSE                  ; close File
    LDA #$00
    STA $C6
    RTS
---------------------------------
LA379
    LDA $F8
    BEQ LA385
    SEC
    LDA $029B
    SBC $029C
    RTS
---------------------------------
LA385
    LDX #$CB
    JMP RUNERR                  ; go to comal error handler
---------------------------------
FuncGetsp
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BNE LA3BF
    INY
    LDA (COPY1),Y
    TAX
    JSR CCHKIN                  ; select input file
    LDA $BA
    CMP #$02
    BNE LA3C4
    LDA #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    STY Q1
    LDA (COPY1),Y
    BEQ LA3C9
    CMP #$01
    BNE LA3BF
    INY
    LDA (COPY1),Y
    BNE LA3BF
    JSR LA379
    BEQ LA3E6
    BNE LA3D5
LA3BF
    LDX #$05
    JMP RUNERR                  ; go to comal error handler
---------------------------------
LA3C4
    LDX #$D9
    JMP RUNERR                  ; go to comal error handler
---------------------------------
LA3C9
    INY
    LDA (COPY1),Y
    BNE LA3D5
    JSR LA379
    BEQ LA3E6
    LDA #$01
LA3D5
    STA Q1
    JSR EXCGST                  ; allocate local storage
    LDY #$00
LA3DC
    JSR CRDT                    ; read character
    STA (COPY2),Y
    INY
    CPY Q1
    BNE LA3DC
LA3E6
    JSR CCLRCH                  ; clear channel
    LDA #$02
    JSR EXCGST                  ; allocate local storage
    LDA #$00
    TAY
    STA (COPY2),Y
    INY
    LDA Q1
    STA (COPY2),Y
    RTS
---------------------------------
FuncCountsp
    JSR LA379
    TAX
    LDA #$00
    JMP PSHINT                  ; Float & pushinteger
---------------------------------
VersFiles
    LDA #$25
    JSR EXCGST                  ; allocate local storage
    LDY #$00
-   LDA Filesvermsg,Y
    STA (COPY2),Y
    INY
    CPY #$23
    BNE -                       ; loop
    LDA #$00
    STA (COPY2),Y
    LDA #$23
    INY
    STA (COPY2),Y
    RTS
---------------------------------
LA41D
Filesvermsg
    !pet " 1.20 files package by Richard Bain"
