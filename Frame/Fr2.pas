unit Fr2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, System.Rtti, FMX.Grid.Style, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.Grid,
  FMX.ScrollBox, FMXTee.Series, FMXTee.Engine, FMXTee.Procs, FMXTee.Chart,
  FMX.ImgList, FMX.Objects, FMX.Layouts;

type
  TF2 = class(TFrame)
    vsMain: TVertScrollBox;
    gplNavigasi: TGridPanelLayout;
    btnLeft: TCornerButton;
    btnRight: TCornerButton;
    Layout6: TLayout;
    Rectangle6: TRectangle;
    lblRange: TLabel;
    loPrediksi: TLayout;
    Rectangle2: TRectangle;
    Layout2: TLayout;
    Label2: TLabel;
    lblHP: TLabel;
    Layout3: TLayout;
    glP: TGlyph;
    lblSP: TLabel;
    lblTglP: TLabel;
    loChart: TLayout;
    ChPrediksi: TChart;
    Series2: TAreaSeries;
    Series3: TLineSeries;
    loReload: TLayout;
    btnReload: TCornerButton;
    Layout5: TLayout;
    lblHasil: TLabel;
    lblLastHistory: TLabel;
    lblTarget: TLabel;
    Layout7: TLayout;
    Label6: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    loLoading: TLayout;
    aniChart: TAniIndicator;
    cbStairs: TCheckBox;
    loHargaToday: TLayout;
    Rectangle1: TRectangle;
    loSpotEmas_: TLayout;
    label9: TLabel;
    lblHN: TLabel;
    Layout10: TLayout;
    glN: TGlyph;
    lblSN: TLabel;
    lblTglN: TLabel;
    Rectangle3: TRectangle;
    stgMain: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    Rectangle4: TRectangle;
    Label10: TLabel;
    btnSelengkapnya: TCornerButton;
    Layout4: TLayout;
    Layout1: TLayout;
    Label8: TLabel;
    lblLastHarga: TLabel;
    gplHeader: TGridPanelLayout;
    CornerButton1: TCornerButton;
    CornerButton2: TCornerButton;
    lblHeader: TLabel;
    reLine: TRectangle;
    tiGrafik: TTimer;
    RClient: TRESTClient;
    RReq: TRESTRequest;
    RResp: TRESTResponse;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FirstShow;
    procedure ReleaseFrame;
  end;

var
  F2 : TF2;

implementation

{$R *.fmx}

{ TF2 }

procedure TF2.FirstShow;
begin

end;

procedure TF2.ReleaseFrame;
begin
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    DisposeOf;
  {$ELSE}
    Free;
  {$ENDIF}
  F2 := Nil;
end;

end.
