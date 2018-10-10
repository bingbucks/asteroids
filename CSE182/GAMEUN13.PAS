Unit FinalExam; {Citasson Final Exam Unit - CSE182}

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

function LOCATION.x:longint;   {Gives x location}
  begin
    x:=xval;
  end;

function LOCATION.y:longint;   {Gives y location}
  begin
    y:=yval;
  end;

function LOCATION.r:real;      {Gives radial distance}
  begin
    r:=sqrt(longint(xval)*longint(xval)+longint(yval)*longint(yval));
  end;

function LOCATION.Theta:real;  {Gives the angle}
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

procedure LOCATION.Make(x1,y1:longint);  {Makes a location}
  begin
    xval:=x1;
    yval:=y1;
  end;

function LOCATION.Manhattan(l:location):longint;    {Gives Manhattan distance}
  begin
    Manhattan:=Abs(l.xval-xval)+Abs(l.yval-yval);
  end;

function LOCATION.Same(l:location):boolean;  {Returns boolean if locations are equal}
  begin
    If (xval=l.xval) and (yval=l.yval) then
      Same:=true
    else
      Same:=false
  end;

function LOCATION.Near(l:location;d:longint):boolean;   {Returns a boolean if locations are within d of each other}
  begin
    If (LOCATION.Manhattan(l)<=d) and ((abs(l.xval-xval)+abs(l.yval-yval))<>0) then
      Near:=true
    else
      Near:=false;
  end;

procedure LOCATION.Distance(l:location; var z:location);  {Returns distance in location form}
  begin
    z.xval:=(l.xval-xval);
    z.yval:=(l.yval-yval);
  end;

function LOCATION.Distance_x(l:location):longint;  {Gives x distance between two locations}
  begin
    Distance_x:=(l.xval-xval);
  end;

function LOCATION.Distance_y(l:location):longint;  {Gives y distance}
  begin
    Distance_y:=(l.yval-yval);
  end;

procedure LOCATION.Moves_by(l:location);  {Adds l to LOCATION}
  begin
    xval:=xval+l.xval;
    yval:=yval+l.yval;
  end;

procedure LOCATION.Incr_x(num:longint);   {Mainly used for SPOT, increments SPOT.xval by num}
  begin
    xval:=xval+num;
  end;

procedure LOCATION.Incr_y(num:longint);   {Increments SPOT.yval by num}
  begin
    yval:=yval+num;
  end;

function RECT.Contains(l:location):boolean;  {Returns boolean concerning the location of LOCATION relative to the RECT}
  begin
    If (l.xval>xval) and (l.xval<(xval+width)) and
       (l.yval>yval) and (l.yval<(yval+height)) then
    Contains:=true
    else
    Contains:=false;
  end;

