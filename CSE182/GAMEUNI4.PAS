Unit GameUni4; {Citasson Homework #6 - CSE182}

INTERFACE

Uses CRT;

Const Universe_max=100;

type LOCATION=object
     function x:integer;
     function y:integer;
     function r:real;
     function theta:real;
     procedure Make(x1,y1:integer);
     function Manhattan(l:location):integer;
     function Same(l:location):boolean;
     function Near(l:location;d:integer):boolean;
     procedure Distance(l:location; var z:location);
     function Distance_x(l:location):integer;
     function Distance_y(l:location):integer;
     procedure Moves_by(l:location);
     private
       xval,yval:integer;
     end;

type RECT=object(LOCATION)
     function Contains(l:location):boolean;
     function Overlap(re:rect):boolean;
     procedure Make(x1,y1,width1,height1:integer);
     procedure Corners(var ur,lr,ll:location);
     function GetWidth:integer;
     function GetHeight:integer;
     function Above(l:location):boolean;
     function Below(l:location):boolean;
     function Right_of(l:location):boolean;
     function Left_of(l:location):boolean;
     private
       width,height:integer;
     end;

type BALL=object(LOCATION)
     display_char:char;
     procedure make(l,v,a:location; bx:rect);
     procedure Bounce_x;
     procedure Bounce_y;
     procedure Up_Date;
     procedure Display;
     private
       velocity,acceleration:location;
       box:rect;
       last:location;
     end;


type
  ASTEROID = object(BALL)
    mass: integer;
    procedure Display (place: location; zoom_level: integer);
  end;

type
  Asteroid_Pointer = ^ASTEROID;

type
  Asteroid_Array = array[1..Universe_Max] of Asteroid_Pointer;

type
  UNIVERSE = object(BALL)     {Should this inherit stuff from BALL}
    List:Asteroid_Array;
    number: integer;
    procedure Create (n: integer);
    procedure Update;
    procedure Display (Place: location; zoom_level: integer);
  private
    procedure Collision (i, j: integer);
  end;





IMPLEMENTATION

function LOCATION.x:integer;
  begin
    x:=xval;
  end;

function LOCATION.y:integer;
  begin
    y:=yval;
  end;

function LOCATION.r:real;
  begin
    r:=sqrt(longint(xval)*longint(xval)+longint(yval)*longint(yval));
  end;

function LOCATION.Theta:real;
  var Quadrant:integer;
      temp:real;
  begin
    If(xval>0) and (yval>0) then Quadrant:=1
    else
    if (xval<0) and (yval>0) then Quadrant:=2
    else
    if (xval<0) and (yval<0) then Quadrant:=3
    else
    if (xval>0) and (yval<0) then Quadrant:=4;

    If xval<>0 then temp:=arctan(yval/xval)
    else
    if (xval=0) and (yval>0) then theta:=pi/2
    else
    if (xval=0) and (yval<0) then theta:=3*pi/2
    else
    if (xval>0) and (yval=0) then theta:=0
    else
    if (xval<0) and (yval=0) then theta:=pi
    else
    if (xval=0) and (yval=0) then theta:=0;

    case Quadrant of
      1: theta:=temp;
      2,3: theta:=temp+pi;
      4: theta:=2*pi+temp;
    end;
  end;

procedure LOCATION.Make(x1,y1:integer);
  begin
    xval:=x1;
    yval:=y1;
  end;

function LOCATION.Manhattan(l:location):integer;
  begin
    Manhattan:=Abs(l.xval-xval)+Abs(l.yval-yval);
  end;

function LOCATION.Same(l:location):boolean;
  begin
    If (xval=l.xval) and (yval=l.yval) then
      Same:=true
    else
      Same:=false
  end;

function LOCATION.Near(l:location;d:integer):boolean;
  begin
    If (LOCATION.Manhattan(l)<=d) and ((abs(l.xval-xval)+abs(l.yval-yval))<>0) then
      Near:=true
    else
      Near:=false;
  end;

procedure LOCATION.Distance(l:location; var z:location);
  begin
    z.xval:=(l.xval-xval);
    z.yval:=(l.yval-yval);
  end;

function LOCATION.Distance_x(l:location):integer;
  begin
    Distance_x:=(l.xval-xval);
  end;

function LOCATION.Distance_y(l:location):integer;
  begin
    Distance_y:=(l.yval-yval);
  end;

procedure LOCATION.Moves_by(l:location);
  begin
    xval:=xval+l.xval;
    yval:=yval+l.yval;

  end;



function RECT.Contains(l:location):boolean;
  begin
    If (l.xval>xval) and (l.xval<(xval+width)) and
       (l.yval>yval) and (l.yval<(yval+height)) then
    Contains:=true
    else
    Contains:=false;
  end;

function RECT.Overlap(re:rect):boolean;
  var UpRightC,LoRightC,LoLeftC:location;
  begin
    re.Corners(UpRightC,LoRightC,LoLeftC);
    If (UpRightC.xval >= xval) and (UpRightC.xval <= (xval+width)) and
       (UpRightC.yval >= yval) and (UpRightC.yval <= (yval+height)) then
    Overlap:=true
    else
    if (LoRightC.xval>=xval) and (LoRightC.xval<=(xval+width)) and
       (LoRightC.yval>=yval) and (LoRightC.yval<=(yval+height)) then
    Overlap:=true
    else
    if (LoLeftC.xval>=xval) and (LoLeftC.xval<=(xval+width)) and
       (LoLeftC.yval>=yval) and (LoLeftC.yval<=(yval+height)) then
    Overlap:=true
    else
    if (re.xval>=xval) and (re.xval<=(xval+width)) and
       (re.yval>=yval) and (re.yval<=(yval+height)) then
    Overlap:=true
    else
    Overlap:=false;
  end;

procedure RECT.Make(x1,y1,width1,height1:integer);
  begin
    xval:=x1;
    yval:=y1;
    width:=width1;
    height:=height1;
    CRT.GotoXY((xval+width),yval); write('C');
    CRT.GotoXY((xval+width),(yval+height)); write('C');
    CRT.GotoXY(xval,(yval+height)); write('C');
    CRT.GotoXY(xval,yval); write('C');
  end;

procedure RECT.Corners(var ur,lr,ll:location);
  begin
    ur.xval:=xval+width;
    ur.yval:=yval;
    lr.xval:=ur.xval;
    lr.yval:=ur.yval+height;
    ll.xval:=xval;
    ll.yval:=yval+height;
  end;

function RECT.GetWidth:integer;
  begin
    GetWidth:=width;
  end;

function RECT.GetHeight:integer;
  begin
    GetHeight:=height;
  end;

function RECT.Above(l:location):boolean;
  begin
    If(yval+height)<l.yval then
    Above:=true
  else
    Above:=false;
  end;

function RECT.Below(l:location):boolean;
  begin
    If yval>l.yval then
    Below:=true
  else
    Below:=false
  end;

function RECT.Right_of(l:location):boolean;
  begin
    If xval>l.xval then
    Right_of:=true
  else
    Right_of:=false
  end;

function RECT.Left_of(l:location):boolean;
  begin
    If (xval+width)<l.xval then
    Left_of:=true
  else
    Left_of:=false;
  end;



procedure BALL.Make(l,v,a:location; bx:rect);
  begin
    Velocity:=v;
    xval:=l.xval;
    yval:=l.yval;
    Acceleration:=a;
    Box:=bx;
    Box.width:=bx.width;
    Box.height:=bx.height;
    last.xval:=bx.xval+1;
    last.yval:=bx.yval+1;
    {iF BOX NOT CONTAINS BALL, THEN START BALL IN BOX LOOP}
  end;

procedure BALL.Bounce_x;
  begin
    velocity.xval:=(-1)*velocity.xval;
    LOCATION.make(last.xval,last.yval);
  end;

procedure BALL.Bounce_y;
  begin
    velocity.yval:=(-1)*velocity.yval;
    LOCATION.Make(last.xval,last.yval);
  end;

procedure BALL.Display;
  begin
    CRT.GotoXY(last.xval,last.yval);
    write(' ');

    CRT.GotoXY(xval,yval);
    write(display_char);
    last.Make(xval,yval);
  end;

procedure BALL.Up_Date;
  begin
    Moves_by(Velocity);
    Velocity.moves_by(acceleration);
     If not box.contains(SELF) then
           If (box.Above(SELF)) or (box.Below(SELF)) then
             Bounce_y
         else
           if (box.Left_of(SELF)) or (box.Right_of(SELF)) then
             Bounce_x;
  end;


procedure UNIVERSE.Create (n: integer);
var
  i, lx, ly: integer;
  l, v, a: location;
  b: rect;
begin
number:=n;
for i := 1 to n do
  begin
    new(list[i]);
    with list[i]^ do
      begin
        mass := random(100) + 1;
	lx := random(10000) - 5000;
	ly := random(10000) - 5000;
	l.make(lx, ly);
	v.make(0, 0);
	a.make(0, 0);
	b.make(-5000, 5000, 10000, 10000);
	make(l, v, a, b);
	writeln('Asteroid ', i, ' ', mass, ' ', lx, ' ', ly);
      end;
    end;
end;

procedure UNIVERSE.Display (Place: location; zoom_level: integer);
var
  i: integer;
begin
  for i := 1 to number do          {Doesn't this need to be n?}
  list[i]^.Display(Place, zoom_level);
end;

procedure UNIVERSE.Update;
var
  i,j: integer;
  VectorX, VectorY: integer;
  F: location;
begin
  for i := 1 to (number - 1) do
    begin
      for j := (i + 1) to number do
        begin
	  if list[i]^.Near(list[j]^, 10) then  {If Manhattan Distance is within 10}
	    begin
	      VectorX := list[i]^.Distance_x(list[j]^);
	      VectorY := list[i]^.Distance_y(list[j]^);
	      while VectorX <> 0 do
	        begin
		  F.xval := Round((list[i]^.mass) * (list[j]^.mass) / (VectorX * VectorX));
		end;
	      while VectorY <> 0 do
	        begin
		  F.yval := Round((list[i]^.mass) * (list[j]^.mass) / (VectorY * VectorY));
		end;

	      if list[i]^.xval > list[j]^.xval then
	        begin
		  list[i]^.Acceleration.xval := Round(-F.xval / list[i]^.mass) + list[i]^.Acceleration.xval;
		  list[j]^.Acceleration.xval := Round(F.xval / list[j]^.mass) + list[j]^.Acceleration.xval;
		end
	      else if list[i]^.xval < list[j]^.xval then
	        begin
		  list[i]^.Acceleration.xval := Round(F.xval / list[i]^.mass) + list[i]^.Acceleration.xval;
		  list[j]^.Acceleration.xval := Round(-F.xval / list[j]^.mass) + list[j]^.Acceleration.xval;
		end
	      else if list[i]^.xval = list[j]^.xval then
	        begin
	          list[i]^.Acceleration.xval := list[i]^.Acceleration.xval;
		  list[j]^.Acceleration.yval := list[j]^.Acceleration.xval;
		end;

	      if list[i]^.yval > list[j]^.yval then
	        begin
		  list[i]^.Acceleration.yval := Round(-F.yval / list[i]^.mass) + list[i]^.Acceleration.yval;
		  list[j]^.Acceleration.yval := Round(F.yval / list[j]^.mass) + list[j]^.Acceleration.yval;
		end
	      else if list[i]^.yval < list[j]^.yval then
	        begin
		  list[i]^.Acceleration.yval := Round(F.yval / list[i]^.mass) + list[i]^.Acceleration.yval;
		  list[j]^.Acceleration.yval := Round(-F.yval / list[j]^.mass) + list[j]^.Acceleration.yval;
		end
	      else if list[i]^.yval = list[j]^.yval then
	        begin
		  list[i]^.Acceleration.yval := list[i]^.Acceleration.yval;
		  list[j]^.Acceleration.yval := list[j]^.Acceleration.yval;
		end;
	    end;

	    UNIVERSE.Collision(i, j);

	    with list[i]^ do
	      begin
	        Moves_by(Velocity);
		Velocity.Moves_by(Acceleration);
	      end;
	    with list[j]^ do
	      begin
	        Moves_by(Velocity);
		Velocity.Moves_by(Acceleration);
	      end;
	  end;
      end;
  end;

procedure UNIVERSE.Collision (i, j: integer);
  begin
    if list[i]^.Same(list[j]^) then
      begin
        list[i]^.Velocity.xval := Round(((list[i]^.mass * list[i]^.Velocity.xval) + (list[j]^.mass * list[j]^.Velocity.xval))
                                  / (list[i]^.mass + list[j]^.mass));
	list[i]^.Velocity.yval := Round(((list[i]^.mass * list[i]^.Velocity.yval) + (list[j]^.mass * list[j]^.Velocity.yval))
                                  / (list[i]^.mass + list[j]^.mass));
	Dispose(list[j]);
        list[j]:=list[number];
        number:=number-1;
        {WHAT ABOUT LIST[I]^ COLLIDING WITH NEW LIST[J]^}
      end;
  end;


procedure ASTEROID.Display (Place: location; zoom_level: integer);
var
  offsetx, offsety: real;
begin
  offsetx := place.xval - ((40) * exp((zoom_level - 1) * ln(2))) / exp((zoom_level - 1) * ln(2));
  offsety := place.yval - ((12) * exp((zoom_level - 1) * ln(2))) / exp((zoom_level - 1) * ln(2));
  xval := xval + Round(offsetx);
  yval := yval + Round(offsety);
  CRT.GotoXY(Last.xval, Last.yval);
  write(' ');
  CRT.GotoXY(xval, yval);
  write(Display_char);
  Last.make(xval, yval);
end;

begin
end.














