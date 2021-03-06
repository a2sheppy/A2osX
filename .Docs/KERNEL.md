*** Auto generated by docgen.cmd ***  

# GetArg  

## ASM  
**In:**  
A = argument index.  
**Out:**   
CC : success  
Y,A = PTR To Arg[A]  
CS : Out Of Bound  

# FileSearch  
Search a file in the provided PATH list  
And return, if found, the full path to it.  

## C  
`int filesearch ( char * filename, char * searchpath, char * fullpath, stat * filestat);`  

## ASM  
**In:**  
`>PUSHWI filestat`  
`>PUSHWI fullpath`  
`>PUSHWI searchpath`  
`>LDYAI filename`  
**Out:**  
CC : success  
DstBuf = FilePath  
DstStat = S.STAT  
CS : not found  

# GetDevByID.A  
**In:**   
A = DevID  
**Out:**  
CC = OK, CS = ERROR  
Y,A = DEVSLOT  
note: X Unmodified  

# GetDevByName.YA  
**In:**   
 Y,A = Ptr to device name (C-String)  
**Out:**  
 CC = OK, CS = ERROR  
 X = DEVID  
 Y,A = DEVSLOT  

# GetDevStatus.A  
**In:**   
 A = DevID  
**Out:**  
 Y,A = S.DSTAT  

# IOCTL  

## C  
`int ioctl ( short int id, short int op, void *param);`  

## ASM  
**In:**   
`PUSHWI param`  
`lda #op`  
`ldy id`  
`>SYSCALL IOCTL`  
**Out:**  
 Y,A = ...  

# OpenDir.YA  
**In:**  
 Y,A = PATH (C-String)  
**Out:**   
 CC : success  
  A = hDIR  
 CS : error  
  A = EC  

# ReadDir.A  
**In:**   
 A = hDIR  
**Out:**   
 CC : success  
  X = hDIRENT  
  Y,A = PTR to S.DIRENT  
 CS : error  
  A = EC  
  note : A = 0 means no more entry  

# CloseDir.A  
**In:**   
 A = hDIR  
**Out:**  
 none, always succeed.   

# ExpandStr  
**In:**  
 Y,A = PTR to String to Expand (C-String)  
**Out:**  
 X = hMem to Expanded String (C-String)  
 Y,A = PTR to Expanded String   

# PutEnv.YA  
**In:**  
 Y,A = PTR to String NAME=VALUE (C-String)  
**Out:**  

# SetEnv  
**In:**  
 PUSHW = PTR To Value (PSTR)  
 PUSHW = PTR To Name (PSTR)  
**Out:**  

# GetEnv.YA  
**In:**  
 Y,A = PTR to NAME (PSTR)  
**Out:**  
 CC : Y,A = PTR to VALUE (PSTR)  
 CS : not found  

# UnsetEnv.YA  
**In:**  
 Y,A = PTR To Name (PSTR)  
**Out:**  

# LoadTxtFile.YA  
Load TXT a file in memory (with ending 0)  
**In:**  
 Y,A = File Path  
**Out:**  
 Y,A = File Length (without ending 0)  
 X = hMem of Loaded File  

# LoadFile  
Load a file in memory  
**In:**  
 PUSHW = AUXTYPE (Handled by....  
 PUSHB = TYPE  ...  
 PUSHB = MODE  ...  
 PUSHW = PATH ...FOpen)  
**Out:**  
 Y,A = File Length  
 X = hMem of Loaded File  

# ChTyp  
**In:**  
 PUSHB = TYPE  
 PUSHW = PATH  

# ChMod  
**In:**  
 PUSHW = UID  
 PUSHW = PATH  

# ChOwn  
**In:**  
 PUSHW = UID  
 PUSHW = PATH  

# ChGrp  
**In:**  
 PUSHW = GID  
 PUSHW = PATH  

# FAdd,FSub,FMult,FDiv,FPwr  
Return X+Y, X-Y, X*Y, X/Y, X^Y  

## ASM  
**In:**  
`>PUSHF X (float)`  
`>PUSHF Y (float)`  
`>SYSCALL fadd`  
`>SYSCALL fsub`  
`>SYSCALL fmult`  
`>SYSCALL fdiv`  
`>SYSCALL fpwr`  
**Out:**  
 On stack (float)  

