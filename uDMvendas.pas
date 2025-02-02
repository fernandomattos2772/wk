unit uDMvendas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Forms;

type
  TDMvendas = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    qryCli: TFDQuery;
    dsCli: TDataSource;
    qryPro: TFDQuery;
    dsPro: TDataSource;
    qryVen: TFDQuery;
    dsVen: TDataSource;
    gravaReg: TFDQuery;
    qryGeral: TFDQuery;
    dsGeral: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMvendas: TDMvendas;

implementation
uses uVendas, uFuncoes;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMvendas.DataModuleCreate(Sender: TObject);
var Erro: Integer;
begin
  Erro      := ErroAtual;
  ErroAtual := 1001;
  if FileExists('config.ini') then
  begin
    FDConnection1.Params.Clear;
    FDConnection1.Connected := False;
    FDConnection1.Params.Add('DriverID='+pegaArqIni('config.ini','DriverID'));
    FDConnection1.Params.Add('Server='+pegaArqIni('config.ini','Server'));
    FDConnection1.Params.Add('Port='+pegaArqIni('config.ini','Port'));
    FDConnection1.Params.Add('Database='+pegaArqIni('config.ini','Database'));
    FDConnection1.Params.Add('CharacterSet='+pegaArqIni('config.ini','CharacterSet'));
    FDConnection1.Params.Add('User_Name='+pegaArqIni('config.ini','User_Name'));
    FDConnection1.Params.Add('Password='+pegaArqIni('config.ini','Password'));

    FDConnection1.Connected := True;
    ErroAtual               := Erro;
  end;
end;

procedure TDMvendas.FDConnection1BeforeConnect(Sender: TObject);
begin
  FDPhysMySQLDriverLink1.VendorLib := ExtractFilePath(Application.Exename)+pegaArqIni('config.ini','Path');
end;

end.

