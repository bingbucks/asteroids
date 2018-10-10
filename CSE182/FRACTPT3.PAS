Unit FractPT3; {Citasson - Fraction Unit - HW#2 CSE182}


 Interface

 type fraction=record
         numerator:integer;
         denominator:integer;
      end;

        function Equal (x, y: fraction): boolean;
	function Lt (x, y: fraction): boolean;
	function Gte (x, y: fraction): boolean;
	procedure Fraction2Real (var q: real; f: fraction);
	procedure Write_Fraction (x: fraction);
	procedure Writef_fraction (var fil:text; x: fraction);
	procedure Normalize (var z: fraction; x: fraction);
	procedure Add (var z: fraction; F1, F2: fraction);
	procedure Subtract (var z: fraction; F1, F2: fraction);
	procedure Multiply (var z: fraction; F1, F2: fraction);
	procedure Divide (var z: fraction; F1, F2: fraction);
	procedure Integers2Fraction (var z: fraction; n, d: integer);
	procedure Read_Fraction (var x: fraction);
	procedure Readf_fraction (var fil: text; var y: fraction);


 Implementation


        function Equal (x, y: fraction): boolean;
             {Equal returns a boolean if the two fractions are equal}
        var w,v:real;
        begin
          fraction2real(w,x);
          fraction2real(v,y);
		if w = v then
			Equal := true
		else
			Equal := false;
	end;
	function Lt (x, y: fraction): boolean;
             {Lt returns a boolean if the first fraction is less than the
              second fraction}
        var w,v:real;
        begin
          fraction2real(w,x);
          fraction2real(v,y);
		if w < v then
			Lt := true
		else
			Lt := false;
	end;
	function Gte (x, y: fraction): boolean;
             {Gte returns a boolean if the 1st fraction is greater than
              the second fraction}
        var w,v:real;
        begin
          fraction2real(w,x);
          fraction2real(v,y);
		if w > v then
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

        function Gcd_Longint(x,y:longint):longint;
        var
	  r: longint;
	begin
          x := abs(x);
	  y := abs(y);
	  if (x = 0) or (y = 0) then
	    begin
	      if x = 0 then
	        Gcd_Longint := y
	      else
	        Gcd_Longint := x
	    end
	  else
	    begin
	      Gcd_Longint := 1;
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
		        Gcd_Longint := y;
			y := 1
		      end;
		  end;
	    end;
	end;





	procedure Fraction2Real (var q: real; f: fraction);
              {Fraction2Real takes the fraction and returns a real}
        begin
                If f.denominator<>0 then
		    q := f.numerator / f.denominator
                else
                    begin
                      writeln('DIVISION BY ZERO!!!');
                      q :=0;
                    end;
		
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
                If greatest=0 then  {This is to avoid division by zero}
                   begin
                     greatest:=1;
                     z.numerator:=z.numerator;
                     z.denominator:=z.denominator;
                   end
                else
                 begin
		z.numerator := trunc(x.numerator / greatest);
		z.denominator := trunc(x.denominator / greatest);
		      end;
                If z.denominator<>0 then
                begin
                  If (z.numerator/z.denominator)=(Abs(z.numerator)/abs(z.denominator))
                   then
                   begin
                    z.numerator:=abs(z.numerator);
                    z.denominator:=abs(z.denominator);
                   end
                end;


	end;
        procedure Normalize_longint(var NewUpSum,NewLoSum:longint; x,y:longint);
           var greatest:longint;
           begin
                greatest:= GCD_Longint(x,y);
                if greatest = 0 then greatest :=1;
                NewUpSum:= trunc(x/greatest);
                NewLoSum:= trunc(y/greatest);
           end;



	procedure Add (var z: fraction; F1, F2: fraction);
              {Adds fractions}
        var UpSum,LoSum,T1,T2:longint;

	begin
		UpSum:= (longint(F1.numerator) * longint(F2.denominator) + longint(F2.numerator) * longint(F1.denominator));
		LoSum:= longint(F1.Denominator) * longint(F2.Denominator);

                Normalize_longint(T1,T2,UpSum,LoSum);


                If abs(T1)<=MAXINT then z.numerator:=(T1)
                   else begin
                    writeln;
                    writeln('OVERFLOW!!! FOR ADDITION!');
                    z.numerator:=0;
                    end;
                If abs(T2)<=MAXINT then z.denominator:=trunc(T2)
                   else begin
                    writeln;
                    writeln('OVERFLOW!!! FOR ADDITION!');
                    z.denominator:=0;  {Won't cause a division by zero}
                    end;
                If z.denominator<>0 then
		normalize(z, z);
	end;
	procedure Subtract (var z: fraction; F1, F2: fraction);
              {Subtracts fractions}
        var UpSum,LoSum,T1,T2:longint;

	begin
		UpSum:= (longint(F1.numerator) * longint(F2.denominator) - longint(F2.numerator) * longint(F1.denominator));
		LoSum:= longint(F1.Denominator) * longint(F2.Denominator);
                Normalize_longint(T1,T2,UpSum,LoSum);
                If abs(T1)<=MAXINT then z.numerator:=trunc(T1)
                   else begin
                    writeln;
                    writeln('OVERFLOW!!! FOR SUBTRACTION!');
                    z.numerator:=0;
                    end;
                If abs(T2)<=MAXINT then z.denominator:=trunc(T2)
                   else begin
                    writeln;
                    writeln('OVERFLOW!!! FOR SUBTRACTION!');
                    z.denominator:=0;  {Won't cause a division by zero}
                    end;
                    If z.denominator<>0 then
                    normalize(z, z);
	end;
	procedure Multiply (var z: fraction; F1, F2: fraction);
              {Multiplies fractions}
        var UpSum,LoSum,T1,T2:longint;
	begin
		UpSum:= longint(F1.numerator) * longint(F2.numerator);
		LoSum:= longint(F1.denominator) * longint(F2.denominator);
                Normalize_Longint(T1,T2,UpSum,LoSum);

                If (T1)<=MAXINT then z.numerator:=trunc(T1)
                   else begin
                     writeln;
                     writeln('OVERFLOW!!! FOR MULTIPLICATION!');
                     z.numerator:=0;
                     End;
                If (T2)<=MAXINT then z.denominator:=trunc(T2)
                   else begin
                     writeln;
                     writeln('OVERFLOW!!! FOR MULTIPLICATION!');
                     z.denominator:=1;  {Won't cause a division by zero}
                     end;
        	normalize(z, z);
	end;
	procedure Divide (var z: fraction; F1, F2: fraction);
              {Divides fractions}
        var UpSum,LoSum,T1,T2:longint;
	begin
		UpSum:= longint(F1.numerator) * longint(F2.denominator);
		LoSum:= longint(F1.denominator) * longint(F2.numerator);
                Normalize_Longint(T1,T2,UpSum,LoSum);

                If abs(T1)<=MAXINT then z.numerator:=trunc(T1)
                   else begin
                     writeln;
                     writeln('OVERFLOW!!! FOR DIVISION!');
                     z.numerator:=0;
                     end;
                If (abs(T2)<=MAXINT) and (abs(T2)>0) then z.denominator:=trunc(T2)
                   else begin
                     writeln;
                       If T2=0 then
                         begin
                           writeln('DIVISION BY ZERO!!!');
                      writeln('OVERFLOW!!! FOR DIVISION!');
                      z.numerator:=0;
                      z.denominator:=0;    {Won't cause a divsion by zero}
                     end;
               end;

           If z.denominator<>0 then
           normalize(z,z);
	end;
	procedure Integers2Fraction (var z: fraction; n, d: integer);
              {Takes the two integers and creates a fraction with them}
	begin
	        z.numerator:=n;
		z.denominator:=d;
                normalize(z,z);
	end;
	procedure Read_Fraction (var x: fraction);
              {Reads the fraction you entered and then calls Integers2Fraction}
        var h:char;
            numerator,denominator:integer;
        begin
          denominator:=0;      {Initializes zero so that loop runs}
            while denominator=0 do
             begin
          	read(numerator);
                read(h);
                read(h);
                read(h);
                readln(denominator);
                If denominator=0 then  {If the user enters a zero for
                                         the denominator then the procedure
                                         asks for another fraction since a
                                         fraction with a zero in the
                                         denominator is not defined}
                begin
                  writeln;
                  writeln('Again. Zero in the denominator is not legal! ');
                  writeln;
                end;
             end;
          Integers2Fraction(x,numerator,denominator);
	end;
	procedure Readf_fraction (var fil: text; var y: fraction);
              {This procedure will read fractions from a text file}
	begin
             repeat
               readln(fil,y.numerator);
               readln(fil,y.denominator);
             until ((y.denominator)<>0) or eof(fil);
             if not eof(fil) and (y.denominator <> 0) then normalize(y,y);
        end;
End.
