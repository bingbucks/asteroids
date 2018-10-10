Program GameTest; {Citasson HW#5 - CSE182}

uses GameUni7,CRT;

var loc,loc2,vel,vel2,acc,acc2,upr,lwr,lwl,dis:location;
    R1,R2:rect;
    B1,B2:ball;
    Fileout:text;
    D:integer;
begin
  Assign(Fileout,'Loc_#s');
  rewrite(Fileout);

  CRT.ClrScr;
  CRT.Textcolor(CRT.Yellow);
  R1.make(2,2,70,20);  {2,2,70,20}
  {R2.make(21,1,10,10);}
  loc.make(30,12); 
  vel.make(1,1);
  acc.make(0,0);
  {loc2.make(25,4);
  vel2.make(2,1);
  acc2.make(1,9);}
  B1.make(loc,vel,acc,R1);
  {B2.make(loc2,vel2,acc2,R2);}
  B1.display_char:='@';
  {B2.display_char:='$';}
  repeat
    B1.Up_Date;
    {B2.Up_Date; }
    B1.Display;
   { B2.Display; }
    delay(50);
  {  Write(Fileout,B1.x);  write(Fileout,' ');}  {This is to follow the}
  {  Write(Fileout,B1.y);  write(Fileout,'  ');} {location of the ball}
  until CRT.keypressed;
  {D:=(b1.manhattan(b2));
  writeln(b1.same(b2));
  writeln(b1.near(b2,D));
  writeln(b1.Distance_x(b2));
  writeln(b1.Distance_y(b2));
  writeln(R1.GetWidth);
  writeln(R1.GetHeight);
  R1.corners(upr,lwr,lwl);
  write(upr.x); writeln(upr.y);
  write(lwr.x); writeln(lwr.y);
  write(lwl.x); writeln(lwl.y);
  b1.distance(b2,dis);
  writeln(dis.x);
  writeln(dis.y);
  Write(r1.overlap(r2));}
end.