
; C128
;L806C
ptC128
    !pet $07,"color80"
    !word phColor80
    !pet $0C,"background80"
    !word phBackground80
    !pet $06,"page80"
    !word phPage80
    !pet $07,"print80"
    !word phPrint80
    !pet $09,"setchar80"
    !word phSetchar80
    !pet $09,"getchar80"
    !word phGetchar80
    !pet $0A,"swapfont80"
    !word phSwapfont80
    !pet $05,"set80"
    !word phSet80
    !pet $06,"read80"
    !word phRead80
    !pet $06,"init80"
    !word phInit80
    !pet $0A,"attributes"
    !word phAttributes
    !pet $05,"turbo"
    !word phTurbo
    !pet $09,"display80"
    !word phDisplay80
    !pet $0A,"hardcopy80"
    !word phHardcopy80
    !pet $06,"keypad"
    !word phKeypad
    !pet $08,"cursor80"
    !word phCursor80
    !pet $07,"input80"
    !word phInput80
    !pet $07,"inkey80"
    !word phInkey80
    !pet $08,"curcol80"
    !word phCurcol80
    !pet $08,"currow80"
    !word phCurrow80
    !pet $0B,"monocolor80"
    !word phMonocolor80
    !pet $09,"settext80"
    !word phSettext80
    !pet $0C,"setgraphic80"
    !word phSetgraphic80
    !pet $06,"plot80"
    !word phPlot80
    !pet $08,"setpen80"
    !word phSetpen80
    !pet $06,"line80"
    !word phLine80
    !pet $07,"clear80"
    !word phClear80
    !pet $0C,"version'c128"
    !word phVersionc128
    !pet $0C,"discard'c128"
    !word phDiscard80
    !by $00

phAttributes
    !by PROC
    !word ProcAtrributes
    !by $04
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phColor80
    !by PROC
    !word ProcColor80
    !by $04
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phBackground80
    !by PROC
    !word ProcBackground80
    !by $04
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phSetchar80
    !by PROC
    !word ProcSetchar80
    !by $03
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + STR 
    !by ENDPRC

phGetchar80
    !byte FUNC + STR
    !word FuncGetchar80
    !by $02
    !by VALUE + INT
    !by VALUE + INT
    !by ENDFNC

phSet80
    !by PROC
    !word ProcSet80
    !by $02
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phDisplay80
    !by PROC
    !word ProcDisplay80
    !by $02
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phKeypad
    !by PROC
    !word ProcKeypad
    !by $01
    !by VALUE + INT
    !by ENDPRC

phHardcopy80
    !by PROC
    !word ProcHardcopy80
    !by $01
    !by VALUE + STR 
    !by ENDPRC

phMonocolor80
    !by PROC
    !word ProcMonocolor80
    !by $01
    !by VALUE + INT
    !by ENDPRC

phInput80
    !byte FUNC + STR
    !word FuncInput80
    !by $03
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by ENDFNC

phPrint80
    !by PROC
    !word ProcPrint80
    !by $03
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + STR 
    !by ENDPRC

phCursor80
    !by PROC
    !word ProcCursor80
    !by $02
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phPlot80
    !by PROC
    !word ProcPlot80
    !by $02
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phSetpen80
    !by PROC
    !word ProcSetpen80
    !by $01
    !by VALUE + INT
    !by ENDPRC

phLine80
    !by PROC
    !word ProcLine80
    !by $04
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phPage80
    !by PROC
    !word ProcPage80
    !by $00
    !by ENDPRC

phSwapfont80
    !by PROC
    !word ProcSwapfont80
    !by $00
    !by ENDPRC

phSettext80
    !by PROC
    !word ProcInit80
    !by $00
    !by ENDPRC

phSetgraphic80
    !by PROC
    !word ProcSetgraphic80
    !by $00
    !by ENDPRC

phClear80
    !by PROC
    !word ProcClear80
    !by $00
    !by ENDPRC

; no call for the following procedure
    !by PROC
    !word L84A6
    !by $00
    !by ENDPRC

phTurbo
    !by PROC
    !word ProcTurbo
    !by $01
    !by VALUE + INT
    !by ENDPRC

phInit80
    !by PROC
    !word ProcInit80
    !by $00
    !by ENDPRC

phRead80
    !by FUNC + REAL
    !word FuncRead80
    !by $01
    !by VALUE + INT
    !by ENDFNC

phInkey80
    !byte FUNC + STR
    !word FuncInkey80
    !by $00
    !by ENDFNC

phVersionc128
    !byte FUNC + STR
    !word FuncVersionc128
    !by $00
    !by ENDFNC

phCurcol80
    !by FUNC + REAL
    !word FuncCurcol80
    !by $00
    !by ENDFNC

phCurrow80
    !by FUNC + REAL
    !word FuncCurrow80
    !by $00
    !by ENDFNC

phDiscard80
    !by PROC
    !word ProcDiscard80
    !by $00
    !by ENDPRC

.noc128
    !pet "computer is not a c128"  
.endnoc128

init_c128
L8287
    LDA $D600                   ; check for c128 (VDC-Base address)
    BNE .haveC128

; else 
; print the message "computer is not a c128"
    LDX #$16
    STX $0200
-   LDA .noc128-1,X
    STA $0200,X
    DEX
    BNE -
    LDA #$6C                    ; jmp()
    STA Q1
    LDA #<TRAPVC                ; low byte
    STA Q1+1
    LDA #>TRAPVC                ; high byte
    STA Q2
    LDY #$00
    LDX #$36
    LDA #$01
    JSR GOTO                    ; jmp to another page
    !by $82                     ; page
    !by $3b                     ; address low byte
    !by $00                     ; address high byte

.haveC128
    LDA $0327                   ; CHROUT vector
    CMP #$F1                    ; check original
    BNE +                       ; branch if c128 is set
    JMP L957A                   ; prepare c128 vectors and routines
+   RTS


;
;-- PROC Init80
;
ProcInit80
    LDX #$24
-   LDA L82FD,X
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    DEX
    BPL -                       ; loop

    LDA $D600
    AND #$07
    BEQ +
    LDA #$47
    LDX #$19
    JSR .write_VDCreg            ; x = VDC reg No., acc = value
+   JSR ProcClear80
    JSR L84A6
    LDA #$8F
    STA $03E9
    JSR ProcPage80
    RTS
---------------------------------
.read_VDCreg                    ; x = VDC reg No., acc = value
    STX $D600
