program FileCopy (input,output); {Citasson - This program will take an imported
                                  text file and change the letters accordingly
                                  and then create a new file}
  var filein, fileout:text;
      file1,file2:string[14];
      ch:char;

  procedure PrevChar (ch:char);
    begin
      read(ch);
      case ord(ch) of
        66..90: ch:= pred(ch);
        98..122: ch:= pred(ch);
        65,97,48: ch:='*';
      end;
    end;
  begin
    write('Enter the name of the file you would like to copy. ');
    readln(file1);
    assign(filein,file1);
    reset(filein);
    write('Enter the name of the new copy of the file.');
    read(file2);
    assign(fileout,file2);
    rewrite(fileout);
    while not eof do
      begin
        while not eoln do
          begin
            read(filein,ch);
            PrevChar(ch);
          end;
        read(filein,ch);
        write(fileout,ch);
      end;
    write('Copy complete.');
  end.
 