Unit Fract2; {Citasson - CSE182 - HW#3}

Interface

  type FRACTION=Object
     function numerator:integer;
     function denominator:integer;
     procedure plus(y:fraction);
     procedure minus(y:fraction);
     procedure times(y:fraction);
     procedure divided_by(y:fraction);
     function equal_to(y:fraction):boolean;
     function gte(y:fraction):boolean;
     function lt(y:fraction):boolean;
     procedure normalize;
     procedure make(n,d:integer);
     function real_value:real;
     procedure read_fraction;
     procedure readf_fraction(var fil:text);
     procedure write_fraction;
     procedure writef_fraction(var fil:text);
  private
     numer:integer;
     denomin:integer;
     function gcf(x,y:integer):integer;
  end;

Implementation

     function FRACTION.numerator:integer;
       begin
         numerator:=numer;
       end;

     function FRACTION.denominator:integer;
       begin
         denominator:=denomin;
       end;

     procedure FRACTION.plus(y:fraction);
       begin
         numer:=(numer*y.denomin)+(denomin*y.numer);
         denomin:=(denomin*y.denomin);
       end;

     procedure FRACTION.minus(y:fraction);
       begin
         numer:=(numer*y.denomin)-(denomin*y.numer);
         denomin:=(denomin*y.denomin);
       end;

     procedure FRACTION.times(y:fraction);
       begin
         numer:=(numer*y.numer);
         denomin:=(denomin*y.denomin);
       end;

     procedure FRACTION.divided_by(y:fraction);
       begin
         numer:=(numer*y.denomin);
         denomin:=(denomin*y.numer);
       end;

     function FRACTION.equal_to(y:fraction):boolean;
       begin
       If (numer/denomin)=(y.numer/y.denomin) then
         equal_to:=true
       else
         equal_to:false;
       end;

     function FRACTION.gte(y:fraction):boolean;
       begin
       If (numer/denomin)>(y.numer/y.denomin) then
         gte:=true
       else
         gte:=false;
       end;

     function FRACTION.lt(y:fraction):boolean;
       begin
       If (numer/denomin)<(y.numer/y.denomin) then
         lt:=true
       else
         lt:=false;
       end;

     procedure FRACTION.normalize;
       var greatest:integer;
       begin
         greatest:=gcf(numer,denomin);
         numer:=trunc(numer/greatest);
         denomin:=trunc(denomin/greatest);
       end;

     procedure FRACTION.make(n,d:integer);
       begin
        n:=numer;
        d:=denomin;
       end;

     function FRACTION.real_value:real;
       begin
         real_value:=numer/denomin;
       end;

     procedure FRACTION.read_fraction;
       var h:char;
       begin
         denomin:=0;
           while denomin=0 do
             begin
               read(numer);
               read(ch);
               read(ch);
               read(ch);
               read(denomin);
               If denomin=0 then
                 begin
                   writeln;
                   writeln('Again, no zeros in the denominator);
                   writeln;
                 end;
             end;
       end;

       procedure FRACTION.readf_fraction(var fil:text);
         begin
           readln(fil,numer);
           readln(fil,denomin);
         end;

       procedure FRACTION.write_fraction;
         begin
           writeln(numer);
           writeln(denomin);
         end;

       procedure FRACTION.writef_fraction(var fil:text);
         begin
           writeln(fil,numer);
           writeln(fil,denomin);
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


