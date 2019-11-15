unit uFunc;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Objects, FMX.StdCtrls,
  FMX.DialogService, System.DateUtils, System.IOUtils, FMX.Layouts, FMX.WebBrowser
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    ;
  {$ELSEIF Defined(MSWINDOWS)}
    ,IWSystem;
  {$ELSE}
  ;
  {$ENDIF}

function fnReplaceStr(strSource, strReplaceFrom, strReplaceWith: string;
         goTrim: Boolean = true): string;
function fnCreateID( nmTbl, colTbl, TempID : string ): string;
function fnReplaceDay(str : String):String;
function fnReplaceMonth(str : String):String;
function fnReplaceEntoID(tgl : TDateTime):String;
function fnGetImgIndex(str : String): Integer;

procedure fnGetColorText(lbl : TLabel; str : String);

procedure fnSQLAdd(Query: TFDQuery; SQL: string; ClearPrior: Boolean = False); overload;
procedure fnSQLOpen(Query: TFDQuery); overload;
procedure fnExecSQL(Query: TFDQuery); overload;
procedure fnSQLParamByName(Query: TFDQuery; ParamStr: string; Value: Variant); overload;
procedure prExplodeStr(SourceStr: string; Delimiter: char; var List: TStringList);

procedure fnLoadImage(img : TImage; nmFile : String);

procedure fnCreateBrowser(ly : TLayout; url : String);
procedure fnReleaseWB;

var
  statBW : Boolean;
  WB : TWebBrowser;

implementation

uses uHelper, uDM;


function fnReplaceStr(strSource, strReplaceFrom, strReplaceWith: string; goTrim: Boolean = true): string;
begin
  if goTrim then strSource := Trim(strSource);
  Result := StringReplace(strSource, StrReplaceFrom, StrReplaceWith, [rfReplaceAll, rfIgnoreCase])
end;

function fnCreateID( nmTbl, colTbl, TempID : string ): string;
var
  ID : string;
  totString : integer;
begin
  totString := Length(TempID);
  //fnSQLAdd(DM.OQID,  'select '+ colTbl + ' from ' + nmTbl +
  //                              ' order by ' + colTbl + ' desc limit 1', True);
  //fnSQLOpen(DM.OQID);
  DM.QTemp1.Close;
  DM.QTemp1.SQL.Clear;
  DM.QTemp1.SQL.Text := 'select '+ colTbl + ' from ' + nmTbl +
                        ' order by ' + colTbl + ' desc limit 1';
  DM.QTemp1.Open;

  ID := Copy(DM.QTemp1.FieldByName(colTbl).AsString, totString + 1, 9);
  if ID <> '' then
    ID := FormatFloat('000000000', StrToInt(ID) + 1)
  else
    ID := '000000001';

  Result := TempID + ID;
end;

function fnReplaceDay(str : String):String;
begin
  if str = 'Sunday' then
    Result := 'Minggu'
  else if str = 'Monday' then
    Result := 'Senin'
  else if str = 'Tuesday' then
    Result := 'Selasa'
  else if str = 'Wednesday' then
    Result := 'Rabu'
  else if str = 'Thursday' then
    Result := 'Kamis'
  else if str = 'Friday' then
    Result := 'Jum`at'
  else if str = 'Saturday' then
    Result := 'Sabtu'
  else
    Result := str;
end;

function fnReplaceMonth(str : String):String;
begin
  if str = '01' then
    Result := 'Januari'
  else if str = '02' then
    Result := 'Februari'
  else if str = '03' then
    Result := 'Maret'
  else if str = '04' then
    Result := 'April'
  else if str = '05' then
    Result := 'Mei'
  else if str = '06' then
    Result := 'Juni'
  else if str = '07' then
    Result := 'Juli'
  else if str = '08' then
    Result := 'Agustus'
  else if str = '09' then
    Result := 'September'
  else if str = '10' then
    Result := 'Oktober'
  else if str = '11' then
    Result := 'November'
  else if str = '12' then
    Result := 'Desember'
end;

function fnReplaceEntoID(tgl : TDateTime):String;
var
  hari, bulan, tahun, tanggal : String;
begin
  try
    hari := FormatDateTime('dddd', tgl);
    hari := fnReplaceDay(hari);

    bulan := FormatDateTime('mm', tgl);
    bulan := fnReplaceMonth(bulan);

    tahun := FormatDateTime('yyyy', tgl);
    tanggal := FormatDateTime('dd', tgl);

    Result := hari + ', ' + tanggal + ' ' + bulan + ' ' + tahun;
  except
    Result := FormatDateTime('dddd, dd mmmm yyyy', Now)
  end;
end;

procedure fnGetColorText(lbl : TLabel; str : String);
begin
  if StrToFloatDef(str, 0) > 0 then
    lbl.FontColor := $FF2ECC71
  else if StrToFloatDef(str, 0) < 0 then
    lbl.FontColor := $FFE74C3C
  else
    lbl.FontColor := TAlphaColorRec.White;
end;

function fnGetImgIndex(str : String): Integer;
begin
  try
    if StrToFloatDef(str, 0) > 0 then
      Result := 5
    else if StrToFloatDef(str, 0) < 0 then
      Result := 4
    else
      Result := 8;
  except
    Result := 8;
  end;
