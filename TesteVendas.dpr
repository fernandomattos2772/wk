program TesteVendas;

uses
  Vcl.Forms,
  uVendas in 'uVendas.pas' {frmVendas},
  uDMvendas in 'uDMvendas.pas' {DMvendas: TDataModule},
  uFuncoes in 'uFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmVendas, frmVendas);
  Application.CreateForm(TDMvendas, DMvendas);
  Application.Run;
end.
