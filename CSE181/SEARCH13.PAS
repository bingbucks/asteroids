program FileofaxSearch; {Citasson-HW13 - This program will search a binary
                        file for the record of the person,phone number,or
                        area code that you enter. It will then print the
                        complete record of the person on the screen}
  type
    NombreType=record
      first:string[10];
      last:string[15];
    end;
    Calle=string[20];
    Estado=record
      City:string[18];
      Zip:integer;
    end;
    Telefon=array[1..3]of integer;
    InfoType=record
      Nombre:NombreType;
      Adres:Calle;
      Donde:Estado;
      Numero:Telefon;
    end;

  var
    InfoEntered:InfoType;
    Answer:char;
    ImportFile:file of InfoType;
    LastNombre:string[15];
    CodaDeArea:integer;
    QuatroDeFinale:integer;

  {PROCEDURE NOMBRESEARCH WILL TAKE THE ENTERED NAME, SEARCH FOR THAT PERSON
  AND THEN PRINT THE WHOLE RECORD OF THAT PERSON}

  Procedure NombreSearch(TheLastNombre:string);
  begin
    while not Eof(ImportFile) do
      begin
        read(ImportFile,InfoEntered);
        if InfoEntered.Nombre.Last=TheLastNombre then
          begin
            write(InfoEntered.Nombre.First);
            write(' ');
            writeln(InfoEntered.Nombre.Last);
            writeln(InfoEntered.Adres);
            write(InfoEntered.Donde.City);
            write(' ');
            writeln(InfoEntered.Donde.Zip);
            write(InfoEntered.Numero[1]);
            write(' ');
            write(InfoEntered.Numero[2]);
            write(' ');
            write(InfoEntered.Numero[3]);
          end;
      end;
  end;

  {PROCEDURE CODADEARESEARCH WILL TAKE THE ENTERED AREA CODE, SEARCH FOR
  ENTRIES WITH THE SAME AREA CODE, AND PRINT THE RECORDS OF THE PEOPLE
  WITH THAT AREA CODE}

  Procedure CodaDeAreaSearch(TheCodaDeArea:integer);
  begin
    while not Eof(ImportFile) do
      begin
        read(ImportFile,InfoEntered);
        if InfoEntered.Numero[1]=TheCodaDeArea then
          begin
            write(InfoEntered.Nombre.First);
            write(' ');
            writeln(InfoEntered.Nombre.Last);
            writeln(InfoEntered.Adres);
            write(InfoEntered.Donde.City);
            write(' ');
            writeln(InfoEntered.Donde.Zip);
            write(InfoEntered.Numero[1]);
            write(' ');
            write(InfoEntered.Numero[2]);
            write(' ');
            write(InfoEntered.Numero[3]);
          end;
      end;
  end;

  {PORCEDURE FINALEQUATROSEARCH WILL TAKE THE LAST FOUR DIGITS OF THE PHONE
  NUMBER YOU ENTER, SEARCH FOR THE PERSON WITH THAT PHONE NUMBER, AND PRINT
  THEIR WHOLE RECORD}

  Procedure FinaleQuatroSearch(TheFinaleQuatro:integer);
  begin
    while not Eof(ImportFile) do
      begin
        read(ImportFile,InfoEntered);
        if InfoEntered.Numero[3]=TheFinaleQuatro then
          begin
            write(InfoEntered.Nombre.First);
            write(' ');
            writeln(InfoEntered.Nombre.Last);
            writeln(InfoEntered.Adres);
            write(InfoEntered.Donde.City);
            write(' ');
            writeln(InfoEntered.Donde.Zip);
            write(InfoEntered.Numero[1]);
            write(' ');
            write(InfoEntered.Numero[2]);
            write(' ');
            write(InfoEntered.Numero[3]);
          end;
      end;
  end;

begin
  assign(ImportFile,'Phone.lst');
  reset(ImportFile);
  write('What do you want to search for? (N) for name,(A) for area code, (L) for the last four digits of the phone number ');
  readln(Answer);
  if Answer ='N' then
    begin
      write('Enter the last name.(ALL IN CAPS) ');
      readln(LastNombre);
      NombreSearch(LastNombre);
    end
  else if Answer='A' then
    begin
      write('Enter the area code. ');
      readln(CodaDeArea);
      CodaDeAreaSearch(CodaDeArea);
    end
  else if Answer='L' then
    begin
      write('Enter the last four digits of the phone number. ');
      readln(QuatroDeFinale);
      FinaleQuatroSearch(QuatroDeFinale);
    end;
end.

    
