unit FrLoading;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.TabControl, FMX.Objects, FMX.Ani, FMX.Controls.Presentation, FMX.Layouts,
  System.Threading;

type
  TFLoading = class(TFrame)
    tcMain: TTabControl;
    tiLoad: TTabItem;
    ti1: TTabItem;
    ti2: TTabItem;
    ti3: TTabItem;
    ti4: TTabItem;
    reBG: TRectangle;
    faAniOpa: TFloatAnimation;
    tiShow: TTimer;
    Rectangle1: TRectangle;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Layout1: TLayout;
    CornerButton1: TCornerButton;
    Label3: TLabel;
    Label4: TLabel;
    Layout2: TLayout;
    CornerButton3: TCornerButton;
    Rectangle2: TRectangle;
    Image3: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Layout3: TLayout;
    CornerButton5: TCornerButton;
    Rectangle3: TRectangle;
    Image4: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Layout4: TLayout;
    CornerButton7: TCornerButton;
    CornerButton8: TCornerButton;
    Rectangle4: TRectangle;
    Image5: TImage;
    CornerButton6: TCornerButton;
    CornerButton4: TCornerButton;
    lg: TLang;
    tiMove: TTimer;
    Label9: TLabel;
    procedure faAniOpaFinish(Sender: TObject);
    procedure tiShowTimer(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
    procedure CornerButton4Click(Sender: TObject);
    procedure CornerButton7Click(Sender: TObject);
    procedure tiMoveTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure setFrame;
    procedure FirstShow;
    procedure ReleaseFrame;
  end;

var
  FLoading : TFLoading;

implementation

{$R *.fmx}

uses FrMain, uDM, uGoFrame, uStartUp, uFunc, uMain;

procedure TFLoading.CornerButton1Click(Sender: TObject);
begin
  tcMain.Next();
end;

procedure TFLoading.CornerButton4Click(Sender: TObject);
begin
  tcMain.Previous();
end;

procedure TFLoading.CornerButton7Click(Sender: TObject);
begin
  tcMain.TabPosition := TTabPosition.None;
  tiLoad.Visible := True;
  tcMain.First();
  tiMove.Enabled := True;
end;

procedure TFLoading.faAniOpaFinish(Sender: TObject);
begin
  faAniOpa.Enabled := False;
end;

procedure TFLoading.FirstShow;
var
  Task : ITask;
begin
  setFrame;
  try
    fnSQLAdd(DM.QTemp1, 'SELECT * FROM tbl_setting WHERE stat = ''DateInstall''', True);
    fnSQLOpen(DM.QTemp1);

    if not DM.QTemp1.IsEmpty then
    begin
      fnSQLAdd(DM.QTemp1, 'SELECT * FROM tbl_username', True);
      fnSQLOpen(DM.QTemp1);

      if DM.QTemp1.IsEmpty then
      begin
        fnGoFrame(goFrame, Login);
        Exit;
      end;

      start
    end
    else
    begin
      Task := TTask.Create(procedure ()
      begin
        DateInstall;
        Sleep(2000);
        TThread.Queue(nil,
        procedure
        begin
          //tiShow.Enabled := True;
          tcMain.Next();
          tiLoad.Visible := False;
          tcMain.TabPosition := TTabPosition.Dots;
          tiShow.Enabled := False;
        end);
      end);
      Task.Start;
    end;
  except
    fnGoFrame(goFrame, Home);
  end;
end;

procedure TFLoading.ReleaseFrame;
begin
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    DisposeOf;
  {$ELSE}
    Free;
  {$ENDIF}
  FLoading := nil;
end;

procedure TFLoading.setFrame;
begin
  goFrame := Loading;

  tcMain.Height := FMain.vsMain.Height;
  tcMain.Width := FMain.vsMain.Width;

  reBG.Height := tcMain.Height;
  reBG.Width := tcMain.Width;

  LoadLangFromStrings(lg.LangStr['EN']);
end;

procedure TFLoading.tiMoveTimer(Sender: TObject);
begin
  fnGoFrame(goFrame, Login);
end;

procedure TFLoading.tiShowTimer(Sender: TObject);
begin
  tcMain.Next();
  tiLoad.Visible := False;
  tcMain.TabPosition := TTabPosition.Dots;
  tiShow.Enabled := False;
end;

end.
