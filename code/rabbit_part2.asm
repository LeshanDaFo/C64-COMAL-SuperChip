;B730
ProcBread
    JSR chk_bmode               ; check if in block mode
    LDA #$04
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BEQ LB776
    JSR LBAFA
    LDX #$33
    JSR LBA28
    JSR LBA9C
    LDA #$04
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$02
    LDA #$01
    STA (COPY1),Y
    INY
    LDA #$00
    STA (COPY1),Y
    CLC
    LDA COPY1
    ADC #$04
    STA COPY1
    LDA COPY1+1
    ADC #$00
    STA COPY1+1
    LDY #$00
LB768
    LDA $C000,Y
    STA (COPY1),Y
    INY
    BNE LB768
    LDA #$01
    STA $C11D
    RTS
---------------------------------
LB776
    LDA #<inv_buf_txt           ; text 'invalid buffer string'
    LDX #>inv_buf_txt
    JMP prnt_txt2
---------------------------------
ProcBwrite
    JSR chk_bmode               ; check if in block mode
    LDA #$04
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$02
    LDA (COPY1),Y
    CMP #$01
    BNE LB776
    INY
    LDA (COPY1),Y
    BNE LB776
    CLC
    LDA COPY1
    ADC #$04
    STA COPY1
    LDA COPY1+1
    ADC #$00
    STA COPY1+1
    LDY #$00
LB7A1
    LDA (COPY1),Y
    STA $C000,Y
    INY
    BNE LB7A1
    JSR LBAFA
    LDX #$34
    JSR LBA28
    JMP LBA86
---------------------------------

ProcSetfast
    JSR getparam1               ; find 1. parameter
    BNE set_fast                ; branch if not zero
    JSR LB7D2
    JSR LB7EE
    JMP LBB9A
---------------------------------
set_fast
;LB7C2
    JMP set_vec                 ; set vectors, and finish
;    JMP LBB32
---------------------------------
; ---- get first parameter
getparam1
;LB7C5
    LDA #$01
    JSR FNDPAR                  ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    INY
    ORA (COPY1),Y
    RTS
---------------------------------
LB7D2
    LDA $C114
    BNE LB7D8
    RTS
---------------------------------
LB7D8
    LDA #<fastfile_open_txt
    LDX #>fastfile_open_txt
    JMP prnt_txt2
---------------------------------
chk_bmode
;LB7DF
    LDA RAB_BM                  ; $C11C
    BEQ no_blkmod
    JMP LB8DF
---------------------------------
no_blkmod
    LDA #<no_bmode_txt          ; text 'not in block mode'
    LDX #>no_bmode_txt
    JMP prnt_txt2
---------------------------------
LB7EE
    LDA RAB_BM                  ; $C11C
    BNE LB7F4
    RTS
---------------------------------
LB7F4
    LDA #<blockmode_on_txt
    LDX #>blockmode_on_txt
    JMP prnt_txt2
---------------------------------
LB7FB
    LDA $C11D
    BEQ LB801
    RTS
---------------------------------
LB801
    LDA #<no_blockread_txt
    LDX #>no_blockread_txt
    JMP prnt_txt2
---------------------------------

ProcSetdevice
    JSR LB7D2
    JSR LB7EE
    LDA #$01
    JSR LBAED
    CMP #$20
    BCS LB81B
    STA RAB_FA                  ; $C119; ;current device number
    RTS
---------------------------------
LB81B
    LDX #$D9
    JMP RUNERR                  ; go to comal error handler
---------------------------------
; this is a dummy function, because the result is everytime '1'
FuncRommed
    LDX #$01
    BPL .printValue

FuncBlockmode
    LDX RAB_BM                  ; $C11C ; block mode
    BPL .printValue

FuncDevice
    LDX RAB_FA                  ; $C119 ; current device number
    BPL .printValue

FuncFast
    LDX $031B
    CPX #$C1
    BNE LB83A
    LDX #$01
    JMP .printValue
---------------------------------
LB83A
    LDX #$00
    JMP .printValue
---------------------------------

FuncRderr
    LDX $C11B
    BPL .printValue

FuncTrack
    JSR LB7FB
    LDX $C000
    BPL .printValue

FuncOfftest
    LDX $C11A
    BPL .printValue

FuncSector
    JSR LB7FB
    LDX $C001

.printValue
    LDA #$00
    JMP PSHINT                  ; Float & pushinteger
---------------------------------

