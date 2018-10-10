program Crap;  {Citasson - CSE182 - Homework #4}

Uses CRT;

type DieOBJ=OBJECT
     procedure Roll;
     function Return:integer;
     procedure NewDie;
     procedure Display;

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
  end;

procedure DieOBJ.NewDie;
  begin
    SYSTEM.Randomize;
  end;

procedure DieOBJ.Display;
  begin
    case value of
      1:writeln('*');
      2:writeln('* *');
      3:writeln('* * *');
      4:writeln('* * * *');
      5:writeln('* * * * *');
      6:writeln('* * * * * *');
    end;
  end;

var FirstDie, SecondDie:DieOBJ;
    RollNumber, Score, NewValue:integer;

begin
  CRT.ClrScr;

   repeat

  RollNumber:=0;
  Score:=0;
  NewValue:=0;

  {CRT.ClrScr;}

  writeln;
  writeln('******** WELCOME TO CRAP!!! *******');
  CRT.Delay(1000);
  writeln;
  writeln('Push any key to quit.');
  CRT.Delay(1000);

  FirstDie.NewDie;
  SecondDie.NewDie;
  FirstDie.Roll;
  SecondDie.Roll;

  writeln;
  writeln('The first roll is a... ' );
  CRT.Delay(1000);
  writeln;
  FirstDie.Display;
  writeln('...and a...');
  SecondDie.Display;
  CRT.Delay(1500);

  RollNumber:=FirstDie.Return + SecondDie.Return;

  Case RollNumber of
    7,11:begin
           writeln;
           writeln('WINNER!!!');
           CRT.Delay(1500);
         end;
    2,3,12:begin
             writeln;
             writeln('LOSER!!!');
             CRT.Delay(1500);
           end;
    4,5,6,8,9,10:begin
                  Score:=RollNumber;

                   repeat
                     FirstDie.NewDie;
                     SecondDie.NewDie;
                     FirstDie.Roll;
                     SecondDie.Roll;
                     Writeln;
                     Writeln('The computer randomly picked...');
                     FirstDie.Display;
                     Writeln('...and...');
                     SecondDie.Display;
                     Writeln;
                     NewValue:=FirstDie.return + SecondDie.Return;
                   until (NewValue=7) or (NewValue=Score);

                 If NewValue=7 then
                   begin
                     writeln('LOSER!!!');
                     CRT.Delay(1500);
                   end
                 else if NewValue=Score then
                   begin
                     writeln('WINNER!!!');
                     CRT.Delay(1500);
                   end;
                 end;

    end;
  Until CRT.KeyPressed;
end.

