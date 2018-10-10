program NumberCount; {Citasson - This program will count the number of digits
                in a number that the user will enter}
  var n:integer; {Stores a memory position}

  {******************************Function Digits**************************}

  function digits(n:integer):integer;
  begin
    if (n>-10) and (n<10) then digits:=1;
    if ((n<=-10) and (n>-100)) or ((n>=10) and (n<100)) then digits:=2;
    if ((n<=-100) and (n>-1000)) or ((n>100) and (n<1000)) then digits:=3;
    if ((n<=-1000) and (n>-10000)) or ((n>1000) and (n<10000)) then digits:=4;
    if ((n<=-10000) and (n>-100000)) or ((n>10000) and (n<100000)) then digits:=5;
  end;

  {******************************Main Program*****************************}

begin
  while n<>-1 do {Until a -1 is enter, the program will keep running}
    begin
      write('Enter an integer. ');
      read(n);
      write('This number has');
      write(digits(n):2);
      writeln(' digit(s).');
    end;
end.