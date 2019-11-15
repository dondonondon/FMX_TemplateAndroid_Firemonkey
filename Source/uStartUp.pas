unit uStartUp;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Threading, FMX.StdCtrls, Data.DB;

procedure fnStat(msg :String);
procedure DateInstall;
procedure fnRunChat(usr,lvl : String);
procedure getIDADS;
procedure getInfo;

procedure start;

var
  statChat : Boolean;
  statCek, tglInstall : String;
  arrNews : array of record
    id : String;
    info : String;
    ket : String;
    tgl : String;
    berita : String;
  end;
  VInfo : String;
implementation

uses uFunc, uDM, uRest, uSign;

procedure fnStat(msg :String);
begin
  statCek := UpperCase(msg);
  Sleep(250);
end;

procedure fnRunChat(usr,lvl : String);
begin

end;

procedure DateInstall;
var
  tgl, id : String;
  arr : TStringArray;
begin
  try
    fnSQLAdd(DM.QTemp1, 'SELECT * FROM tbl_setting', True);
    fnSQLOpen(DM.QTemp1);

    if DM.QTemp1.IsEmpty then
    begin
      try
        fnStat('SETTING FIRST INSTALL');
        tgl := FormatDateTime('yyyy-mm-dd 00:00:00', Now);
        DM.Conn.StartTransaction;

        fnSQLAdd(DM.QTemp2, 'INSERT INTO tbl_setting VALUES(''DateInstall'','+QuotedStr(tgl)+')', True);
        fnExecSQL(DM.QTemp2);

        DM.Conn.Commit;
        Sleep(2000);
      except
        on E : Exception do
        begin
          DM.Conn.Rollback;
        end;
      end;
    end;
  except

  end;
end;

procedure getInfo;
begin

end;

procedure getIDADS;
begin

end;

procedure start;
var
  TaskStart : ITask;
begin
  TaskStart := TTask.Create(procedure()
  begin
    try
      sleep(1500); //Hilangkan Jika sudah banyak proses dibawah ini hanya untuk menampilkan animasi
      CekLogin;
    except

    end;
  end);
  TaskStart.Start;
end;

end.
