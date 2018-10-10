program stuff;
const
  Universe_Max = 100;
type
  ASTEROID = object(BALL)
    mass: integer;
    procedure Display (place: location; zoom_level: integer);
  end;
type
  Asteroid_Pointer = ^ASTEROID;
type
  UNIVERSE = object(BALL)     {Should this inherit stuff from BALL}
    number: integer;
    list = array[1..Universe_Max] of Asteroid_Pointer;
    procedure Create (n: integer);
    procedure Update;
    procedure Display (Place: location; zoom_level: intger);
  private
    procedure Collision (i, j: integer);
  end;


procedure UNIVERSE.Create (n: integer);
var
  i, lx, ly: integer;
  l, v, a: location;
  b: rect;
begin
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
  i: integer;
  VectorX, VectorY: integer;
  F: location;
begin
  for i := 1 to (n - 1) do
    begin
      for j := (i + 1) to n do
        begin
	  if list[i]^.Near(list[j]^, 10) then  {If Manhattan Distance is within 10}
	    begin
	      VectorX := list[i]^.Distance_x(list[j]^);
	      VectorY := list[i]^.Distance_y(list[j]^);
	      while VectorX <> 0 do
	        begin
		  F.xval := Rnd((list[i]^.mass) * (list[j]^.mass) / (VectorX * VectorX));
		end;
	      while VectorY <> 0 do
	        begin
		  F.yval := Rnd((list[i]^.mass) * (list[j].mass) / (VectorY * VectorY));
		end;

	      if list[i]^.xval > list[j]^.xval then
	        begin
		  list[i]^.Acceleration.xval := Rnd(-F.xval / list[i]^.mass) + list[i]^.Acceleration.xval;
		  list[j]^.Acceleration.xval := Rnd(F.xval / list[j]^.mass) + list[j]^.Acceleration.xval;
		end
	      else if list[i]^.xval < list[j]^.xval then
	        begin
		  list[i]^.Acceleration.xval := Rnd(F.xval / list[i]^.mass) + list[i]^.Acceleration.xval;
		  list[j]^.Acceleration.xval := Rnd(-F.xval / list[j]^.mass) + list[j]^.Acceleration.xval;
		end
	      else if list[i]^.xval = list[j]^.xval then
	        begin
	          list[i]^.Acceleration.xval := list[i]^.Acceleration.xval;
		  list[j]^.Acceleration.yval := list[j]^.Acceleration.xval;
		end;

	      if list[i]^.yval > list[j]^.yval then
	        begin
		  list[i]^.Acceleration.yval := Rnd(-F.yval / list[i]^.mass) + list[i]^.Acceleration.yval;
		  list[j]^.Acceleration.yval := Rnd(F.yval / list[j]^.mass) + list[j]^.Acceleration.yval;
		end
	      else if list[i]^.yval < list[j]^.yval then
	        begin
		  list[i]^.Acceleration.yval := Rnd(F.yval / list[i]^.mass) + list[i]^.Acceleration.yval;
		  list[j]^.Acceleration.yval := Rnd(-F.yval / list[j]^.mass) + list[j]^.Acceleration.yval;
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
        list[i]^.Velocity.xval := Rnd(((list[i]^.mass * list[i]^.Velocity.xval) + (list[j]^.mass * list[j]^.Velocity.xval)) / (list[i]^.mass + list[j]^.mass));
	list[i]^.Velocity.yval := Rnd(((list[i]^.mass * list[i]^.Velocity.yval) + (list[j]^.mass * list[j]^.Velocity.yval)) / (list[i]^.mass + list[j]^.mass));
	del(list[j]^);
      end;
  end;

procedure ASTEROID.Display (Place: location, zoom_level: integer);
var
  offsetx, offsety: real;
begin
  offsetx := place.xval - ((40) * exp((zoom_level - 1) * ln(2))) / exp((zoom_level - 1) * ln(2));
  offsety := place.yval - ((12) * exp((zoom_level - 1) * ln(2))) / exp((zoom_level - 1) * ln(2));
  ASTEROID.xval := xval + Rnd(offsetx);
  ASTEROID.yval := yval + Rnd(offsety);
  CRT.GotoXY(Last.xval, Last.yval);
  write(' ');
  CRT.GotoXY(xval, yval);
  write(Display_char);
  Last.make(xval, yval);
end;