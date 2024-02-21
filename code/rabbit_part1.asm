ptRabbit
    !pet $05,"bread"
    !word phBread               ; reads a block
    !pet $06,"bwrite"
    !word phBwrite              ; writes a block
    !pet $08,"setbmode"
    !word phSetbmode            ; set block mode
    !pet $07,"setfast"
    !word phSetfast             ; set fast mode
    !pet $09,"setrommed"
    !word phSetrommed           ; set rommed
    !pet $09,"setdevice"
    !word phSetdevice           ; set the device number
    !pet $0A,"setofftest"
    !word phSetofftest          ; SETOFFTEST..
    !pet $06,"device"
    !word phDevice              ; eturns the current device number
    !pet $05,"track"
    !word phTrack               ; returns the number of the next track
    !pet $06,"sector"
    !word phSector              ; returns the number of the next sector
    !pet $04,"fast"
    !word phFast                ; FAST
    !pet $06,"rommed"
    !word phRommed              ; ROMMED
    !pet $07,"offtest"
    !word phOfftest             ; OFFTEST
    !pet $05,"rderr"
    !word phRderr               ; read error number
    !pet $09,"blockmode"
    !word phBlockmode           ; check block mode
    !pet $0E,"version'rabbit"
    !word phVersionRabbit         ; check block mode
    !by $00


;
;-- PROC phBread
;
phBread
    !by PROC
    !word ProcBread
    !by $04
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by $77
    !by ENDPRC


;
;-- PROC phBwrite
;
phBwrite
    !by PROC
    !word ProcBwrite
    !by $04
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by $77
    !by ENDPRC


;
;-- PROC phSetfast
;
phSetfast
    !by PROC
    !word ProcSetfast
    !by $01
    !by VALUE + INT
    !by ENDPRC


;
;-- PROC phSetrommed
;
; this is a useless function, maybe kept to be cmpatible to old rabbit 'ram' version
phSetrommed
    !by PROC
    !word DUMMY                 ; ProcSetrommed ; CA2F
    !by $01
    !by VALUE + INT
    !by ENDPRC


;
;-- PROC phSetdevice
;
phSetdevice
    !by PROC
    !word ProcSetdevice
    !by $01
    !by VALUE + INT
    !by ENDPRC


;
;-- FUNC phDevice
;
phDevice
    !by FUNC
    !word FuncDevice
    !by $00
    !by ENDFNC


;
;-- PROC phSetbmode
;
phSetbmode
    !by PROC
    !word ProcSetbmode
    !by $01
    !by VALUE + INT
    !by ENDPRC


;
;-- FUNC phTrack
;
phTrack
    !by FUNC
    !word FuncTrack
    !by $00
    !by ENDFNC


;
;-- FUNC phSector
;
phSector
    !by FUNC
    !word FuncSector
    !by $00
    !by ENDFNC


;
;-- FUNC phFast
;
phFast
    !by FUNC
    !word FuncFast
    !by $00
    !by ENDFNC


;
;-- FUNC phRommed
;
; this is a dummy function, the result is everytinme '1'
phRommed
    !by FUNC
    !word FuncRommed
    !by $00
    !by ENDFNC

;
;-- PROC phSetofftest
;
phSetofftest
    !by PROC
    !word ProcSetofftest
    !by $01
    !by VALUE + INT
    !by ENDPRC


;
;-- FUNC phOfftest
;
phOfftest
    !by FUNC
    !word FuncOfftest
    !by $00
    !by ENDFNC


;
;-- FUNC phRderr
;
phRderr
    !by FUNC
    !word FuncRderr
    !by $00
    !by ENDFNC


;
;-- FUNC phBlockmode
;
phBlockmode
    !by FUNC
    !word FuncBlockmode
    !by $00
    !by ENDFNC


;
;-- FUNC VersRabbit
;
phVersionRabbit
    !by FUNC + STR
    !word VersRabbit            ; proc code address
    !by $00                     ; count of params
    !by ENDFNC


LAD85
    JMP $06C9
    JMP $05C6
    JMP $0537
---------------------------------
    LDA $0158
    LDX $0159
LAD94
    LDY $015A
    CLC
    JSR $05D3
    JSR $069E
    BNE LADAB
    JSR $06D6
    LDX $0301
    LDA $0300
    BNE LAD94
LADAB
    RTS

LADAC
    !by $00,$04,$01,$05,$08,$0C,$09,$0D
    !by $02,$06,$03,$07,$0A,$0E,$0B,$0F

    LDA $FE85
    LDX #$01
LADC1
    LDY $015A
    CLC
    JSR $05D3
    LDY #$02
LADCA
    LDA $0300,Y
    AND #$07
    BEQ LAE06
    INY
    INY
    INY
    LDX #$00
    BEQ LADF2
    LDA $0147,X
LADDB
    CMP $0300,Y
    BEQ LADEB
    CMP #$3F
    BNE LAE06
    LDA $0300,Y
    CMP #$A0
    BEQ LAE06
