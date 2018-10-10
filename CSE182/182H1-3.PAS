program FractionManipulation; {Citasson - CSE182 HW#1}
	type
		fraction = record
				numerator: integer;
				denominator: integer;
			end;
	var
		F1, F2, F3, F4, s, FinalFraction, w, y: fraction;
		r, greatest: integer;
		response: char;
		d: real;
                filein,fileout:text;
                TheFile,name,first:string[8];
                name2,fil:text;
	function Equal (x, y: fraction): boolean;
             {Equal returns a boolean if the two fractions are equal}
        begin
		if (x.numerator / x.denominator) = (y.numerator / y.denominator) then
			Equal := true
		else
			Equal := false;
	end;
	function Lt (x, y: fraction): boolean;
             {Lt returns a boolean if the first fraction is less than the second fraction}
        begin
		if (x.numerator / x.denominator) < (y.numerator / y.denominator) then
			Lt := true
		else
			Lt := false;
	end;
	function Gte (x, y: fraction): boolean;
             {Gte returns a boolean if the 1st fraction is greater than the second fraction}
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
		writeln(fileout, x.numerator);
                writeln(fileout, x.denominator);
	end;
	
	procedure Normalize (var z: fraction; x: fraction);
              {Reduces the fraction by using the function Gcd}
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
		normalize(s, z);
	end;
	procedure Subtract (var z: fraction; F1, F2: fraction);
              {Subtracts fractions}
	begin
		z.numerator := ((F1.numerator * F2.denominator) - (F2.numerator * F1.denominator));
		z.denominator := (F1.Denominator * F2.Denominator);
		normalize(s, z);
	end;
	procedure Multiply (var z: fraction; F1, F2: fraction);
              {Multiplies fractions}
	begin
		z.numerator := (F1.numerator * F2.numerator);
		z.denominator := (F1.denominator * F2.denominator);
		normalize(s, z);
	end;
	procedure Divide (var z: fraction; F1, F2: fraction);
              {Divides fractions}
	begin
		z.numerator := (F1.numerator * F2.denominator);
		z.denominator := (F1.denominator * F2.numerator);
		if z.denominator = 0 then
			writeln('This fraction is undefined. ');
                normalize(s,z);
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
               	read(finalfraction.numerator);
                read(h);
                read(h);
                read(h);
		read(finalfraction.denominator);
                writeln;
		normalize(s, x);

	end;
	procedure Readf_fraction (var fil: text; var y: fraction);
              {This procedure will read fractions from a text file}
	begin
             readln(filein,y.numerator);
             readln(filein,y.denominator);
	end;

begin {MAIN PROGRAM}

        writeln('Enter a file name: ');
        read(name);

        assign(fileout,name); {Assigns the name you specify to fileout}                    
        rewrite(fileout);

        Writeln('Enter a number, space, slash, space and another number: ');
	Read_Fraction(Finalfraction);
       
        assign(filein,'infile');
        reset(filein);
        readf_fraction(filein,f4); {Reads fraction from file and performs
                                    the procedure below with the fraction
                                    it just read and the one the user enters}
       

           add(f3,s,f4);
        Writef_fraction(fileout,s); {Writes the result to a text file}
        write_fraction(s);          {Writes the result to the screen}

           subtract(f3,s,f4);
        Writef_fraction(fileout,s); {Writes the result to a text file}
        write_fraction(s);          {Writes the result to the screen}
           multiply(f3,s,f4);
        Writef_fraction(fileout,s); {Writes the result to a text file}
        write_fraction(s);          {Writes the result to the screen}
           divide(f3,s,f4);


        Writef_fraction(fileout,s); {Writes the result to a text file}
        write_fraction(s);          {Writes the result to the screen}
        
        close(fileout);              {Closes fileout}

end. {MAIN PROGRAM}