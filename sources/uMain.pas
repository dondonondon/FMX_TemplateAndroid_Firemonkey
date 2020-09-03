unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects,
  System.ImageList, FMX.ImgList, System.Rtti, FMX.Grid.Style, FMX.ScrollBox,
  FMX.Grid,FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListBox, FMX.Ani, System.Threading,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Memo, FMX.Edit,
  {$IFDEF ANDROID}
    Androidapi.Helpers, FMX.Platform.Android, System.Android.Service, System.IOUtils,
    FMX.Helpers.Android, Androidapi.JNI.PlayServices, Androidapi.JNI.Os,
  {$ELSEIF Defined(MSWINDOWS)}
    IWSystem,
  {$ENDIF}
  System.Generics.Collections;

const
  //FRAME
  LOADING = 'LOADING';
  HOME = 'HOME';
  LOGIN = 'LOGIN';

  //Proses
  PBack = 'go Back';
  pGo = 'go Go';

  idle = 400;
  FontS = 11;

procedure fnTransitionFrame(from, go : TControl; faFrom, faGo : TFloatAnimation; prs : String);

procedure fnGoFrame(from, go : String; stat : Boolean = False);
procedure fnHideFrame(from : String);
procedure fnBack;

procedure fnLoadLoading(lo : TLayout; ani : TAniIndicator; stat : Boolean); overload;  //ganti ini
procedure fnLoadLoading(stat : Boolean); overload;
procedure fnLoadLoadingAds(stat : Boolean);

procedure fnGetE(Msg, Cls : String); overload;
procedure fnGetE(mem : TMemo; str : String); overload;
procedure fnShowE(str : String);

procedure fnThreadSyncGoFrame(from, go : String);
procedure setSearch(lv : TListView);

procedure setEdit(E : TEdit);
procedure fnSimpanUserINI(usr, pass : String);
procedure fnLoadUserINI;
procedure fnClearUserINI;

var
  FCorner : TList<TCornerButton>;
  goFrame, fromFrame, tempFrom, VInfo : String;
  statTransition : Boolean;
  tabCount : Integer;

  username, password : String;

  //PERMISSION
  FPermissionReadExternalStorage, FAccess_Coarse_Location, FAccess_Fine_Location,
  FPermissionWriteExternalStorage: string;

implementation

uses frMain, uFunc, uGoFrame, uOpenUrl, uRest;

procedure fnTransitionFrame(from, go : TControl; faFrom, faGo : TFloatAnimation; prs : String);
var
  i : Integer;
begin
  statTransition := True;

  tabCount := 0;

  with FMain do begin
    loDisable.Visible := True;

    if fromFrame <> '' then
      from.Visible := False;

    go.Visible := True;
    go.BringToFront;

    faGo.Parent := go;
    faFrom.Parent := go;

    faGo.PropertyName := 'Position.Y';
    faFrom.PropertyName := 'Opacity';

    faGo.StartValue := 50;
    faGo.StopValue := 0;

    faFrom.StartValue := 0.65;
    faFrom.StopValue := 1;

    faGo.Duration := 0.25;
    faFrom.Duration := 0.2;

    faFrom.Interpolation := TInterpolationType.Quadratic;
    faGo.Interpolation := TInterpolationType.Quadratic;

    //fnChangeFrame(goFrame, True);
    fnShowFrame;

    Sleep(100);

    faGo.Enabled := True;

    if fromFrame <> '' then
      faFrom.Enabled := True;
  end;
end;

procedure fnGoFrame(from, go : String; stat : Boolean = False);
var
  proses : String;
  i: Integer;
begin
  if stat = False then
    proses := pGo
  else
    proses := pBack;

  //fnGetFromFrame(from);
  //fnChangeFrame(go);
  fnGetFrame(sFrom, from);
  fnGetFrame(sGo, go);

  if not Assigned(frGo) then begin
    fnShowE('MOHON MAAF, TERJADI KESALAHAN');
    Exit;
  end;

  fromFrame := from;
  goFrame := go;

  tabCount := 0;

  fnTransitionFrame(frFrom, frGo, FMain.faFromX, FMain.faGoX, proses);
