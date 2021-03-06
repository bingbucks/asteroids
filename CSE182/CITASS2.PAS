program FractionManipulation; {Citasson - CSE182 HW#1}
	type
		fraction = record
				numerator: integer;
				denominator: integer;
			end;
       	var
		F1, F2, F3, F4, FinalFraction: fraction;
		v: real;
                filein,fileout:text;
                name:string[8];

	function Equal (x, y: fraction): boolean;
             {Equal returns a boolean if the two fractions are equal}
        begin
		if (x.numerator / x.denominator) = (y.numerator / y.denominator) then
			Equal := true
		else
			Equal := false;
	end;
	function Lt (x, y: fraction): boolean;
             {Lt returns a boolean if the first fraction is less than the
              second fraction}
        begin
		if (x.numerator / x.denominator) < (y.numerator / y.denominator) then
			Lt := true
		else
			Lt := false;
	end;
	function Gte (x, y: fraction): boolean;
             {Gte returns a boolean if the 1st fraction is greater than
              the second fraction}
        begin
		if (x.numerator / x.denominator) > (y.numerator / y.denominator) then
			Gte := true
		else
			Gte := false;
	end;
	function Gcd (x, y: integer): integer;
             {Gcd uses Euclid's algorithm to find the greatest common
              divisor of a fraction}

		var
			r: integer;
	begin
		x := abs(x);
		y := abs(y);
		if (x = 0) or (y = 0) then
			begin
				if x = 0 then
					Gcd := y
				else
					Gcd := x
			end
		else
			begin
				Gcd := 1;
				while y > 1 do
					begin
						r := x mod y;
						if r <> 0 then
							begin
								x := y;
								y := r
							end
						else
							begin
								Gcd := y;
								y := 1
							end;
					end;
			end;
	end;
	procedure Fraction2Real (var q: real; f: fraction);
              {Fraction2Real takes the fraction and returns a real}
        begin
		q := f.numerator / f.denominator;
		
	end;
	procedure Write_Fraction (x: fraction);
              {Writes the fraction to the screen}

	begin
		writeln(x.numerator);
		writeln(x.denominator);
	end;
        
	procedure Writef_fraction (var fil:text; x: fraction);
              {Writes the fraction to the file of name you specify}

	begin
		writeln(fil, x.numerator);
                writeln(fil, x.denominator);
	end;
	
	procedure Normalize (var z: fraction; x: fraction);
              {Reduces the fraction by using the function Gcd}
        var greatest:integer;
	begin
		greatest := GCD(x.numerator, x.denominator);
		z.numerator := trunc(x.numerator / greatest);
		z.denominator := trunc(x.denominator / greatest);
		
	end;
	procedure Add (var z: fraction; F1, F2: fraction);
              {Adds fractions}
	begin
		z.numerator := ((F1.numerator * F2.denominator) + (F2.numerator * F1.denominator));
		z.denominator := (F1.Denominator * F2.Denominator);
		normalize(z, z);
	end;
	procedure Subtract (var z: fraction; F1, F2: fraction);
              {Subtracts fractions}
	begin
		z.numerator := ((F1.numerator * F2.denominator) - (F2.numerator * F1.denominator));
		z.denominator := (F1.Denominator * F2.Denominator);
		normalize(z, z);
	end;
	procedure Multiply (var z: fraction; F1, F2: fraction);
              {Multiplies fractions}
	begin
		z.numerator := (F1.numerator * F2.numerator);
		z.denominator := (F1.denominator * F2.denominator);
		normalize(z, z);
	end;
	procedure Divide (var z: fraction; F1, F2: fraction);
              {Divides fractions}
	begin
		z.numerator := (F1.numerator * F2.denominator);
		z.denominator := (F1.denominator * F2.numerator);
		if z.denominator = 0 then
			writeln('This fraction is undefined. ');
                normalize(z,z);
	end;
	procedure Integers2Fraction (var z: fraction; n, d: integer);
              {Takes the two integers and creates a fraction with them}

	begin
		n := z.numerator;
		d := z.denominator;
	end;
	procedure Read_Fraction (var x: fraction);
              {Reads the fraction you entered and then calls the Normalize
               procedure}
        var h:char;
        begin
          x.denominator:=0;      {Initializes zero so that loop runs}
            while (x.denominator=0) do
             begin
          	read(x.numerator);
                read(h);
                read(h);
                read(h);
		read(x.denominator);
                If x.numerator=0 then
                  writeln('Please enter another fraction without a zero in the numerator. ');
                If x.denominator=0 then  {If the user enters a zero for
                                         the denominator then the procedure
                                         asks for another fraction since a
                                         fraction with a zero in the
                                         denominator is not defined}
                  writeln('Again. Zero in the denominator is not legal! ');
                writeln;
		normalize(x,x);
             end;

	end;
	procedure Readf_fraction (var fil: text; var y: fraction);
              {This procedure will read fractions from a text file}
	begin
             readln(fil,y.numerator);
             readln(fil,y.denominator);
	end;

begin {DEMO PROGRAM}

        writeln('Enter a file name: ');
        read(name);

        assign(fileout,name);       {Assigns the name you specify to fileout}                    
        rewrite(fileout);

        Writeln('Enter a number, space, slash, space and another number: ');
	Read_Fraction(Finalfraction);

        assign(filein,'infile');
        reset(filein);
        readf_fraction(filein,f4);  {Reads fraction from file and performs
                                     the procedures below with the fraction
                                     it just read and the one the user enters}
        multiply(f3,finalfraction,f4);
        writeln(fileout,'MULTIPLICATION: ');
        Writef_fraction(fileout,f3); {Writes the result to a text file}
        writeln('MULTIPLICATION: ');
        write_fraction(f3);          {Writes the result to the screen}
        fraction2real(v,f3);         {Turns fraction into a real}

        writeln(v);                 {Writes the real value to the screen}
        writeln(fileout,v);         {Writes the real value to a text file}
          {The two writeln above this line are just to show that
           fraction2real works}
        Writeln(fileout);           {Writes a blank line to fileout}


        add(f3,finalfraction,f4);
        Writeln(fileout,'ADDITION :');
        Writef_fraction(fileout,f3); {Writes the result to a text file}
        Writeln;
        Writeln('ADDITION: ');
        write_fraction(f3);          {Writes the result to the screen}
        fraction2real(v,f3);         {Turns fraction into a real}

        writeln(v);                 {Writes the real value to the screen}
        writeln(fileout,v);         {Writes the real value to a text file}
          {The two writeln above this line are just to show that
           fraction2real works}
        Writeln(fileout);


        subtract(f3,finalfraction,f4);
        Writeln(fileout,'SUBTRACTION: ');
        Writef_fraction(fileout,f3); {Writes the result to a text file}
        Writeln;
        Writeln('SUBTRACTION: ');
        write_fraction(f3);          {Writes the result to the screen}
        fraction2real(v,f3);         {Turns fraction into a real}

        writeln(v);                 {Writes the real value to the screen}
        writeln(fileout,v);         {Writes the real value to a text file}
          {The two writeln above this line are just to show that
           fraction2real works}
        Writeln(fileout);


        divide(f3,finalfraction,f4);
        Writeln(fileout,'DIVISION: ');
        Writef_fraction(fileout,f3); {Writes the result to a text file}
        Writeln;
        Writeln('DIVISION: ');
        write_fraction(f3);          {Writes the result to the screen}
        fraction2real(v,f3);         {Turns fraction into a real}

        writeln(v);                 {Writes the real value to the screen}
        writeln(fileout,v);         {Writes the real value to a text file}
          {The two writeln above this line are just to show that
           fraction2real works}
        write('THE TWO FRACTIONS ARE EQUAL: ');
        writeln(equal(finalfraction,f4));       {Writes the boolean expressions}
        write('THE FRACTION YOU ENTERED IS LESS THAN THE FRACTION READ FROM THE TEXT FILE: ');
        writeln(lt(finalfraction,f4));          {for all three functions to the screen}
        write('THE FRACTION YOU ENTERED IS GREATER THAN THE FRACTION READ FROM THE TEXT FILE: ');
        writeln(gte(finalfraction,f4));         {ONLY to demonstrate that they do work}


        write(fileout,'THE TWO FRACTIONS ARE EQUAL: ');
        writeln(fileout,equal(finalfraction,f4)); {Writes the boolean expression to fileout}
        write(fileout,'THE FRACTION YOU ENTERED IS LESS THAN THE FRACTION READ FROM THE TEXT FILE: ');
        writeln(fileout,lt(finalfraction,f4));    {Writes the boolean expression to fileout}
        write(fileout,'THE FRACTION YOU ENTERED IS GREATER THAN THE FRACTION READ FROM THE TEXT FILE: ');
        writeln(fileout,gte(finalfraction,f4));   {Writes the boolean expression to fileout}

        close(fileout);             {Closes fileout}

end. {DEMO PROGRAM}