program dfd;
uses crt;
const

maxx : integer = 40;
maxy : integer = 12;
type  point = record
   x : integer;
   y: integer;
   end;
zoom : integer = 1;
var
 upper : point;
 temp : char;
 spot : point;

begin

 upper.x :=-maxx;
 upper.y :=maxy;
 spot.x:=0;
 spot.y:=0;

 repeat
 temp := readkey;
 if temp='0' then temp :=readkey;


 case temp of

 chr(72): spot.y :=spot.y+5;
 chr(80) : spot.y:= spot.y-5;
 chr(77): spot.x  :=spot.x+5;
 chr(75) : spot.x := spot.x-5;
 '+' : begin maxx:=maxx*2; maxy:=maxy*2; end;
 '-' : begin maxx:=maxx div 2;maxy:=maxy div 2; end;
 end;
 upper.x :=spot.x -maxx;
 upper.y :=spot.y +maxy;
 clrscr;
 gotoxy(10,10); writeln('(',upper.x,',',upper.y,')');
 until temp = 'q';
end.