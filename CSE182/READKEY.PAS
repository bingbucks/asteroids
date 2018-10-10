program g;
uses crt;

var response:string[8];
    hit:char;
begin


readln(response);
if response='yes,sir' then
  begin
    repeat
      writeln('yes');
    until crt.keypressed;
    hit:=readkey; 
    case readkey of
      chr(0),chr(72):write('You got it!');
    end;
  end;
end.