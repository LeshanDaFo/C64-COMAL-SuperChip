; ###############################################################
; #                                                             #
; #  math package for                                           #
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

ptMath
    !pet $05,"round"
    !word phRound               ; proc header
    !pet $05,"trunc"
    !word phTrunc               ; proc header
    !pet $04,"even"
    !word phEven                ; proc header
    !pet $03,"odd"
    !word phOdd                 ; proc header
    !pet $05,"prime"
    !word phPrime               ; proc header
    !pet $08,"distance"
    !word phDistance            ; proc header
    !pet $0A,"hypotenuse"
    !word phHypotenuse          ; proc header
    !pet $03,"hex"
    !word phHexN                ; proc header
    !pet $03,"bin"
    !word phBin                 ; proc header
    !pet $06,"maxint"
    !word phMaxint              ; proc header
    !pet $03,"max"
    !word phMax                 ; proc header
    !pet $03,"min"
    !word phMin                 ; proc header
    !pet $03,"gcf"
    !word phGCF                 ; proc header
    !pet $03,"gcd"
    !word phGCF                 ; proc header
    !pet $03,"lcm"
    !word phLCM                 ; proc header
    !pet $0C,"version'math"
    !word phVersMath            ; proc header
    !by $00

;
;-- FUNC round(a) -----
;
phRound
    !by FUNC + REAL
    !word Round                 ; func code address
    !by $01                     ; count of params
    !by VALUE + REAL            ; a - real value
    !by ENDFNC

;
;-- FUNC trunc(a) -----
;
phTrunc
    !by FUNC + REAL
    !word Trunc                 ; func code address
    !by $01                     ; count of params
    !by VALUE + REAL            ; a - real value
    !by ENDFNC

;
;-- FUNC even(p) -----
;
phEven
    !by FUNC + REAL
    !word Even                  ; func code address
    !by $01                     ; count of params
    !by VALUE + REAL            ; a - real value
    !by ENDFNC

;
;-- FUNC odd(p) -----
;
phOdd
    !by FUNC + REAL
    !word Odd                   ; func code address
    !by $01                     ; count of params
    !by VALUE + REAL            ; a - real value
    !by ENDFNC

;
;-- FUNC prime(p1) -----
;
phPrime
    !by FUNC + REAL
    !word FuncPrime             ; func code address
    !by $01                     ; count of params
    !by VALUE + REAL            ; p1 - float value
    !by ENDFNC


;
;-- FUNC distance(x1, y1, x2 ,y2)
;
phDistance
    !by FUNC + REAL
    !word FuncDistance          ; func code address
    !by $04                     ; count of params
    !by VALUE + REAL            ; a - real value
    !by VALUE + REAL            ; b - real value
    !by VALUE + REAL            ; a - real value
    !by VALUE + REAL            ; b - real value
    !by ENDFNC


;
;-- FUNC hypotenuse(p1,p2)
;
phHypotenuse
    !by FUNC + REAL
    !word FuncHypotenuse        ; func code address
    !by $02                     ; count of params
    !by VALUE + REAL            ; a - real value
    !by VALUE + REAL            ; b - real value
    !by ENDFNC


;
;-- FUNC hex$(a)
;
phHexN
    !by FUNC + STR
    !word FuncHexN              ; func code address
    !by $01                     ; count of params
    !by VALUE + REAL            ; a - integer value
    !by ENDFNC


