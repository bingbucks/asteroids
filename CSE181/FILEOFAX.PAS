program FileoFax; {Citasson - HW12: This program will create a directory of
                  names and phone numbers}
  type
    names=record
      first:string[10];
      last:string[15];
    end;
    address=array[1..20] of char;
    zipcity=record
      zip:string[5];
      city:string[18];
    end;
    phonenum=array[1..3] of integer;
  var
    name:names;
    adres:string[20];
    city:zipcity;
    number:phonenum;
    fileout:text;
    filename:string[10];
    another:char;

  begin
    filename:='Phone.LST';
    assign(fileout,filename);
    rewrite(fileout);

   while not (another='y') do begin
    writeln(fileout);
    write('What"s the first name? ');
    readln(name.first);
    write(fileout,name.first);
    write(fileout,' ');

    write('What"s the last name? ');
    readln(name.last);
    writeln(fileout,name.last);

    write('What"s the street address? ');
    readln(adres);
    writeln(fileout,adres);

    write('What"s the city? ');
    readln(city.city);
    write(fileout,city.city);
    write(fileout,' ');

    write('What"s the zip code? ');
    readln(city.zip);
    writeln(fileout,city.zip);

    write('What"s the phone number? ');
    readln(number[1],number[2],number[3]);
    write(fileout,number[1]);
    write(fileout,' ');
    write(fileout,number[2]);
    write(fileout,' ');
    writeln(fileout,number[3]);
    write('Are you done? (y/n) ');
    readln(another);
   end;
    close(fileout);
  end.