-   BIT $D600
    BPL -
    LDA $D601
    RTS
---------------------------------
.write_VDCreg                   ; x = VDC reg No., acc = value
    STX $D600
-   BIT $D600
    BPL -
    STA $D601
    RTS
---------------------------------
L82FD
    !by $7E,$50,$66,$49,$20,$E0,$19,$1D
    !by $FC,$E7,$A0,$E7,$00,$00,$00,$00 
    !by $00,$00,$00,$00,$10,$00,$78,$E8 
    !by $20,$40,$F0,$00,$2F,$E7,$01,$00 
    !by $00,$00,$7D,$64,$F5


;
;-- PROC Page80
;
ProcPage80
    LDX #$0C
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    LDX #$12
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$0D
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    LDX #$13
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$20
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JSR L8374
    LDA #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$19
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$40
    BEQ ++
    LDX #$14
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    LDX #$12
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$15
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    LDX #$13
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA $03E9
    AND #$8F
    STA $03E9
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
L8374
    LDX #$06
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    TAY
    LDA #$4F
    LDX #$1E
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    DEY
    BEQ ++
    LDA #$50
--
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    DEY
    BNE --                      ; loop
++
    LDA #$00
    STA $03F0
    STA $03EF
    RTS


;
;-- PROC Clear80
;
ProcClear80
    LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$00
    LDX #$12
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    INX
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$00
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$00
    LDX #$1E
    LDY #$40
--  JSR .write_VDCreg           ; x = VDC reg No., acc = value
    DEY
    BNE --                      ; loop
    RTS


;
;-- PROC SetChar80
;
ProcSetchar80
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$01
    LDA (COPY1),Y
    STA $03E6
    LDA #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$01
    LDA (COPY1),Y
    STA $03E7
    LDA #$03
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$03
    LDA (COPY1),Y
    STA $03E8
    LDA COPY1
    CLC
    ADC #$04
    STA $07
    LDA COPY1+1
    ADC #$00
    STA $08
    LDA #COPY1+1
    STA $09
    LDA $03E7
    STA $03E2
    LDA #$02
    STA $03E3
    LDX #$04
--  ASL $03E2
    ROL $03E3
    DEX
    BNE --                      ; loop
    LDA $03E6
    BEQ +
    LDA $03E3
    ORA #$10
    STA $03E3
+   LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JSR L922E

L8423
    LDY #$00
--  CPY $03E8
    BEQ +
    JSR LOAD                    ; load from pagex
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    INY
    CPY #$10
    BNE --                      ; loop
+   LDA #$00
--  CPY #$10
    BEQ +
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    INY
    BNE --                      ; loop
+   RTS


;
;-- PROC GetChar80
;
FuncGetchar80
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$01
    LDA (COPY1),Y
    STA $03E6
    LDA #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$01
    LDA (COPY1),Y
    STA $03E7
    STA $03E2
    LDA #$02
    STA $03E3
    LDX #$04
--  ASL $03E2
    ROL $03E3
    DEX
    BNE --                      ; loop
    LDA $03E6
    BEQ +
    LDA $03E3
    ORA #$10
    STA $03E3
+   LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JSR L922E
    LDA #$12
    JSR EXCGST                  ; allocate local storage
    LDY #$00
    LDX #$1F
--  JSR .read_VDCreg            ; x = VDC reg No., acc = value
    STA (COPY2),Y
    INY
    CPY #$10
    BNE --                      ; loop
    LDA #$00
    STA (COPY2),Y
    LDA #$10
    INY
    STA (COPY2),Y
    RTS
---------------------------------
L84A6
    LDA #$00
    STA $03E7
    LDA #$02
    STA $03E6
    LDA #$08
    STA $03E8
    LDA #$00
    STA $07
    LDA #$D0
    STA $08
    LDA #$20
    LDX #$12
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$00
    INX
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$03
    STA $09
--  JSR L8423
    LDA $07
    CLC
    ADC #$08
    STA $07
    BCC +
    INC $08
+   INC $03E7
    BNE --
    DEC $03E6
    BNE --
    RTS


;
;-- PROC Set80
;
ProcSet80
    LDA #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$01
    LDA (COPY1),Y
    STA $03E7
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$01
    LDA (COPY1),Y
    TAX
    LDA $03E7
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    RTS


;
;-- PROC Read80
;
FuncRead80
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$01
    LDA (COPY1),Y
    TAX
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    TAX
    LDA #$00
    JSR PSHINT                  ; Float & pushinteger
    RTS
---------------------------------

L8522
    LDA #$01
    STA $03E7
    LDA #$04
    STA $03E2
L852C
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BPL L8545
    LDA $03E6
    LDX $03E7
-   LSR
    DEX
    BNE -
    LDA #$00
    ROL
    JMP L854E
---------------------------------
L8545
    BNE +
    INY
    LDA (COPY1),Y
    BEQ L854E
+   LDA #$01
L854E
    PHA
    DEC $03E2
    LDA $03E2
    BNE L852C
    STA $03E7
    LDX #$04
-   PLA
    LSR
    ROL $03E7
    DEX
    BNE -
    LDA $03E7
    RTS


;
;-- PROC Background80
;
ProcBackground80
    LDX #$1A
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    STA $03E6
    JSR L8522
    LDX #$1A
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$F0
    ORA $03E7
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    RTS


;
;-- PROC Attributes
;
ProcAtrributes
    LDA $03E9
    LDX #$04
--  LSR
    DEX
    BNE --

    STA $03E6
    JSR L8522
    LDX #$04
--  ASL
    DEX
    BNE --

    STA $03E7
    LDA $03E9
    AND #$0F
    ORA $03E7
    STA $03E9
    RTS


;
;-- PROC Color80
;
ProcColor80
    LDA $03E9
    STA $03E6
    JSR L8522
    LDA $03E9
    AND #$F0
    ORA $03E7
    STA $03E9
    LDX #$04
-   ASL
    DEX
    BNE -
    STA $03E7
    LDX #$1A
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$0F
    ORA $03E7
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    RTS


;
;-- PROC Print80
;
ProcPrint80
    JSR ProcCursor80
    LDA #$03
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$02
    LDA (COPY1),Y
    STA COPY2+1
    INY
    LDA (COPY1),Y
    STA COPY2
    CLC
    LDA COPY1
    ADC #$04
    STA COPY1
    LDA COPY1+1
    ADC #$00
    STA COPY1+1
