program coins; {Citasson:cse181:This is the name of the program}
  var qtrs, dms, pnys, total:real; {Declares variables, saves a memory spot}

{****************************Procedure GetInfo*****************************}

  procedure GetInfo(var quarters:real; var dimes:real; var pennies:real);
            {Declares these local variables, and a memory spot is saved}
  begin
    write('Enter the number of quarters you have. ');
    read(quarters);  {Puts answer in memory location}
    write('Enter the number of dimes you have. ');
    read(dimes);
    write('Enter the number of pennies you have. ');
    read(pennies);
  end;

{****************************Procedure PrintInfo***************************}

  procedure PrintInfo(quarters:real; dimes:real; pennies:real);
  begin
    write('The dollar amount of quarters is ');
    writeln(quarters*(1/4):15:2);
    write('The dollar amount of dimes is ');
    writeln(dimes*(1/10):18:2);
    write('The dollar amount of pennies is ');
    writeln(pennies*(1/100):16:2);
    total:=(quarters*(1/4))+(dimes*(1/10))+(pennies*(1/100));
    writeln('You have a total of ',total:28:2,' dollars.');
  end;

{****************************MAin Program**********************************}
begin
  GetInfo(qtrs,dms,pnys); {Calls this procedure and this variables are entered}
  PrintInfo(qtrs,dms,pnys); {Calls this procedure and these variables are entered}
end.                              {Prints results}
