program TEST_HW6_HW7;  {Citasson HW#6 and HW#7 - CSE182}

uses Gameun10,CRT;


var Myuniverse:universe;
    spot:location;
    temp:char;
    n:integer;
begin
  CRT.ClrScr;
  write('                    How many asteroids do you want? ');
  readln(n);
  CRT.ClrScr;
  Myuniverse.create(n);
  spot.make(0,0);
  zoom:=1;
 repeat 
   repeat
    Myuniverse.Update;
    Myuniverse.Display(spot,zoom);
    CRT.delay(50);
   until CRT.Keypressed;
 temp := readkey;
   if temp='0' then temp :=readkey;
     case temp of
       chr(72): spot.incr_y(round(12*exp((zoom-1)*ln (2))));
       chr(80): spot.incr_y(-round(12*exp((zoom-1)*ln (2))));
       chr(77): spot.incr_x(round(40*exp((zoom-1)*ln (2))));
       chr(75): spot.incr_x(-round(40*exp((zoom-1)*ln (2))));
       '=' : begin
               zoom:=zoom+1;
             end;
       '-' : begin
               zoom:=zoom-1;
             end;
     end; 
 CRT.GotoXY(10,10);
 writeln(Spot.X,' ',spot.y,' ',zoom);
 until temp= 'q';
end.
