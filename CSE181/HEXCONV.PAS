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
   readln(filein,x);
   while not eof(filein) do
     begin
       y:=(pos(' ',x))-1;
       readln(filein,x);
       case x[1] of
         'A','a':l:=10;
         'B','b':l:=11;
         'C','c':l:=12;
         'D','d':l:=13;
         'E','e':l:=14;
         'F','f':l:=15;
         '1'    :l:=1;
         '2'    :l:=2;
         '3'    :l:=3;
         '4'    :l:=4;
         '5'    :l:=5;
         '6'    :l:=6;
         '7'    :l:=7;
         '8'    :l:=8;
         '9'    :l:=9;
         '0'    :l:=0;
       end;
       if (y=4) then
         begin
           readln(x[1]);
           if (pos(z,x[1])=1) then
             t:=(l*16*16*16);
           if (pos(z,x[1])=2) then
             s:=(l*16*16);
           if (pos(z,x[1])=3) then
             r:=(l*16);
           if (pos(z,x[1])=4) then
             q:=(l);
           writeln(q+r+s+t);
         end
       else if (y=3) then
         begin
           readln(x[1]);
           if (pos(z,x[1])=1) then
             s:=(l*16*16);
           if (pos(z,x[1])=2) then
             r:=(l*16);
           if (pos(z,x[1])=3) then
             q:=(l);
           writeln(q+r+s);
         end
       else if (y=2) then
         begin
           readln(x[1]);
           if (pos(z,x[1])=1) then
             r:=(l*16);
             q:=(l);
           writeln(q+r);
         end
       else if (y=1) then
         begin
           readln(x[1]);
           q:=(l);
           writeln(q);
         end;
       delete(x,1,(y+1));
     end;
     writeln(fileout);
     close(filein);
     close(fileout);
   end.