L85F0
    LDA COPY2
    BNE +
    LDA COPY2+1
    BNE +
    RTS

+   LDY #$00
    LDA (COPY1),Y
    STA $03E7
    JSR L8635
    SEC
    LDA COPY2
    SBC #$01
    STA COPY2
    LDA COPY2
    SBC #$00
    STA COPY2
    CLC
    LDA COPY1
    ADC #$01
    STA COPY1
    LDA COPY1+1
    ADC #$00
    STA COPY1+1
    JMP L85F0


;
;-- PROC Curcol80
;
FuncCurcol80
    LDX $03F0
    INX
    LDA #$00
    JMP PSHINT                  ; Float & pushinteger


;
;-- PROC Currow80
;
FuncCurrow80
    LDX $03EF
    INX
    LDA #$00
    JMP PSHINT                  ; Float & pushinteger
---------------------------------
L8632
    STA $03E7
L8635
    STX $03EB
    STY $03EC
    JMP L8677
---------------------------------
L863E
    LDA #$00
    STA $03E2
    STA $03E3
    LDX $03EF
    INX
-   DEX
    BEQ +
    LDA #$50
    CLC
    ADC $03E2
    STA $03E2
    BCC -
    INC $03E3
    JMP -

+   LDA $03F0
    CLC
    ADC $03E2
    STA $03E2
    STA $03E4
    LDA $03E3
    ADC #$00
    STA $03E3
    STA $03E5
    RTS
---------------------------------
L8677
    JSR L863E
    LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JMP L86A0
---------------------------------
L8687
    LDX #$15
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    CLC
    ADC $03E2
    STA $03E2
    PHP
    DEX
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    PLP
    ADC $03E3
    STA $03E3
    RTS
---------------------------------
L86A0
    LDX #$19
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$40
    BEQ ++
    LDA $03E7
    CMP #$20
    BCC ++
    BPL +
    CMP #$95
    BCC ++
+   JSR L8687
    JSR L922E
    LDA $03E9
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
++  JSR L86CA
    JMP L86E3
---------------------------------
L86CA
    LDX #$0D
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    CLC
    ADC $03E4
    STA $03E2
    PHP
    DEX
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    PLP
    ADC $03E5
    STA $03E3
    RTS
---------------------------------
L86E3
    LDX #$12
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    INX
    LDA $03E2
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$1F
    LDA $03E7
    CMP #$20
    BCC L8741
    CMP #$40
    BCS L8708
    ORA $03EA
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    INC $03F0
    JMP L8A61
---------------------------------
L8708
    CMP #$60
    BCS L871A
    AND #$3F
    ORA $03EA
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    INC $03F0
    JMP L8A61
---------------------------------
L871A
    CMP #$80
    BCS L872C
    AND #$5F
    ORA $03EA
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    INC $03F0
    JMP L8A61
---------------------------------
L872C
    CMP #$C0
    BCS L8733
    JMP L884C
---------------------------------
L8733
    AND #$7F
    ORA $03EA
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    INC $03F0
    JMP L8A61
---------------------------------
L8741
    CMP #$02
    BNE L8755
    BIT $03F6
    BMI L87BE
    LDA $03E9
    ORA #$20
    STA $03E9
    JMP L8A61
---------------------------------
L8755
    CMP #$05
    BNE L8769
    BIT $03F6
    BMI L87BE
    LDA $03E9
    ORA #$0F
    STA $03E9
    JMP L8A61
---------------------------------
L8769
    CMP #$0C
    BNE L8778
    BIT $03F6
    BMI L87BE
    JSR ProcPage80
    JMP L8A61
---------------------------------
L8778
    CMP #$0D
    BNE L878A
    LDA #$00
    STA $03F0
    STA $03EA
    INC $03EF
    JMP L8A61
---------------------------------
L878A
    CMP #$0E
    BNE L879E
    BIT $03F6
    BMI L87BE
    LDA $03E9
    ORA #$80
    STA $03E9
    JMP L8A61
---------------------------------
L879E
    CMP #$0F
    BNE L87B2
    BIT $03F6
    BMI L87BE
    LDA $03E9
    ORA #$10
    STA $03E9
    JMP L8A61
---------------------------------
L87B2
    CMP #$11
    BNE L87C1
    BIT $03F6
    BMI L87BE
    INC $03EF
L87BE
    JMP L8A61
---------------------------------
L87C1
    CMP #$12
    BNE L87CF
    BIT $03F6
    BMI L87BE
    LDA #$80
    STA $03EA
L87CF
    CMP #$13
    BNE L87F4
    BIT $03F6
    BPL L87E7
    LDA $03F7
    STA $03F0
    LDA $03F8
    STA $03EF
    JMP L8A61
---------------------------------
L87E7
    LDA #$00
    STA $03F0
    LDA #$00
    STA $03EF
    JMP L8A61
---------------------------------
L87F4
    CMP #$14
    BNE L8800
    BIT $03F6
    BPL L87BE
    JMP L8A8A
---------------------------------
L8800
    CMP #$1C
    BNE L8816
    BIT $03F6
    BMI L87BE
    LDA $03E9
    AND #$F0
    ORA #$08
    STA $03E9
    JMP L8A61
---------------------------------
L8816
    CMP #$1D
    BNE L8820
    INC $03F0
    JMP L8A61
---------------------------------
L8820
    CMP #$1E
    BNE L8836
    BIT $03F6
    BMI L8849
    LDA $03E9
    AND #$F0
    ORA #$04
    STA $03E9
    JMP L8A61
---------------------------------
L8836
    CMP #$1F
    BNE L8849
    BIT $03F6
    BMI L8849
    LDA $03E9
    AND #$F0
    ORA #$02
    STA $03E9
L8849
    JMP L8A61
---------------------------------
L884C
    CMP #$81
    BNE L8862
    BIT $03F6
    BMI L8849
    LDA $03E9
    AND #$F0
    ORA #$09
    STA $03E9
    JMP L8A61
---------------------------------
L8862
    CMP #$82
    BNE L8876
    BIT $03F6
    BMI L8849
    LDA $03E9
    AND #$DF
    STA $03E9
    JMP L8A61
---------------------------------
L8876
    CMP #$8E
    BNE L888A
    BIT $03F6
    BMI L88C7
    LDA $03E9
    AND #$7F
    STA $03E9
    JMP L8A61
