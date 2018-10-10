program industry; {Citasson.hw6 This program will calculate the price of
                  gas or electricity used}
  var GoE:string;
      m1,m2:real;
  {*****************************Function Gas********************************}
  function gas(x1,x2:real):real; {Declares function to be used later}
    var x3:real;
  begin
    x3:=abs(x2-x1); {Absolute value, just in case readings are inputted wrong}
    if x3<=31 then
      begin
        gas:=(x3*0.50403)
      end;
    if x3>31 then
      begin
        gas:=((31*0.50403)+((x3-31)*0.82421))
      end;
  end;
  {*****************************Function Electric***************************}
  function electric(x1,x2:real):real; {Declares function to be used later}
    var x3:real;
  begin
    x3:=abs(x2-x1);
    if x3<=238.7 then
      begin
        electric:=(x3*0.10294)
      end;
    if x3>238.7 then
      begin
        electric:=((238.7*0.10294)+((x3-238.7)*0.13682));
      end;
  end;
  {****************************Procedure Calculate**************************}
  procedure Calculate(GoE:string); {Declare procedure to determine gas or electricity}
  begin
    if (GoE='G') or (GoE='g') then
      begin
        write('What is the first meter reading? ');
        readln(m1);
        write('What is the second meter reading? ');
        readln(m2);
        write('The cost of gas is $');
        writeln(gas(m1,m2):5:2);
      end;
    if (GoE='E') or (GoE='e') then
      begin
        write('What is the first meter reading? ');
        readln(m1);
        write('What is the second meter reading? ');
        readln(m2);
        write('The cost of electricity is $');
        writeln(electric(m1,m2):5:2);
      end;
  end;
  {****************************Main Program*********************************}
begin
  write('Will this be a (G)as or an (E)lectric reading? ');
  readln(GoE);
  Calculate(GoE)
end.

