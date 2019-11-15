unit FrLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.TabControl, FMX.Ani,
  FMX.ImgList, FMX.Edit, System.ImageList, FMX.Effects, System.Threading, System.RegularExpressions;

type
  TFLogin = class(TFrame)
    loMain: TLayout;
    reCenter: TRectangle;
    gplLogin: TGridPanelLayout;
    btnLogin: TCornerButton;
    btnSignUp: TCornerButton;
    tcMain: TTabControl;
    tiLogin: TTabItem;
    tiSignUp: TTabItem;
    loRegister: TLayout;
    btnRegister: TCornerButton;
    edREmail: TEdit;
    edRPass: TEdit;
    PasswordEditButton2: TPasswordEditButton;
    edRRePass: TEdit;
    PasswordEditButton3: TPasswordEditButton;
    edRUser: TEdit;
    faRegOpa: TFloatAnimation;
    loTermsCon: TLayout;
    cbTermsCon: TCheckBox;
    Label7: TLabel;
    loLoginOpa: TLayout;
    loLogo: TLayout;
    CornerButton1: TCornerButton;
    edLUser: TEdit;
    edLPass: TEdit;
    PasswordEditButton1: TPasswordEditButton;
    faLogOpa: TFloatAnimation;
    Glyph1: TGlyph;
    Glyph2: TGlyph;
    Glyph3: TGlyph;
    Glyph4: TGlyph;
    Glyph5: TGlyph;
    tiShow: TTimer;
    faOpa: TFloatAnimation;
    img: TImageList;
    ShadowEffect1: TShadowEffect;
    Glyph6: TGlyph;
    Glyph7: TGlyph;
    Glyph8: TGlyph;
    Glyph9: TGlyph;
    reBG: TRectangle;
    Image1: TImage;
    faAniOpa: TFloatAnimation;
    faHide: TFloatAnimation;
    Label9: TLabel;

    procedure ReleaseFrame;
    procedure btnLoginClick(Sender: TObject);
    procedure btnSignUpClick(Sender: TObject);
    procedure faOpaFinish(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
    procedure faHideFinish(Sender: TObject);
    procedure tiShowTimer(Sender: TObject);
    procedure edREmailTyping(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
  private
    { Private declarations }
    procedure fnReg;
    procedure fnLogin;
    function IsMatch(const Input, Pattern: string): boolean;
    function IsValidEmailRegEx(const EmailAddress: string): boolean;
  public
    { Public declarations }
    procedure FirstShow;
    procedure ClearData;
    procedure goLogin;
    procedure goRegister;
  end;

var
  FLogin : TFLogin;

implementation

{$R *.fmx}

uses uDM, FrMain, uMain, uSign;

{ TFLogin }

procedure TFLogin.btnLoginClick(Sender: TObject);
begin
  goLogin;
end;

procedure TFLogin.btnRegisterClick(Sender: TObject);
begin
  if cbTermsCon.IsChecked = False then
    fnShowE('Centang Terms & Conditions', Err)
  else
    fnReg;
end;

procedure TFLogin.btnSignUpClick(Sender: TObject);
begin
  goRegister;
end;

procedure TFLogin.ClearData;
begin
  edLUser.Text := '';
  edLPass.Text := '';
  edRUser.Text := '';
  edREmail.Text := '';
  edRPass.Text := '';
  edRRePass.Text := '';
end;

procedure TFLogin.CornerButton1Click(Sender: TObject);
begin
  if edLUser.Text = '' then
  begin
    fnShowE('FIELD USERNAME KOSONG', Err);
    Exit;
  end;

  if edLPass.Text = '' then
  begin
    fnShowE('FIELD PASSWORD KOSONG', Err);
    Exit;
  end;

  fnLoading;

  fnLogin;
  fnDefICO(FMain.btnPrediksi, FMain.btnPrediksiMV, 0);
end;

procedure TFLogin.edREmailTyping(Sender: TObject);
begin
  if edREmail.Text = '' then
    edREmail.FontColor := TAlphaColorRec.Black;

  if IsValidEmailRegEx(edREmail.Text) then
  begin
    edREmail.FontColor := TAlphaColorRec.Black;
  end
  else
    edREmail.FontColor := TAlphaColorRec.Red;

  edREmail.StyledSettings := [];
end;

procedure TFLogin.faHideFinish(Sender: TObject);
begin
  faHide.Enabled := False;
  faAniOpa.Enabled := True;

  tiShow.Enabled := True;
end;

procedure TFLogin.faOpaFinish(Sender: TObject);
begin
  faOpa.Enabled := False;
end;

procedure TFLogin.FirstShow;
begin
  faOpa.Enabled := True;
  goFrame := Login;
end;

procedure TFLogin.fnLogin;
var
  pass : String;
  Task : ITask;
begin
  pass := MD5(edLPass.Text);
  Task := TTask.Create(procedure ()
  begin
    LogUser(edLUser.Text, pass);
  end);
  Task.Start;
end;

procedure TFLogin.fnReg;
var
  Task : ITask;
begin
  if IsValidEmailRegEx(edREmail.Text) then
  begin
    if edRPass.Text <> edRRePass.Text then
      fnShowE('Password tidak sama', Err)
    else
    begin
      if (edRUser.Text = '') or (edREmail.Text = '') or (edRPass.Text = '') then
      begin
        fnShowE('Tidak Boleh Kosong', Err);
        Exit;
      end;

      fnLoading;
      Task := TTask.Create(procedure ()
      begin
        RegUser(edRUser.Text, edREmail.Text, edRPass.Text);
      end);
      Task.Start;
    end;
  end
  else
    fnShowE('Invalid Email', Err);
end;

procedure TFLogin.goLogin;
begin
  gplLogin.Enabled := False;
  btnLogin.StyleLookup := 'btnPressed';
  btnSignUp.StyleLookup := 'btnIdle';
  tcMain.Previous();
  gplLogin.Enabled := True;
end;

procedure TFLogin.goRegister;
begin
  gplLogin.Enabled := False;
  btnLogin.StyleLookup := 'btnIdle';
  btnSignUp.StyleLookup := 'btnPressed';
  tcMain.Next();
  gplLogin.Enabled := True;
end;

function TFLogin.IsMatch(const Input, Pattern: string): boolean;
begin
  Result := TRegEx.IsMatch(Input, Pattern);
end;

function TFLogin.IsValidEmailRegEx(const EmailAddress: string): boolean;
const
  EMAIL_REGEX = '^((?>[a-zA-Z\d!#$%&''*+\-/=?^_`{|}~]+\x20*|"((?=[\x01-\x7f])'
             +'[^"\\]|\\[\x01-\x7f])*"\x20*)*(?<angle><))?((?!\.)'
             +'(?>\.?[a-zA-Z\d!#$%&''*+\-/=?^_`{|}~]+)+|"((?=[\x01-\x7f])'
             +'[^"\\]|\\[\x01-\x7f])*")@(((?!-)[a-zA-Z\d\-]+(?<!-)\.)+[a-zA-Z]'
             +'{2,}|\[(((?(?<!\[)\.)(25[0-5]|2[0-4]\d|[01]?\d?\d))'
             +'{4}|[a-zA-Z\d\-]*[a-zA-Z\d]:((?=[\x01-\x7f])[^\\\[\]]|\\'
             +'[\x01-\x7f])+)\])(?(angle)>)$';
begin
  Result := IsMatch(EmailAddress, EMAIL_REGEX);
end;

procedure TFLogin.ReleaseFrame;
begin
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    DisposeOf;
  {$ELSE}
    Free;
  {$ENDIF}
  FLogin := Nil;
end;

procedure TFLogin.tiShowTimer(Sender: TObject);
begin
  FMain.tiFH.Enabled := True;
  fnGoFrame(Login, Home);
end;

end.
