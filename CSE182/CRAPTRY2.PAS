Program crap; {Citasson HW#4 - CSE182}

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
      1:begin
          writeln;
          writeln;
          writeln('       *  ');
          writeln;
        end;
      2:begin
          writeln;
          writeln('     *');
          writeln;
          writeln('         *');
        end;
      3:begin
          writeln;
          writeln('     *');
          writeln('       * ');
          writeln('         *');
        end;
      4:begin
          writeln;
          writeln('     *   *');
          writeln;
          writeln('     *   *');
        end;
      5:begin
          writeln;
          writeln('     *   *');
          writeln('       * ');
          writeln('     *   *');
        end;
      6:begin
          writeln;
          writeln('     *   *');
          writeln('     *   *');
          writeln('     *   *');
        end;
    end;
  end;

var FirstDie,SecondDie:DieOBJ;
    Total,Score,NewValue,PlayerOneScore,ComputerScore,NumofHands,I,J:integer;
    ShuffleSpeed:integer;

begin
  PlayerOneScore:=0;
  ComputerScore:=0;
  CRT.ClrScr;
  CRT.TextColor(CRT.Red);
  write('Instead of using ''CRT.KeyPressed''. How many hands would you like to play? ');
  readln(NumofHands);
  write('           How fast do you want the computer to roll the dice? ');
  readln(ShuffleSpeed);
 For I:=2 to (NumofHands+1) do begin


  CRT.ClrScr;
  CRT.Window(1,1,20,5);
  CRT.GotoXY(1,1);
  write('Player One: ');
  write(PlayerOneScore);

  CRT.Window(65,1,80,5);
  CRT.GotoXY(1,1);
  write('Computer: ');
  write(ComputerScore);

  CRT.Window(30,5,70,25);
  CRT.ClrScr;
  CRT.GotoXY(1,1);
  {CRT.TextBackGround(CRT.Blue);}
  CRT.TextColor(CRT.Red);



  FirstDie.NewDie;
  FirstDie.Roll;
  FirstDie.Display;
  CRT.Delay(ShuffleSpeed);
  SecondDie.NewDie;
  SecondDie.Roll;
  SecondDie.Display;
  CRT.Delay(ShuffleSpeed);

  Total:=FirstDie.Return + SecondDie.Return;

  Case Total of
    7,11:begin
           If I mod 2=0 then
             begin
               writeln('Player One Wins!');
               PlayerOneScore:=PlayerOneScore+1;
               CRT.Delay(2000);
             end
           else
             begin
               writeln('Computer Wins!');
               ComputerScore:=ComputerScore+1;
               CRT.Delay(2000);
             end;
         end;
    2,3,12:begin
             If I mod 2=0 then
               begin
                 writeln('Player One Looses!');
                 CRT.Delay(2000);
               end
             else
               begin
                 writeln('Computer Looses!');
                 CRT.Delay(2000);
               end;
           end;
    4,5,6,8,9,10:begin
                  Score:=Total;

                   repeat
                     CRT.ClrScr;
                     FirstDie.NewDie;
                     SecondDie.NewDie;
                     FirstDie.Roll;
                     SecondDie.Roll;
                     FirstDie.Display;
                     CRT.Delay(ShuffleSpeed);
                     SecondDie.Display;
                     CRT.Delay(ShuffleSpeed);
                     NewValue:=FirstDie.Return + SecondDie.Return;

                   until (NewValue=7) or (NewValue=Score);

                 If NewValue=7 then
                   begin
                     If I mod 2=0 then
                       begin
                         writeln('Player One Looses!');
                         CRT.Delay(2000);
                       end
                     else
                       begin
                         writeln('Computer Looses!');
                         CRT.Delay(2000);
                       end;
                   end
                 else if NewValue=Score then
                   begin
                     If I mod 2=0 then
                       begin
                         writeln('Player One Wins!');
                         PlayerOneScore:=PlayerOneScore+1;
                         CRT.Delay(2000);
                       end
                     else
                       begin
                         writeln('Computer Wins!');
                         ComputerScore:=ComputerScore+1;
                         CRT.Delay(2000);
                       end;
                   end;
                 end;

    end; {Case Statement}
  end;   {For Loop}

 CRT.Window(1,1,80,25);
 CRT.ClrScr;
 If PlayerOneScore>ComputerScore then
   begin
     for J:=1 to 25 do
     begin
       writeln('PLAYER ONES WINS!!!');
       CRT.Delay(150);
     end;
   end
 else if ComputerScore>PlayerOneScore then
   begin
     for J:=1 to 25 do
     begin
       writeln('COMPUTER WINS!!!');
       CRT.Delay(150);
     end;
   end
 else if ComputerScore=PlayerOneScore then
   begin
     for J:=1 to 25 do
     begin
       writeln('IT''S A TIE! NOBODY WINS!!!');
       CRT.Delay(150);
     end;
   end;
end.     {Crap}