---------------------------------
L888A
    CMP #$8F
    BNE L889E
    BIT $03F6
    BMI L88C7
    LDA $03E9
    AND #$EF
    STA $03E9
    JMP L8A61
---------------------------------
L889E
    CMP #$90
    BNE L88B2
    BIT $03F6
    BMI L88C7
    LDA $03E9
    AND #$F0
    STA $03E9
    JMP L8A61
---------------------------------
L88B2
    CMP #$91
    BNE L88CA
    BIT $03F6
    BMI L88C7
    LDA $03EF
    CMP #$00
    BCC L88C7
    BEQ L88C7
    DEC $03EF
L88C7
    JMP L8A61
---------------------------------
L88CA
    CMP #$92
    BNE L88DB
    BIT $03F6
    BMI L88C7
    LDA #$00
    STA $03EA
    JMP L8A61
---------------------------------
L88DB
    CMP #$93
    BNE L8941
    BIT $03F6
    BPL L892E
    LDA $03F7
    STA $03F0
    LDA $03F8
    STA $03EF
    JSR L863E
    LDX #$19
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$40
    BEQ L890F
    JSR L8687
    JSR L922E
    LDA $03E9
    AND #$8F
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JSR L8934
L890F
    JSR L86CA
    JSR L922E
    LDA #$20
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JSR L8934
    LDA $03F7
    STA $03F0
    LDA $03F8
    STA $03EF
    JMP L8A61
---------------------------------
L892E
    JSR ProcPage80
    JMP L8A61
---------------------------------
L8934
    LDY $03F5
    DEY
    BEQ L8940
    TYA
    LDX #$1E
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
L8940
    RTS
---------------------------------
L8941
    CMP #$94
    BNE L894D
    BIT $03F6
    BPL L898C
    JMP L8B11
---------------------------------
L894D
    CMP #$95
    BNE L8963
    BIT $03F6
    BMI L898C
    LDA $03E9
    AND #$F0
    ORA #$0C
    STA $03E9
    JMP L8A61
---------------------------------
L8963
    CMP #$96
    BNE L8979
    BIT $03F6
    BMI L89CE
    LDA $03E9
    AND #$F0
    ORA #$09
    STA $03E9
    JMP L8A61
---------------------------------
L8979
    CMP #$97
    BNE L898F
    BIT $03F6
    BMI L89CE
    LDA $03E9
    AND #$F0
    ORA #$06
    STA $03E9
L898C
    JMP L8A61
---------------------------------
L898F
    CMP #$98
    BNE L89A5
    BIT $03F6
    BMI L89CE
    LDA $03E9
    AND #$F0
    ORA #$00
    STA $03E9
    JMP L8A61
---------------------------------
L89A5
    CMP #$99
    BNE L89BB
    BIT $03F6
    BMI L89CE
    LDA $03E9
    AND #$F0
    ORA #$05
    STA $03E9
    JMP L8A61
---------------------------------
L89BB
    CMP #$9A
    BNE L89D1
    BIT $03F6
    BMI L89CE
    LDA $03E9
    AND #$F0
    ORA #$03
    STA $03E9
L89CE
    JMP L8A61
---------------------------------
L89D1
    CMP #$9B
    BNE L89E7
    BIT $03F6
    BMI L89CE
    LDA $03E9
    AND #$F0
    ORA #$0E
    STA $03E9
    JMP L8A61
---------------------------------
L89E7
    CMP #$9C
    BNE L89FD
    BIT $03F6
    BMI L89CE
    LDA $03E9
    AND #$F0
    ORA #$0A
    STA $03E9
    JMP L8A61
---------------------------------
L89FD
    CMP #$9D
    BNE L8A29
    BIT $03F6
    BPL L8A0E
    LDA $03F1
    CMP $03E2
    BEQ L8A16
L8A0E
    LDA $03F0
    BEQ L8A19
    DEC $03F0
L8A16
    JMP L8A61
---------------------------------
L8A19
    LDA $03EF
    BEQ L8A16
    LDA #$4F
    STA $03F0
    DEC $03EF
    JMP L8A61
---------------------------------
L8A29
    CMP #$9E
    BNE L8A3F
    BIT $03F6
    BMI L8A16
    LDA $03E9
    AND #$F0
    ORA #$0D
    STA $03E9
    JMP L8A61
---------------------------------
L8A3F
    CMP #$9F
    BNE L8A55
    BIT $03F6
    BMI L8A16
    LDA $03E9
    AND #$F0
    ORA #$07
    STA $03E9
    JMP L8A61
---------------------------------
L8A55
    SEC
    SBC #$40
    ORA $03EA
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    INC $03F0
L8A61
    LDA $03F0
    CMP #$50
    BCC +
    LDA #$00
    STA $03F0
    INC $03EF
+   LDX #$06
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    CMP $03EF
    BEQ +
    BCS ++
+   JSR L8B7D
    DEC $03EF
++  LDX $03EB
    LDY $03EC
    CLC
    RTS
---------------------------------
L8A8A
    LDA $03F5
    CMP #$01
    BNE L8A9B
    LDA #$20
    JSR L8632
    LDA #$9D
    JMP L8632
---------------------------------
L8A9B
    LDA $03E2
    CMP $03F1
    BNE +
    LDA #$1D
    JSR L8632
+   LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    ORA #$80
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JSR L863E
    JSR L86CA
    LDA $03E2
    LDX #$21
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    SEC
    SBC #$01
    PHP
    LDX #$13
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA $03E3
    LDX #$20
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    PLP
    SBC #$00
    LDX #$12
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    SEC
    LDA $03F3
    SBC $03E2
    LDX #$1E
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA $03F3
    LDX #$13
    SEC
    SBC #$01
    PHP
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA $03F4
    DEX
    PLP
    SBC #$00
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$20
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$9D
    JMP L8632
---------------------------------
L8B11
    LDA $03F5
    CMP #$01
    BNE L8B1B
    JMP L8A61
---------------------------------
L8B1B
    CLC
    LDA $03F3
    SBC $03E2
    STA $03E8
    LDA $03F3
    SEC
    SBC #$01
    STA $03E2
    LDA $03F4
    SBC #$00
    STA $03E3
    JSR L922E
    LDX #$1F
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    CMP #$20
    BEQ L8B45
    JMP L8A61
---------------------------------
L8B45
    LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
-   SEC
    LDA $03E2
    SBC #$01
    STA $03E2
    LDA $03E3
    SBC #$00
    STA $03E3
    JSR L922E
    LDX #$1F
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    DEC $03E8
    BNE -
    JSR L922E
    LDA #$20
    JSR L8632
    LDA #$9D
    JMP L8632
