; ###############################################################
; #                                                             #
; #  strings package for                                        #
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

ptStrings
    !pet $09,"uppercase"
    !word phUcase
    !pet $09,"lowercase"
    !word phLcase
    !pet $09,"swap'real"
    !word phSwapReal
    !pet $0C,"swap'integer"
    !word phSwapInt
    !pet $0B,"swap'string"
    !word phSwapStr
    !pet $05,"float"
    !word phFloat
    !pet $09,"quicksort"
    !word phQuickSort
    !pet $06,"string"
    !word phString
    !pet $0F,"version'strings"
    !word phVersionString

    !by $00



;
;-- FUNC ucase$(str$)
;
phUcase
    !by FUNC + STR
    !word Ucase                 ; func code address
    !by $01                     ; count of params
    !by VALUE + STR             ; char$ - string value
    !by ENDFNC


;
;-- FUNC lcase$(str$)
;
phLcase
    !by FUNC + STR
    !word Lcase                 ; func code address
    !by $01                     ; count of params
    !by VALUE + STR             ; char$ - string value
    !by ENDFNC


;
;-- PROC swap'real(REF p1, REF p2) -----
;
phSwapReal
    !by PROC
    !word ProcSwapReal          ; func code address
    !by $02                     ; count of params
    !by REF + REAL              ; p1
    !by REF + REAL              ; p2
    !by ENDPRC

;
;-- PROC swap'integer(REF p1#, REF p2#) -----
;
phSwapInt
    !by PROC
    !word ProcSwapInt           ; func code address
    !by $02                     ; count of params
    !by REF + INT               ; p1#
    !by REF + INT               ; p2#
    !by ENDPRC


;
;-- PROC swap'string(REF p1$, REF p2$) -----
;
phSwapStr
    !by PROC
    !word ProcSwapStr           ; func code address
    !by $02                     ; count of params
    !by REF + STR               ; p1$
    !by REF + STR               ; p2$
    !by ENDPRC


;
;-- FUNC float$(p)
;
phFloat
    !by FUNC + STR
    !word FuncFloat             ; func code address
    !by $01                     ; count of params
    !by VALUE + REAL            ; p - float value
    !by ENDFNC


;
;
;
phQuickSort
    !by PROC
    !word ProcQuicksort
    !by $03
    !by REF + ARRAY + STR,1
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC


