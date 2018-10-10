program TEST_HW6_HW7;  {Citasson Final Exam - CSE182}

uses FinalExa,CRT,Graph;

var Myuniverse:universe;
    spot:location;
    temp,response:char;
    n,IN1,IN2,Input1,G:integer;
begin
  ClearViewPort;
  SetTextStyle(1,0,1);
  OutTextXY(140,75,' How many asteroids do you want?');
  Response:=Readkey;
  Val(Response,IN1,G);   {Reads in a key hit so that you don't need a CR}
  Input1:=IN1*10;
  response:=readkey;
  Val(Response,IN2,G);
  n:=Input1+IN2;
  Myuniverse.create(n);  {Create universe with the number of asteroids entered}
  spot.make(0,0);
  zoom:=1;
  ClearViewPort;
 repeat 
   repeat
    Myuniverse.Update;
    Myuniverse.Display(spot,zoom);
    CRT.delay(50);
   until CRT.Keypressed;
 temp := readkey;
   if temp='0' then temp :=readkey;
     case temp of
       chr(72):begin
                  spot.incr_y(-round(240*(zoom/2)*exp((zoom-1)*ln (2))));
                  ClearViewPort;
               end;
       chr(80):begin
                  spot.incr_y(round(240*(zoom/2)*exp((zoom-1)*ln (2))));
                  ClearViewPort;
               end;
       chr(77): begin
                  spot.incr_x(round(480*(zoom/2)*exp((zoom-1)*ln (2))));
                  ClearViewPort;
                end;
       chr(75): begin
                  spot.incr_x(-round(480*(zoom/2)*exp((zoom-1)*ln (2))));
                  ClearViewPort;
                end;
       '-' : begin
               zoom:=zoom+1;
               ClearViewPort;

             end;
       '=' : begin
               zoom:=zoom-1;
               ClearViewPort;

             end;
       'z':begin
             ClearViewPort;
             OuttextXY(150,10,'What zoom level would you like?');
             response:=readkey;
             val(response,zoom,G);
             ClearViewPort;
             OutTextXY(450,20,'Zoom Factor: ');
             OutTextXY(620,20,response);
           end;
     end;
 SetTextStyle(1,0,2);
 until temp= 'q';
end.
