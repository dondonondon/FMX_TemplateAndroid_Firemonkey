unit uSign;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.DB, MemDS, DBAccess, Uni, UniProvider,
  MySQLUniProvider, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Objects, FMX.StdCtrls,
  FMX.DialogService, IdHashMessageDigest, idHash, IdGlobal, System.Threading;

function MD5(str : string): String;

procedure RegUser(user, mail, pass : string);
procedure LogUser(user, pass : string);
procedure CekLogin;

var
  statReg, statLog, succReg : Boolean;

implementation

uses uDM, uFunc, uMain, uRest, uGoFrame,
  uStartUp, FrMain, FrLogin, FrLoading;

function MD5(str : string): String;
var
  obj: TIdHashMessageDigest5;
begin
  obj := TIdHashMessageDigest5.Create;
  try
    Result := obj.HashStringAsHex(str, IndyTextEncoding_UTF8);
  finally
    obj.Free;
  end;
end;

procedure RegUser(user, mail, pass : string);
var
  arr : TStringArray;
  tgl : TDateTime;
  level : string;
begin
  try
    try
      pass := MD5(pass);
      level := user;
      SetLength(level,pos(':',level)-1);
      level := Trim(level);

      Delete(user,1,pos(':',user));
      user := Trim(user);

      level := Trim(fnReplaceStr(level, '/', ''));

      if level = 'modmoda' then
        level := 'ModModA'
      else if level = 'modmodb' then
        level := 'ModModB'
      else
        level := 'User';

      arr := fnParseJSON(DM.RClient, DM.RReq, DM.RResp, 'register&username='+user+'&password='+pass+'&email='+mail+'&leveluser='+level);

      if Length(arr) = 0 then
        Exit;

      TThread.Synchronize(nil,
      procedure
      begin
        if arr[0,0] = 'USERNAME DIGUNAKAN' then
          fnShowE(arr[0,0], Err)
        else if arr[0,0] = 'SUKSES DAFTAR' then
        begin
          fnShowE(arr[0,0], Sukses);
          FLogin.goLogin;
          FLogin.ClearData;
        end
        else if arr[0,0] = 'GAGAL DAFTAR' then
          fnShowE(arr[0,0] + ', COBA LAGI', Err)
        else if arr[0,0] = 'Null' then
          fnShowE('SERVER BERMASALAH, COBA LAGI', Err);
      end);
    except
      TThread.Synchronize(nil,
      procedure
      begin
        fnShowE('SERVER BERMASALAH, COBA LAGI GAN', Err);
      end);
    end;
  finally
    fnCloseLoading;
  end;
end;

procedure LogUser(user, pass : string);
var
  arr : TStringArray;
  x : String;
begin
  try
    try
      arr := fnParseJSON(DM.RClient, DM.RReq, DM.RResp, 'login&username='+user+'&password='+pass);
      x := 'login&username='+user+'&password='+pass;
      if arr[0,0] = 'Null' then
        Exit;

      TThread.Synchronize(nil,
      procedure
      begin
        if goFrame = Login then
        begin
          if arr[0,0] = 'USERNAME DITEMUKAN' then
          begin
            FLogin.loMain.Align := TAlignLayout.None;

            FLogin.faHide.StartValue := FMain.loMain.Position.Y;
            FLogin.faHide.StopValue := FLogin.reBG.Height + 25;

            FLogin.faHide.Enabled := True;
          end
          else if arr[0,0] = 'USERNAME TIDAK DITEMUKAN' then
            fnShowE(arr[0,0], Err)
          else if arr[0,0] = 'PASSWORD SALAH' then
            fnShowE(arr[0,0], Err)
          else if arr[0,0] = 'Null' then
            fnShowE('SERVER BERMASALAH, COBA LAGI', Err);

          if arr[0,0] = 'USERNAME DITEMUKAN' then
          begin
            try
              DM.Conn.StartTransaction;

              fnSQLAdd(DM.QTemp1, 'DELETE FROM tbl_username',True);
              fnExecSQL(DM.QTemp1);

              fnSQLAdd(DM.QTemp1, 'INSERT INTO tbl_username (id, username, password, email, leveluser)'#13 +
                                  ' VALUES (:id, :user, :pass, :email, :leveluser)',True);
              fnSQLParamByName(DM.QTemp1, 'id', '1');
              fnSQLParamByName(DM.QTemp1, 'user', user);
              fnSQLParamByName(DM.QTemp1, 'pass', pass);
              fnSQLParamByName(DM.QTemp1, 'email', 'aa');
              fnSQLParamByName(DM.QTemp1, 'leveluser', 'aa');
              fnExecSQL(DM.QTemp1);

              DM.Conn.Commit;

              Username := user;
            except
              on E : Exception do
              begin
                DM.Conn.Rollback;
                fnGetE(E.Message, E.ClassName);
              end;
            end;
          end;
        end else
        begin
          //fnGetE('Pesan', 'Sukses');
          if arr[0,0] = 'USERNAME DITEMUKAN' then
          begin
            FMain.tiFH.Enabled := True;
            fnGoFrame(goFrame, Home);
          end
          else if arr[0,0] = 'USERNAME TIDAK DITEMUKAN' then
            goLogin
          else if arr[0,0] = 'PASSWORD SALAH' then
            goLogin
          else if arr[0,0] = 'Null' then
            if user <> '' then
              begin
                FMain.tiFH.Enabled := True;
                fnGoFrame(goFrame, Home);
              end
        end;
      end);
    except
      on E : Exception do
      begin
        TThread.Synchronize(nil,
        procedure
        begin
          goLogin;
          fnShowE('SERVER BERMASALAH, COBA LAGI', Err);
          fnGetE(E.Message, E.ClassName + ' ------ ' + x );
        end);
      end;
    end;
  finally
    fnCloseLoading;
  end;
end;

procedure CekLogin;
var
  user, pass, mail : String;
begin
  try
    fnSQLAdd(DM.QTemp1, 'SELECT * FROM tbl_username', True);
    fnSQLOpen(DM.QTemp1);

    if not DM.QTemp1.IsEmpty then
    begin
      user := DM.QTemp1.FieldByName('username').AsString;
      pass := DM.QTemp1.FieldByName('password').AsString;

      username := user;
      levelakses := DM.QTemp1.FieldByName('leveluser').AsString;
      email := DM.QTemp1.FieldByName('email').AsString;
      IDUser := DM.QTemp1.FieldByName('id').AsString;

      LogUser(user, pass);
    end else
      TThread.Synchronize(nil,
      procedure
      begin
        fnGoFrame(goFrame, Login);
      end);
  except
    TThread.Synchronize(nil,
    procedure
    begin
      fnGoFrame(goFrame, Login);
    end);
  end;
end;

end.

