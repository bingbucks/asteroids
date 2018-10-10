program averages; {Citasson.HW5 - This program will find the Arithematic,
                  Geometric, and Harmonic means of two numbers}
  var x,y,AM,GM,HM:real; {Declares a memory position for these values}

  {**************************GetInfo**************************************}

  procedure GetInfo (var num1,num2:real);
  begin
    write('Enter a value for x. ');
    read(num1);
    write('Enter a value for y. ');
    read(num2);
  end;

  {**************************Calculate************************************}

  procedure Calculate(num1,num2:real);
    function Amean(x1,x2:real):real;
    begin
      Amean:=(x1+x2)/2
    end;
    function Gmean(x3,x4:real):real;
    begin
      Gmean:=sqrt(x3*x4);
    end;
    function Hmean(x5,x6:real):real;
    begin
      Hmean:=((1/x5)+(1/x6))/2;
    end;
  begin
    AM:=Amean(num1,num2);
    GM:=Gmean(num1,num2);
    HM:=Hmean(num1,num2);
  end;

  {******************************PrintInfo********************************}

  procedure PrintInfo (num1,num2,Amean,Gmean,Hmean:real);
  begin
    write('The Arithmatic average of x and y is ');
    writeln(AM:2:3);
    write('The Geometric average of x and y is ');
    writeln(GM:2:3);
    write('The Harmonic average of x and y is ');
    writeln(HM:2:3);
  end;
begin
  GetInfo(x,y); {Calls the procedure GetInfo and enters the appropriate values}
  Calculate(x,y);
  PrintInfo(x,y,AM,GM,HM);
end.
