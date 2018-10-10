program TEST; {Citasson - CSE182 - HW#3}

uses hw3tpu2;

var a,b,c:fraction;
    FileIn,FileOut:text;
begin
  {assign(FileIn,'Infile');
  reset(FileIn);}

  assign(FileOut,'OutFile');
  rewrite(fileout);



  writeln;
  write('Enter a fraction in this form ---> N / D: ');
  a.read_fraction;

 { write('Enter a fraction in this form ---> N / D: ');
  b.read_fraction;}

 { b.readf_fraction(FileIn);}

  a.writef_fraction(fileout);


{  a.plus(b);
  a.write_fraction;
  writeln(a.real_value);

  a.minus(b);
  a.write_fraction;
  writeln(a.real_value);

  a.times(b);
  a.write_fraction;
  writeln(a.real_value);

  a.divided_by(b);
  a.write_fraction;
  writeln(a.real_value);

  writeln(a.equal_to(b));
  writeln(a.gte(b));
  writeln(a.lt(b));

  writeln(a.real_value);
  writeln(b.real_value);



  writeln(a.numerator);
  writeln(a.denominator);}

end.