ProcSetofftest
    JSR getparam1               ; find 1. parameter
    BEQ LB863
    LDA #$01
LB863
    STA $C11A
    RTS
---------------------------------

ProcSetbmode
    JSR LB88C
    JSR LB7D2
    JSR getparam1               ; find 1. parameter
    BNE LB87E
    JSR LBA42
    LDA #$00
    STA RAB_BM                  ; $C11C
    STA $C11D
    RTS
---------------------------------
LB87E
    JSR LB912
    LDA #$01
    STA RAB_BM                  ; $C11C
    LDA #$00
    STA $C11D
    RTS
---------------------------------
LB88C
    LDA $031B
    CMP #$C1
    BNE LB894
    RTS
---------------------------------
LB894
    LDA #<not_in_fastmode_txt
    LDX #>not_in_fastmode_txt
    JMP prnt_txt2
---------------------------------
; init diskrabbit
LB89B
    CPY #$01                    ; signal 'POWER2'
    BNE LB8C4
    LDA #$01
    STA NOREST                  ; <> 0: disable stop/restore
    STA $C11A
    LDA #$08
    STA RAB_FA                  ; $C119; ;current device number
; clear markers
    LDA #$00
    STA $C114
    STA $C115
    STA $C11B
    STA RAB_BM                  ; $C11C
    STA NOREST                  ; <> 0: disable stop/restore
    LDA #<startup_txt
    LDX #>startup_txt
    JMP prnt_msg                ; print message on screen
---------------------------------
LB8C4
    CPY #$0B
    BNE LB8D0
    LDA $C114
    BEQ LB8D0
    JMP LBDB5
---------------------------------
LB8D0
    RTS
---------------------------------
.opendevice
    LDA RAB_FA                  ; $C119; ;current device number
    JSR LISTN                   ; COMMAND DEVICE TO LISTEN
    LDA #$6F
    JSR SECOND                  ; SEND SA AFTER LISTEN
    LDA $90
    RTS
---------------------------------
LB8DF
    LDA $D011
    AND #$07
    CLC
    ADC #$2F
    STA $FB
    LDA $DD00
    AND #$07
    STA $FC
    ORA #$20
    STA $FE
    LDA #$FF
    LDX #$04
LB8F8
    EOR $FC
    ROL
    ROL
    DEX
    BNE LB8F8
    ROL
    STA $FD
    LDY #$1F
LB904
    LDA LB989,Y
    AND #$30
    ORA $FC
    STA $C135,Y
    DEY
    BPL LB904
    RTS

; ---- prepare FB/FC with flopyy prg part address
LB912
    LDA #<LAD85
    LDY #>LAD85
    STA $FB
    STY $FC
    LDA #$00                    ; floppy memory address low byte
    LDY #$05                    ; floppy memory address high byte
    STA $FD
    STY $FE
    LDX #$10
    LDY #$20
LB926
    STX $C10E
    STY $C10F
    LDA #$00                    ; clear status
    STA $90
LB930
    JSR .opendevice
    BPL +
    LDX #$D0
    JMP RUNERR                  ; go to comal error handler

+   LDA #$4D                    ; 'M'
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    LDA #$2D                    ; "-"
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    LDA #$57                    ; "W"
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    LDA $FD                     ; address low byte
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    LDA $FE                     ; addresss high byte
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    LDA $C10F                   ; #$20
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    LDY #$00
LB95B
    LDA ($FB),Y
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    INY
    CPY $C10F
    BCC LB95B
    JSR UNLSN                   ; COMMAND DEVICE TO UNLISTEN
    CLC
    LDA $FB
    ADC $C10F
    STA $FB
    BCC LB975
    INC $FC
LB975
    CLC
    LDA $FD
    ADC $C10F
    STA $FD
    BCC LB981
    INC $FE
LB981
    DEC $C10E
    BNE LB930
    JMP LB8DF
---------------------------------
LB989
    !by $07,$07,$27,$27,$07,$07,$27,$27
    !by $17,$17,$37,$37,$17,$17,$37,$37
    !by $07,$27,$07,$27,$17,$37,$17,$37
    !by $07,$27,$07,$27,$17,$37,$17,$37

LB9A9
    BIT $DD00
    BVS LB9A9
    STA $FF
    LSR
    LSR
    LSR
    LSR
    TAX
LB9B5
    SEC
    LDA $D012
    SBC $FB
    BCC LB9C1
    AND #$07
    BEQ LB9B5
