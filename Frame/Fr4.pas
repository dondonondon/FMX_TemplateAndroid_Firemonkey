unit Fr4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TF4 = class(TFrame)
    CornerButton1: TCornerButton;
    Label1: TLabel;
    procedure CornerButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FirstShow;
    procedure ReleaseFrame;
  end;

var
  F4 : TF4;

implementation

{$R *.fmx}

uses uMain, uDM, uFunc;

{ TF4 }

procedure TF4.CornerButton1Click(Sender: TObject);
begin
  try
    DM.Conn.StartTransaction;

    fnSQLAdd(DM.QTemp1, 'DELETE FROM tbl_username', True);
    fnExecSQL(DM.QTemp1);

    DM.Conn.Commit;
    fnShowE('SUKSES LOGOUT', Ok);
  except
    DM.Conn.Rollback;
  end;

  fnGoFrame(goFrame, Login);
end;

procedure TF4.FirstShow;
begin

end;

procedure TF4.ReleaseFrame;
begin
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    DisposeOf;
  {$ELSE}
    Free;
  {$ENDIF}
  F4 := Nil;
end;

end.