LADEB
    INX
    INY
    CPX $0146
    BCS LADFB
LADF2
    LDA $0147,X
    CMP #$2A
    BEQ LAE1A
    BNE LADDB
LADFB
    CPX #$10
    BCS LAE1A
    LDA $0300,Y
    CMP #$A0
    BEQ LAE1A
LAE06
    TYA
    AND #$E0
    CLC
    ADC #$22
    TAY
    BCC LADCA
    LDX $0301
    LDA $0300
    BNE LADC1
    JMP $0612
---------------------------------
LAE1A
    TYA
    AND #$E0
    TAY
    LDA $0302,Y
    LDX $0303,Y
    PHA
    LDA $0304,Y
    TAY
    PLA
    AND #$07
    CMP #$04
    BEQ LAE48
    STX $0158
    STY $0159
    LDY $0146
    CMP $0147,Y
    BEQ LAE43
    LDA $0147,Y
    BNE LAE48
LAE43
    LDA #$FF
    JMP $065A
---------------------------------
LAE48
    JMP $0615
---------------------------------
    JSR $06E3
    LDA $0158
    LDX $0159
    LDY $015A
    SEC
    STA $80
    STX $81
    STY $7F
    JSR $C118
    LDX #$00
    STX $F9
    BCS LAE6A
    LDA #$80
    !by $2C
LAE6A
    LDA #$90
    ORA $7F
    JSR $05F7
    SEI
    LDA $1C00
    AND #$F7
    STA $1C00
    CLI
    RTS
---------------------------------
    TAY
    LDA $80
    BEQ LAE91
    CMP $FED7
    BCS LAE91
    STA $06
    JSR $F24B
    CMP $81
    BEQ LAE91
    BCS LAEAF
LAE91
    LDA #$E6
    !by $2C
LAE94
    LDA #$F3
    BIT $E2A9
    BIT $E4A9
LAE9C
    PHA
    LDA #$01
    JSR $065A
    PLA
    BMI LAEAA
    LDX $F9
    JMP $E60A
---------------------------------
LAEAA
    AND #$7F
    JMP $E645
---------------------------------
LAEAF
    LDA $81
    STA $07
    TYA
    AND #$F0
    CMP #$90
    BNE LAECD
    TYA
    LSR
    BCS LAEC3
    LDA $0101
    BCC LAEC6
LAEC3
    LDA $0102
LAEC6
    BEQ LAECD
    CMP $FED5
    BNE LAE94
LAECD
    STY $024D
    STY $00
    STY $025B
LAED5
    LDA $00
    BMI LAED5
    CMP #$02
    BCS LAE9C
    LDA #$00
    STA $D5
    SEI
    LSR
    LSR
    LSR
    LSR
    TAX
    LDA $0527,X
    TAX
    LDA #$01
LAEED
    BIT $1800
    BEQ LAEED
    LDA #$08
    STA $1800
    LDA #$01
LAEF9
    BIT $1800
    BNE LAEF9
    STX $1800
    TXA
    ASL
    AND #$0F
    STA $1800
    LDA $D5
    AND #$0F
    TAX
    LDA $0527,X
    STA $1800
    ASL
    AND #$0F
    NOP
    STA $1800
    NOP
    NOP
    NOP
    LDA #$00
    STA $1800
    RTS
---------------------------------
    SEI
    LDA #$08
    STA $1800
    LDX #$00
    LDA #$01
LAF2D
    BIT $1800
    BEQ LAF2D
    STX $1800
    LDA $1800
    ASL
    NOP
    EOR $1800
    ASL
    ASL
    ASL
    ASL
    STA $D5
    LDA $1800
    ASL
    NOP
    EOR $1800
    EOR $D5
    RTS
---------------------------------
    LDA $0158
    LDX $0159
    LDY $015A
    CLC
    JSR $05D3
    LDY #$00
LAF5D
    LDA $0300,Y
    JSR $065A
    INY
    BNE LAF5D
    CLI
    RTS
---------------------------------
    LDY #$00
LAF6A
    JSR $069E
    STA $0300,Y
    INY
    BNE LAF6A
    CLI
    RTS
---------------------------------

VersRabbit
    LDA #$6F
    JSR EXCGST                  ; allocate local storage
    LDY #$00
-   LDA Rabbitvermsg,Y
    STA (COPY2),Y
    INY
    CPY #$6D
    BNE -                       ; loop
    LDA #$00
    STA (COPY2),Y
    LDA #$6D
    INY
    STA (COPY2),Y
    RTS
---------------------------------
Rabbitvermsg
    !pet " 1.20 rabbit package by M. Bokhorst",$0D
    !pet "      updated        by Phil Bacon",$0D
    !pet "      made rommable  by Terry Ricketts"

    !by $ff,$ff,$ff
; end of first modul part, and end of Rabbit part 1
