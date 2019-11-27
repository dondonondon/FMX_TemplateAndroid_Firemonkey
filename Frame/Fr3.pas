unit Fr3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, System.Rtti, FMX.Grid.Style, FMX.Gestures,
  System.Actions, FMX.ActnList, FMX.TabControl, FMX.Grid, FMXTee.Series,
  FMX.ScrollBox, FMX.Memo, FMX.ListView, FMX.Layouts, FMX.ImgList, FMX.Effects,
  FMXTee.Engine, FMXTee.Procs, FMXTee.Chart, FMX.Objects, FMX.Ani;

type
  TF3 = class(TFrame)
    faOpaMain: TFloatAnimation;
    gplHeader: TGridPanelLayout;
    reHeader: TRectangle;
    Rectangle2: TRectangle;
    Layout2: TLayout;
    lblRegion: TLabel;
    lblAlias: TLabel;
    loRate: TLayout;
    lblRate: TLabel;
    btnRate: TCornerButton;
    reLine: TRectangle;
    loSwipe: TLayout;
    rePrediksi: TRectangle;
    chHeader: TChart;
    Series1: TAreaSeries;
    loLoadingPrediksi: TLayout;
    aniLoadingPrediksi: TAniIndicator;
    Popup1: TPopup;
    lblValueChart: TLabel;
    lblTanggalChart: TLabel;
    reLeft: TRectangle;
    InnerGlowEffect1: TInnerGlowEffect;
    Glyph1: TGlyph;
    reRight: TRectangle;
    Glyph2: TGlyph;
    InnerGlowEffect2: TInnerGlowEffect;
    loPrediksi: TLayout;
    lblTanggal: TLabel;
    loHargaSekarang: TLayout;
    lblHargaSekarang: TLabel;
    glN: TGlyph;
    lblSN: TLabel;
    faHeaderHide: TFloatAnimation;
    faHeaderShow: TFloatAnimation;
    loDetailPrediksi: TLayout;
    Label2: TLabel;
    lblRange: TLabel;
    lbltglPred: TLabel;
    lblPrediksi: TLabel;
    FlowLayout1: TFlowLayout;
    lblSNPrediksi: TLabel;
    glP: TGlyph;
    loInfo: TLayout;
    tcMain: TTabControl;
    tiFeed: TTabItem;
    lvFeed: TListView;
    loFeed: TLayout;
    btnAddFeed: TCornerButton;
    glChat: TGlyph;
    reFeed: TRectangle;
    faWReFeed: TFloatAnimation;
    faHReFeed: TFloatAnimation;
    faWReFBack: TFloatAnimation;
    faHReFBack: TFloatAnimation;
    memFeed: TMemo;
    tiGrafikPrediksi: TTabItem;
    reChart: TRectangle;
    ChPrediksi: TChart;
    Series2: TAreaSeries;
    Series3: TLineSeries;
    Popup2: TPopup;
    lblTargetC: TLabel;
    lblTglC: TLabel;
    lblPrediksiC: TLabel;
    tiHistory: TTabItem;
    stgMain: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    loDownload: TLayout;
    btnDownload: TCornerButton;
    Glyph3: TGlyph;
    loLoadingInfo: TLayout;
    aniLoadingInfo: TAniIndicator;
    tiGrafikHeader: TTimer;
    tiFeedT: TTimer;
    ACL: TActionList;
    ctFeed: TChangeTabAction;
    ctGrafik: TChangeTabAction;
    ctHistory: TChangeTabAction;
    GM: TGestureManager;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FirstShow;
    procedure ReleaseFrame;
  end;

var
  F3 : TF3;

implementation

{$R *.fmx}

{ TF3 }

procedure TF3.FirstShow;
begin

end;

procedure TF3.ReleaseFrame;
begin
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    DisposeOf;
  {$ELSE}
    Free;
  {$ENDIF}
  F3 := Nil;
end;

end.
