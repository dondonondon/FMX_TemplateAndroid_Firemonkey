unit FrHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TFHome = class(TFrame)
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FirstShow;
    procedure ReleaseFrame;
  end;

var
  FHome : TFHome;

implementation

{$R *.fmx}

uses uMain;

{ TFHome }

procedure TFHome.FirstShow;
begin

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

end.
