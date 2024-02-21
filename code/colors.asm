; ###############################################################
; #                                                             #
; #  colors package for                                         #
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

ptColors
    !pet $05,"black"
    !word phColBlack
    !pet $05,"grey0"
    !word phColBlack
    !pet $05,"white"
    !word phColWhite
    !pet $05,"grey4"
    !word phColWhite
    !pet $03,"red"
    !word phColRed
    !pet $04,"cyan"
    !word phColCyan
    !pet $06,"purple"
    !word phColPurple
    !pet $05,"green"
    !word phColGreen
    !pet $04,"blue"
    !word phColBlue
    !pet $06,"yellow"
    !word phColYellow
    !pet $06,"orange"
    !word phColOrange
    !pet $05,"brown"
    !word phColBrown
    !pet $04,"pink"
    !word phColLRed
    !pet $09,"light'red"
    !word phColLRed
    !pet $06,"lt'red"
    !word phColLRed
    !pet $04,"lred"
    !word phColLRed
    !pet $09,"dark'grey"
    !word phColGrey1
    !pet $05,"grey1"
    !word phColGrey1
    !pet $05,"dgrey"
    !word phColGrey1
    !pet $04,"grey"
    !word phColGrey2
    !pet $05,"mgrey"
    !word phColGrey2
    !pet $05,"grey2"
    !word phColGrey2
    !pet $0B,"medium'grey"
    !word phColGrey2
    !pet $0B,"light'green"
    !word phColLGreen
    !pet $08,"lt'green"
    !word phColLGreen
    !pet $06,"lgreen"
    !word phColLGreen
    !pet $0A,"light'blue"
    !word phColLBlue
    !pet $07,"lt'blue"
    !word phColLBlue
    !pet $05,"lblue"
    !word phColLBlue
    !pet $0A,"light'grey"
    !word phColGrey3
    !pet $07,"lt'grey"
    !word phColGrey3
    !pet $05,"grey3"
    !word phColGrey3
    !pet $05,"lgrey"
    !word phColGrey3
    !pet $0E,"version'colors"
    !word phVersionColors

    !by $00


;-- FUNC Black() -----
phColBlack
    !by FUNC + REAL
    !word FuncBlack             ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC White() -----
phColWhite
    !by FUNC + REAL
    !word FuncWhite             ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC Red() -----
phColRed
    !by FUNC + REAL
    !word FuncRed               ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC Cyan() -----
phColCyan
    !by FUNC + REAL
    !word FuncCyan              ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC Purple() -----
phColPurple
    !by FUNC + REAL
    !word FuncPurple            ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC Green() -----
phColGreen
    !by FUNC + REAL
    !word FuncGreen             ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC Blue() -----
phColBlue
    !by FUNC + REAL
    !word FuncBlue              ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC yellow() -----
phColYellow
    !by FUNC + REAL
    !word FuncYellow            ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC Orange() -----
phColOrange
    !by FUNC + REAL
    !word FuncOrange            ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC Brown() -----
phColBrown
    !by FUNC + REAL
    !word FuncBrown             ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC LRed() -----
phColLRed
    !by FUNC + REAL
    !word FuncLRed              ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC Grey1() -----
phColGrey1
    !by FUNC + REAL
    !word FuncGrey1             ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC Grey2() -----
phColGrey2
    !by FUNC + REAL
    !word FuncGrey2             ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC LGreen() -----
phColLGreen
    !by FUNC + REAL
    !word FuncLGreen            ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;-- FUNC LBlue() -----
phColLBlue
    !by FUNC + REAL
    !word FuncLBlue             ; func code address
    !by $00                     ; count of params
    !by ENDFNC


;-- FUNC grey3() -----
phColGrey3
    !by FUNC + REAL
    !word FuncGrey3             ; func code address
    !by $00                     ; count of params
    !by ENDFNC


;-- FUNC Version'Colors$
phVersionColors
    !by FUNC + STR
    !word VersColors            ; proc code address
    !by $00                     ; count of params
    !by ENDFNC


;
;-- FUNC colxxx()
;


;-- FUNC Black() -----
FuncBlack
    LDX #$00
    !by $0D


;-- FUNC White() -----
FuncWhite
    LDX #$01
    !by $0D


;-- FUNC Red() -----
FuncRed
    LDX #$02
    !by $0D


;-- FUNC Cyan() -----
FuncCyan
    LDX #$03
    !by $0D

;-- FUNC Purple() -----
FuncPurple
    LDX #$04
    !by $0D

;-- FUNC Green() -----
FuncGreen
    LDX #$05
    !by $0D

;-- FUNC Blue() -----
FuncBlue
    LDX #$06
    !by $0D

;-- FUNC yello() -----
FuncYellow
    LDX #$07
    !by $0D

;-- FUNC Orange() -----
FuncOrange
    LDX #$08
    !by $0D

;-- FUNC Brown() -----
FuncBrown
    LDX #$09
    !by $0D

;-- FUNC LRed() -----
FuncLRed
    LDX #$0A
    !by $0D

;-- FUNC Grey1() -----
FuncGrey1
    LDX #$0B
    !by $0D

;-- FUNC Grey2() -----
FuncGrey2
    LDX #$0C
    !by $0D

;-- FUNC LGreen() -----
FuncLGreen
    LDX #$0D
    !by $0D

;-- FUNC LBlue() -----
FuncLBlue
    LDX #$0E
    !by $0D

;-- FUNC grey3() -----
FuncGrey3
    LDX #$0F

    LDA #$00
    JSR PSHINT                  ; push result
    RTS

---------------------------------
VersColors
    LDA #$26
    JSR EXCGST                  ; allocate local storage
    LDY #$00
-   LDA Colvermsg,Y
    STA (COPY2),Y
    INY
    CPY #$24
    BNE -                       ; loop
    LDA #$00
    STA (COPY2),Y
    LDA #$24
    INY
    STA (COPY2),Y
    RTS
---------------------------------
Colvermsg
    !pet " 1.20 colors package by Richard Bain"