LB9C1
    LDA $FE
    STA $DD00
    NOP
    LDA $C135,X
    STA $DD00
    LDA $C145,X
    STA $DD00
    LDA $FF
    AND #$0F
    TAX
    LDA $C135,X
    STA $DD00
    LDA $C145,X
    STA $DD00
    NOP
    NOP
    LDA $FC
    STA $DD00
    RTS
---------------------------------
LB9EC
    LDA $FE
    STA $DD00
LB9F1
    BIT $DD00
    BVS LB9F1
LB9F6
    SEC
    LDA $D012
    SBC $FB
    BCC LBA02
    AND #$07
    BEQ LB9F6
LBA02
    LDA $FC
    STA $DD00
    NOP
    NOP
    NOP
    NOP
    NOP
    LDA $FD
    EOR $DD00
    ROL
    ROL
    NOP
    EOR $DD00
    ROL
    ROL
    PHA
    PLA
    EOR $DD00
    ROL
    ROL
    NOP
    EOR $DD00
    ROL
    ROL
    ROL
    RTS
---------------------------------
LBA28
    LDA #$00
    STA $90
    JSR .opendevice
    BPL LBA36
LBA31
    LDX #$D0
    JMP RUNERR                  ; go to comal error handler
---------------------------------
LBA36
    LDA #$55
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    TXA
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    JMP UNLSN                   ; COMMAND DEVICE TO UNLISTEN
---------------------------------
LBA42
    LDA #$00
    STA $90
    JSR .opendevice
    BMI LBA31
    LDA #$49
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    JMP UNLSN                   ; COMMAND DEVICE TO UNLISTEN
---------------------------------
LBA53
    PHA
    JSR .opendevice
    BMI LBA31
    LDA #$4D                    ; 'M'
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    LDA #$2D                    ; '-''
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    LDA #$57                    ; 'W'
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    LDA #$58                    
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    LDA #$01
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    LDA #$03
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    PLA
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    TXA
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    TYA
    JSR CIOUT                   ; OUTPUT BYTE TO  SERIAL PORT
    JMP UNLSN                   ; COMMAND DEVICE TO UNLISTEN
---------------------------------
LBA86
    JSR LBAB8
    LDY #$00
LBA8B
    LDA $C000,Y
    JSR LB9A9
    INY
    BNE LBA8B
    JSR LB9EC
    BNE LBAA4
    JMP LBAD9
---------------------------------
LBA9C
    JSR LBAB8
    JSR LB9EC
    BEQ LBAAA
LBAA4
    JSR LBAD9
    JMP $CEA7
---------------------------------
LBAAA
    LDY #$00
LBAAC
    JSR LB9EC
    STA $C000,Y
    INY
    BNE LBAAC
    JMP LBAD9
---------------------------------
LBAB8
    SEI
    LDA $D011
    STA $C11E
    ORA #$10
    STA $D011
    LDA $D030
    STA $C155
    LDA $D015
    STA $C118
    LDA #$00
    STA $D015
    STA $D030
    RTS
---------------------------------
LBAD9
    LDA $C11E
    STA $D011
    LDA $C118
    STA $D015
    LDA $C155
    STA $D030
    CLI
    RTS
---------------------------------
LBAED
    JSR FNDPAR               ; find parameter (asm. calls)
    LDY #$00
    LDA (COPY1),Y
    BNE LBB1C
    INY
    LDA (COPY1),Y
    RTS
---------------------------------
LBAFA
    LDA #$03
    JSR LBAED
    CMP #$02
    BCS LBB1C
    STA $C111
    LDA #$02
    JSR LBAED
    STA $C110
    LDA #$01
    JSR LBAED
    LDX $C110
    LDY $C111
    JMP LBA53
---------------------------------
LBB1C
    LDX #$01
    JMP RUNERR                  ; go to comal error handler
---------------------------------
prnt_msg
LBB21
    STA COPY1
    STX COPY1+1
    LDY #$00
--  LDA (COPY1),Y
    BEQ +
    JSR CWRT                    ; write character
    INY
    BNE --                      ; loop
+   RTS
---------------------------------
set_vec
LBB32
    LDA $031B
    CMP #$C1                    ; check if rabbit vectors are set
    BEQ set_vec_ok              ; branch if allready set (RTS)
    JSR set_jump_table          ; set jump table vectors

; save vector table
    LDX #$0B                    ; pointer
--  LDA $031A,X                 ; save vectors
    STA $C100,X
    DEX
    BPL --                      ; loop