# Log,Sqr,Exp,Cos,Sin,Tan,ATan  
Return Log(x), Sqr(x), E^X, Cos(x), Sin(X), Tan(x), ATan(x)  

## C  
`float log ( float x);`  
`float sqr ( float x);`  
`float exp ( float x);`  
`float cos ( float x);`  
`float sin ( float x);`  
`float tan ( float x);`  
`float atan ( float x);`  

## ASM  
**In:**  
`>PUSHF x (Float)`  
`>SYSCALL log`  
**Out:**  
 On stack (Float)  

# float  
Return 'floated' long  

## C  
`float f = (float)12345678;  

## ASM  
**In:**  
 `>PUSHL X` (long)  
**Out:**  
 On stack (float)  

# lrintf  
Return float rounded into a long  

## C  
`long int lrintf (float x);`  

## ASM  
**In:**  
`>PUSHF x`  
`>SYSCALL lrintf`  
**Out:**  
 On stack (long)  

# GetMem0  
**In:**   
 Y,A = Size Requested  
**Out:**  
 CC : success  
  YA = PTR to Mem (ZERO Initialised)  
*	X = hMem  
 CS :  
  A = EC  

# GetMem  
**In:**   
 Y,A = Size Requested  
**Out:**  
 CC : success  
  YA = PTR to Mem (Uninitialised)  
*	X = hMem  
 CS :  
  A = EC  

# FreeMem  
**In:**  
 A = hMem To Free  
**Out:**  
 none.  
 (X,Y unmodified)  

# GetMemPtr  
**In:**  
 A = hMem  
**Out:**  
 Y,A = PTR to MemBlock  
 (X unmodified)  

# GetMemByID  
**In:**  
 A = hMem  
**Out:**  
 Y,A = ZPMemMgrSPtr = PTR to S.MEM  
 X unmodified  

# NewStr  
Create a new copy of this C-String  
**In:**  
 Y,A = Ptr to source C-String  
**Out:**  
 CC : success   
  Y,A = PTR to String  
  X = hMem (PSTR)  
 CS : error  
  A = SYS error code  

# SListGetByID  
**In:**  
 PUSHB = hSList  
 PUSHW = KeyID  
 PUSHW = Data Ptr  
 PUSHW = Key Ptr  
**Out:**  
 X,Y = Next KeyID  

# SListUpdateByID  
**In:**  
 PUSHB = hSList  
 PUSHW = KeyID  
 PUSHW = Data Ptr  
**Out:**  
 A = Key Length  
 X,Y = KeyID  

# SListAdd  
**In:**  
 PUSHB = hSList  
 PUSHW = Key Ptr  
 PUSHW = Data Ptr  
**Out:**  
 A = Key Length  
 X,Y = KeyID  

# SListLookup  
**In:**  
 PUSHB = hSList  
 PUSHW = Key Ptr  
 PUSHW = Data Ptr  
**Out:**  
 A = Key Length  
 X,Y = KeyID  

# SListNew  
**In:**  
**Out:**  
 A=hSList  

# SListFree  
**In:**  
 A=hSList  
**Out:**  

# GetStkObjProp  
**In:**  
 A = hObject (AUX Memory)  
 Y = Property Index  
**Out:**  
 Y,A = Property Value  

# NewStkObj  
**In:**   
 Y,A = Size Requested  
**Out:**  
 CC : success  
  YA = PTR to Mem (Uninitialised)  
*	X = hMem  
 CS :  
  A = EC  

# FreeStkObj  
**In:**  
 A = hMem To Free (AUX Memory)  
**Out:**  
 none.  
 (X,Y unmodified)  

# LoadStkObj  
Load a file in AUX memory (Stock Objects)  
**In:**  
 PUSHW = AUXTYPE (Handled by....  
 PUSHB = TYPE  ...  
 PUSHB = MODE  ...  
 PUSHW = PATH ...FOpen)  
**Out:**  
 Y,A = File Length  
 X = hMem of Loaded Object in AUX mem  

# ExecPSNewEnv.YA  

# ExecPS.YA (Blocking Parent PID)  

# CreatePSNewEnv.YA   

# CreatePS.YA (Non Blocking)  
**In:**  
  Y,A = PTR To Cmd Line  
**Out:**  
  A = Child PSID  

# GetMemStat.YA  
**In:**  
 Y,A = Ptr to 24 bytes buffer  
**Out:**  
 Buffer filled with memory stats  

# GetPSStatus.A  
**In:**  
 A = PID  
**Out:**  
 A = Status Byte  

# GetPSStat.YA  
**In:**  
 Y,A = Ptr to 24 bytes buffer  
**Out:**  
 Buffer filled with PS stats  

# Stat  
Return information about a file  
**In:**  
 PUSHW = PTR to S.STAT buffer  
 PUSHW = PTR to Filename (C-String)  
**Out:**  

# MKDir.YA  
**In:**   
 Y,A = DIR name  
**Out:**  
 CC : success  
 CS : error  
  A = EC  

# MkNod.YA  
return a hFile for a given Device Name  
**In:**   
 Y,A=DevName  
**Out:**  
 CC = OK, CS = ERROR  
 A = hFILE  

# MKFIFO  
return a hFILE to a new FIFO  
**In:**   
**Out:**  
 CC = OK, CS = ERROR  
 A = hFILE  

# FPutC  
Print A (char) to hFILE  

## C  
`int fputc ( int character, hFILE stream );`  

## ASM  
**In:**  
A : character  
Y : stream  
**Out:**   
CC = success  

# PutChar  

## C  
`int putchar ( int character );`  

## ASM  
Print A (char) to StdOut  
**In:**  
A : char to print  
**Out:**   
CC = success  

# PutS  
Write Str to StdOut, appends '\r\n'  

## C  
`int puts ( const char * str );`  
**In:**  
Y,A : str   
**Out:**   
CC = success  

# FPutS  
Write Str to FILE  

## C  
`int fputs ( const char * str, hFILE stream );`  
**In:**  
PUSHB : hFILE  
Y,A: str   
**Out:**   
CC = success  

# PrintF/SPrintF/FPrintF  
Prints C-Style String  

## C  
`int printf ( const char * format, ... );`  
`int sprintf ( char * str, const char * format, ... );`  
`int fprintf ( hFILE stream, const char * format, ... );`  

## ASM  
**In:**  
PrintF : (example is for printing Y,A as integer : format="Y,A= %I", 2 bytes)    
`>PUSHYA`  
`>PUSHBI 2`  
`>LDYAI format`  
`>SYSCALL printf`  
SPrintF :   
`>PUSHYA`  
`>PUSHBI 2`  
`>PUSHWI format`  
`>LDYAI str`  
`>SYSCALL sprintf`  
FPrintF :   
`>PUSHYA`  
`>PUSHBI 2`  
`>PUSHWI format`  
`lda hFILE`  
`>SYSCALL fprintf`  
**Out:**  
CC : success, Y,A = bytes sent  
CS : error, A = code from Output  
Specifiers :  
+ %b : pull 1 byte to Print BIN   
+ %B : pull 2 bytes to Print BIN  
+ %d : pull 1 byte unsigned DEC 0..255  
+ %D : pull 2 bytes unsigned DEC 0..65535  
+ %u : pull 4 bytes long unsigned DEC 0..4294967295  
+ %e : pull 5 Bytes float (-)1.23456789e+12  
+ %f : pull 5 Bytes float (-)3.1415  
+ %h : pull 1 byte to Print HEX  
+ %H : pull 2 bytes to Print HEX  
+ %i : pull 1 byte to Print signed DEC -128..127  
+ %I : pull 2 bytes to Print signed DEC -32768..32767  
+ %L : pull 4 bytes signed DEC -2147483648..2147483647  
+ %n : pull 1 byte to Print low Nibble HEX  
+ %N : pull 1 byte to Print high Nibble HEX  
+ %s : pull 2 bytes ptr to C-Style String  
+ %S : pull 2 bytes ptr to P-Style String  
+ \b : Print 'BS' (08)  
+ \e : Print 'ESC' ($1B,27)  
+ \f : Print 'FF' ($0C,12)  
+ \n : Print 'LF' ($0A,10)  
+ \r : Print 'CR' ($0D,13)  
+ \\\\ : Print \  
+ \\% : Print %  

Modifiers for len and padding :   
+ %d	  : '9'  '12'  
+ %2d	  : ' 9' '12'   				  
+ %02d  : '09' '12'  
+ %11s  : 'ABCDEFGH   '	  
+ %011s : 'ABCDEFGH000'  
+ %2f	  :	'3.14'  


# GetChar  
Get char from StdIn  
**In:**  
 none.  
**Out:**   
 CC = success  
  A = char  

# GetC  
Get char from Node  

## C  
`int getc ( FILE * stream );`  

## ASM  
**In:**  
 A = hNODE  
**Out:**   
 CC = success  
  A = char  

# SScanF  
Read formatted data from string  

## C  
`int sscanf ( const char * s, const char * format, ...);`  

## ASM  
**In:**  
`>PUSHBI Argument Byte count`  
`>PUSHWI format`  
+ %i : short int  
+ %d : byte  
+ %I : int  
+ %D : word  
+ %L : long int  
+ %U : dword  
+ %h : HEX byte  
+ %H : HEX word  

`>LDYA s`  
**Out:**  
Y,A = Number of arguments filled.  

# FOpen  
Open a file  

## C  
`hFILE fopen ( const char * filename, short int mode, short int ftype, int auxtype );`  
**In:**  

## ASM  
`>PUSHWI auxtype`  
`>PUSHBI ftype`  
`>PUSHBI mode`  
 + SYS.FOpen.R : if R and exists -> ERROR  
 + SYS.FOpen.W : if W and exists -> CREATE  
 + SYS.FOpen.A : Append  
 + SYS.FOpen.T : Open/Append in Text mode  
 + SYS.FOpen.X : Create if not exists  
`>LDYAI filename`  
**Out:**   
 CC : A = hFILE  
 CS : A = EC  

# FClose.A  
Close a file  
**In:**  
 A = hFILE  
**Out:**  

# FRead  
int fread ( void * ptr, int count, FILE * stream );  
Read bytes from file  
**In:**  
 PUSHW = Dest Ptr  
 PUSHW = Bytes To Read  
 PUSHB = hFILE  
**Out:**  
 Y,A = Bytes Read  

# FWrite  
Write bytes to file  

## C  
`int fwrite ( const void * ptr, int count, hFILE stream );`  

## ASM  
**In:**  
`>PUSHB = hFILE`  
`>PUSHWI ptr`  
`>LDYA count`  

# Out:  
 Y,A = Bytes Written  

# FFlush.A  
**In:**  
 A = hFILE  

# FSeek  
Set the file-position indicator for hFILE  
**In:**  
 PUSHW = Ptr to Offset (DWORD)  
 PUSHB = From  
 PUSHB = hFILE  

# FEOF.A  
Test the end-of-file indicator for hFILE  
**In:**  
 A = hFILE  
**Out:**  
 CC :   
  A=0 EOF  
  A =0 NOT EOF  
 CS :  

# FTell  
Return the current value of the file-position indicator  
**In:**  
 PUSHW = Ptr to Offset (DWORD)  
 PUSHB = hFILE  
**Out:**  
  Offset = Offset  

# Remove.YA  

# Rename  
Rename a file  
**In:**  
 PUSHW = New Name  
 PUSHW = Old Name  
**Out:**  

# strtof  
Convert String to 40 bits Float  

##C  
`float strtof (const char* str, char** endptr);`  

##ASM  
**In:**  
`>PUSHWI EndPtr`  
`>LDYA str`  
`>SYSCALL strtof`  
**Out:**  
On stack (float)  

# AToF  
Convert String to 40 bits Float  

## C  
`float atof (const char* str);`  

## ASM  
**In:**  
`>LDYA str`  
`>SYSCALL atof`  
**Out:**  
On stack (float)  

# StrToL/StrToUL  
Convert String to 32 bits (unsigned) int  

## C  
`long strtol (const char* str, char** endptr, int base);`  
`unsigned long strtoul (const char* str, char** endptr, int base);`  

## ASM  
**In:**  
`>PUSHB Base`  
`>PUSHWI EndPtr`  
`>LDYAI str`  
`>SYSCALL strtol`  
**Out:**  
On stack (long)  

# atol  
Convert String to 32 bits long  

## C  
`long atol ( const char * str );`  

## ASM  
**In:**  
`>LDYA str`  
`>SYSCALL atol`  
**Out:**  
On stack (long)  

# atoi  
Convert String to 16 bits int  

## C  
`int atoi ( const char * str );`  

## ASM  
**In:**  
`>LDYAI str`  
`>SYSCALL atoi`  
**Out:**  
 Y,A = int  

# realpath  
Return the canonicalized absolute pathname  

## C  
`unsigned short int realpath (const char* str);`  

## ASM  
**In:**  
`>LDYA str`  
`>SYSCALL realpath`  
**Out:**  
CC : success  
 Y,A = Ptr to Full Path (C-String)  
 X = hMem of Full Path  
CS : A = Error Code  

# StrLen  
Returns Length of C-String  

## C  
`int strlen ( char * str);`  

## ASM  
**In:**   
`>LDYAI str`  
`>SYSCALL strlen`  
**Out:**   
Y,A = String length  

# StrCat  
Concatenate strings  

## C  
`char * strcat ( char * destination, const char * source );`  

## ASM  
**In:**   
`>PUSHWI source`  
`>LDYAI destination`  
`>SYSCALL strcat`  
**Out:**   
Y,A = destination  

# StrCpy  
Copy string  

## C  
`char * strcpy ( char * destination, const char * source );`  

## ASM  
**In:**   
`>PUSHWI source`  
`>LDYAI destination`  
`>SYSCALL strcpy`  
**Out:**   
Y,A = destination  

# StrMatch  
Compare a String against pattern  
**In:**   
  PUSHW = PTR to Pattern (e.g. '*test?.txt')  
  PUSHW = PTR to Src String   
**Out:**   
  CC : match  
  CS : no match  

# StrUpr/StrLwr  
Convert string to UPPERCASE/lowercase  
**In:**  
Y,A = PTR to String (CSTR)  
**Out:**  
Uppercased/lowercased String in Buffer  

# StrCmp  
Compare 2 strings  
**In:**   
 PUSHW = Ptr to String1 (CSTR)  
 PUSHW = Ptr to String2 (CSTR)  
**Out:**   
 DST = SRC  

# StrICmp  
Compare 2 strings  
**In:**   
 PUSHW = Ptr to String1 (CSTR)  
 PUSHW = Ptr to String2 (CSTR)  
**Out:**   
 CC, Y,A=0  
 CS, Y,A > 0 or < 0  

# Time  
Get System Time in Buffer  

## C  
`time_t time (time_t* timer);`  

##ASM  
**In:**  
Y,A = PTR to S.TIME  
**Out:**  
S.TIME filled with System date/time  

# PTime2Time  
 Convert ProDOS Time To S.TIME  

## C  
`time_t time (long ptime, time_t* timer);`  

##ASM  
**In :**   
 PUSHW = Dst PTR To S.TIME  
 PUSHW = Src PTR to ProDOS DATE/TIME (DWORD)  
**Out:**  

# CTime2Time  
 Convert CTIME to S.TIME  
**In:**   
 PUSHW = Dst PTR To S.TIME  
 PUSHW = Src CTIME DWORD  

# StrFTime  

## C  
Convert S.TIME struct to CSTR  
`size_t strftime (char* ptr, size_t maxsize, const char* format, const struct tm* timeptr );`  

## ASM  
**In:**  
PUSHW = Dst PTR To CSTR Buf  
PUSHW = Src PTR To Format String  
+ %a : Abbreviated weekday name : Thu  
+ %A : Full weekday name : Thursday   
+ %b : Abbreviated month name : Aug   
+ %B : Full month name : August   
+ %d : Day of the month, zero-padded (01-31)  
+ %H : Hour in 24h format (00-23) 14   
+ %I : Hour in 12h format (01-12) 02   
+ %m : Month as a decimal number (01-12) 08   
+ %M : Minute (00-59) 55   
+ %p : AM or PM designation PM   
+ %S : Second (00-61) 02   
+ %w : Weekday as a decimal number with Sunday as 0 (0-6)   
+ %y : Year, last two digits (00-99)  
+ %Y : Year four digits 2001   

PUSHW = Src PTR To S.Time  
**Out:**  
  none. always succeed.  
