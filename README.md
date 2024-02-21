## C64 COMAL 80 SuperChip extension

Information about COMAL itself can be found here:<br />
https://www.c64-wiki.com/wiki/Commodore-64_Comal_80_rev_2.01<br />
<br />

### SuperChip for COMAL80 is an extension for the existing COMAL80 module for the C64/C128

#### Super Chip information from COMAL Today #13

"Super Chip is a 16k EPROM designed to plug<br />
into the empty socket inside the black<br />
COMAL 2.0 cartridge. It works with both<br />
the C64 and C128."

This extension was provided original by the COMAL Users Group, USA, Limited,

#### COMAL SuperChip Screenshots<br />
<div align="left">
<table border="0" cellpadding="6" width="600">
 <tr>
  <td align="center"><img width="715" alt="SuperChip start screen" src="https://github.com/LeshanDaFo/C64-COMAL-SuperChip/assets/97148663/e3e2a152-4e2c-4d30-af12-4859f48357d6">
  <td align="center"><img width="716" alt="SuperChip Autostart" src="https://github.com/LeshanDaFo/C64-COMAL-SuperChip/assets/97148663/d9b74b86-7a1d-4f97-b736-b7b149e216ac"></td>
 </tr>
</table>
</div>

### SuperChip details from COMAL Today #13:

The SuperChip is a collection of different packages, build in one EPROM.
The Packages are as following:

   1. AUTOSTART:<br />
      When the computer is turned on or reset, if the shift key is depressed, the file named "hi" is loaded and run from disk.
   2. RABBIT:<br />
      An updated version of the rabbit package from COMAL Today #12 with 16 commands is included on SuperChip.
   3. C128:<br />
      The C128 package 1.21 from David Stidolph with 29 commands is added.
   4. MATH:<br />
      The Math package 1.20 from Richard Bain with 16 commands is added.
   5. FILES:<br />
      The Files package 1.20 from Richard Bain with 12 commands is added.
   6. Keyboard:<br />
      The keyboard package 1.20 from Richard Bain with 10 commands is added.
   7. COLORS:<br />
      The colors package 1.20 from Richard Bain is added.
   8. SYSTEM2:<br />
      The system2 package 1.20 from Richard Bain with 10 commands is added.
   9. STRINGS<br />
      The strings package 1.20 from Richard Bain with 9 commands is added, including the QUICKSORT from Robert Ross, and STRING code from David Stidolph<br />

You can find more detailed information on the COMAL Today magazines -- https://archive.org/search?query=comal+today<br />

Information about a new version of the SuperChip can be found here:<br />
https://www.forum64.de/index.php?thread/139801-comal-80-super-chip-package-eigene-implementierung/&highlight=super%20chip<br />
<br />
<br />

I would like to point out that the point here is not to describe the functions or procedures.
I just want to present the source code I created from the modules.

The extensions created with this source code were compared by me with the existing data and correspond to this 1:1

With the source code I created and made available, it should be possible to create your 'own' extension.
So you can e.g. change contained commands, remove them or replace them with new ones.

The source code is mostly undocumented, only in a few places I have added some documentation.

Information about the structure of a COMAL extension and its packages can be found e.g. here in this book.<br />
https://archive.org/details/comal-80-for-the-commodore-64/page/n255/mode/2up.


### REMARK:

Used Software:
Visual Studio Code, Version: 1.86.1 (Universal)
Acme Cross-Assembler for VS Code (C64) v0.0.18

Used Hardware:
Apple iMac (24-inch, M1, 2021)

The source code can be compiled by using the Acme Cross Compiler (C64)

Please use this source code on your own risk ;)