; prepare jump table vectors
; at $C156 is the start of the jump table
    LDA #$56
    LDY #$C1
    STA $031A                   ; open routine vector
    STY $031B
    LDA #$5D
    LDY #$C1
    STA $031C                   ; close routine vector
    STY $031D
    LDA #$64
    LDY #$C1
    STA $031E                   ; chkin routine vector
    STY $031F
    LDA #$6B
    LDY #$C1
    STA $0320                   ; ckout routine vector
    STY $0321
    LDA #$72
    LDY #$C1
    STA $0322                   ; clrchn routine vector
    STY $0323
    LDA #$79
    LDY #$C1
    STA $0324                   ; chrin routine vector
    STY $0325
; end set jump table vectors
; save error handler vector
    LDA TRAPVC                  ; pageb; error handler
    LDY TRAPVC+1                ; pageb; error handler
    STA $C10C
    STY $C10D
; set rabbit error handler vector
    LDA #$80
    LDY #$C1
    STA TRAPVC                  ; pageb; error handler
    STY TRAPVC+1                ; pageb; error handler
set_vec_ok
    RTS
---------------------------------
LBB9A
    LDA $031B
    CMP #$C1
    BNE LBBB8
    LDX #$0B
LBBA3
    LDA $C100,X
    STA $031A,X
    DEX
    BPL LBBA3
    LDA $C10C
    LDY $C10D
    STA TRAPVC                   ; pageb; error handler
    STY TRAPVC+1                 ; pageb; error handler
LBBB8
    RTS
---------------------------------
LBBB9
    LDY #$00
    STY $C112
    STY MODE                     ; file mode
    STY $C120
    LDA ($BB),Y
    AND #$01
    STA $C134
LBBCB
    CPY $B7
    BCC LBBD0
    RTS
---------------------------------
LBBD0
    LDA ($BB),Y
    CMP #$3A
    BEQ LBBDE
    CMP #$24
    BNE LBBDB
    RTS
---------------------------------
LBBDB
    INY
    BNE LBBCB
LBBDE
    LDX #$00
LBBE0
    INY
    CPY $B7
    BCS LBC17
    LDA ($BB),Y
    CMP #$2C
    BEQ LBBF8
    CPX #$10
    BCS LBBE0
    STA $C121,X
    INX
    INC $C120
    BNE LBBE0
LBBF8
    INY
    CPY $B7
    BCS LBC17
    LDA ($BB),Y
    STA $C112
LBC02
    INY
    CPY $B7
    BCS LBC17
    LDA ($BB),Y
    CMP #$2C
    BNE LBC02
    INY
    CPY $B7
    BCS LBC17
    LDA ($BB),Y
    STA $C113
LBC17
    LDA $C113
    BNE LBC28
    LDA $C112
    STA $C113
    LDA #$00
    STA $C112
    CLC
LBC28
    RTS
---------------------------------
LBC29
    LDX $BA
    CPX RAB_FA                  ; $C119; ;current device number
    BEQ LBC33
LBC30
    JMP ($C100)
---------------------------------
LBC33
    LDX $B8
    JSR $F30F
    BNE LBC3D
    JMP $F6FE
---------------------------------
LBC3D
    LDA $C114
    BEQ LBC49
    LDA #<fastfile_open_txt
    LDX #>fastfile_open_txt
    JMP prnt_txt1
---------------------------------
LBC49
    LDA $C11C
    BEQ LBC55
    LDA #<blockmode_on_txt
    LDX #>blockmode_on_txt
    JMP prnt_txt1
---------------------------------
LBC55
    LDA $B9
    AND #$1F
    CMP #$0F
    BCS LBC30
    LDA $B8
    BEQ LBC30
    JSR LBBB9
    BCS LBC30
    LDA $C113
    BEQ LBC6F
    CMP #$52
    BNE LBC30
LBC6F
    LDA $C112
    CMP #$4C
    BEQ LBC30
    LDX $98
    BEQ LBC8C
LBC7A
    DEX
    BEQ LBC8C
    LDA $0263,X
    CMP RAB_FA                  ; $C119; ;current device number
    BNE LBC7A
    LDA #<discfile_open_txt
    LDX #>discfile_open_txt
    JMP prnt_txt1
---------------------------------
LBC8C
    LDX $98
    INC $98
    LDA $B8
    STA $0259,X
    LDA $B9
    ORA #$60
    STA $B9
    STA $026D,X
    LDA $BA
    STA $0263,X
    LDA $C112
    LDY #$03
