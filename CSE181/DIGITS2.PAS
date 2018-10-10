program NumberCount; {Citasson - This is the rewrite to the program that will
                     count the number od digits in the entered integer}
  var n, counter:integer;

  {****************************Function Digits*****************************}

  function digits(n:integer):integer;
  begin
    counter:=0; {Sets counter at zero}
    if n<>0 then {This if then statement is here because of the need of the
                 else statement down below. Both are needed in order to
                 have the number zero work properly}
      begin
        while n<>0 do {If n isn't equal to zero than this will divide it
                      down to the point where it will equal zero and the
                      number of divisions performed equal the number of
                      digits in the integer} 
          begin
            n:=n div 10;
            counter:=counter + 1;
          end;
        digits:=counter;
      end
    else
      digits:=1; {This is for when zero is entered as n}
  end;

  {**************************Main Program*********************************}

begin
  while n<>-1 do {If n isn't entered as -1 than it will keep asking until
                 n is entered as -1}
    begin
      write('Enter any integer. ');
      read(n);
      writeln('This number has ',digits(n):2,' digit(s).');
    end;
end.