end;

procedure prExplodeStr(SourceStr: string; Delimiter: char; var List: TStringList);
var
  i: integer;
begin
  List.Clear;
  while Length(SourceStr) > 0 do
  begin
    i := Pos(Delimiter, SourceStr);
    if (i > 0) then
    begin
      List.Add(Copy(SourceStr, 1, i - 1));
      SourceStr := Copy(SourceStr, i + 1, Length(SourceStr) - i);
    end // if (i > 0) then
    else if Length(SourceStr) > 0 then
    begin
      List.Add(SourceStr);
      SourceStr := '';
    end // if Length(SourceStr) > 0 then
  end; //while Length(SourceStr) > 0 do
end;

procedure fnSQLAdd(Query: TFDQuery; SQL: string; ClearPrior: Boolean = False); overload;
var s: string;
begin
  if ClearPrior then
    Query.SQL.Clear;

  s := fnReplaceStr(SQL, 'GETDATE', 'CURRENT_DATE');
  s := fnReplaceStr(s, 'ISNULL', 'IFNULL');

  Query.SQL.Add(S);
end;

procedure fnSQLOpen(Query: TFDQuery); overload;
var L: TStringList;
  s: string;
  s1: string;
  TempS: string;
  x1: integer;
  x2: integer;
begin
  L := TStringList.Create;

  s := Query.SQL.Text;
  x1 := Pos('SELECT TOP', UpperCase(s));
  if x1 > 0 then
  begin
    if s[x1 - 1] = '(' then // --> berarti ada Sub Query di dalam Query, perlu diparse lagi
    begin
      x2 := Pos(')', s); // ambil akhir dari sub query
      s1 := UpperCase(Copy(s, x1, x2 - x1));
      prExplodeStr(s1, ' ', L);

      TempS := L[1] + ' ' + L[2];

      Insert(' LIMIT ' + L[2], s, x2);
      s := fnReplaceStr(s, TempS, '');
      Query.SQL.Text := s;
    end
    else
    begin
      // ambil jumlahnya
      prExplodeStr(UpperCase(s), ' ', L);

      TempS := L[1] + ' ' + L[2];

      s := fnReplaceStr(s, TempS, '');
      s := s + ' LIMIT ' + L[2];
      Query.SQL.Text := s;
    end
  end;

  FreeAndNil(L);

  Query.Prepared;
//  fnWriteQueryLog(Format('DATE: %s | QUERY: %s', [fnFormatDateTimeDB(Now), Query.SQL.Text]));
  Query.Open;
end;

procedure fnExecSQL(Query: TFDQuery); overload;
var L: TStringList;
  s: string;
  s1: string;
  TempS: string;
  x1: integer;
  x2: integer;
begin
  L := TStringList.Create;

  s := Query.SQL.Text;
  x1 := Pos('SELECT TOP', UpperCase(s));
  if x1 > 0 then
  begin
    if s[x1 - 1] = '(' then // --> berarti ada Sub Query di dalam Query, perlu diparse lagi
    begin
      x2 := Pos(')', s); // ambil akhir dari sub query
      s1 := UpperCase(Copy(s, x1, x2 - x1));
      prExplodeStr(s1, ' ', L);

      TempS := L[1] + ' ' + L[2];

      Insert(' LIMIT ' + L[2], s, x2);
      s := fnReplaceStr(s, TempS, '');
      Query.SQL.Text := s;
    end
    else
    begin
      // ambil jumlahnya
      prExplodeStr(UpperCase(s), ' ', L);

      TempS := L[1] + ' ' + L[2];

      s := fnReplaceStr(s, TempS, '');
      s := s + ' LIMIT ' + L[2];
      Query.SQL.Text := s;
    end
  end;

  FreeAndNil(L);

  Query.Prepared;

  Query.ExecSQL;
end;

procedure fnSQLParamByName(Query: TFDQuery; ParamStr: string; Value: Variant); overload;
begin
  Query.Params.ParamByName(ParamStr).Value := Value
end;

procedure fnLoadImage(img : TImage; nmFile : String);
var
  loc : String;
begin
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    loc := TPath.GetDocumentsPath + PathDelim + nmFile;
  {$ELSEIF Defined(MSWINDOWS)}
    loc := gsAppPath + PathDelim + 'img' + PathDelim + nmFile;
  {$ENDIF}

  img.Bitmap.LoadFromFile(loc);
end;

procedure fnCreateBrowser(ly : TLayout; url : String);
begin
  statBW := True;

  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        WB := TWebBrowser.Create(ly);
        WB.Parent := ly;
        WB.Align := TAlignLayout.Client;
        WB.Visible := False;
        WB.URL := URL;
        WB.OnDidFinishLoad := Helper.WBDidLoad;
      end
      );
    end
  ) .Start;
end;

procedure fnReleaseWB;
begin
  if statBW = True then
  begin
    {$IF DEFINED(IOS) or DEFINED(ANDROID)}
      WB.DisposeOf;
    {$ELSE}
      WB.Free;
    {$ENDIF}
    statBW := False;
  end;
end;

end.
