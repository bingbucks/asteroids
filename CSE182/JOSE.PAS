Unit GameUn13; {Citasson Homework #6 - CSE182}

INTERFACE

Uses CRT,GRAPH;

var graphdriver,graphmode:integer;

Const Universe_max=100;
      maxX : longint = 40;
      maxY : longint = 12;
      zoom : longint = 1;

type LOCATION=object
     function x:longint;
     function y:longint;
     function r:real;
     function theta:real;
     procedure Make(x1,y1:longint);
     function Manhattan(l:location):longint;
     function Same(l:location):boolean;
     function Near(l:location;d:longint):boolean;
     procedure Distance(l:location; var z:location);
     function Distance_x(l:location):longint;
     function Distance_y(l:location):longint;
     procedure Moves_by(l:location);
     procedure Incr_x(num:longint);
     procedure Incr_y(num:longint);
     private
       xval,yval:longint;
     end;

type RECT=object(LOCATION)
     function Contains(l:location):boolean;
     function Overlap(re:rect):boolean;
     procedure Make(x1,y1,width1,height1:longint);
     procedure Corners(var ur,lr,ll:location);
     function GetWidth:longint;
     function GetHeight:longint;
     function Above(l:location):boolean;
     function Below(l:location):boolean;
     function Right_of(l:location):boolean;
     function Left_of(l:location):boolean;
     private
       width,height:longint;
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
    mass: longint;
    procedure Display (place: location; zoom_level: longint);
  end;

type
  Asteroid_Pointer = ^ASTEROID;

type
  Asteroid_Array = array[1..Universe_Max] of Asteroid_Pointer;

type
  UNIVERSE = object(BALL)     {Should this inherit stuff from BALL}
    List:Asteroid_Array;
    number: longint;
    procedure Create (n: longint);
    procedure Update;
    procedure Display (Place: location; zoom_level: longint);
  private
    procedure Collision (i, j: longint);
  end;





IMPLEMENTATION

function LOCATION.x:longint;
  begin
    x:=xval;
  end;

function LOCATION.y:longint;
  begin
    y:=yval;
  end;

function LOCATION.r:real;
  begin
    r:=sqrt(longint(xval)*longint(xval)+longint(yval)*longint(yval));
  end;

function LOCATION.Theta:real;
  var Quadrant:longint;
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

procedure LOCATION.Make(x1,y1:longint);
  begin
    xval:=x1;
    yval:=y1;
  end;

function LOCATION.Manhattan(l:location):longint;
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

function LOCATION.Near(l:location;d:longint):boolean;
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

function LOCATION.Distance_x(l:location):longint;
  begin
    Distance_x:=(l.xval-xval);
  end;

function LOCATION.Distance_y(l:location):longint;
  begin
    Distance_y:=(l.yval-yval);
  end;

procedure LOCATION.Moves_by(l:location);
  begin
    xval:=xval+l.xval;
    yval:=yval+l.yval;

  end;

procedure LOCATION.Incr_x(num:longint);
  begin
    xval:=xval+num;
  end;

procedure LOCATION.Incr_y(num:longint);
  begin
    yval:=yval+num;
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

procedure RECT.Make(x1,y1,width1,height1:longint);
  begin
    xval:=x1;
    yval:=y1;
    width:=width1;
    height:=height1;
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

function RECT.GetWidth:longint;
  begin
    GetWidth:=width;
  end;

function RECT.GetHeight:longint;
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
  end;

procedure BALL.Bounce_x;
  begin
  end;

procedure BALL.Bounce_y;
  begin
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
    Last.make(Xval,Yval);
    Moves_by(Velocity);
    Velocity.moves_by(acceleration);

   { If not box.contains(SELF) then
           If (box.Above(SELF)) or (box.Below(SELF)) then
             Bounce_y
         else
           if (box.Left_of(SELF)) or (box.Right_of(SELF)) then
             Bounce_x; }
  end;


procedure UNIVERSE.Create (n: longint);
var
  i, lx, ly, vx, vy, ax, ay: longint;
  l, v, a: location;
  b: rect;
begin
number:=n;
for i := 1 to number do
  begin
    new(list[i]);
    with list[i]^ do
      begin
        mass:=1;
        ly:=0;
        lx := 30*(i-1);
        vx:=(1-i);
        vy:=0;
        ax:=0;
        ay:=0;
	l.make(lx, ly);
	v.make(vx, vy);
	a.make(ax, ay);
	b.make(-32000,24000,64000,48000);
	make(l, v, a, b);
      end;
    end;
end;

procedure UNIVERSE.Display (Place: location; zoom_level: longint);
var
  i: longint;
begin
  for i := 1 to number do          {Doesn't this need to be n?}
  list[i]^.Display(Place, zoom_level);
end;

procedure UNIVERSE.Update; {Calculates the new acceleration due to the
                           gravitational forces between two asteroids}
var
  i,j: longint;
  vector : location;
  F: location;
  rad :real;
begin
  for i := 1 to (number - 1) do
    begin
      for j := (i + 1) to number do
        begin

	  if list[i]^.Near(list[j]^, 1000) then  {If Manhattan Distance is within 10}
	    begin
   {     list[i]^.distance(list[j]^,vector);
         rad := (vector.xval * vector.xval + vector.yval*vector.yval);
   list[i]^.Acceleration.xval := Round((list[j]^.mass/rad) * (vector.xval/sqrt(rad)) + list[i]^.Acceleration.xval);
   list[i]^.Acceleration.yval := Round((list[i]^.mass/rad) * (-vector.yval/sqrt(rad)) + list[i]^.Acceleration.xval);
   list[i]^.Acceleration.xval := Round((list[j]^.mass/rad) * (vector.yval/sqrt(rad)) + list[i]^.Acceleration.xval);
   list[i]^.Acceleration.yval := Round((list[i]^.mass/rad) * (-vector.yval/sqrt(rad)) + list[i]^.Acceleration.xval);
   }
	    end;

	    UNIVERSE.Collision(i, j);

        end;   {Inner Loop}
    end;   {Outer Loop}

          for i:=1 to number do
            begin
              list[i]^.Up_Date;       {BALL.Up_Date}
            end;
end;  {Procedure}

procedure UNIVERSE.Collision (i, j: longint);
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
      end;
  end;


procedure ASTEROID.Display (Place: location; zoom_level: longint);
var
  DisplayX,DisplayY,LastUnX,LastUnY:longint;
begin
  MaxX:=round(320*exp((zoom-1)*ln(2)));
  MaxY:=round(240*exp((zoom-1)*ln(2)));
  DisplayX:=round((MaxX+xval-Place.xval)/exp((zoom_level-1)*ln(2)));
  DisplayY:=round((MaxY+yval-Place.yval)/exp((zoom_level-1)*ln(2)));
  LastUnX:=round((MaxX+Last.xval-Place.xval)/exp((zoom_level-1)*ln(2)));
  LastUnY:=round((MaxY+Last.yval-Place.yval)/exp((zoom_level-1)*ln(2)));

  If (DisplayX>=0) and (DisplayX<=640) and (DisplayY>=0) and (DisplayY<=480) then
    begin
      setcolor(0);
      CIRCLE(LastUnX,LastUnY,round(mass/(exp(zoom_level-1)*ln(2))));
      setcolor(7);
      CIRCLE(DisplayX,DisplayY,round(mass/(exp(zoom_level-1)*ln(2))));
    end;
{  else
  if (DisplayX<0) or (DisplayX>640) and (DisplayY<0) or (DisplayY>480) then
    begin
     setcolor(0);
     CIRCLE(LastUnx,LastUnY,round(mass/(exp(zoom_level-1)*ln(2))));
     setcolor(7);
    end;}
end;


begin

 Graphdriver:=Detect;
 Initgraph(Graphdriver,Graphmode,'C:');
 Cleardevice;
 System.Randomize;
end.