---------------------------------
L8B7D
    LDA $03F0
    STA $03EE
    LDA $03EF
    STA $03ED
    LDA #$00
    STA $03F0
    STA $03EF
-   JSR L863E
    LDX #$19
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$40
    BEQ +
    JSR L8687
    JSR L8C09
+   JSR L86CA
    JSR L8C09
    INC $03EF
    LDX #$06
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    TAY
    DEY
    CPY $03EF
    BNE -
    JSR L863E
    JSR L8687
    LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$19
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$40
    BEQ +
    JSR L8687
    JSR L922E
    LDA $03E9
    AND #$8F
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$4F
    LDX #$1E
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
+   JSR L86CA
    JSR L922E
    LDA #$20
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$4F
    LDX #$1E
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA $03ED
    STA $03EF
    LDA $03EE
    STA $03F0
    RTS
---------------------------------
L8C09
    LDA $03E2
    LDX #$13
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    ADC #$50
    PHP
    LDX #$21
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA $03E3
    LDX #$12
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    PLP
    ADC #$00
    LDX #$20
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    ORA #$80
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$50
    LDX #$1E
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    RTS


;
;-- PROC Cursor80
;
ProcCursor80
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BNE ++
    INY
    LDA (COPY1),Y
    BEQ +
    TAY
    DEY
    STY $03E7
    BMI ++
    LDX #$06
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    CMP $03E7
    BCC ++
    BEQ ++
    LDA $03E7
    STA $03EF
+   LDA #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BNE ++
    INY
    LDA (COPY1),Y
    BEQ +
    TAY
    DEY
    TYA
    CMP #$50
    BCS ++
    STA $03F0
+   RTS
---------------------------------
;L8C7F
++  LDX #$05
    JMP RUNERR                  ; go to comal error handler


;
;-- PROC Monocolor80
;
ProcMonocolor80
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BNE +
    INY
    LDA (COPY1),Y
    BNE +
    LDX #$19
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    ORA #$40
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    RTS

+   LDA #$80
    LDX #$19
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$BF
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    RTS


;
;-- PROC Display80
;
ProcDisplay80
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BNE +++
    INY
    LDA (COPY1),Y
    BEQ ++
    TAX
    DEX
    STX $03E7
    LDA #$00
    STA $03E2
    STA $03E3
-   LDA $03E7
    BEQ +
    CLC
    LDA $03E2
    ADC #$50
    STA $03E2
    LDA $03E3
    ADC #$00
    STA $03E3
    DEC $03E7
    BNE -
+   LDA $03E3
    LDX #$0C
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA $03E2
    INX
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$15
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA $03E3
    ORA #$10
    DEX
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
++  LDA #$02
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BNE +++
    INY
    LDA (COPY1),Y
    BEQ +
    BMI +++
    LDX #$06
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    TAX
    DEX
    TXA
    BMI +++
    LSR
    SEC
    SBC #$0C
    CLC
    ADC #$1D
    LDX #$07
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
+
    RTS
---------------------------------
;L8D2A
+++ LDX #$05
    JMP RUNERR                  ; go to comal error handler


;
;-- PROC Turbo
;
ProcTurbo
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BNE .faston
    INY
    LDA (COPY1),Y
    BNE .faston
    JMP fastoff                 ; switch off c128 Turbo-Mode
---------------------------------
.faston
    LDA $D011
    AND #$EF                    ;clear bit 4
    STA $D011                   ;screen off
    LDA #$01
    STA $D030                   ;enable fast mode (2MHz)
    RTS
---------------------------------
; in case off an error or with the C128 command turbo
fastoff 
    LDA $D011
    ORA #$10                    ; set bit 4
    STA $D011                   ; screen on
    LDA #$00
    STA $D030                   ; disable fast mode
    RTS


;
;-- PROC Swapfont80
;
ProcSwapfont80
    LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    ORA #$80
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$00
    LDX #$13
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$21
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$30
    DEX
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$20
    LDX #$12
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDY #$10
    LDA #$00
    LDX #$1E
-   JSR .write_VDCreg           ; x = VDC reg No., acc = value
    DEY
    BNE -
    RTS


;
;-- PROC Versioc128
;
FuncVersionc128
    LDA #$4B
    JSR EXCGST                  ; allocate local storage
    LDY #$00
-   LDA C128vermsg,Y
    STA (COPY2),Y
    INY
    CPY #$49
    BNE -                       ; loop
    LDA #$00
    STA (COPY2),Y
    LDA #$49
    INY
    STA (COPY2),Y
    RTS
---------------------------------
C128vermsg
    !pet " 1.21 c128 package by David Stidolph",$0D
    !pet "      keypad code  by John Zacharias"


;
;-- FUNC Inkey80
;
FuncInkey80
    LDA #$03
    JSR EXCGST                  ; allocate local storage
    JSR L863E
    JSR L86CA
    LDA $03E2
    LDX #$0F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    DEX
    LDA $03E3
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JSR L8687
    JSR L922E
    LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$19
    AND #$40
    BEQ +
    LDA $03E9
    AND #$8F
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
+   LDX #$0A
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$9F
    ORA #$60
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
-   JSR $FFE4
    CMP #$00
    BNE +
    LDA $4D
    AND #$02
    BNE -
    LDA $4D
    AND #$08
    BEQ -
    LDA #$00
+   LDY #$00
    STA (COPY2),Y
    INY
    LDA #$00
    STA (COPY2),Y
    LDA #$01
    INY
    STA (COPY2),Y
    LDX #$0A
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$9F
    ORA #$20
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    RTS
---------------------------------
--  LDX #$05
    JMP RUNERR                  ; go to comal error handler


;
;-- FUNC Input80
;
FuncInput80
    JSR ProcCursor80
    LDA $03F0
    STA $03F7
    LDA $03EF
    STA $03F8
    LDA #$03
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BNE --
    INY
    LDA (COPY1),Y
    STA $03F5
    CMP #$FA
    BEQ +
    BCS --