;
;-- FUNC bin$(a#)
;
phBin
    !by FUNC + STR
    !word Bin1                  ; func code address
    !by $01                     ; count of params
    !by VALUE + INT             ; a# - integer value
    !by ENDFNC

;
;-- FUNC maxint() -----
;
phMaxint
    !by FUNC + REAL
    !word FuncMaxint            ; func code address
    !by $00                     ; count of params
    !by ENDFNC

;
;-- FUNC max(a, b) -----
;
phMax
    !by FUNC + REAL
    !word FuncMax               ; func code address
    !by $02                     ; count of params
    !by VALUE + REAL            ; a - real value
    !by VALUE + REAL            ; b - real value
    !by ENDFNC

;
;-- FUNC min(a, b) -----
;
phMin
    !by FUNC + REAL
    !word FuncMin               ; func code address
    !by $02                     ; count of params
    !by VALUE + REAL            ; a - real value
    !by VALUE + REAL            ; b - real value
    !by ENDFNC

;
;-- FUNC gcf(p1,p2) -----
;
phGCF
    !by FUNC + REAL
    !word FuncGCF               ; func code address
    !by $02                     ; count of params
    !by VALUE + REAL            ; p1 - float value
    !by VALUE + REAL            ; p2 - float value
    !by ENDFNC


;
;-- FUNC lcm(p1,p2) -----
;
phLCM
    !by FUNC + REAL
    !word FuncLCM               ; func code address
    !by $02                     ; count of params
    !by VALUE + REAL            ; p1 - float value
    !by VALUE + REAL            ; p2 - float value
    !by ENDFNC


;
;-- PROC Vers'Math$
;
phVersMath
    !by FUNC + STR
    !word VersMath              ; proc code address
    !by $00                     ; count of params
    !by ENDFNC


LA6B6
    LDA #$01
LA6B8
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDA COPY1
    STA Q1
    LDY COPY1+1
    STY Q1+1
    JMP LDAC1                   ; load ac1
---------------------------------
Round
    JSR LA6B6
    JSR FPAHF                   ; add 0.5 to ac1
    JSR FPINTG                  ; convert act into integer (-2^24 .2^24-1)
    JMP PUSHA1                  ; push aci
---------------------------------
Trunc
    JSR LA6B6
    LDA $66
    STA $6E
    LDA #$00
    STA $66
    JSR FPINTG                  ; convert act into integer (-2^24 .2^24-1)
    LDA $6E
    STA $66
    JMP PUSHA1                  ; push aci
---------------------------------
Even
    LDA #$01
    BNE LA6ED

Odd
    LDA #$00
LA6ED
    STA Q2
    JSR Round
    DEC $61
    JSR FPINTG                  ; convert act into integer (-2^24 .2^24-1)
    INC $61
    LDA COPY2
    LDY COPY2+1
    JSR FPCOM                   ; compare number t o acl
    BEQ LA706
    LDA #$01
    BNE LA708
LA706
    LDA #$00
LA708
    EOR Q2
    TAX
    LDA #$00
    JMP PSHINT                  ; Float & pushinteger
---------------------------------

LA710
    !by $03,$05,$07,$0B,$0D,$11,$13,$17 
    !by $1D,$1F,$25,$29,$2B,$2F,$35,$3B 
    !by $3D,$43,$47,$49,$4F,$53,$59,$61 
    !by $65,$67,$6B,$6D,$71,$7F,$83,$89 
    !by $8B,$95,$97,$9D,$A3,$A7,$AD,$B3 
    !by $B5,$BF,$C1,$C5,$C7,$D3,$DF,$E3 
    !by $E5,$E9,$EF,$F1,$FB,$00

---------------------------------
FuncPrime
    JSR LA6B6
    JSR FPINTA                  ; convert ac1 into integer (0 .. 65535)
    LDA $64
    BNE LA762
    LDA $65
    CMP #$02
    BEQ LA7A2
    LDX #$34
LA758
    CMP LA710,X
    BEQ LA7A2
    DEX
    BPL LA758
    BMI LA7A9
LA762
    LDA #$00
    STA COPY3+1
    LDA $65
    LSR
    BCC LA7A9
LA76B
    LDX COPY3+1
    LDA LA710,X
    BEQ LA7A2
    LDX $64
    LDY $65
    STY COPY1
    STX COPY1+1
LA77A
    ASL
    BCC LA77A
    ROR
    STA COPY2+1
    LDA #$00
    STA COPY2
LA784
    SEC
    LDA COPY1
    SBC COPY2
    TAX
    LDA COPY1+1
    SBC COPY2+1
    BCC LA794
    STA COPY1+1
    STX COPY1
LA794
    LSR COPY2+1
    ROR COPY2
    BCC LA784
    LDA COPY1
    BEQ LA7A9
    INC COPY3+1
    BNE LA76B
LA7A2
    LDA #$00
    LDX #$01
    JMP PSHINT                  ; Float & pushinteger
---------------------------------
LA7A9
    LDA #$00
    TAX
    JMP PSHINT                  ; Float & pushinteger
---------------------------------
LA7AF
    STA Q2
    JSR LA6B8
    CLC
    LDA Q2
    ADC #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDA COPY1
    LDY COPY1+1
    JSR FPSUB                   ; load ac2 and sub ac2 from ac1
    LDX Q1
    LDY Q1+1
    JMP STAC1                   ; store ac1
---------------------------------
FuncDistance
    LDA #$01
    JSR LA7AF
    LDA #$02
    JSR LA7AF
    JMP FuncHypotenuse
---------------------------------
LA7D7
    JSR LA6B8
    LDA Q1
    LDY Q1+1
    JMP FPMUL                   ; load ac2 and mul ac2 by ac1
---------------------------------
FuncHypotenuse
    LDA #$01
    JSR LA7D7
    JSR PUSHA1                  ; push aci
    LDA #$02
    JSR LA7D7
    LDA COPY2
    LDY COPY2+1
    JSR FPADD                   ; load ac2 and add ac2 to ac1
    JSR FPSQR                   ; square root of ac1
    LDA #$05
    JSR EXCREM                  ; reclaim Local storage
    JMP PUSHA1                  ; push aci
---------------------------------
LA800
    !pet "0123456789abcdef"

LA810
    TAX
    LSR
    LSR
    LSR
    LSR
    TAY
    LDA LA800,Y
    LDY Q2
    STA (COPY2),Y
    TXA
    AND #$0F
    TAY
    LDA LA800,Y
    LDY Q2
    INY
    STA (COPY2),Y
    RTS
---------------------------------
FuncHexN
    JSR LA6B6
    JSR FPINTA                  ; convert ac1 into integer (0 .. 65535)
    LDA #$07
    JSR EXCGST                  ; allocate local storage
    LDY #$00
    LDA #$24
    STA (COPY2),Y
    LDA #$01
    STA Q2
    LDA $64
    JSR LA810
    LDA #$03
    STA Q2
    LDA $65
    JSR LA810
    LDA #$00
    LDY #$05
    STA (COPY2),Y
    TYA
    INY
    STA (COPY2),Y
    RTS
---------------------------------
Bin1
    LDA #$0B
    JSR EXCGST                  ; allocate local storage
    LDA #$25
    LDY #$00
    STA (COPY2),Y
    LDY #$09
    LDA #$00
    STA (COPY2),Y
    TYA
    INY
    STA (COPY2),Y
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BNE LA88A
    INY
    LDA (COPY1),Y
    LDY #$08
LA87D
    LSR
    TAX
    LDA #$00
    ADC #$30
    STA (COPY2),Y
    TXA
    DEY
    BNE LA87D
    RTS
---------------------------------
LA88A
    LDX #$05
    JMP RUNERR                  ; go to comal error handler
---------------------------------
FuncMaxint
    LDA #$7F
    LDX #$FF
    JMP PSHINT                  ; Float & pushinteger
---------------------------------
LA896
    JSR LA6B6
    LDA #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDA COPY1
    LDY COPY1+1
    JMP FPCOM                   ; compare number t o acl
---------------------------------
FuncMax
    JSR LA896
    BPL LA8B6
LA8AA
    LDA #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDX COPY1
    LDA COPY1+1
    JMP PUSHRL                  ; push real number
---------------------------------
LA8B6
    JMP PUSHA1                  ; push aci
---------------------------------
FuncMin
    JSR LA896
    BMI LA8C1
    JMP LA8AA
---------------------------------
LA8C1
    JMP PUSHA1                  ; push aci
---------------------------------
LA8C4
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$01
    LDA (COPY1),Y
    AND #$7F
    STA (COPY1),Y
    LDA COPY1
    LDY COPY1+1
    JSR LDAC1                   ; load ac1
    JSR FPAHF                   ; add 0.5 to ac1
    JSR FPINTG                  ; convert act into integer (-2^24 .2^24-1)
    LDA COPY1
    LDY COPY1+1
    JMP FPCOM                   ; compare number t o acl
---------------------------------
FuncGCF
    LDA #$01
    JSR LA8C4
    BNE LA955
    LDA COPY1
    STA Q1
    LDA COPY1+1
    STA Q1+1
    LDA #$02
    JSR LA8C4
    BNE LA955
    LDA Q1
    LDY Q1+1
    JSR LDAC1                   ; load ac1
    LDA COPY1
    LDY COPY1+1
    JSR FPCOM                   ; compare number t o acl
    BMI LA920
    LDA COPY1
    LDY COPY1+1
    JSR LDAC1                   ; load ac1
LA910
    LDA Q1
    LDX COPY1
    STA COPY1
    STX Q1
    LDA Q1+1
    LDX COPY1+1
    STA COPY1+1
    STX Q1+1
LA920
    LDA COPY1
    LDY COPY1+1
    JSR FPDIV                   ; load ac2 and div ac2 by ac1
    JSR FPINTG                  ; convert act into integer (-2^24 .2^24-1)
    LDA Q1
    LDY Q1+1
    JSR FPMUL                   ; load ac2 and mul ac2 by ac1
    JSR FPNEG                   ; negate ac1
    LDA COPY1
    LDY COPY1+1
    JSR FPADD                   ; load ac2 and add ac2 to ac1
    LDA $61
    BEQ LA94E
    SEC
    SBC #$81
    BCC LA955
    LDX COPY1
    LDY COPY1+1
    JSR STAC1                   ; store ac1
    JMP LA910
---------------------------------
LA94E
    LDA Q1+1
LA950
    LDX Q1
    JMP PUSHRL                  ; push real number
---------------------------------
LA955
    LDX #$01
    JMP RUNERR                  ; go to comal error handler
---------------------------------
LA95A
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDX COPY1
    LDA COPY1+1
    JMP PUSHRL                  ; push real number
---------------------------------
FuncLCM
    LDA #$01
    JSR LA95A
    LDA #$02
    JSR LA95A
    JSR FuncGCF
    JSR POPA1                   ; pop ac1
    SEC
    LDA $2D
    SBC #$05
    TAX
    LDA $2E
    SBC #$00
    TAY
    TXA
    JSR FPDIV                   ; load ac2 and div ac2 by ac1
    SEC
    LDA $2D
    SBC #$0A
    TAX
    LDA $2E
    SBC #$00
    TAY
    TXA
    JSR FPMUL                   ; load ac2 and mul ac2 by ac1
    LDA #$0A
    JSR EXCREM                  ; reclaim Local storage
    LDA #$00
    STA $66
    JMP PUSHA1                  ; push aci
---------------------------------
VersMath
    LDA #$24
    JSR EXCGST                  ; allocate local storage
    LDY #$00
-   LDA Mathvermsg,Y
    STA (COPY2),Y
    INY
    CPY #$22
    BNE -                       ; loop
    LDA #$00
    STA (COPY2),Y
    LDA #$22
    INY
    STA (COPY2),Y
    RTS
---------------------------------
Mathvermsg
    !pet " 1.20 math package by Richard Bain"
