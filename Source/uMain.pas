unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects,
  System.ImageList, FMX.ImgList, System.Rtti, FMX.Grid.Style, FMX.ScrollBox,
  FMX.Grid,FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView;

const
  Err = $FFB3302E;
  Sukses = $FF538257;
  Ok = $FF4582F8;
  Login = 'Login';
  Loading = 'Loading Screen';
  Home = 'Home';
  Fra2 = 'Fra2';
  Fra3 = 'Fra3';
  Fra4 = 'Fra4';

procedure fnLog(usr, log : String; tgl : TDateTime);

procedure fnDefICO(btn, btnMV : TCornerButton; no : Integer; stat : Boolean = True);
procedure fnGoFrame(From, Go : String);
procedure fnChangeFrame;
procedure fnShowFootHead(stat : Boolean = True);
procedure fnShowE(text : String; stat : Cardinal);
procedure fnCloseLoading; //CARA LAMA
procedure fnLoading;      //CARA LAMA
procedure fnLoadLoading(lo : TLayout; ani : TAniIndicator; stat : Boolean);  //ganti ini


procedure fnGetE(Msg, Cls : String);

var
  fromFrame, goFrame : String;
  username, levelakses, iduser, email : String;
  statFH, statErr : Boolean;
  coErr, tabCount : Integer;  //coErr untuk fnShowE

implementation

uses FrMain, uRest, FrHome, FrLoading, FrLogin, uGoFrame, Fr2, Fr3, Fr4;

procedure fnLog(usr, log : String; tgl : TDateTime);
var
  arr : TStringArray;
begin
  //arr
end;

procedure fnDefICO(btn, btnMV : TCornerButton; no : Integer; stat : Boolean = True);
var
  colT, colF : Cardinal;
begin
  colT := $FF33A393;
  colF := $FFA5ADC6;
  with FMain do
  begin
    btnPrediksi.ImageIndex := 1;
    btnNews.ImageIndex := 1;
    btnChat.ImageIndex := 1;
    btnAcc.ImageIndex := 1;

    btnPrediksiMV.ImageIndex := 1;
    btnNewsMV.ImageIndex := 1;
    btnChatMV.ImageIndex := 1;
    btnAccMV.ImageIndex := 1;

    btnPrediksi.FontColor := colF;
    btnNews.FontColor := colF;
    btnChat.FontColor := colF;
    btnAcc.FontColor := colF;

    btnPrediksiMV.FontColor := colF;
    btnNewsMV.FontColor := colF;
    btnChatMV.FontColor := colF;
    btnAccMV.FontColor := colF;

    if stat = True then
    begin
      btn.ImageIndex := no;
      btn.FontColor := colT;

      btnMV.ImageIndex := no;
      btnMV.FontColor := colT;
    end;
  end;
end;

procedure fnGoFrame(From, Go : String);
begin
  fromFrame := From;
  goFrame := Go;

  with FMain do
  begin
    fnLoadLoading(loLoad, aniLoad, True);
    loMain.Align := TAlignLayout.None;

    loMain.Opacity := 0;
    loMain.Position.Y := 50;
    fnChangeFrame;
  end;
end;

procedure fnChangeFrame;
begin
  try
    if (goFrame = Loading) or (goFrame = Login) then begin
      if (FMain.header.Visible = True) or (FMain.footer.Visible = True) then
        fnShowFootHead(False)
    end else if (goFrame <> Loading) or (goFrame <> Login) then begin
      if (FMain.header.Visible = False) or (FMain.footer.Visible = False) then
        fnShowFootHead(True)
    end;

    if fromFrame = Login then
      FLogin.ReleaseFrame
    else if fromFrame = Loading then
      FLoading.ReleaseFrame
    else if fromFrame = Home then
      FHome.Visible := False
    else if fromFrame = Fra2 then
      F2.Visible := False
    else if fromFrame = Fra3 then
      F3.Visible := False
    else if fromFrame = Fra4 then
      F4.Visible := False;

    if goFrame = Login then
      goLogin
    else if goFrame = Loading then
      goLoading
    else if goFrame = Home then
      goHome
    else if goFrame = Fra2 then
      goF2
    else if goFrame = Fra3 then
      goF3
    else if goFrame = Fra4 then
      goF4;

    tabCount := 0;

    FMain.faShow.Enabled := True;
    FMain.faShowHeight.Enabled := True;
  except
  end;
end;

procedure fnShowFootHead(stat : Boolean = True);
begin
  with FMain do
  begin
    if stat = True then
    begin
      statFH := stat;
      tcMain.Margins.Top := 5;

      footer.Height := 1;
      header.Height := 1;

      faShowFooter.StartValue := 1;
      faShowFooter.StopValue := 50;

      faShowHeader.StartValue := 1;
      faShowHeader.StopValue := 50;

      footer.Visible := True;
      header.Visible := True;

      faShowFooter.Enabled := True;
      faShowHeader.Enabled := True;
    end else
    begin
      statFH := stat;
      tcMain.Margins.Top := 0;

      footer.Height := 50;
      header.Height := 50;

      faShowFooter.StartValue := 50;
      faShowFooter.StopValue := 1;

      faShowHeader.StartValue := 50;
      faShowHeader.StopValue := 1;

      faShowFooter.Enabled := True;
      faShowHeader.Enabled := True;
    end;
  end;
end;

procedure fnShowE(text : String; stat : Cardinal);
var
  colBG : Cardinal;
begin
  TThread.Synchronize(nil, procedure
  begin
    try
      with FMain do
      begin
        statErr := True;
        coErr := 0;

        loMessage.BringToFront;
        loMessage.Opacity := 1;

        loMessage.Align := TAlignLayout.Center;
        loMessage.Align := TAlignLayout.None;

        loMessage.Position.Y := FMain.Height - (loMessage.Height + 50);

        lblMessage.Text := text;
        if tiError.Enabled = False then
          tiError.Enabled := True;

        if stat = Err then
          colBG := $FFECC8C5
        else if stat = Sukses then
          colBG := $FFD0E9DF
        else if stat = Ok then
          colBG := $FFCEE7F8;

        reMessage.Fill.Color := colBG;
        lblMessage.FontColor := stat;
        lblMessage.StyledSettings := [];
      end;
    except

    end;
  end);
end;

procedure fnLoading;
begin
  TThread.Synchronize(nil, procedure
  begin
    FMain.loLoad.BringToFront;
    FMain.loLoad.Visible := True;
    FMain.aniLoad.Enabled := True;
  end);
end;

procedure fnCloseLoading;
begin
  TThread.Synchronize(nil, procedure
  begin
    FMain.loLoad.Visible := False;
    FMain.aniLoad.Enabled := False;
  end);
end;

procedure fnLoadLoading(lo : TLayout; ani : TAniIndicator; stat : Boolean);  //ganti ini
begin
  TThread.Queue(nil, procedure
  begin
    if stat = True then
      lo.BringToFront;
    lo.Visible := stat;
    ani.Enabled := stat;
  end);
end;

procedure fnGetE(Msg, Cls : String);
begin
  TThread.Synchronize(nil, procedure
  begin
    FMain.memLog.Lines.Add('Message : ' + Msg);
    FMain.memLog.Lines.Add('Class E : ' + Cls);
  end);
end;

end.