end;

procedure fnHideFrame(from : String);
begin
  if fromFrame <> '' then
    frFrom.Visible := False;

  frFrom := nil;
  frGo := nil;
end;

procedure fnBack;
begin

end;


procedure fnLoadLoading(lo : TLayout; ani : TAniIndicator; stat : Boolean);
begin
  TThread.Synchronize(nil, procedure
  begin
    if stat = True then
      lo.BringToFront;
    lo.Visible := stat;
    //ani.Kind := TLoadingIndicatorKind.Wave;
    ani.Enabled := stat;
  end);
end;

procedure fnLoadLoading(stat : Boolean);
begin
  with FMain do begin
    fnLoadLoading(loLoad, aniLoad, stat);
  end;
end;

procedure fnLoadLoadingAds(stat : Boolean);
begin
  with FMain do begin
    //fnLoadLoading(loLoadAds, aniLoadAds, stat);
  end;
end;

procedure fnGetE(Msg, Cls : String); overload;
begin
  TThread.Synchronize(nil, procedure
  begin
    FMain.memLog.Lines.Add('Message : ' + Msg);
    FMain.memLog.Lines.Add('Class E : ' + Cls);
  end);
end;

procedure fnGetE(mem : TMemo; str : String);
begin
  TThread.Synchronize(nil, procedure
  begin
    mem.BeginUpdate;
    try
      mem.Lines.Add(str);
    finally
      mem.EndUpdate;
    end;
  end);
end;

procedure fnShowE(str : String);
begin
  with FMain do begin
    TThread.Synchronize(nil, procedure
    begin
      //TM.Toast(UpperCase(str));
    end);
  end;
end;

procedure fnThreadSyncGoFrame(from, go : String);
begin
  TThread.Synchronize(nil, procedure begin
    fnGoFrame(from, go);
  end);
end;

procedure setSearch(lv : TListView);
var
  i: Integer;
  edSearch: TEdit;
begin
  for i := 0 to lv.ControlsCount - 1 do
  begin
    if lv.Controls[i] is TEdit then
    begin
      edSearch := TEdit(lv.Controls[i]);
      edSearch.Text := '';
      edSearch.TextPrompt := 'pencarian...';
      edSearch.Font.Size := 11;
      edSearch.StyleLookup := 'edLV';
      edSearch.Height := 40;

      Break;
    end;
  end;
end;

procedure setEdit(E : TEdit);
var
  L : TLabel;
  T : TFloatAnimation;
  i: Integer;
begin
  L := nil;

  for i := 0 to E.ControlsCount - 1 do begin
    if E.Controls[i] is TLabel then
      L := TLabel(E.Controls[i]);
  end;

  if not Assigned(L) then begin
    L := TLabel.Create(E);
    L.Parent := E;
    L.Width := E.Width;
    L.Text := E.TextPrompt;
    fnGetCenter(E, L);
    L.Position.X := 0;
    L.Font.Size := 13;
    L.FontColor := E.FontColor;
    L.Font.Style := [TFontStyle.fsBold];
    L.StyledSettings := [];

    L.Visible := False;

    T := TFloatAnimation.Create(L);
    T.Parent := L;
    T.Interpolation := TInterpolationType.Quadratic;
    T.PropertyName := 'Position.Y';
    T.Duration := 0.15;
    T.StartValue := L.Position.Y;
    T.StopValue := -17;

    T.Trigger := 'IsVisible=true';
    T.TriggerInverse := 'IsVisible=false';
  end;

  if E.Text <> '' then begin
    L.Visible := True;
  end else begin
    L.Visible := False;
  end;
end;

procedure fnSimpanUserINI(usr, pass : String);
begin
  SaveSettingString('user', 'usr', usr);
  SaveSettingString('user', 'password', pass);
end;

procedure fnClearUserINI;
begin
  SaveSettingString('user', 'usr', '');
  SaveSettingString('user', 'password', '');
end;

procedure fnLoadUserINI;
begin
  username := LoadSettingString('user', 'usr','');
  password := LoadSettingString('user', 'password','');
end;

end.
