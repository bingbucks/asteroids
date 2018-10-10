Unit GameUnit; {Citasson Homework #5 - CSE182}

INTERFACE

Uses CRT;


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
    If (abs(l.xval-xval)+abs(l.yval-yval))<d then
      Near:=true
    else
      Near:=false;
  end;

procedure LOCATION.Distance(l:location; var z:location);
  begin
    z.xval:=abs(l.xval-xval);
    z.yval:=abs(l.yval-yval);
  end;

function LOCATION.Distance_x(l:location):integer;
  begin
    Distance_x:=abs(l.xval-xval);
  end;

function LOCATION.Distance_y(l:location):integer;
  begin
    Distance_y:=abs(l.yval-yval);
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
    Velocity.xval:=v.xval;
    Velocity.yval:=(-1)*v.yval;
    xval:=l.xval;
    yval:=l.yval;
    Acceleration.xval:=a.xval;
    Acceleration.yval:=(-1)*a.yval;
    Box.xval:=bx.xval;
    Box.yval:=bx.yval;
    Box.width:=bx.width;
    Box.height:=bx.height;
    last.xval:=bx.xval;
    last.yval:=bx.yval;
  end;

procedure BALL.Bounce_x;
  begin
    velocity.xval:=(-1)*velocity.xval;
  end;

procedure BALL.Bounce_y;
  begin
    velocity.yval:=(-1)*velocity.yval;
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
    If (Velocity.xval<box.width) and (Velocity.yval<box.height) then
     Velocity.Moves_by(Acceleration)
    else
     begin
       Velocity.xval:=velocity.xval-1;
       Velocity.yval:=velocity.yval-1;
     end;

 {   If (xval>box.width) or (yval>box.height) then
      begin
        Acceleration.xval:=0;
        Acceleration.yval:=0;
        Velocity.xval:=velocity.xval-box.width;
        Velocity.yval:=velocity.yval-box.height;
      end;  }

    If not box.Contains(SELF) then
      If (box.Above(SELF)) or (box.Below(SELF)) then
      Bounce_y
    else
      if (box.Left_of(SELF)) or (box.Right_of(SELF)) then
      Bounce_x;
  end;


begin
end.














