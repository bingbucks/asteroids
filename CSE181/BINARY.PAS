program FileofaxSearch; {Citasson-HW13 - This program will search a binary
                        file for the record of the person,phone number,or
                        area code that you enter. It will then print the
                        complete record of the person on the screen}
  type
    Nametype=record
      first:string[10];
      last:string[15];
    end;
    Staddress=string[20];
    Location=record
      City:string{18};
      Zip:integer;
    end;
    Phone=array[1..3]of integer;
    Entrytype=record
      Name:nametype;
      Address:Staddress;
      Place:Location;
      Number:Phone;
    end;

  var
    TheEntry:Entrytype;
    Response:char;
    infile:file of Entrytype;
    Surname:string[15];
    Areacode:integer;
    FinalFour:integer;

  Procedure NameSearch(TheLastName:string);
  begin
    while not Eof(infile) do
      begin
        read(infile,TheEntry);
        if TheEntry.Name.Last=TheLastName then
          begin
            write(TheEntry.Name.First);
            write(TheEntry.Name.Last);
            write(TheEntry.Address);
            write(TheEntry.Place.City);
            write(TheEntry.Place.Zip);
            write(TheEntry.Number[1]);
            write(TheEntry.Number[2]);
            write(TheEntry.Number[3]);
          end;
      end;
  end;

  Procedure AreaCodeSearch(TheAreaCode:integer);
  begin
    while not Eof(infile) do
      begin
        read(infile,TheEntry);
        if TheEntry.Number[1]=TheAreaCode then
          begin
            write(TheEntry.Name.First);
            write(TheEntry.Name.Last);
            write(TheEntry.Address);
            write(TheEntry.Place.City);
            write(TheEntry.Place.Zip);
            write(TheEntry.Number[1]);
            write(TheEntry.Number[2]);
            write(TheEntry.Number[3]);
          end;
      end;
  end;

  Procedure LastFourSearch(TheLastFour:integer);
  begin
    while not Eof(infile) do
      begin
        read(infile,TheEntry);
        if TheEntry.Number[3]=TheLastFour then
          begin
            write(TheEntry.Name.First);
            write(TheEntry.Name.Last);
            write(TheEntry.Address);
            write(TheEntry.Place.City);
            write(TheEntry.Place.Zip);
            write(TheEntry.Number[1]);
            write(TheEntry.Number[2]);
            write(TheEntry.Number[3]);
          end;
      end;
  end;

begin
  assign(infile,'Phone.lst');
  write('What do you want to search for? (N) for name,(A) for area code, (L) for the last four digits of the phone number ');
  readln(response);
  if response ='N' then
    begin
      write('Enter the last name. ');
      readln(surname);
      NameSearch(surname);
    end
  else if response='A' then
    begin
      write('Enter the area code. ');
      readln(Areacode);
      AreaCodeSearch(Areacode);
    end
  else if response='L' then
    begin
      write('Enter the last four digits of the phone number. ');
      readln(FinalFour);
      LastFourSearch(FinalFour);
    end;
end.

    
