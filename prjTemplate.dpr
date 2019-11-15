program prjTemplate;

uses
  System.StartUpCopy,
  FMX.Forms,
  FrMain in 'FrMain.pas' {FMain},
  {$IFDEF ANDROID}
  FMX.FontGlyphs.Android in 'Source\FMX.FontGlyphs.Android.pas',
  {$ENDIF }
  uFontSetting in 'Source\uFontSetting.pas',
  uFunc in 'Source\uFunc.pas',
  uHelper in 'Source\uHelper.pas',
  uOpenUrl in 'Source\uOpenUrl.pas',
  uRest in 'Source\uRest.pas',
  uStartUp in 'Source\uStartUp.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  uMain in 'Source\uMain.pas',
  FrLoading in 'Frame\FrLoading.pas' {FLoading: TFrame},
  uGoFrame in 'Source\uGoFrame.pas',
  FrLogin in 'Frame\FrLogin.pas' {FLogin: TFrame},
  uSign in 'Source\uSign.pas',
  FrHome in 'Frame\FrHome.pas' {FHome: TFrame},
  Fr2 in 'Frame\Fr2.pas' {F2: TFrame},
  Fr3 in 'Frame\Fr3.pas' {F3: TFrame},
  Fr4 in 'Frame\Fr4.pas' {F4: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