+   JSR L863E
    JSR L86CA
    LDA $03E3
    STA $03F2
    LDA $03E2
    STA $03F1
    CLC
    ADC $03F5
    STA $03F3
    LDA $03E3
    ADC #$00
    STA $03F4
    LDA #$80
    STA $03F6
    LDA $03E2
    LDX #$0F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    DEX
    LDA $03E3
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JSR L8687
    JSR L922E
    LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$19
    AND #$40
    BEQ +
    LDA $03E9
    AND #$8F
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
+   LDX #$0A
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$9F
    ORA #$60
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
L8EF4
    JSR L863E
    JSR L86CA
    LDA $03E2
    LDX #$0F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA $03E3
    DEX
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JSR $FFE4
    STA $03E7
    CMP #$00
    BNE L8F3F
    LDA $4D
    AND #$02
    BNE L8EF4
    LDA $4D
    AND #$08
    BEQ L8EF4
L8F1F
    LDX #$0A
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$9F
    ORA #$20
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA #$02
    JSR EXCGST                  ; allocate local storage
    LDY #$00
    STY $03F6
    TYA
    STA (COPY2),Y
    INY
    STA (COPY2),Y
    STA $03F5
    RTS
---------------------------------
L8F3F
    LDA $03F5
    BNE +
    LDA $03E7
    CMP #$0D
    BNE L8EF4
+   LDA $03E7
    CMP #$0D
    BEQ L8F6E
    JSR L8635
    JSR L863E
    JSR L86CA
    LDA $03F3
    CMP $03E2
    BNE L8EF4
    LDA #$9D
    STA $03E7
    JSR L8635
    JMP L8EF4
---------------------------------
L8F6E
    LDA $03F5
    BEQ L8F1F
    LDX #$0A
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$9F
    ORA #$20
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
L8F7F
    SEC
    LDA $03F3
    SBC #$01
    STA $03F3
    LDA $03F4
    SBC #$00
    STA $03F4
    BMI L8F1F
    SEC
    LDA $03F3
    SBC $03F1
    LDA $03F4
    SBC $03F2
    BCS L8FA4
    JMP L8F1F
---------------------------------
L8FA4
    LDA $03F4
    LDX #$12
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDA $03F3
    INX
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDX #$1F
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    CMP #$20
    BEQ L8F7F
    SEC
    LDA $03F3
    SBC $03F1
    STA $03F5
    INC $03F5
    CLC
    ADC #$03
    BCC L8FD3
    LDX #$05
    JMP RUNERR                  ; go to comal error handler
---------------------------------
L8FD3
    JSR EXCGST                  ; allocate local storage
    LDA $03F2
    LDX #$12
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    INX
    LDA $03F1
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    LDY #$00
    LDX #$1F
L8FE9
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    CMP #$20
    BCS L8FF5
    ORA #$40
    JMP L8FFF
---------------------------------
L8FF5
    CMP #$40
    BCC L8FFF
    CMP #$80
    BCS L8FFF
    ORA #$C0
L8FFF
    STA (COPY2),Y
    INY
    CPY $03F5
    BCC L8FE9
    LDA #$00
    STA $03F6
    STA (COPY2),Y
    INY
    LDA $03F5
    STA (COPY2),Y
    RTS


;
;  PROC Hardcopy80
;
ProcHardcopy80
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$02
    LDA (COPY1),Y
    BEQ +
-
    LDX #$05
    JMP RUNERR                  ; go to comal error handler

+   INY
    LDA (COPY1),Y
    BEQ -
    TAY
    LDA COPY1
    CLC
    ADC #$04
    STA COPY1
    LDA COPY1+1
    ADC #$00
    STA COPY1+1
    LDA #$FB
    STA $B8
    LDA COPY1
    LDX COPY1+1
    STA $BB
    STX $BC
    STY $B7
    LDA #$22
    JSR CFNAME                  ; parse & copy file name
    JSR COPEN                   ; open File
    LDX #$FB
    JSR CCKOUT                  ; select output File
    LDX #$0D
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    STA $03F1
    DEX
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    STA $03F2
    LDX #$06
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    STA $03E6
    BEQ L90BC
L906C
    LDA $03F1
    CLC
    ADC #$50
    STA $03F3
    LDA $03F2
    ADC #$00
    STA $03F4
    LDA #$50
    STA $03F5
    JSR L8F7F
    LDA $03F5
    BEQ +
    LDY #$00
-   LDA (COPY2),Y
    JSR CWRT                    ; write character
    INY
    CPY $03F5
    BNE -
+   JSR CRLF                    ; output cr and lf
    LDA $03F5
    CLC
    ADC #$02
    JSR EXCREM                  ; reclaim Local storage
    DEC $03E6
    BEQ L90BC
    LDA $03F1
    CLC
    ADC #$50
    STA $03F1
    LDA $03F2
    ADC #$00
    STA $03F2
    JMP L906C
---------------------------------
L90BC
    LDA #$FB
    JSR CCLOSE                  ; close File
    RTS


;
;  PROC Setgraphic80
;
ProcSetgraphic80
    LDX #$19
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$3F
    ORA #$80
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JSR ProcClear80
    LDA #$01
    STA $03F9
    RTS
---------------------------------
L90D7
    LDA $03E6
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$01
    LDA (COPY1),Y
    STA TXT
    DEY
    LDA (COPY1),Y
    BMI L9119
    STA TXT+1
    LDA $03E7
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$01
    LDA (COPY1),Y
    STA TXT+2
    DEY
    LDA (COPY1),Y
    BNE L9119
    STA TXT+3
    LDA #$C7
    SEC
    SBC TXT+2
    STA TXT+2
    BCC L9119
    LDA TXT
    SEC
    SBC #$80
    LDA TXT+1
    SBC #$02
    BCC L911E
L9119
    LDX #$05
    JMP RUNERR                  ; go to comal error handler
---------------------------------
L911E
    LDA TXT+3 
    BNE L9119
    LDA TXT+2 
    CMP #$C7
    BEQ +
    BCS L9119
+   RTS
---------------------------------
L912D
    LDA #$00
    STA $03E2
    STA $03E3
    LDA TXT+2 
    BEQ +
    STA $03E2
    LDX #$02
    JSR L91B4
    CLC
    LDA TXT+2 
    ADC $03E2
    STA $03E2
    LDA $03E3
    ADC #$00
    STA $03E3
    LDX #$04
    JSR L91B4
+   LDX #$0D
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    CLC
    ADC $03E2
    STA $03E2
    PHP
    DEX
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    PLP
    ADC $03E3
    STA $03E3
    LDA TXT     
    AND #$F8
    STA $03E4
    LDA TXT     
    AND #$07
    STA $03E7
    LDA TXT+1   
    STA $03E5
    LDX #$03
