unit FrMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani, FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, FMX.DialogService,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.ScrollBox, FMX.Memo, FMX.TabControl, System.ImageList, System.Math,
  FMX.ImgList, FMX.MultiView, FMXTee.Engine, FMXTee.Series, FMX.VirtualKeyboard,
  FMXTee.Procs, FMXTee.Chart, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.Gestures, FMX.Effects, FMX.Platform;

type
  TFMain = class(TForm)
    header: TRectangle;
    loHeader: TLayout;
    btnBack: TCornerButton;
    faBack: TFloatAnimation;
    btnNotif: TCornerButton;
    loMessage: TLayout;
    reMessage: TRectangle;
    lblMessage: TLabel;
    SB: TStyleBook;
    tiDetik: TTimer;
    tiFH: TTimer;
    tiReload: TTimer;
    tcMain: TTabControl;
    tiMain: TTabItem;
    loMain: TLayout;
    vsMain: TVertScrollBox;
    faShow: TFloatAnimation;
    footer: TToolBar;
    bgFooter: TRectangle;
    gplMenu: TGridPanelLayout;
    btnPrediksi: TCornerButton;
    btnNews: TCornerButton;
    btnChat: TCornerButton;
    btnAcc: TCornerButton;
    tiTemp: TTabItem;
    btnTest: TCornerButton;
    memLog: TMemo;
    ListView1: TListView;
    mvMain: TMultiView;
    loBackground: TLayout;
    reBGMV: TRectangle;
    Image1: TImage;
    btnPrediksiMV: TCornerButton;
    btnNewsMV: TCornerButton;
    btnAccMV: TCornerButton;
    btnChatMV: TCornerButton;
    faShowHeight: TFloatAnimation;
    faShowFooter: TFloatAnimation;
    faShowHeader: TFloatAnimation;
    tiError: TTimer;
    loLoad: TLayout;
    aniLoad: TAniIndicator;
    img: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure btnPrediksiClick(Sender: TObject);
    procedure btnNewsClick(Sender: TObject);
    procedure btnChatClick(Sender: TObject);
    procedure btnAccClick(Sender: TObject);
    procedure faShowFinish(Sender: TObject);
    procedure faShowHeightFinish(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure faShowFooterFinish(Sender: TObject);
    procedure faShowHeaderFinish(Sender: TObject);
    procedure tiFHTimer(Sender: TObject);
    procedure btnNotifClick(Sender: TObject);
    procedure tiErrorTimer(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    {Keyboard}
    FService1 : IFMXVirtualKeyboardToolbarService;
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    {Keyboard}
    { Private declarations }
    procedure setForm;

    {Keyboard}
    procedure CalcContentBoundsProc(Sender: TObject;
                                    var ContentBounds: TRectF);
    procedure RestorePosition;
    procedure UpdateKBBounds;
    {Keyboard}
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.fmx}

uses uMain, FrLoading, uGoFrame, FrLogin;

{ TFMain }

procedure TFMain.btnAccClick(Sender: TObject);
begin
  if goFrame = Fra4 then
    Exit;

  fnDefICO(btnAcc, btnAccMV, 0);
  fnGoFrame(goFrame, Fra4);
end;

procedure TFMain.btnChatClick(Sender: TObject);
begin
  if goFrame = Fra3 then
    Exit;

  fnDefICO(btnChat, btnChatMV, 0);
  fnGoFrame(goFrame, Fra3);
end;

procedure TFMain.btnNewsClick(Sender: TObject);
begin
  if goFrame = Fra2 then
    Exit;

  fnDefICO(btnNews, btnNewsMV, 0);
  fnGoFrame(goFrame, Fra2);
end;

procedure TFMain.btnNotifClick(Sender: TObject);
begin
  fnGoFrame(goFrame, Loading);
end;

procedure TFMain.btnPrediksiClick(Sender: TObject);
begin
  if goFrame = Home then
    Exit;

  fnDefICO(btnPrediksi, btnPrediksiMV, 0);
  fnGoFrame(goFrame, Home);
end;

procedure TFMain.CalcContentBoundsProc(Sender: TObject;   //kibord
  var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
                                2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TFMain.faShowFinish(Sender: TObject);
begin
  faShow.Enabled := False;
  faShowHeight.StartValue := 50;
  faShowHeight.StopValue := 0;
end;

procedure TFMain.faShowFooterFinish(Sender: TObject);
begin
  if statFH = False then
    footer.Visible := False;
  faShowFooter.Enabled := False;
end;

procedure TFMain.faShowHeaderFinish(Sender: TObject);
begin
  if statFH = False then
    header.Visible := False;
  faShowHeader.Enabled := False;
end;

procedure TFMain.faShowHeightFinish(Sender: TObject);
begin
  fnLoadLoading(loLoad, aniLoad, False);
  faShowHeight.Enabled := False;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardToolbarService, IInterface(FService1)) then
  begin
    FService1.SetToolbarEnabled(True);
    FService1.SetHideKeyboardButtonVisibility(True);
  end;
  vsMain.OnCalcContentBounds := CalcContentBoundsProc;

  setForm;
end;

procedure TFMain.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;

procedure TFMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
var FService: IFMXVirtualKeyboardService;
begin
  if Key = vkHardwareBack  then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
    begin
      FService.HideVirtualKeyboard;
    end
    else
    begin
      Key := 0;
      if goFrame = Home then
      begin
        if tabCount < 1 then
          fnShowE('Tap Dua Kali Untuk Keluar', Ok)
        else
          fnShowE('Sampai Jumpa Kembali', Ok);
        Inc(TabCount);
      end;

      if ((goFrame = Home) or (goFrame = Login)) and (TabCount >= 2) then
      begin
        Application.Terminate;
      end;
    end;
  end
  else
  if Key = vkReturn then
  begin
    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
    begin
      FService.HideVirtualKeyboard;
    end;
  end;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  tcMain.Margins.Top := 0;
  fnGoFrame(Loading, Loading);
end;

procedure TFMain.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TFMain.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TFMain.RestorePosition; //kibord
begin
  vsMain.ViewportPosition := PointF(vsMain.ViewportPosition.X, 0);
  loMain.Align := TAlignLayout.Client;
  vsMain.RealignContent;
end;

procedure TFMain.setForm;
begin
  GlobalUseGPUCanvas := True;
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    FullScreen := True;
  {$ELSE}

  {$ENDIF}
  header.Visible := False;
  footer.Visible := False;
  mvMain.Width := 300;
  loMessage.Opacity := 0;
end;

procedure TFMain.tiErrorTimer(Sender: TObject);
begin
  try
    if statErr = True then
    begin
      if coErr < 5 then
        Inc(coErr)
      else
        statErr := False;
    end else
    begin
      loMessage.Opacity := loMessage.Opacity - 0.05;

      if loMessage.Opacity <= 0 then
        tiError.Enabled := False;
    end;
  except
    begin
      tiError.Enabled := False;
      loMessage.Opacity := 0;
    end;
  end;
end;

procedure TFMain.tiFHTimer(Sender: TObject);
begin
  tiFH.Enabled := False;
  fnShowFootHead(True);
end;

procedure TFMain.UpdateKBBounds;  //kibord
var
  LFocused : TControl;
  LFocusRect: TRectF;
begin
  FNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(vsMain.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and
       (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FNeedOffset := True;
      loMain.Align := TAlignLayout.Horizontal;
      vsMain.RealignContent;
      Application.ProcessMessages;
      vsMain.ViewportPosition :=
        PointF(vsMain.ViewportPosition.X,
               LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;
  if not FNeedOffset then
    RestorePosition;
end;

end.