function RECT.Overlap(re:rect):boolean;   {Returns boolean concerning the overlapping of two RECT's}
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

procedure RECT.Make(x1,y1,width1,height1:longint);  {Makes a RECT, with desired starting corner and width and height}
  begin
    xval:=x1;
    yval:=y1;
    width:=width1;
    height:=height1;
  end;

procedure RECT.Corners(var ur,lr,ll:location);  {Returns to value of the RECT's corners}
  begin
    ur.xval:=xval+width;
    ur.yval:=yval;
    lr.xval:=ur.xval;
    lr.yval:=ur.yval+height;
    ll.xval:=xval;
    ll.yval:=yval+height;
  end;

function RECT.GetWidth:longint; {Returns width of RECT}
  begin
    GetWidth:=width;
  end;

function RECT.GetHeight:longint; {Returns height of RECT}
  begin
    GetHeight:=height;
  end;

function RECT.Above(l:location):boolean;  {Returns boolean on whether or not RECT is above l}
  begin
    If(yval+height)<l.yval then
    Above:=true
  else
    Above:=false;
  end;

function RECT.Below(l:location):boolean;  {Is RECT below l?}
  begin
    If yval>l.yval then
    Below:=true
  else
    Below:=false
  end;

function RECT.Right_of(l:location):boolean;  {Is RECT to the right of l?}
  begin
    If xval>l.xval then
    Right_of:=true
  else
    Right_of:=false
  end;

function RECT.Left_of(l:location):boolean;   {Is RECT to the left of l?}
  begin
    If (xval+width)<l.xval then
    Left_of:=true
  else
    Left_of:=false;
  end;



procedure BALL.Make(l,v,a:location; bx:rect);  {Puts the BALL in the RECT}
  begin
    LAST := L;
    Velocity:=v;
    xval:=l.xval;
    yval:=l.yval;
    Acceleration:=a;
    Box:=bx;
    Box.width:=bx.width;
    Box.height:=bx.height;
  end;

procedure BALL.Bounce_x; {Bounce the ball's x velocity}
  begin
    velocity.xval:=velocity.xval;
    LOCATION.make(last.xval,last.yval);
  end;

procedure BALL.Bounce_y; {Bounce the ball's y velocity}
  begin
    velocity.yval:=velocity.yval;
    LOCATION.make(last.xval,last.yval);
  end;

procedure BALL.Display;  {Display the ball}
  begin
    CRT.GotoXY(last.xval,last.yval);
    write(' ');
    CRT.GotoXY(xval,yval);
    write(display_char);
    last.Make(xval,yval);
  end;

procedure BALL.Up_Date;  {Update the ball's parameters}
  begin
    Moves_by(Velocity);
    Velocity.moves_by(acceleration);
                         {If the ball is out of the box bounce it}
   { If not box.contains(SELF) then
       If (box.Above(SELF)) or (box.Below(SELF)) then
         Bounce_y
     else
       if (box.Left_of(SELF)) or (box.Right_of(SELF)) then
         Bounce_x; }
  end;


procedure UNIVERSE.Create (n: longint);  {Create the universe with n asteroids}
var
  i, lx, ly, vx, vy, ax, ay: longint;
  l, v, a: location;
  b: rect;
begin
number:=n;
for i := 1 to number do
  begin
    new(list[i]);  {Create a new memory location}
    with list[i]^ do
      begin
        mass:=random(8);  {Gives the asteroid random parameters}
        lx:={30*(1-i);} random(640);
        ly:=random(480);
        vx:={-1*(1-i);}random(0);
        vy:=random(0);
        ax:=random(0);
        ay:=random(0);
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
begin                       {Diaplays the asteroids in the universe}
  for i := 1 to number do   {by calling ASTEROID.Display}       
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
	  if list[i]^.Near(list[j]^, 100) then  {If the asteroids are within 100, then they exert gravity on one another}
	    begin
              list[i]^.distance(list[j]^,vector);
              rad := (vector.xval*vector.xval + vector.yval*vector.yval);
              list[i]^.Acceleration.xval := (Round((list[j]^.mass/(rad/100))*
                       (vector.xval/sqrt(rad))+list[i]^.Acceleration.xval));
              list[i]^.Acceleration.yval := (Round((list[j]^.mass/(rad/100))*
                       (vector.yval/sqrt(rad))+list[i]^.Acceleration.yval));
              list[j]^.Acceleration.xval :=-(Round((list[i]^.mass/(rad/100))*
                       (vector.xval/sqrt(rad))+list[j]^.Acceleration.xval));
              list[j]^.Acceleration.yval :=-(Round((list[i]^.mass/(rad/100))*
                       (vector.yval/sqrt(rad))+list[j]^.Acceleration.yval));
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

{If two asteroids collide then momentum is conserved in a perfectly inelastic collision}
  begin
    if list[i]^.Same(list[j]^) then  {If i and j have the same location, they have collided}
      begin
        list[i]^.Velocity.xval := Round(((list[i]^.mass * list[i]^.Velocity.xval) + (list[j]^.mass * list[j]^.Velocity.xval))
                                  / (list[i]^.mass + list[j]^.mass));
	list[i]^.Velocity.yval := Round(((list[i]^.mass * list[i]^.Velocity.yval) + (list[j]^.mass * list[j]^.Velocity.yval))
                                  / (list[i]^.mass + list[j]^.mass));
	Dispose(list[j]);   {Disposes one asteroid, since the two that collided are now one}
        list[j]:=list[number];
        number:=number-1;   {Reduce the number of asteroids, since one was just disposed}
      end;
  end;


procedure ASTEROID.Display (Place: location; zoom_level: longint);
var
  DisplayX,DisplayY,LastUnX,LastUnY:longint;
begin
  MaxX:=round(320*exp((zoom-1)*ln(2)));  {MaxX and MaxY change exponentially with the zoom level}
  MaxY:=round(240*exp((zoom-1)*ln(2)));

  DisplayX:=round((MaxX+xval-Place.xval)/exp((zoom_level-1)*ln(2)));
  {Maps the asteroids x and y values in order to be displayed on the screen}
  DisplayY:=round((MaxY+yval-Place.yval)/exp((zoom_level-1)*ln(2)));

  LastUnX:=round((MaxX+Last.xval-Place.xval)/exp((zoom_level-1)*ln(2)));
  {Remembers the last values of the asteroid in order to eraese it}
  LastUnY:=round((MaxY+Last.yval-Place.yval)/exp((zoom_level-1)*ln(2)));

  setcolor(0);   {Sets color to black, in order to erase the last position}
  CIRCLE(Last.X,Last.Y,round(mass/(exp(zoom_level-1)*ln(2))));  {Erases the last position of the asteroid}
  If (DisplayX>=0) and (DisplayX<=640) and (DisplayY>=0) and (DisplayY<=480) then
    begin
                   {If the new mapped positions of the asteroid are within the sreen dimensions, 640x480,
                    then the asteroid will be displayed}
      setcolor(7); {Set the color to whit in order to show the asteroid}
      CIRCLE(DisplayX,DisplayY,round(mass/(exp(zoom_level-1)*ln(2))));  {Display the white asteroid}
      LAST.MAKE(DISPLAYX,DISPLAYY);  {Makes displayX and displayY the new last values}
    end;
end;


begin

 Graphdriver:=Detect;  {Detect the graphics mode of the terminal the program is being used on}
 Initgraph(Graphdriver,Graphmode,'C:');  {Initializes the graphics mode}
 ClearViewPort;                          {Clears the screen}
 System.Randomize;                       {Randomizes the system}
end.                                     {Ends the UNIT}