-   LSR $03E5
    ROR $03E4
    DEX
    BNE -
    LDA $03E4
    CLC
    ADC $03E2
    STA $03E2
    LDA $03E5
    ADC $03E3
    STA $03E3
    LDA #$80
    LDY $03E7
    BEQ +
-   LSR
    DEY
    BNE -
+   STA $03E7
    RTS
---------------------------------
L91B4
    ASL $03E2
    ROL $03E3
    DEX
    BNE L91B4
    RTS


;
;  PROC Plot80
;
ProcPlot80
    LDY #$01
    STY $03E6
    INY
    STY $03E7
    LDX #$18
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND #$7F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    JSR L90D7
L91D4
    JSR L912D
    JSR L922E
    LDA $03F9
    BMI L9217
    BEQ L91F8
    LDX #$1F
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    ORA $03E7
    STA $03E7
    JSR L922E
    LDA $03E7
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    RTS
---------------------------------
L91F8
    LDA $03E7
    EOR #$FF
    STA $03E7
    LDX #$1F
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    AND $03E7
    STA $03E7
    JSR L922E
    LDA $03E7
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    RTS
---------------------------------
L9217
    LDX #$1F
    JSR .read_VDCreg            ; x = VDC reg No., acc = value
    EOR $03E7
    STA $03E7
    JSR L922E
    LDA $03E7
    LDX #$1F
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    RTS
---------------------------------
L922E
    LDX #$12
    LDA $03E3
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    INX
    LDA $03E2
    JSR .write_VDCreg           ; x = VDC reg No., acc = value
    RTS


;
;  PROC Line80
;
ProcLine80
    JSR ProcPlot80
    LDA TXT 
    STA TXT+20
    LDA TXT+1 
    STA TXT+21
    LDA TXT+2 
    STA TXT+24
    LDA TXT+3 
    STA TXT+25
    LDY #$03
    STY $03E6
    INY
    STY $03E7
    JSR L90D7
    LDA TXT 
    STA TXT+22
    LDA TXT+1 
    STA TXT+23
    LDA TXT+2 
    STA TXT+26
    LDA TXT+3 
    STA TXT+27
    SEC
    LDA TXT+22
    SBC TXT+20
    STA TXT+10
    LDA TXT+23
    SBC TXT+21
    STA TXT+11
    BPL +
    LDA TXT+10
    EOR #$FF
    STA TXT+10
    LDA TXT+11
    EOR #$FF
    STA TXT+11
    CLC
    LDA TXT+10
    ADC #$01
    STA TXT+10
    LDA TXT+11
    ADC #$00
    STA TXT+11
+   SEC
    LDA TXT+26
    SBC TXT+24
    STA TXT+12
    LDA TXT+27
    SBC TXT+25
    STA TXT+13
    BPL +
    LDA TXT+12
    EOR #$FF
    STA TXT+12
    LDA TXT+13
    EOR #$FF
    STA TXT+13
    CLC
    LDA TXT+12
    ADC #$01
    STA TXT+12
    LDA TXT+13
    ADC #$00
    STA TXT+13
+   SEC
    LDA TXT+10
    SBC TXT+12
    LDA TXT+11
    SBC TXT+13
    BCS L92FB
    JMP L9414
---------------------------------
L92FB
    LDA TXT+20
    STA TXT 
    LDA TXT+21
    STA TXT+1 
    LDA TXT+24
    STA TXT+2 
    LDA TXT+25
    STA TXT+3 
    LDA TXT+22
    STA TXT+4 
    LDA TXT+23
    STA TXT+5 
    SEC
    LDA TXT+22
    SBC TXT+20
    LDA TXT+23
    SBC TXT+21
    BCS L9331
    JMP L933E
---------------------------------
L9331
    LDA #$01
    STA TXT+6 
    LDA #$00
    STA TXT+7 
    JMP L9346
---------------------------------
L933E
    LDA #$FF
    STA TXT+6 
    STA TXT+7 
L9346
    SEC
    LDA TXT+26
    SBC TXT+24
    LDA TXT+27
    SBC TXT+25
    BCS L9358
    JMP L9365
---------------------------------
L9358
    LDA #$01
    STA TXT+8 
    LDA #$00
    STA TXT+9 
    JMP L936D
---------------------------------
L9365
    LDA #$FF
    STA TXT+8 
    STA TXT+9 
L936D
    CLC
    LDA TXT+12
    ADC TXT+12
    STA TXT+16
    LDA TXT+13
    ADC TXT+13
    STA TXT+17
    SEC
    LDA TXT+16
    SBC TXT+10
    STA TXT+14
    LDA TXT+17
    SBC TXT+11
    STA TXT+15
    SEC
    LDA TXT+14
    SBC TXT+10
    STA TXT+18
    LDA TXT+15
    SBC TXT+11
    STA TXT+19
L93A6
    LDA TXT 
    CMP TXT+4 
    BNE L93B7
    LDA TXT+1 
    CMP TXT+5 
    BNE L93B7
    RTS
---------------------------------
L93B7
    CLC
    LDA TXT 
    ADC TXT+6 
    STA TXT 
    LDA TXT+1 
    ADC TXT+7 
    STA TXT+1 
    LDA TXT+15
    BMI L93D2
    JMP L93E8
---------------------------------
L93D2
    CLC
    LDA TXT+14
    ADC TXT+16
    STA TXT+14
    LDA TXT+15
    ADC TXT+17
    STA TXT+15
    JMP L940E
---------------------------------
L93E8
    CLC
    LDA TXT+2 
    ADC TXT+8 
    STA TXT+2 
    LDA TXT+3 
    ADC TXT+9 
    STA TXT+3 
    CLC
    LDA TXT+14
    ADC TXT+18
    STA TXT+14
    LDA TXT+15
    ADC TXT+19
    STA TXT+15
L940E
    JSR L91D4
    JMP L93A6
---------------------------------
L9414
    LDA TXT+24
    STA TXT+2 
    LDA TXT+25
    STA TXT+3 
    LDA TXT+20
    STA TXT 
    LDA TXT+21
    STA TXT+1 
    LDA TXT+26
    STA TXT+4 
    LDA TXT+27
    STA TXT+5 
    SEC
    LDA TXT+26
    SBC TXT+24
    LDA TXT+27
    SBC TXT+25
    BCS L944A
    JMP L9457