;
;-- FUNC string$(char$,count#)
;
phString
    !by FUNC + STR
    !word FuncString            ; func code address
    !by $02                     ; count of params
    !by VALUE + STR             ; char$ - string value
    !by VALUE + INT             ; count#
    !by ENDFNC


;
;-- FUNC Version'Strings$
;
phVersionString
    !by FUNC + STR
    !word VersStrings           ; proc code address
    !by $00                     ; count of params
    !by ENDFNC


L9726
    CLC
    LDA COPY1
    ADC #$04
    STA COPY1
    LDA COPY1+1
    ADC #$00
    STA COPY1+1
    RTS
---------------------------------
Ucase
    LDA #$41
    STA $61
    LDA #$5B
    STA $62
    BNE L9746
Lcase
    LDA #$C1
    STA $61
    LDA #$DB
    STA $62
L9746
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDA $2D
    STA Q1
    LDA $2E
    STA Q1+1
    CLC
    LDY #$03
    LDA (COPY1),Y
    STA COPY3
    ADC $2D
    STA $2D
    DEY
    LDA (COPY1),Y
    STA COPY3+1
    ADC $2E
    STA $2E
    LDA #$02
    JSR EXCGST                  ; allocate local storage
    LDY #$00
    LDA COPY3+1
    STA (COPY2),Y
    INY
    LDA COPY3
    STA (COPY2),Y
    BNE L977E
    LDA COPY3+1
    BNE L977E
    RTS
---------------------------------
L977E
    JSR L9726
    SEC
    LDA COPY3
    SBC #$01
    STA COPY3
    LDA COPY3+1
    SBC #$00
    STA COPY3+1
    LDY #$00
L9790
    LDA (COPY1),Y
    CMP $61
    BCC L979C
    CMP $62
    BCS L979C
    EOR #$80
L979C
    STA (Q1),Y
    DEC COPY3
    LDA COPY3
    CMP #$FF
    BNE L97AF
    DEC COPY3+1
    LDA COPY3+1
    CMP #$FF
    BNE L97AF
    RTS
---------------------------------
L97AF
    INY
    BNE L9790
    INC COPY1+1
    INC Q1+1
    BNE L9790
L97B8
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDA COPY1
    STA COPY2
    LDA COPY1+1
    STA COPY2+1
    LDA #$02
    JMP FNDPAR                  ; find parameter (asm. calls)
---------------------------------
ProcSwapReal
    LDA #$04
    STA $61
    BNE L97D4
ProcSwapInt
    LDA #$01
    STA $61
L97D4
    JSR L97B8
    LDY $61
L97D9
    JSR L9861
    DEY
    BPL L97D9
    RTS
---------------------------------
ProcSwapStr
    JSR L97B8
    LDY #$03
    LDA (COPY1),Y
    STA $61
    LDA (COPY2),Y
    STA $63
    STA COPY3+1
    DEY
    LDA (COPY1),Y
    STA $62
    LDA (COPY2),Y
    STA $64
    STA COPY3
    SEC
    LDA COPY3+1
    SBC $61
    LDA COPY3
    SBC $62
    BCS L981D
    LDA $61
    STA COPY3+1
    LDA $62
    STA COPY3
    LDA COPY1
    LDX COPY2
    STX COPY1
    STA COPY2
    LDA COPY1+1
    LDX COPY2+1
    STX COPY1+1
    STA COPY2+1
L981D
    SEC
    LDY #$01
    LDA (COPY1),Y
    SBC COPY3+1
    DEY
    LDA (COPY1),Y
    SBC COPY3
    BCS L983C
    LDA (COPY1),Y
    STA COPY3
    LDY #$02
    STA (COPY2),Y
    DEY
    LDA (COPY1),Y
    STA COPY3+1
    LDY #$03
    STA (COPY2),Y
L983C
    INC COPY3+1
    BNE L9842
    INC COPY3
L9842
    CLC
    LDA COPY1
    ADC #$02
    STA COPY1
    LDA COPY1+1
    ADC #$00
    STA COPY1+1
    CLC
    LDA COPY2
    ADC #$02
    STA COPY2
    LDA COPY2+1
    ADC #$00
    STA COPY2+1
    LDY #$00
    JMP L9C71
---------------------------------
L9861
    LDA (COPY1),Y
    TAX
    LDA (COPY2),Y
    STA (COPY1),Y
    TXA
    STA (COPY2),Y
    RTS
---------------------------------
L986C
    LDX #$05
    JSR RUNERR                  ; go to comal error handler

FuncString
    LDA #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    STY Q3
    STY Q3+1
    LDA (COPY1),Y
    BMI L986C
    STA Q1+1
    INY
    LDA (COPY1),Y
    STA Q1
    BNE L9890
    LDA Q1+1
    BNE L9890
    JMP L98D7
---------------------------------
L9890
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$02
    LDA (COPY1),Y
    BNE L986C
    INY
    LDA (COPY1),Y
    BEQ L98D7
    STA Q2
    JSR L9726
L98A5
    LDA Q2
    JSR EXCGST                  ; allocate local storage
    LDY #$00
L98AC
    LDA (COPY1),Y
    STA (COPY2),Y
    INY
    CPY Q2
    BNE L98AC
    SEC
    LDA Q1
    SBC #$01
    STA Q1
    LDA Q1+1
    SBC #$00
    STA Q1+1
    LDA Q3
    CLC
    ADC Q2
    STA Q3
    LDA Q3+1
    ADC #$00
    STA Q3+1
    LDA Q1
    BNE L98A5
    LDA Q1+1
    BNE L98A5
L98D7
    LDA #$02
    JSR EXCGST                  ; allocate local storage
    LDA Q3+1
    LDY #$00
    STA (COPY2),Y
    INY
    LDA Q3
    STA (COPY2),Y
    RTS
---------------------------------
FuncFloat
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDA #$07
    JSR EXCGST                  ; allocate local storage
    LDY #$04
L98F4
    LDA (COPY1),Y
    STA (COPY2),Y
    DEY
    BPL L98F4
    LDY #$05
    LDA #$00
    STA (COPY2),Y
    LDA #$05
    INY
    STA (COPY2),Y
    RTS
---------------------------------
ProcQuicksort
    CLD
    LDA $2E
    STA TXT+9 
    LDX $2D
    STX TXT+8 
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDA COPY1+1
    STA $FE
    LDX COPY1
    STX $FD
    LDA #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$01
    LDA (COPY1),Y
    STA TXT
    DEY
    STY TXT+16
    LDA (COPY1),Y
    STA TXT+1 
    LDA #$03
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    STY TXT+18
    LDA (COPY1),Y
    STA TXT+3 
    INY
    LDA (COPY1),Y
    STA TXT+2 
    SEC
    SBC TXT 
    LDA TXT+3 
    SBC TXT+1 
    BVC L995A
L9955
    LDX #$02
    JMP L9C13
---------------------------------
L995A
    BPL L9983
    STY TXT+18
    LDA TXT+1 
    STA TXT+5 
    LDX TXT
    STX TXT+4 
    LDA TXT+3 
    STA TXT+1 
    LDX TXT+2 
    STX TXT
    LDA TXT+5 
    STA TXT+3 
    LDX TXT+4 
    STX TXT+2 
L9983
    SEC
    LDY #$04
    LDA TXT
    SBC ($FD),Y
    STA COPY3
    DEY
    LDA TXT+1 
    SBC ($FD),Y
    STA COPY3+1
    BVS L9955
    BPL L999E
L9999
    LDX #$0A
    JMP L9C13
---------------------------------
L999E
    LDY #$06
    SEC
    LDA ($FD),Y
    CMP TXT+2 
    DEY
    LDA ($FD),Y
    SBC TXT+3 
    BVS L9955
    BMI L9999
    LDY #$00
    LDA ($FD),Y
    TAX
    INY
    LDA ($FD),Y
    STX $FD
    STA $FE
    DEY
    CLC
    LDA ($FD),Y
    TAX
    INY
    LDA ($FD),Y
    ADC #$02
    BCC L99C9
    INX
L99C9
    STA TXT+13
    STX TXT+12
    CLC
    ADC #$02
    STA TXT+15
    BCC L99D8
    INX
L99D8
    STX TXT+14
    CLC
    ADC $2D
    STA $2D
    TXA
    ADC $2E
    STA $2E
    LDA $2D
    CMP $2F
    LDA $2E
    SBC $30
    SEC
    BPL L99F1
    CLC
L99F1
    BCC L99F8
    LDX #$34
    JMP L9C13
---------------------------------
L99F8
    CLC
    LDA #$02
    ADC $FD
    STA TXT+10
    LDA #$00
    ADC $FE
    STA TXT+11
    JSR L9C19
    LDA COPY1+1
    STA TXT+11
    LDX COPY1
    STX TXT+10
    SEC
    LDA TXT+2 
    SBC TXT 
    STA TXT+2 
    LDA TXT+3 
    SBC TXT+1 
    STA TXT+3 
    LDA #$00
    STA TXT 
    STA TXT+1 
    LDA TXT+1 
    STA TXT+5 
    LDX TXT 
    STX TXT+4 
    LDA TXT+3 
    STA TXT+7 
    LDX TXT+2 
    STX TXT+6 
L9A47
    CLC
    LDA TXT
    ADC TXT+2 
    STA COPY3
    LDA TXT+1 
    ADC TXT+3 
    STA COPY3+1
    LSR COPY3+1
    ROR COPY3
    JSR L9C19
    LDA TXT+13
    STA COPY3+1
    LDX TXT+12
    STX COPY3
    LDA TXT+8 
    STA COPY2
    LDA TXT+9 
    STA COPY2+1
    JSR COPY                    ; сору area towards lower addresses
L9A76
    LDA TXT+9 
    STA $FE
    LDX TXT+8 
    STX $FD
    LDA TXT+5 
    STA COPY3+1
    LDX TXT+4 
    STX COPY3
    JSR L9C19
    LDA COPY1+1
    STA $FC
    LDX COPY1
    STX $FB
L9A95
    JSR L9C8D
    BCS L9AB3
    CLC
    LDA TXT+15
    ADC $FB
    STA $FB
    LDA TXT+14
    ADC $FC
    STA $FC
    INC TXT+4 
    BNE L9AB1
    INC TXT+5 
L9AB1
    BCC L9A95
L9AB3
    LDA TXT+9 
    STA $FC
    LDX TXT+8 
    STX $FB
    LDA TXT+7 
    STA COPY3+1
    LDX TXT+6 
    STX COPY3
    JSR L9C19
    LDA COPY1+1
    STA $FE
    LDX COPY1
    STX $FD
L9AD2
    JSR L9C8D
    BCS L9AFC
    SEC
    LDA $FD
    SBC TXT+15
    STA $FD
    LDA $FE
    SBC TXT+14
    STA $FE
    SEC
    LDA TXT+6 
    SBC #$01
    STA TXT+6 
    BCS L9AF9
    LDA TXT+7 
    SBC #$00
    STA TXT+7 
L9AF9
    JMP L9AD2
---------------------------------
L9AFC
    LDA TXT+6 
    CMP TXT+4 
    LDA TXT+7 
    SBC TXT+5 
    SEC
    BPL L9B0C
    CLC
L9B0C
    BCC L9B56
    LDA $FE
    STA COPY2+1
    LDX $FD
    STX COPY2
    LDA TXT+5 
    STA COPY3+1
    LDX TXT+4 
    STX COPY3
    JSR L9C19
    JSR L9C63
    INC TXT+4 
    BNE L9B2E
    INC TXT+5 
L9B2E
    SEC
    LDA TXT+6 
    SBC #$01
    STA TXT+6 
    BCS L9B41
    LDA TXT+7 
    SBC #$00
    STA TXT+7 
L9B41
    LDA TXT+6 
    CMP TXT+4 
    LDA TXT+7 
    SBC TXT+5 
    SEC
    BPL L9B51
    CLC
L9B51
    BCC L9B56
    JMP L9A76
---------------------------------
L9B56
    LDX #$FF
    LDA TXT
    CMP TXT+6 
    LDA TXT+1 
    SBC TXT+7 
    SEC
    BPL L9B68
    CLC
L9B68
    TXA
    ROL
    TAX
    LDA TXT+4 
    CMP TXT+2 
    LDA TXT+5 
    SBC TXT+3 
    SEC
    BPL L9B7B
    CLC
L9B7B
    TXA
    ROL
    ADC #$00
    BEQ L9BC7
    CMP #$FD
    BNE L9BC1
    LDA #$04
    JSR EXCGST                  ; allocate local storage
    LDY #$03
    LDA TXT+4 
    STA (COPY2),Y
    DEY
    LDA TXT+5 
    STA (COPY2),Y
    DEY
    LDA TXT+2 
    STA (COPY2),Y
    DEY
    LDA TXT+3 
    STA (COPY2),Y
    INC TXT+16
L9BA6
    LDA TXT+7 
    STA TXT+3 
    LDX TXT+6 
    STX TXT+2 
    LDA TXT+1 
    STA TXT+5 
    LDX TXT 
    STX TXT+4 
    JMP L9A47
---------------------------------
L9BC1
    CMP #$FF
    BEQ L9BED
    BNE L9BA6
L9BC7
    LDA TXT+16
    BEQ L9C08
    LDA #$04
    JSR EXCREM                   ; reclaim Local storage
    LDY #$03
    LDA ($2D),Y
    STA TXT+4 
    DEY
    LDA ($2D),Y
    STA TXT+5 
    DEY
    LDA ($2D),Y
    STA TXT+2 
    DEY
    LDA ($2D),Y
    STA TXT+3 
    DEC TXT+16
L9BED
    LDA TXT+5 
    STA TXT+1 
    LDX TXT+4 
    STX TXT 
    LDA TXT+3 
    STA TXT+7 
    LDX TXT+2 
    STX TXT+6 
    JMP L9A47
---------------------------------
L9C08
    LDA TXT+9 
    STA $2E
    LDX TXT+8 
    STX $2D
    RTS
---------------------------------
L9C13
    JMP RUNERR                  ; go to comal error handler
---------------------------------
    JMP L9C08
---------------------------------
L9C19
    LDX #$10
    LDA #$00
    STA COPY1
    STA COPY1+1
    BEQ L9C2B
L9C23
    ASL COPY1
    ROL COPY1+1
    ROL COPY3
    ROL COPY3+1
L9C2B
    LDA #$80
    BIT COPY3+1
    BEQ L9C50
    CLC
    LDA COPY1
    ADC TXT+15
    STA COPY1
    LDA COPY1+1
    ADC TXT+14
    STA COPY1+1
    BCC L9C50
    LDA #$00
    ADC COPY3
    STA COPY3
    BCC L9C50
    LDA #$00
    ADC COPY3+1
    STA COPY3+1
L9C50
    DEX
    BNE L9C23
    CLC
    LDA COPY1
    ADC TXT+10
    STA COPY1
    LDA COPY1+1
    ADC TXT+11
    STA COPY1+1
    RTS
---------------------------------
L9C63
    LDA TXT+13
    STA COPY3+1
    LDX TXT+12
    STX COPY3
    LDY #$00
    BEQ L9C7B
L9C71
    JSR L9861
    INY
    BNE L9C7B
    INC COPY1+1
    INC COPY2+1
L9C7B
    SEC
    LDA COPY3+1
    SBC #$01
    STA COPY3+1
    BCS L9C8A
    LDA COPY3
    SBC #$00
    STA COPY3
L9C8A
    BCS L9C71
    RTS
---------------------------------
L9C8D
    LDY TXT+18
    BEQ L9C9B
    JSR L9D04
    JSR L9C9B
    JMP L9D04
---------------------------------
L9C9B
    LDY #$00
    STY TXT+17
    LDA ($FB),Y
    CMP ($FD),Y
    BCC L9CBF
    BNE L9CB0
    INY
    LDA ($FB),Y
    CMP ($FD),Y
    DEY
    BCC L9CBF
L9CB0
    INC TXT+17
    LDA ($FD),Y
    STA COPY3
    INY
    LDA ($FD),Y
    STA COPY3+1
    JMP L9CCB
---------------------------------
L9CBF
    DEC TXT+17
    LDA ($FB),Y
    STA COPY3
    INY
    LDA ($FB),Y
    STA COPY3+1
L9CCB
    INY
    LDA $FE
    STA COPY1+1
    LDX $FD
    STX COPY1
    LDA $FC
    STA COPY2+1
    LDX $FB
    STX COPY2
L9CDC
    SEC
    LDA COPY3+1
    SBC #$01
    STA COPY3+1
    BCS L9CEB
    LDA COPY3
    SBC #$00
    STA COPY3
L9CEB
    BCS L9CF4
    LDA TXT+17
    BMI L9CF3
    SEC
L9CF3
    RTS
---------------------------------
L9CF4
    LDA (COPY2),Y
    CMP (COPY1),Y
    BNE L9CF3
    INY
    BNE L9CDC
    INC COPY1+1
    INC COPY2+1
    JMP L9CDC
---------------------------------
L9D04
    LDA $FD
    LDX $FB
    STA $FB
    STX $FD
    LDA $FE
    LDX $FC
    STA $FC
    STX $FE
    RTS
---------------------------------
VersStrings
    LDA #$74
    JSR EXCGST                  ; allocate local storage
    LDY #$00
-   LDA Strvermsg,Y
    STA (COPY2),Y
    INY
    CPY #$72
    BNE -                       ; loop
    LDA #$00
    STA (COPY2),Y
    LDA #$72
    INY
    STA (COPY2),Y
    RTS
---------------------------------

Strvermsg
    !pet " 1.20 strings package by Richard Bain",$0D
    !pet "      quicksort code  by Robert Ross",$0D
    !pet "      string code     by David Stidolph"
