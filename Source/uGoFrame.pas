unit uGoFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, System.Threading;

procedure goLoading;
procedure goLogin;
procedure goHome;
procedure goF2;
procedure goF3;
procedure goF4;

implementation

uses FrLoading, FrMain, FrLogin, FrHome, Fr2, Fr3, Fr4;

procedure goLoading;
begin
  try
    FLoading := TFLoading.Create(FMain);
    FLoading.Parent := FMain.vsMain;
    FLoading.Align := TAlignLayout.Contents;

    FLoading.FirstShow;
  except

  end;
end;

procedure goLogin;
begin
  try
    FLogin := TFLogin.Create(FMain);
    FLogin.Parent := FMain.vsMain;
    FLogin.Align := TAlignLayout.Contents;

    FLogin.loMain.Opacity := 0;
    FLogin.FirstShow;
  except

  end;
end;

procedure goHome;
begin
  try
    FHome := TFHome.Create(FMain);
    FHome.Parent := FMain.vsMain;
    FHome.Align := TAlignLayout.Contents;

    FHome.FirstShow;
  except

  end;
end;

procedure goF2;
begin
  try
    F2 := TF2.Create(FMain);
    F2.Parent := FMain.vsMain;
    F2.Align := TAlignLayout.Contents;

    F2.FirstShow;
  except

  end;
end;

procedure goF3;
begin
  try
    F3 := TF3.Create(FMain);
    F3.Parent := FMain.vsMain;
    F3.Align := TAlignLayout.Contents;

    F3.FirstShow;
  except

  end;
end;

procedure goF4;
begin
  try
    F4 := TF4.Create(FMain);
    F4.Parent := FMain.vsMain;
    F4.Align := TAlignLayout.Contents;

    F4.FirstShow;
  except

  end;
end;

end.