---------------------------------
L944A
    LDA #$01
    STA TXT+6 
    LDA #$00
    STA TXT+7 
    JMP L945F
---------------------------------
L9457
    LDA #$FF
    STA TXT+6 
    STA TXT+7 
L945F
    SEC
    LDA TXT+22
    SBC TXT+20
    LDA TXT+23
    SBC TXT+21
    BCS L9471
    JMP L947E
---------------------------------
L9471
    LDA #$01
    STA TXT+8 
    LDA #$00
    STA TXT+9 
    JMP L9486
---------------------------------
L947E
    LDA #$FF
    STA TXT+8 
    STA TXT+9 
L9486
    CLC
    LDA TXT+10
    ADC TXT+10
    STA TXT+16
    LDA TXT+11
    ADC TXT+11
    STA TXT+17
    SEC
    LDA TXT+16
    SBC TXT+12
    STA TXT+14
    LDA TXT+17
    SBC TXT+13
    STA TXT+15
    SEC
    LDA TXT+14
    SBC TXT+12
    STA TXT+18
    LDA TXT+15
    SBC TXT+13
    STA TXT+19
L94BF
    LDA TXT+2 
    CMP TXT+4 
    BNE L94D0
    LDA TXT+3 
    CMP TXT+5 
    BNE L94D0
    RTS
---------------------------------
L94D0
    CLC
    LDA TXT+2 
    ADC TXT+6 
    STA TXT+2 
    LDA TXT+3 
    ADC TXT+7 
    STA TXT+3 
    LDA TXT+15
    BMI L94EB
    JMP L9501
---------------------------------
L94EB
    CLC
    LDA TXT+14
    ADC TXT+16
    STA TXT+14
    LDA TXT+15
    ADC TXT+17
    STA TXT+15
    JMP L9527
---------------------------------
L9501
    CLC
    LDA TXT 
    ADC TXT+8 
    STA TXT 
    LDA TXT+1 
    ADC TXT+9 
    STA TXT+1 
    CLC
    LDA TXT+14
    ADC TXT+18
    STA TXT+14
    LDA TXT+15
    ADC TXT+19
    STA TXT+15
L9527
    JSR L91D4
    JMP L94BF


;
;  PROC Setpen80
;
ProcSetpen80
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BMI +
    BNE ++
    INY
    LDA (COPY1),Y
    BNE ++
    LDA #$00
    STA $03F9
    RTS
---------------------------------
+   LDA #$80
    STA $03F9
    RTS
---------------------------------
++  LDA #$01
    STA $03F9
    RTS
---------------------------------
.signal1
    STY $03EC                   ; save signal byte
    CPY #$01                    ; signal 'POWER2'
    BEQ .check128
    CPY #$09                    ; signal 'ERROR'
    BNE .checkstop
    JMP fastoff                 ; switch off c128 Turbo-Mode
---------------------------------
.checkstop
    CPY #$0A                    ; signal 'STOP1'
    BNE L9594                   ; RTS
    JMP fastoff                 ; switch off C128 Turbo-Mode
---------------------------------
.check128
    LDA $D600
    BNE L956E                   ; is a c128
    JMP LB89B                   ; init superchip
---------------------------------
L956E
    JSR ProcInit80
    JSR L957A                   ; prepare c128 vectors and routines
    LDY $03EC                   ; load signal byte
    JMP LB89B                   ; init superchip
---------------------------------

L957A
; set new CHROUT vector
    LDA #$C8
    STA $0326
    LDA #$03
    STA $0327
L9584
    LDY #$00
-   LDA L95A8,Y
    STA $0334,Y
    INY
    CPY #$AD
    BNE -                       ; loop
    JSR .set_newIRQ
L9594
    RTS


;
;  PROC Keypad
;
ProcKeypad
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BNE L9584
    INY
    LDA (COPY1),Y
    BNE L9584
    JMP L966C

; -------------------------------
;
; the following code sequence will be coppied to $0334
;
L95A8
!pseudopc $0334 {

;$0334
    LDA #>L0343
    PHA
    LDA #<L0343
    PHA
    PHP
    PHA
    LDA $C5
    PHA
    PHA
    JMP $C3BF
---------------------------------
L0343
    SEI
    LDY #$00
    LDA $CB
    CMP #$40
    BNE L03A4
    LDA #$FF
    STA D1PRA                   ; CIA#1 (Port Register A)
    STY $D02F
    LDA D1PRB                   ; CIA#1 (Port Register B)
    CMP #$FF
    BEQ L03A4
    STX $C5
    LDA #$FE
--  PHA
    LDX #$08
    STA $D02F
-   LDA D1PRB                   ; CIA#1 (Port Register B)
    CMP D1PRB                   ; CIA#1 (Port Register B)
    BNE -
-   LSR
    BCS ++
    PHA
    LDA L03AF,Y
    BEQ +
    STA $CB
+   PLA
++  INY
    DEX
    BNE -
    PLA
    SEC
    ROL
    CPY #$17
    BCC --
    LDA $CB
    CMP #$40
    BEQ L03A4
    LDX #$81
    LDY #$00
    BCC +
    AND #$7F
    STA $CB
    LDX #$C2
    LDY #$01
+   LDA #$EB
    STY $028D
    STX $F5
    STA $F6
    JSR $EAE0
L03A4
    LDA #$FF
    STA $D02F
    JSR $EB42
    JMP $EA81
---------------------------------
L03AF
    !by $0F,$1B,$10,$E2,$3B
    !by $0B,$18,$38,$3F,$28,$2B,$07,$01
    !by $13,$20,$08,$80,$23,$2C,$87,$07
    !by $82,$02,$3C,$00

---------------------------------
;$03C8
    STA $03E7
    LDA $9A
    CMP #$07
    BEQ L03D7
    LDA $03E7
    JMP $F1CA
---------------------------------
;$03D7
L03D7
    LDA $03E7
    JSR CALL                    ; jsr to another page
    !by $84                     ; page No.
    !word L8632                 ; address
    RTS
}
;
; end of $0334 code sequence
;
; -------------------------------

; set new irq vector
.set_newIRQ
L9655
    SEI
    LDA #$34
    STA $0314
    LDA #$03
    STA $0315
    CLI
    RTS
---------------------------------
ProcDiscard80
    LDA #$CA
    STA $0326
    LDA #$F1
    STA $0327
L966C
    SEI
    LDA #$BF
    STA $0314
    LDA #$C3
    STA $0315
    CLI
    RTS
---------------------------------