LBCA8
    CMP LBFEE-1,Y
    BEQ LBCB0
    DEY
    BNE LBCA8
LBCB0
    TYA
    LDY $C120
    STA $C121,Y
    JSR LBA42
    JSR LB912
    JSR LBE9A
    LDX #$35
    JSR LBA28
    JSR LBAB8
LBCC8
    JSR LB9EC
    BEQ LBCC8
    CMP #$FF
    BNE LBCDE
    LDA $B8
    STA $C114
    LDA #$00
    STA $C115
    STA $C11B
LBCDE
    JSR LBAD9
    CLC
    RTS
---------------------------------
LBCE3
    STY $C111
    TXA
    BEQ LBCF1
    CPX $C114
    BEQ LBCFD
LBCEE
    JMP ($C104)
---------------------------------
LBCF1
    LDA $C115
    BEQ LBCEE
    LDA #<fastfile_open_txt
    LDX #>fastfile_open_txt
    JMP prnt_txt2
---------------------------------
LBCFD
    JSR $F30F
    BEQ LBD05
    JMP $F701
---------------------------------
LBD05
    JSR $F31F
    LDA $BA
    STA $99
    LDA $C115
    BNE LBD30
    LDX #$36
    JSR LBA28
    JSR LBAB8
    JSR LB9EC
    BNE LBD45
    LDA #$00
    JSR LB9A9
    JSR LBAAA
    LDA #$02
    STA $C116
    LDA #$01
    STA $C115
LBD30
    LDA $C11B
    BEQ LBD40
    LDA #$00
    STA $C115
    STA $C11B
    JMP $CEA7
---------------------------------
LBD40
    LDY $C111
    CLC
    RTS
---------------------------------
LBD45
    JSR LBAD9
    JMP $CEA7
---------------------------------
LBD4B
    STX $C110
    STY $C111
    LDA $99
    CMP RAB_FA                  ; $C119; ;current device number
    BEQ LBD5B
LBD58
    JMP ($C10A)
---------------------------------
LBD5B
    LDA $C114
    BEQ LBD58
    LDA $C115
    BEQ LBD58
    LDA $90
    BEQ LBD6C
    JMP $F1B1
---------------------------------
LBD6C
    LDX $C116
    LDA $C000,X
    PHA
    INC $C116
    LDA $C000
    BNE LBD8D
    CPX $C001
    BCC LBD84
    LDA #$40
    STA $90
LBD84
    PLA
    LDX $C110
    LDY $C111
    CLC
    RTS
---------------------------------
LBD8D
    INX
    BNE LBD84
    JSR LBAB8
    JSR LB9EC
    BNE LBDA7
    LDA #$00
    JSR LB9A9
    JSR LBAAA
    LDA #$02
    STA $C116
    BNE LBD84
LBDA7
    JSR LBAD9
    LDA #$40
    STA $90
    LDA #$01
    STA $C11B
    BNE LBD84
LBDB5
    TAX
    BEQ LBDBD
    CMP $C114
    BEQ LBDC0
LBDBD
    JMP ($C102)
---------------------------------
LBDC0
    JSR $F30F
    BNE LBDFA
    JSR $F31F
    JSR $F2F3
    LDA $C115
    BEQ LBDEA
    LDA $C11B
    BNE LBDEA
    LDA $C000
    BEQ LBDEA
    JSR LBAB8
    JSR LB9EC
    BNE LBDE7
    LDA #$01
    JSR LB9A9
LBDE7
    JSR LBAD9
LBDEA
    LDA #$00
    STA $C115
    STA $C114
    LDA $C11B
    BNE LBDFA
    JSR LBA42
LBDFA
    CLC
    RTS
---------------------------------
LBDFC
    LDX $99
    CPX RAB_FA                  ; $C119; ;current device number
    BEQ LBE06
LBE03
    JMP ($C108)
---------------------------------
LBE06
    LDA $C114
    BEQ LBE03
    LDX #$03
    STX $9A
    LDA #$00
    STA $99
    RTS
---------------------------------
LBE14
    CPX #$00
    BEQ LBE1B
LBE18
    JMP ($C106)
---------------------------------
LBE1B
    JSR LB7D2
    JSR LB7EE
    JMP LBE18
