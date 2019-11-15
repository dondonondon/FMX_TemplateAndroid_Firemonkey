unit uRest;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.Rtti,
  FMX.Controls.Presentation, FMX.StdCtrls, System.JSON,
  System.JSON.Types,System.JSON.Writers, System.Threading, System.Generics.Collections;


const
  url = 'https://kucobatukbertahan.000webhostapp.com/API/getData.php?key=hUIY&act=';

type
  TStringArray = array of array of String;

function fnParseJSON(Cli : TRESTClient; Req : TRESTRequest; Resp :TRESTResponse;act : string):TStringArray;
function fnParseJSONbg(Cli : TRESTClient; Req : TRESTRequest; Resp :TRESTResponse;act : string):TStringArray;

var
  stat : String;

implementation

uses uFunc;

function fnParseJSON(Cli : TRESTClient; Req : TRESTRequest; Resp :TRESTResponse;act : string):TStringArray;
var
  JSONString : String;
  jDataArray : TJSONArray;
  jDataObject : TJSONObject;
  value : String;
  index : String;
  kol, bar : integer;

  statE : String;
begin
  try
    try
      Cli.Disconnect;
      Cli.BaseURL := url + act;
      Req.Execute;
      statE := 'JSONSTring';
      JSONString := Resp.JSONText;

      jDataArray:= TJSONObject.ParseJSONValue(JSONString) as TJSONArray;
      jDataObject := TJSONObject(jDataArray.Get(0));

      kol := Pred(jDataObject.Size);
      bar := Pred(jDataArray.Size);

      SetLength(Result, kol + 1, bar + 1);
      for var i:= 0 to Pred(jDataArray.Size) do
      begin
        jDataObject := TJSONObject(jDataArray.Get(i));
        for var obj := 0 to Pred(jDataObject.Size) do
        begin
          index := jDataObject.Pairs[obj].JsonString.ToString;
          value := jDataObject.Pairs[obj].JsonValue.ToString;

          Result[obj, i] := fnReplaceStr(value, '"','');
        end;
      end;
    except
      SetLength(Result, 1, 1);
      Result[0,0] := 'Null';
    end;
  finally
    begin
    {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    try
      jDataArray.DisposeOf;
      jDataArray := Nil;
    except
    end;
    {$ELSE}
    try
      FreeAndNil(jDataArray); //Jika Error Hapus ini
    except

    end;
    {$ENDIF}
    end;
  end;
end;

function fnParseJSONbg(Cli : TRESTClient; Req : TRESTRequest; Resp :TRESTResponse;act : string):TStringArray;
var
  JSONStringbg : String;
  jDataArraybg : TJSONArray;
  jDataObjectbg : TJSONObject;
  valuebg : String;
  indexbg : String;
  kolbg, barbg : integer;

  statEbg : String;
begin
  try
    try
      Cli.Disconnect;
      Cli.BaseURL := url + act;
      Req.Execute;
      statEbg := 'JSONSTring';
      JSONStringbg := Resp.JSONText;

      jDataArraybg:= TJSONObject.ParseJSONValue(JSONStringbg) as TJSONArray;
      jDataObjectbg := TJSONObject(jDataArraybg.Get(0));

      kolbg := Pred(jDataObjectbg.Size);
      barbg := Pred(jDataArraybg.Size);

      SetLength(Result, kolbg + 1, barbg + 1);
      for var i:= 0 to Pred(jDataArraybg.Size) do
      begin
        jDataObjectbg := TJSONObject(jDataArraybg.Get(i));
        for var obj := 0 to Pred(jDataObjectbg.Size) do
        begin
          indexbg := jDataObjectbg.Pairs[obj].JSONString.ToString;
          valuebg := jDataObjectbg.Pairs[obj].JsonValue.ToString;

          Result[obj, i] := fnReplaceStr(valuebg, '"','');
        end;
      end;
    except
      SetLength(Result, 1, 1);
      Result[0,0] := 'Null';
    end;
  finally
    begin
    {$IF DEFINED(IOS) or DEFINED(ANDROID)}
    try
      jDataArraybg.DisposeOf;
      jDataArraybg := Nil;
    except
    end;
    {$ELSE}
    try
      FreeAndNil(jDataArraybg); //Jika Error Hapus ini
    except

    end;
    {$ENDIF}
    end;
  end;
end;

end.
