unit FrHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.TabControl, FMXTee.Engine,
  FMXTee.Series, FMXTee.Procs, FMXTee.Chart, FMX.Objects, FMX.Layouts,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Gestures, FMX.Effects, FMX.Ani, FMX.ImgList, System.Threading;

type
  TFHome = class(TFrame)
    tcMain: TTabControl;
    tiMain: TTabItem;
    loMain: TLayout;
    lvMain: TListView;
    aniLV: TAniIndicator;
    btnAdd: TCornerButton;
    lblTgl: TLabel;
    loHeader: TLayout;
    reHeader: TRectangle;
    gplHighlight: TGridPanelLayout;
    imgHL: TImage;
    lblKode: TLabel;
    lblAlias: TLabel;
    lblharga: TLabel;
    loKet: TLayout;
    lblKet: TLabel;
    glKet: TGlyph;
    loChart: TLayout;
    chHeader: TChart;
    Series1: TAreaSeries;
    cpChart: TCalloutPanel;
    Rectangle6: TRectangle;
    lblTanggalChart: TLabel;
    lblValueChart: TLabel;
    faHeaderHide: TFloatAnimation;
    faHeaderShow: TFloatAnimation;
    reLeft: TRectangle;
    InnerGlowEffect1: TInnerGlowEffect;
    Glyph1: TGlyph;
    reRight: TRectangle;
    Glyph2: TGlyph;
    InnerGlowEffect2: TInnerGlowEffect;
    Label1: TLabel;
    aniHd: TAniIndicator;
    reLine: TRectangle;
    tiTemp: TTabItem;
    loTemp1: TLayout;
    btnBack: TCornerButton;
    tiChart: TTimer;
    tiData: TTimer;
    GM: TGestureManager;
    RClient: TRESTClient;
    RReq: TRESTRequest;
    RResp: TRESTResponse;
    procedure tiChartTimer(Sender: TObject);
    procedure chHeaderMouseLeave(Sender: TObject);
    procedure chHeaderMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
  private
    arrHarga : array of record //untuk menyimpan data digunakan untuk ditampilkan di chart
      jenis : String;
      nama : String;
      harga : Double;
    end;
    jmlData, cou : Integer;
    { Private declarations }
    procedure LoadHarga;
    procedure addItem(id, kd, nm : String; harga, ket : Double);
  public
    { Public declarations }
    procedure FirstShow;
    procedure ReleaseFrame;
  end;

var
  FHome : TFHome;

implementation

{$R *.fmx}

uses uMain, uRest, uDM;

{ TFHome }

procedure TFHome.addItem(id, kd, nm: String; harga, ket: Double);
var
  ItemAdd : TListViewItem;
  txt : TListItemText;
begin
  try
    ItemAdd := lvMain.Items.Add;
    with ItemAdd do
    begin
      txt := TListItemText(Objects.FindDrawable('idSaham'));
      txt.Text := id;
      txt := TListItemText(Objects.FindDrawable('KodeSaham'));
      txt.Text := kd;
      txt := TListItemText(Objects.FindDrawable('NamaSaham'));
      txt.Text := nm;
      txt := TListItemText(Objects.FindDrawable('HargaSekarang'));
      txt.Text := 'Rp. ' + FormatFloat('###,##0.00', harga);
      txt := TListItemText(Objects.FindDrawable('Keterangan'));
      txt.Text := ket.ToString;
    end;
  except

  end;
end;

procedure TFHome.chHeaderMouseLeave(Sender: TObject);
begin
  cpChart.Visible := False;
end;

procedure TFHome.chHeaderMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
var
  xTemp, yTemp, ww, max, min : Double;
  xx : Integer;
begin
  cpChart.Visible := True;
  try
    max := loChart.Width - cpChart.Width;
    min := (cpChart.Width / 2);

    chHeader.Series[0].GetCursorValues(xTemp, yTemp);
    if xTemp < Round(xTemp) then
      xTemp := Round(xTemp - 0.5)
    else
      xTemp := Round(xTemp);

    xx := StrToIntDef(FloatToStr(xTemp),0);

    lblValueChart.Text := FormatFloat('###,##0.00', arrHarga[xx + 1].harga);
    lblTanggalChart.Text := UpperCase(arrHarga[xx + 1].jenis);

    if X > max then
      ww := x - cpChart.Width
    else if X < min then
      ww := x
    else
      ww := x - min;

    cpChart.Position.X := ww;
    cpChart.Position.Y := y - (cpChart.Height * 2);
  except
  end;
end;

procedure TFHome.FirstShow;
var
  Task : ITask;
begin
  Task := TTask.Create(procedure
  begin
    //Tasking, agar responsive. hati hati dalam menggunakan Task.
    LoadHarga;
  end);
  Task.Start;
end;

procedure TFHome.LoadHarga;
var
  arr : TStringArray;
  bar : Integer;
begin
  try
    arr := fnParseJSON(DM.RClient, DM.RReq, DM.RResp, 'getHarga');

    if arr[0, 0] = 'null' then
      Exit;

    jmlData := Length(arr[0]); //panjang array json

    SetLength(arrHarga, Length(arr[0]));
    for bar := 0 to jmlData - 1 do
    begin
      arrHarga[bar].jenis := arr[0, bar];
      arrHarga[bar].nama := arr[1, bar];
      arrHarga[bar].harga := StrToFloatDef(arr[2, bar], 1); //[data ke..., baris ke..]
    end;

    TThread.Queue(nil, procedure
    begin
      //Thread ini digunakan untuk mengupdate GUI
      //how to check link ==> inputBox('','', url + 'getHarga');
      //inputBox('','', url + 'getHarga');
      cou := 0;
      chheader.Series[0].Clear;
      tichart.Enabled := True; //chart agar keren dikit
    end);

  except
    On E : Exception do
    begin
      fnGetE(E.Message, E.ClassName);
      fnShowE('Error : ' + E.Message, Err);
    end;
  end;
end;

procedure TFHome.ReleaseFrame;
begin
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    DisposeOf;
  {$ELSE}
    Free;
  {$ENDIF}
  FHome := Nil;
end;

procedure TFHome.tiChartTimer(Sender: TObject);
begin
  try
    if cou > jmlData - 1 then
      tiChart.Enabled := False
    else
    begin
      chHeader.Series[0].Add(arrHarga[cou].harga);
      addItem('', arrHarga[cou].jenis, arrHarga[cou].nama, arrHarga[cou].harga, 0);
      Inc(cou);
    end;
  except
    tiChart.Enabled := False;
  end;
end;

end.
