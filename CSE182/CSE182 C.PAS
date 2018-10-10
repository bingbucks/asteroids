program Crap;  {Citasson - CSE182 - Homework #4}

type DieOBJ=OBJECT
     procedure Roll;
     function Return:integer;
     procedure NewDie;
     procedure Display(DisplayValue:integer);

   private
     value:integer;
   end;

procedure DieOBJ.Roll;
  begin
    Value:=SYSTEM.Random(6)+1;
  end;

function DieOBJ.Return:integer;
  begin
    Return:=Value;
  rnd;

procedure DieOBJ.NewDie;
  begin
    SYSTEM.Randomize;
  end;

procedure DieOBJ.Display(DisplayValue:integer);
  begin
    case DisplayValue of
      1:writeln('*');
      2:writeln('* *');
      3:writeln('* * *');
      4:writeln('* * * *');
      5:writeln('* * * * *');
      6:writeln('* * * * * *');
      7:writeln('* * * * * * *');
      8:writeln('* * * * * * * *');
      9:writeln('* * * * * * * * *');
      10:writeln('* * * * * * * * * *');
      11:writeln('* * * * * * * * * * *');
      12:writeln('* * * * * * * * * * * *');
    end;
  end;

var FirstDie, SecondDie:DieOBJ;
    RollNumber:integer;
begin
  FirstDie.Roll;
  SecondDie.Roll;
  RollNumber:=FirstDie.Return + SecondDie.Return;

  Case RollNumber of
    7,11:begin
           writeln('YOU WIN!!!');
           DieOBJ.Display(RollNumber);
         end;
    2,3,12:begin
             writeln('YOU LOSE!!!');
             DieOBJ.Display(RollNumber);
           end;
    4,5,6,8,9,10:begin
                   Score:=RollNumber;
                   FirstDie.Roll;
                   SecondDie.Roll;
                 end;


