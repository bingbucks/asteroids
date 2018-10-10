unit fraction; {Citasson.hw9 - This unit contains four prodecures and one
               function that will perform certain mathematical calculations}

interface

  procedure AddFrac (a,b,c,d:integer; var x,y:integer);
  procedure SubFrac (a,b,c,d:integer; var x,y:integer);
  procedure MultFrac(a,b,c,d:integer; var x,y:integer);
  procedure DivFrac (a,b,c,d:integer; var x,y:integer);
  function Gcd (x,y:longint):longint;

implementation

  Function Gcd;            (*This function takes an input of two numbers
                           and finds their greatest common divisor using
                           Euclids algorithm. The GCD value is returned
                           to the main program through the function. *)
  var r: integer;          (* used to store the remainder *)
  begin
  x:=abs(x);
  y:=abs(y);
   If (x=0) or (y=0) then
     begin
       if x=0 then
         GCD:=y
       else
         GCD:=x
     end
   else
   begin
    GCD :=1;               (* set value to 1 in case thats the GCD *)
     while y > 1 do        (* Repeat following until GCD is found or until *)
       begin               (* the GCD is 1 *)
         r := x mod y;     (* remainder when x is divided by y *)
           if r <> 0 then  (* if r is 0 we're done, otherwise *)
             begin         (* exchange values and do it again *)
               x :=y;
               y :=r
             end           (* end of then *)
           else
             begin
               GCD :=y;
               y :=1
             end;          (* end of if *)
       end;                (* end of while *)
   end;                    (* end of else for x,y not zero *)
  end;                     (* end of function Gcd *)

  procedure AddFrac;
  begin
    x:=(a*d)+(b*c);
    y:=(b*d);
    writeln(x,y);
  end;

  procedure SubFrac;
  begin
    x:=(a*d)-(b*c);
    y:=(b*d);
    writeln(x,y);
  end;

  procedure MultFrac;
  begin
    x:=a*c;
    y:=b*d;
    writeln(x,y);
  end;

  procedure DivFrac;
  begin
    x:=a*d;
    y:=b*c;
    writeln(x,y);
  end;
end.

