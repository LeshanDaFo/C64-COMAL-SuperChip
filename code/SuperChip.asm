
; ###############################################################
; #                                                             #
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

!source "code/c64symb.asm"

RAB_FA  = $C119
RAB_BM  = $C11C

.start =$8000

!pet "chip",$00,$00,$40,$10,$00,$00,$00,$04,$80,$00,$40,$00

!pseudopc $8000 {

    !word COLD
    !word WARM

    !pet "CBM80comal"

    !by >.start                 ; $80
    !by PAGE5 + ROMMED          ; PAGE 5 =$84 + %00010000 <> $94

    !word .end1                 ; the module end address
    !word .signal1              ; the address of the signal handler

; start of package table
;
    !pet $04,"c128"             ; char amount, 'name'
    !word ptC128                ; proc's name table address
    !word init_c128             ; package init address
;
    !pet $07,"strings"
    !word ptStrings            
    !word DUMMY                 
;
    !pet $06,"colors"
    !word ptColors
    !word DUMMY
;    
    !pet $05,"files"
    !word ptFiles
    !word DUMMY
;    
    !pet $08,"keyboard"
    !word ptKeyboard
    !word DUMMY
;
    !pet $04,"math"
    !word ptMath
    !word DUMMY
;
    !pet $07,"system2"
    !word ptSystem2
    !word DUMMY
;
    !pet $06,"rabbit"
    !word ptRabbit
    !word DUMMY

    !by $00

!source "code/c128.asm"

!source "code/strings.asm"

!source "code/colors.asm"

!source "code/files.asm"

!source "code/keyboard.asm"

!source "code/math.asm"

!source "code/system2.asm"

; the Rabbit package starts here.
; a second part is located after the Autostart-part
;
; !!! The here included version of DiskRabbit is not working on PAL machines.
; The disc version from ComalToday No. 12 will work on NTSC and PAL
;
!source "code/rabbit_part1.asm"


; COMAL will scan for valid modules on $8000, and also on $B000
; the Autostart is located here
.bstart
; ---------------------------------------------------------------
; second part, start at $B000
    !word COLD
    !word WARM

    !pet "CBM80comal"

    !by >.bstart                ; $B0
    !by PAGE5 + ROMMED          ; PAGE 5 =$84 + %00010000 <> $94

    !word .end2                 ; the module end address
    !word .signal2              ; the address of the signal handler

; start of package table
;
    !pet $09,"autostart"        ; char amount, 'name'
    !word ptAutostart           ; proc's name table address
    !word .init_auto            ; package init address

ptAutostart
    !by $00


.signal2
    NOP
    NOP
    NOP
    CPY #$01
    BEQ .init_auto
    RTS

.init_auto
    LDX #<.basprg
    LDA #>.basprg
    JSR .prep_autostart
    LDA #$FF
    STA HEADLN                  ; power on message flag
    STA CDBUF+3                 ; code buffer
    LDA #$0E
    STA CDBUF+4                 ; code buffer
    JSR EXCUTE                  ; execute code in cabuf
    JSR RESET                   ; reset program pointers
    JMP COMAL                   ; go to comal editor
---------------------------------
.prep_autostart
    STX TXTLO                   ; $7C
    STA TXTHI                   ; $7D
    LDY #$24
LB04E
    LDA LB067-1,Y
    STA TXT-1,Y                 ; $C760; string constant buffer
    DEY
    BNE LB04E
    STY $0040                   ; STY Q3 +1
    STY EXTPRC                  ; flag for loading of external proc/func
    JSR RESET                   ; reset program pointers
    LDX #<TXT
    LDA #>TXT
    JMP JLOAD                   ; load comal program
---------------------------------
LB067
    LDY #$00
    SEI
    LDX #PAGE5
    STX $DE00
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    LDA (TXTLO),Y               ; ($7C),y
    NOP
    NOP
    NOP
    NOP
    NOP
    LDX PAGE                    ; $06
    STX $DE00
    CLI
    INC TXTLO                   ; $7C
    BNE +
    INC TXTHI                   ; $7D
+   RTS
---------------------------------
; the next code will be executet during COMAL start as a program file
.basprg
    !by $ff,$ff,$02,$00,$00,$AE,$03,$06,$04
    
    !by $27,$1a,$06,$d4,$00,$00                                 ; 0010 USE system
    !by $27,$24,$17,$00                                         ; 0020 //textcolors(15,1,11)
    !pet "textcolors(15,1,11)"
    !by $27,$2E,$06,$D4,$0A,$00                                 ; 0030 USE files
    !by $27,$38,$06,$D4,$13,$00                                 ; 0040 USE system2
    !by $27,$42,$06,$D4,$1E,$00                                 ; 0050 USE graphics
    !by $27,$4C,$0A,$BD,$03,$03,$44,$53,$3A,$BE                 ; 0060 SELECT OUTPUT "ds:"
    !by $27,$56,$0A,$BD,$03,$03,$4B,$42,$3A,$CC                 ; 0070 SELECT INPUT "kb:"
    !by $27,$60,$05,$FF,$1A                                     ; 0080 CLOSE
    !by $27,$6A,$09,$03,$02,$30,$3A,$FF,$1E                     ; 0090 UNIT "0:"
    !by $27,$74,$07,$CE,$00,$FF,$31                             ; 0100 TIME 0
    !by $27,$7E,$06,$81,$2A,$00                                 ; 0110 textscreen
    !by $27,$88,$05,$FF,$15                                     ; 0120 PAGE
    !by $27,$92,$30,$5F,$03,$28,$0E                             ; 0130 PRINT ""14" $$$ Commodore-64 COMAL 80 rev 2.01 $$$"
    !pet " $$$ Commodore-64 COMAL 80 rev 2.01 $$$"
    !by $65,$60
    !by $27,$9C,$2C,$5F,$03,$24                                 ; 0140 PRINT "    (C) 1984 by UniComal & Commodore"
    !pet "    (C) 1984 by UniComal & Commodore"
    !by $65,$60
    !by $27,$A6,$05,$5F,$60                                     ; 0150 PRINT 
    !by $27,$B0,$24,$5F,$03,$1C                                 ; 0160 PRINT "           30714 bytes free."
    !pet "           30714 bytes free."
    !by $65,$60
    !by $27,$C4,$05,$5F,$60                                     ; 0180 PRINT
    !by $27,$CE,$29,$5F,$03,$21                                 ; 0190 PRINT "      SUPER CHIP - copyright 1986"
    !pet "      SUPER CHIP - copyright 1986"
    !by $65,$60
    !by $27,$EC,$2D,$5F,$03,$25                                 ; 0220 PRINT "   COMAL Users Group, U.S.A., Limited"
    !pet "   COMAL Users Group, U.S.A., Limited"
    !by $65,$60
    !by $27,$F6,$05,$5F,$60                                     ; 0230 PRINT
    !by $28,$00,$28,$5F,$03                                     ; 0240 PRINT "         New Super Chip packages:"
    !pet "         New Super Chip packages:"
    !by $65,$60
    !by $28,$0A,$05,$5F,$60                                     ; 0250 PRINT
    !by $28,$14,$06,$CE,$0E,$46                                 ; 0260 ZONE 14
    !by $28,$1E,$29,$5F,$03,$0C                                 ; 0270 PRINT "   autostart","  files","rabbit"
    !pet "   autostart"
    !by $65,$66,$03,$07
    !pet "  files"
    !by $65,$66,$03,$06
    !pet "rabbit"
    !by $65,$60
    !by $28,$28,$28,$5F,$03,$07                                 ; 0280 PRINT "   c128","  keyboard","strings"
    !pet "   c128"
    !by $65,$66,$03,$0A
    !pet "  keyboard"
    !by $65,$66,$03,$07
    !pet "strings"
    !by $65,$60
    !by $28,$32,$26,$5F,$03,$09                                 ; 0290 PRINT "   colors","  math","system2"
    !pet "   colors"
    !by $65,$66,$03,$06
    !pet "  math"
    !by $65,$66,$03,$07
    !pet "system2"
    !by $65,$60
    !by $28,$46,$06,$CE,$00,$46                                 ; 0310 ZONE 0
    !by $28,$50,$11,$68,$06,$38,$00,$03,$04                     ; 0320 IF host$="c128" THEN
    !pet "c128"
    !by $2d,$69,$00,$00
    !by $28,$55,$05,$5F,$60                                     ; 0325 PRINT
    !by $28,$5A,$2C,$5F,$03,$24                                 ; 0330 PRINT "  C128 detected -- keypad now active"
    !pet "  C128 detected -- keypad now active"
    !by $65,$60
    !by $28,$78,$04,$6F                                         ; 0360 ENDIF
    !by $28,$82,$09,$1A,$40,$00,$CE,$03,$13                     ; 0370 bell(3)
    !by $28,$8C,$05,$5F,$60                                     ; 0380 PRINT
    !by $28,$96,$2D,$5F,$03,$25                                 ; 0390 PRINT "  To enable Rabbit Fastloader (1541),"
    !pet "  To enable Rabbit Fastloader (1541),"
    !by $65,$60
    !by $28,$A0,$27,$5F,$03,$1F                                 ; 0400 PRINT "  issue the following commands:"
    !pet "  issue the following commands:"
    !by $65,$60
    !by $28,$AA,$05,$5F,$60                                     ; 0410 PRINT
    !by $28,$B4,$14,$5F,$03,$0C                                 ; 0420 PRINT "  USE rabbit"
    !pet "  USE rabbit"
    !by $65,$60
    !by $28,$BE,$17,$5F,$03,$0F                                 ; 0430 PRINT "  setfast(TRUE)"
    !pet "  setfast(TRUE)"
    !by $65,$61
    !by $28,$C8,$0E,$68,$02,$02,$8D,$D8,$CE,$02,$26,$69,$00,$00 ; 0440 IF PEEK(653) MOD 2 THEN
    !by $28,$D2,$05,$5F,$60                                     ; 0450 PRINT
    !by $28,$DC,$2D,$5F,$03,$25                                 ; 0460 PRINT "shift key pressed - AUTOSTART enabled"
    !pet "shift key pressed - AUTOSTART enabled"
    !by $65,$60
    !by $28,$E6,$22,$5F,$03,$1A                                 ; 0470 PRINT "Checking for program ""hi"":"
    !pet "Checking for program ",$22,"hi",$22,":"
    !by $65,$60
    !by $28,$F0,$0F,$68,$0A,$48,$00,$03,$02,$48,$49             ; 0480 IF file'exists("hi") THEN
    !by $15,$69,$00,$00
    !by $28,$FA,$1D,$5F,$03,$15                                 ; 0490 PRINT "file found - CHAINing"
    !pet "file found - CHAINing"
    !by $65,$60
    !by $29,$04,$09,$03,$02,$48,$49,$FF,$1C                     ; 0500 CHAIN "hi"
    !by $29,$0E,$06,$6E,$00,$00                                 ; 0510 ELSE
    !by $29,$18,$2E,$5F,$03,$26                                 ; 0520 PRINT "file not found - terminating AUTOSTART"
    !pet "file not found - terminating AUTOSTART"
    !by $65,$60
    !by $29,$22,$04,$6F                                         ; 0530 ENDIF
    !by $29,$2C,$04,$6F                                         ; 0540 ENDIF
    !by $29,$36,$07,$CD,$91,$FF,$38

    
    !by $00,$00,$00,$9F
    
    !by $0A,$00,$00,$00
    !pet "system"
    !by $09,$00,$00,$00
    !pet "files"
    !by $0B,$00,$00,$00
    !pet "system2"
    !by $0C,$00,$00,$00
    !pet "graphics"
    !by $0E,$00,$00,$00
    !pet "textscreen"
    !by $08,$00,$00,$00
    !pet "host"
    !by $08,$00,$00,$00
    !pet "bell"
    !by $0F,$00,$00,$00
    !pet "file'exists"

    !by $00,$20,$B5,$00,$B1,$52,$45,$00 
    !by $40,$00
; here is the end of the program file
.end2

; the next part seems has no function related to the Super Chip Modul
; there is no call from anywhere to this part
; i let it here for compatibility
!source "code/filler.asm"


; the second part of the Rabbit package starts here
!source "code/rabbit_part2.asm"

}