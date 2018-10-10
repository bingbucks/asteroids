Program Make_List;

TYPE
    Nametype = Record
                First:String[10];
                Last:String[15];
               end;

    StAddress=String[20];
    Location = Record
                City:String[18];
                ZIP:Integer;
               end;

    Phone = Array [1..3] of Integer;

    Entrytype = Record
                 Name:Nametype;
                 Address:StAddress;
                 Place:Location;
                 Number:phone
                end;
    Xfile=file of Entrytype;
Var

   TheEntry:EntryType;
   Name:Nametype;
   Address:StAddress;
   Place:Location;
   Phonenum:Phone;
   outfile:Xfile;
   i:Integer;

BEGIN
     Assign(outfile,'PHONE.LST');
     Rewrite(outfile);

     TheEntry.Name.First:='Bob';
     TheEntry.Name.Last:='Belge';
     TheEntry.Address:='123 Belge St.';
     TheEntry.Place.City:='Syracuse, NY';
     TheEntry.Place.ZIP:=01320;
     TheEntry.Number[1]:=315;
     TheEntry.Number[2]:=123;
     TheEntry.Number[3]:=1234;

     Write(outfile,TheEntry);

     TheEntry.Name.First:='Adam';
     TheEntry.Name.Last:='Smith';
     TheEntry.Address:='234 Belge St.';
     TheEntry.Place.City:='Syracuse, NY';
     TheEntry.Place.ZIP:=01320;
     TheEntry.Number[1]:=315;
     TheEntry.Number[2]:=231;
     TheEntry.Number[3]:=1234;

     Write(outfile,TheEntry);

     TheEntry.Name.First:='Chris';
     TheEntry.Name.Last:='Tassone';
     TheEntry.Address:='111 Belge St.';
     TheEntry.Place.City:='Syracuse, NY';
     TheEntry.Place.ZIP:=12345;
     TheEntry.Number[1]:=123;
     TheEntry.Number[2]:=123;
     TheEntry.Number[3]:=1111;

     Write(outfile,TheEntry);
End.


