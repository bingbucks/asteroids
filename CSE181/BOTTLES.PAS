program bottles; {CITASSON - This progeam will allow you to choose a name
                 of a drink and type in the number of bottles you want}
  var first: integer; name:string; {Holds a place in memory for these
                                   variable}

  {*************************PROCEDURE GETINFO*************************}
  {This procedure gets the name of the drink and the number of bottles
   that the you type in}

   procedure GetInfo(var drink:string; var number:integer);
   begin
     write('Give me a brand of beverage. ');
     read(drink); {Stores info typed in in memory}
     readln;
     write('Give me a number from 1 to 100. ');
     read(number);
     readln;
   end;

   {************************PROCEDURE PRINTINFO***********************}
   {This procedure writes the riddle with the information given above}


  procedure PrintInfo(drink:string; number:integer); {Saves space
                        in memory for these variables}
  begin
    write(number);
    write(' bottles of ');
    write(drink);
    writeln(' on the wall,');
    write(number);
    write(' bottles of ');
    write(drink);
    writeln('.');
    write('If you should drop a bottle of ');
    write(drink);
    writeln(',');
    writeln('You might get hit in the head.');
    write('(and have only ');
    write(number-1);
    write(' bottles of ');
    write(drink);
    writeln(')');
  end;

  {**************************MAIN PROGRAM******************************}
begin
  GetInfo(name,first);   {Runs this procedure to get information}
  PrintInfo(name,first); {Runs this procedure to take info and put it into}
end.                      {the riddle}
