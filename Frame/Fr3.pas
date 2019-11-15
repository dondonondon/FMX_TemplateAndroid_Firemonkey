unit Fr3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TF3 = class(TFrame)
    Label1: TLabel;
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
