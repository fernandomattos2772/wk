unit uFuncoes;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  Buttons, ActnList, Printers, Windows;

  procedure GravaArqTxt(sArqTxt, sTx: String);
  procedure LeArqTxt1(sArq:String);
  function splitVar(pVar, pQuebra, pSort: String) : TStringList;
  function AspasDTHR(sDT, sTime: string): string;
  function gravaValor(sVlr: string): string;
  function gravaInt(sVlr: string): string;
  function pegaArqIni(sArq, sVar:String): String;
var
   iLst,iLnh: Integer;
   F0,F1,F2: TextFile;
   lstVar,lstLn1,lstLn2: TStringList;

implementation

function gravaInt(sVlr: string): string;
var i0: integer;
begin
  Result := '';
  for i0 := 1 to Length(sVlr) do
  begin
    if Pos(Copy(sVlr,i0,1),'1234567890') > 0 then
      Result := Result + Copy(sVlr,i0,1);
  end;
end;

function gravaValor(sVlr: string): string;
var i0: integer;
begin
  Result := '';
  for i0 := 1 to Length(sVlr) do
  begin
    if Copy(sVlr,i0,1)=',' then
      Result := Result + '.'
    else
      if Pos(Copy(sVlr,i0,1),'1234567890') > 0 then
        Result := Result + Copy(sVlr,i0,1);
  end;
end;

function splitVar(pVar, pQuebra, pSort: String) : TStringList;
var i0: Integer;
   sTxt: String;
begin
  Result        := TStringList.Create;
  Result.Sorted := False;
  sTxt          := '';
  if pVar='' then begin
    gravaArqTxt('SQL.txt', #13+'[Erro x splitVar] '+DateToStr(Date())+'-'+TimeToStr(Time())+' >>> '+Copy(pSort,2,9999));
    ShowMessage('ATENÇÃO: Erro na função splitVar (pVar sem valor) !!!'+#13+Copy(pSort,2,9999));
    Result := Nil;
    Exit;
  end;
  if Pos(pQuebra, pVar)=0 then
    pVar := pVar + pQuebra;
  Result.Clear;                                       // o índice inicia em zero
  for i0 := 1 to Length(pVar) do begin
    if Copy(pVar,i0,Length(pQuebra)) <> pQuebra then
      sTxt := sTxt + Copy(pVar,i0,Length(pQuebra))
    else begin
      Result.Add(sTxt);
      sTxt := '';
    end;
  end;
  if sTxt<>'' then
    Result.Add(sTxt);
  if Copy(pSort,1,1)='S' then
     Result.Sorted := True;
  iLst := Result.Count;
end;

procedure GravaArqTxt(sArqTxt, sTx: String);
begin
   AssignFile(F1, sArqTxt);
   if FileExists(sArqTxt) then
     Append(F1)
   else
     ReWrite(F1);
   WriteLn(F1, sTx);
   Inc(iLnh);
   CloseFile(F1);
end;

function AspasDTHR(sDT, sTime: string): string;
begin
  if Copy(sDT + '  ', 1, 2) <> '  ' then begin
    if sTime <> '' then
      AspasDTHR := #39 + FormatDateTime('YYYY/MM/DD' + ' HH:MM:SS', StrToDateTime(sDT + ' ' + sTime)) + #39
    else
      AspasDTHR := #39 + FormatDateTime('YYYY/MM/DD', StrToDateTime(sDT)) + #39;
  end else begin
    AspasDTHR := 'null';
  end;
end;

function pegaArqIni(sArq, sVar:String): String;
var i0: Integer;
begin
  Result := '';
  if Not FileExists(sArq) then
  begin
    ShowMessage('Arquivo '+sArq+' não encontrado no sistema !');
    Exit;
  end;
  LeArqTxt1(sArq);
  for i0 := 0 to lstLn1.Count-1 do
  begin
    if Pos(sVar,lstLn1[i0]) > 0 then
    begin
      lstVar := splitVar(lstLn1[i0], '=', 'N');
      Result := lstVar[1];
    end;
  end;
end;

procedure LeArqTxt1(sArq:String);
var sTxt: String;
begin
  lstLn1.Clear;
  if FileExists(sArq) then begin
    AssignFile(F1, sArq);
    Reset(F1);
    While (Not Eof(F1)) do begin
      ReadLn(F1, sTxt);
      lstLn1.Add(sTxt);
    end;
    CloseFile(F1);
  end;
end;

end.

