program HexConversion; {Citasson.hw11 - This program will convert a file
                        of hex codes into a file of numbers of base 10}
   type
     long=array[1..20]of longint;
     longF=file of long;
   var
     filein:text;
     fileout:text;
     l:integer;
     x:string[8];
     y:integer;
     z:char;
     q,r,s,t:longint;
 begin
   assign(filein,'Hexconv.B16');
   reset(filein);
   assign(fileout,'Hexconv.B10');
   rewrite(fileout);
 repeat
   readln(filein,z);
   case (z) of
         'A','a':l:=10;
         'B','b':l:=11;
         'C','c':l:=12;
         'D','d':l:=13;
         'E','e':l:=14;
         'F','f':l:=15;
   end;
 until eof(filein);
 end.