---------------------------------
LBE24
    CPY #$00
    BEQ LBE3F
    CPY $C114
    BNE LBE53
    PHA
    STX $C110
    STY $C111
    TYA
    JSR LBDB5
    LDX $C110
    LDY $C111
LBE3E
    PLA
LBE3F
    PHA
    LDA #$0C
    STA Q1+1
    LDA #$C1
    STA Q2
    LDA #$6C
    STA Q1
    PLA
    JSR GOTO                    ; jmp to another page
    !by $82                     ; Page
    !by $3B                     ; address low byte
    !by $00                     ; address high byte
---------------------------------
LBE53
    PHA
    LDA $C11B
    BEQ LBE3E
    JSR LBA42
    LDA #$00
    STA $C11B
    BEQ LBE3E
; ---- print texts
LBE63
prnt_txt1
    LDY $B8                     ; current logic file number ???
    !by $2C
; ---- print texts
LBE66
prnt_txt2
    LDY #$00
    STA COPY1                   ; low byte message address
    STX COPY1+1                 ; high byte message address
    STY $C111                   ; store y for later use
    LDY #$00                    ; index
--
    LDA (COPY1),Y               ; load char from text address,y
    BEQ ++                      ; branch if zero
    STA $0201,Y                 ; else store into System-/BASIC-input buffer ,y
    INY
    BNE --                      ; loop
++
    STY $0200                   ; y holds now the message length
; buffer $0200 .. $02xx has now the message length + the message

; copy the code for 'JMP ($C7DE)' to $03b - $03d
; $C7DE is the "pageb; error handler" TRAPVC
    LDA #$6C
    STA Q1                      ; $3b
    LDA #$DE
    STA Q1+1                    ; $3c
    LDA #$C7
    STA Q2                      ; $3d
    INY
    LDA (COPY1),Y               ; the first number behind the text, allways $01
    TAX                         ; transfere to x
    INY
    LDA (COPY1),Y               ; a number from $2D to $33 (msg number?)

    LDY $C111                   ; get back the saved y-value, either content of $B8, or #$00

    JSR GOTO                    ; jmp to another page
    !by $82                     ; Page
    !by $3b                     ; address low byte (Q1)
    !by $00                     ; address high byte
---------------------------------
LBE9A
    LDA #$20
    LDY #$C1
    STA $FB
    STY $FC
    LDA #COPY1+1
    LDY #$01
    STA $FD
    STY $FE
    LDX #$01
    LDY #$15
    JMP LB926
---------------------------------
set_jump_table
    LDX #$2F
LBEB3
    LDA LBEBD,X
    STA $C156,X
    DEX
    BPL LBEB3
    RTS
---------------------------------
LBEBD
    JSR CALL                    ; jsr to another page
    !by PAGE5
    !word LBC29
    RTS

    JSR CALL                    ; jsr to another page
    !by PAGE5
    !word LBDB5
    RTS

    JSR CALL                    ; jsr to another page
    !by PAGE5
    !word LBCE3
    RTS

    JSR CALL                    ; jsr to another page
    !by PAGE5
    !word LBE14
    RTS

    JSR CALL                    ; jsr to another page
    !by PAGE5
    !word LBDFC
    RTS

    JSR CALL                    ; jsr to another page
    !by PAGE5
    !word LBD4B
    RTS

    JSR GOTO                    ; jmp to another page
    !by PAGE5
    !word LBE24

startup_txt
;LBEED
    !by $93,$08,$0E,$0D
    
    !pet " +++ comal's diskrabbit v140785/1.1",$0D,$0D
    !pet "    developed & produced by m.bokhorst",$0D,$0D
    !pet "    (c) 1985 by comal80ggnl ser #75000",$0D,$0D
    !by $00

fastfile_open_txt
    !pet "fastfile open",$00,$01,$2D
discfile_open_txt
    !pet "disk file open",$00,$01,$2E
inv_buf_txt
    !pet "invalid buffer string",$00,$01,$2F
blockmode_on_txt
    !pet "rabbit block mode on",$00,$01,$30
no_bmode_txt
    !pet "not in block mode",$00,$01,$31
not_in_fastmode_txt
    !pet "not in fast mode",$00,$01,$32
no_blockread_txt
    !pet "no block read",$00,$01,$33
LBFEE
    !pet "spu"
.end1   ; ??? why here
LBFF1
    !by $52,$20
    !by $02,$E7,$56,$43,$48
LBFF8
    !by $4B,$49,$4E,$C1,$44
    !by $FF,$FF,$FF
