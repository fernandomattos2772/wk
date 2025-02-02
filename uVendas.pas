unit uVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, System.Actions,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.Buttons;

type
  TfrmVendas = class(TForm)
    Panel1: TPanel;
    grdVen: TDBGrid;
    Panel2: TPanel;
    LabeledEdit1: TLabeledEdit;
    Panel3: TPanel;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    StatusBar1: TStatusBar;
    grdCli: TDBGrid;
    grdPro: TDBGrid;
    TotPedido: TLabeledEdit;
    PedAtual: TLabeledEdit;
    ActionManager1: TActionManager;
    F8gravaItem: TAction;
    spdF8: TSpeedButton;
    Delete: TAction;
    spbConsulta: TSpeedButton;
    edtPedido: TLabeledEdit;
    spdCancela: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit1Enter(Sender: TObject);
    procedure LabeledEdit6KeyPress(Sender: TObject; var Key: Char);
    procedure grdCliKeyPress(Sender: TObject; var Key: Char);
    procedure grdCliExit(Sender: TObject);
    procedure LabeledEdit1Exit(Sender: TObject);
    procedure pegaCliente;
    procedure pegaProduto;
    procedure novoPedido;
    procedure limpaCliente;
    procedure consultaPedidos;
    procedure pegaItens;
    procedure LabeledEdit7Enter(Sender: TObject);
    procedure LabeledEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure grdProKeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure F8gravaItemExecute(Sender: TObject);
    procedure grdVenKeyPress(Sender: TObject; var Key: Char);
    procedure DeleteExecute(Sender: TObject);
    procedure spbConsultaClick(Sender: TObject);
    procedure edtPedidoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVendas: TfrmVendas;
  ErroAtual: Integer;

implementation
uses uDMVendas, uFuncoes;
{$R *.dfm}

procedure TfrmVendas.DeleteExecute(Sender: TObject);
begin
  if Not grdVen.Focused then
    Exit;

  if DMvendas.qryVen.RecordCount=0 then
  begin
    ShowMessage('Não há itens neste pedido para serem excluídos !');
    Exit;
  end;

  if MessageDlg(
    DMvendas.qryVen.FieldByName('descricao').AsString+' Qt: '+DMvendas.qryVen.FieldByName('quantidade').AsString+#13+
    'Confirma a EXCLUSÃO deste item de venda ?',mtWarning,[mbYEs,mbNo],0)=mrYes then
  begin
    DMvendas.gravaReg.SQL.Clear;
    DMvendas.gravaReg.SQL.Add(
      'delete from pedidos_produtos where'+
      ' idpedidos_produtos='+DMvendas.qryVen.FieldByName('idpedidos_produtos').AsString
    );
    DMvendas.gravaReg.ExecSQL;
    ShowMessage('Registro EXCLUÍDO com sucesso !');
    LabeledEdit2.SetFocus;
  end;
end;

procedure TfrmVendas.edtPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if Not (Key in ['0'..'9',#8,#9,#13,#42]) then
    Key := #0;

  if (Key=#13) and (edtPedido.Text<>'') then
  begin
    DMvendas.qryGeral.SQL.Clear;
    DMvendas.qryGeral.SQL.Add(
      'select A.idpedido,B.idcliente'+
      ' from pedidos_produtos A, pedidos B, clientes C'+
      ' where A.idpedido='+edtPedido.Text+
      ' and B.idpedido=A.idpedido'+
      ' and C.codigo=B.idcliente'
    );
    DMvendas.qryGeral.Open;

    if DMvendas.qryGeral.RecordCount=0 then
    begin
      ShowMessage('Pedido não encontrado no sistema !');
      Exit;
    end;
    PedAtual.Text := edtPedido.Text;

    DMvendas.qryCli.SQL.Clear;
    DMvendas.qryCli.SQL.Add('select * from clientes where codigo='+
      DMvendas.qryGeral.FieldByName('idcliente').AsString);
    DMvendas.qryCli.Open;

    pegaCliente;
    pegaItens;

    if edtPedido.Tag=1 then
    begin
      if MessageDlg('Confirma a EXCLUSÃO do pedido de venda '+edtPedido.Text+' ?',mtWarning,[mbYEs,mbNo],0)=mrYes then
      begin
        DMvendas.gravaReg.SQL.Clear;
        DMvendas.gravaReg.SQL.Add('delete from pedidos_produtos where idpedido='+edtPedido.Text);
        DMvendas.gravaReg.ExecSQL;

        DMvendas.gravaReg.SQL.Clear;
        DMvendas.gravaReg.SQL.Add('delete from pedidos where idpedido='+edtPedido.Text);
        DMvendas.gravaReg.ExecSQL;

        ShowMessage('Pedido '+edtPedido.Text+' EXCLUÍDO com sucesso !');
      end;

      LabeledEdit6.SetFocus;
      limpaCliente;
      PedAtual.Text := '-9999';
      pegaItens;
      PedAtual.Text := '';
      limpaCliente;
      consultaPedidos;
    end;
  end;
end;

procedure TfrmVendas.F8gravaItemExecute(Sender: TObject);
begin
  if LabeledEdit4.Text='' then
  begin
    ShowMessage('Favor digitar uma quantidade válida para este produto !');
    Exit;
  end;

  LabeledEdit4.Text := gravaValor(LabeledEdit4.Text);
  LabeledEdit5.Text := gravaValor(LabeledEdit5.Text);

  DMvendas.gravaReg.SQL.Clear;
  if spdF8.Tag=0 then
  begin
    DMvendas.gravaReg.SQL.Add(
      'insert into pedidos_produtos (idpedido,idproduto,quantidade,valor_unitario,valor_total) values ('+
      gravaInt(PedAtual.Text) + ',' +
      LabeledEdit2.Text + ',' +
      LabeledEdit4.Text + ',' +
      LabeledEdit5.Text + ',' +
      LabeledEdit4.Text + '*' + LabeledEdit5.Text + ')'
    );
  end
  else
  begin
    DMvendas.gravaReg.SQL.Add(
      'update pedidos_produtos set'+
      ' quantidade='+LabeledEdit4.Text+','+
      ' valor_unitario='+LabeledEdit5.Text+','+
      ' valor_total='+LabeledEdit4.Text + '*' + LabeledEdit5.Text+
      ' where idpedidos_produtos='+IntToStr(spdF8.Tag)
    );
  end;
  DMvendas.gravaReg.ExecSQL;

  pegaItens;

  LabeledEdit2.ReadOnly := False;
  LabeledEdit3.ReadOnly := False;
  spdF8.Tag             := 0;                   // espera nova inclusão de itens

  LabeledEdit2.SetFocus;
end;

procedure TfrmVendas.FormActivate(Sender: TObject);
begin
  if ErroAtual<>0 then begin
    ShowMessage('Erro atual: '+IntToStr(ErroAtual));
    Application.Terminate;
  end;
end;

procedure TfrmVendas.FormCreate(Sender: TObject);
begin
  PedAtual.EditLabel.Caption := '';
  ErroAtual := 0;                                            // Nehum erro atual
  lstLn1    := TStringList.Create;
  lstLn2    := TStringList.Create;
  lstVar    := TStringList.Create;
  lstLn1.Clear;
  lstLn2.Clear;
  lstVar.Clear;

  if Not FileExists('config.ini') then
    ErroAtual := 1000;             // arquivo config.ini não encontrado na pasta
end;

procedure TfrmVendas.FormShow(Sender: TObject);
begin
  TotPedido.Text := '';
  PedAtual.Text  := '';
  LabeledEdit6.SetFocus;
end;

procedure TfrmVendas.grdCliExit(Sender: TObject);
begin
  TDBGrid(Sender).Visible := False;
end;

procedure TfrmVendas.grdCliKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    pegaCliente;
    novoPedido;
  end;
end;

procedure TfrmVendas.grdProKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    pegaProduto;
end;

procedure TfrmVendas.grdVenKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    if DMvendas.qryVen.RecordCount=0 then
    begin
      ShowMessage('Não há itens neste pedido para serem alterados !');
      Exit;
    end;
    spdF8.Tag         := DMvendas.qryVen.FieldByName('idpedidos_produtos').AsInteger; // espera alteração deste item
    LabeledEdit2.Text := DMvendas.qryVen.FieldByName('idproduto').AsString;
    LabeledEdit3.Text := DMvendas.qryVen.FieldByName('descricao').AsString;
    LabeledEdit4.Text := DMvendas.qryVen.FieldByName('quantidade').AsString;
    LabeledEdit5.Text := DMvendas.qryVen.FieldByName('valor_unitario').AsString;
    LabeledEdit2.ReadOnly := True;
    LabeledEdit3.ReadOnly := True;
    LabeledEdit4.SetFocus;
  end;
end;

procedure TfrmVendas.LabeledEdit1Enter(Sender: TObject);
begin
  consultaPedidos;

  if TLabeledEdit(Sender).Tag=1 then
  begin
    TLabeledEdit(Sender).Color := clYellow;
    LabeledEdit2.Text          := '';
    LabeledEdit3.Text          := '';
    LabeledEdit4.Text          := '';
    LabeledEdit5.Text          := '';
  end;

  pegaItens;

  StatusBar1.Panels[0].Text := TLabeledEdit(Sender).Hint;

  if PedAtual.Text<>'' then
    StatusBar1.Panels[0].Text := TLabeledEdit(Sender).Hint+
      '   >>> Pedido: '+PedAtual.Text+'   Valor total: '+TotPedido.Text;
end;

procedure TfrmVendas.LabeledEdit1Exit(Sender: TObject);
begin
  TLabeledEdit(Sender).Color := clWindow;
end;

procedure TfrmVendas.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  consultaPedidos;
  if Not (Key in ['0'..'9',#8,#9,#13,#42]) then
    Key := #0;

  if (Key=#13) and (LabeledEdit1.Text<>'') then
  begin
    DMvendas.qryCli.SQL.Clear;
    DMvendas.qryCli.SQL.Add('select * from clientes where codigo='+LabeledEdit1.Text);
    DMvendas.qryCli.Open;

    if DMvendas.qryCli.RecordCount>0 then
    begin
      pegaCliente;
      novoPedido;
      pegaItens;
    end;
  end;
end;

procedure TfrmVendas.LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Not (Key in ['0'..'9',#8,#9,#13,#42]) then
    Key := #0;

  if (Key=#13) and (LabeledEdit2.Text<>'') then
  begin
    DMvendas.qryPro.SQL.Clear;
    DMvendas.qryPro.SQL.Add('select * from produtos where codigo='+LabeledEdit2.Text);
    DMvendas.qryPro.Open;
    pegaProduto;
  end;
end;

procedure TfrmVendas.LabeledEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  if Not (Key in ['0'..'9','A'..'Z','a'..'z',#8,#9,#13,#42]) then
    Key := #0;

  if Key=#13 then
  begin
    LabeledEdit3.Text := UpperCase(LabeledEdit3.Text);
    DMvendas.qryPro.SQL.Clear;
    DMvendas.qryPro.SQL.Add('select * from produtos where descricao like '+QuotedStr('%'+LabeledEdit3.Text+'%'));
    DMvendas.qryPro.Open;

    if DMvendas.qryPro.RecordCount>0 then
    begin
      grdPro.Top     := LabeledEdit3.Top;
      grdPro.Left    := LabeledEdit3.Left;
      grdPro.Width   := LabeledEdit3.Width+50;
      grdPro.Height  := 500;
      grdPro.Visible := True;
      grdPro.SetFocus;
    end;
  end;
end;

procedure TfrmVendas.LabeledEdit4KeyPress(Sender: TObject; var Key: Char);
begin
  if Not (Key in ['0'..'9',',',#8,#9,#13,#42]) then
    Key := #0;

  if Key=#13 then
    F8gravaItemExecute(Sender);
end;

procedure TfrmVendas.LabeledEdit6KeyPress(Sender: TObject; var Key: Char);
begin
  if Not (Key in ['0'..'9','A'..'Z','a'..'z',#8,#9,#13,#42]) then
    Key := #0;

  if Key=#13 then
  begin
    LabeledEdit6.Text := UpperCase(LabeledEdit6.Text);
    DMvendas.qryCli.SQL.Clear;
    DMvendas.qryCli.SQL.Add('select * from clientes where nome like '+QuotedStr('%'+LabeledEdit6.Text+'%'));
    DMvendas.qryCli.Open;

    if DMvendas.qryCli.RecordCount>0 then
    begin
      grdCli.Top     := LabeledEdit6.Top;
      grdCli.Left    := LabeledEdit6.Left;
      grdCli.Width   := LabeledEdit3.Width+50;
      grdCli.Height  := 500;
      grdCli.Visible := True;
      grdCli.SetFocus;
    end;
  end;
end;

procedure TfrmVendas.LabeledEdit7Enter(Sender: TObject);
begin
  if LabeledEdit1.Text<>'' then
    LabeledEdit2.SetFocus
  else
    LabeledEdit1.SetFocus;
end;

procedure TfrmVendas.pegaCliente;
begin
  LabeledEdit1.Text := DMvendas.qryCli.FieldByName('codigo').AsString;
  LabeledEdit6.Text := DMvendas.qryCli.FieldByName('nome').AsString;
  LabeledEdit7.Text := DMvendas.qryCli.FieldByName('cidade').AsString;
  LabeledEdit8.Text := DMvendas.qryCli.FieldByName('UF').AsString;
  LabeledEdit2.SetFocus;
end;

procedure TfrmVendas.pegaProduto;
begin
  if DMvendas.qryPro.RecordCount>0 then
  begin
    LabeledEdit2.Text := DMvendas.qryPro.FieldByName('codigo').AsString;
    LabeledEdit3.Text := DMvendas.qryPro.FieldByName('descricao').AsString;
    LabeledEdit4.Text := '1';
    LabeledEdit5.Text := DMvendas.qryPro.FieldByName('preco_venda').AsString;
    LabeledEdit4.SetFocus;
  end
    else
      LabeledEdit2.SetFocus;
end;

procedure TfrmVendas.spbConsultaClick(Sender: TObject);
begin
  edtPedido.Text              := '';
  edtPedido.Tag               := TSpeedButton(Sender).Tag;
  edtPedido.EditLabel.Caption := TSpeedButton(Sender).Caption;
  edtPedido.EditLabel.Hint    := TSpeedButton(Sender).Hint;
  edtPedido.Left              := spbConsulta.Left;
  edtPedido.Top               := LabeledEdit1.Top;
  edtPedido.Width             := LabeledEdit1.Width;
  edtPedido.Visible           := True;
  spbConsulta.Visible         := False;
  spdCancela.Visible          := False;
  StatusBar1.Panels[0].Text   := TLabeledEdit(Sender).Hint;
  edtPedido.SetFocus;
end;

procedure TfrmVendas.novoPedido;
begin
  if LabeledEdit1.Text='' then
  begin
    ShowMessage('Favor informar um Cliente cadastrado para abrir um novo pedido !');
    LabeledEdit1.SetFocus;
    Exit;
  end;

  DMvendas.qryGeral.SQL.Clear;
  DMvendas.qryGeral.SQL.Add(
    'select * from pedidos where idcliente='+LabeledEdit1.Text+
    ' and dt_emissao='+AspasDTHR(DateToStr(Date()),'')+
    ' and valor_total=0'+
    ' order by idpedido');      // pega o último pedido do Cliente na data atual
  DMvendas.qryGeral.Open;
  DMvendas.qryGeral.First;

  if DMvendas.qryGeral.RecordCount=0 then
  begin
    DMvendas.gravaReg.SQL.Clear;
    DMvendas.gravaReg.SQL.Add(
      'insert into pedidos (dt_emissao, idcliente, valor_total) values ('+
      AspasDTHR(DateToStr(Date()),'')+','+
      LabeledEdit1.Text+
      ',0)');                      // grava novo registro com valor_total zerado
    DMvendas.gravaReg.ExecSQL;

    DMvendas.qryGeral.SQL.Clear;
    DMvendas.qryGeral.SQL.Add(
      'select * from pedidos where idcliente='+LabeledEdit1.Text+
      ' and dt_emissao='+AspasDTHR(DateToStr(Date()),'')+
      ' and valor_total=0'+
      ' order by idpedido');    // pega o último pedido do Cliente na data atual
    DMvendas.qryGeral.Open;
    DMvendas.qryGeral.First;
  end;

  TotPedido.Text := DMvendas.qryGeral.FieldByName('valor_total').AsString;
  PedAtual.Text  := DMvendas.qryGeral.FieldByName('idpedido').AsString;
end;

procedure TfrmVendas.pegaItens;
begin
  if (PedAtual.Text='') or (PedAtual.Text='0') then
    Exit;

  DMvendas.qryVen.SQL.Clear;
  DMvendas.qryVen.SQL.Add(
    'select A.idpedidos_produtos,A.idproduto,B.descricao,A.quantidade,A.valor_unitario,A.valor_total'+
    ' from pedidos_produtos A, produtos B'+
    ' where A.idpedido='+gravaInt(PedAtual.Text)+
    ' and B.codigo=A.idproduto'+
    ' order by A.idpedidos_produtos desc');
  DMvendas.qryVen.Open;

  DMvendas.qryGeral.SQL.Clear;
  DMvendas.qryGeral.SQL.Add(
    'select sum(valor_total) as total from pedidos_produtos '+
    ' where idpedido='+gravaInt(PedAtual.Text));
  DMvendas.qryGeral.Open;
  DMvendas.qryGeral.First;

  TotPedido.Text := DMvendas.qryGeral.FieldByName('total').AsString;

  DMvendas.gravaReg.SQL.Clear;
  DMvendas.gravaReg.SQL.Add(
    'update pedidos set valor_total=0'+gravaValor(TotPedido.Text)+
    ' where idpedido='+gravaInt(PedAtual.Text));
  DMvendas.gravaReg.ExecSQL;

  TotPedido.Text := formatfloat('R$ ###,##0.#0', StrToFloat('0'+TotPedido.Text));
  PedAtual.Text  := formatfloat('000,000', StrToFloat(gravaInt(PedAtual.Text)));

  grdVen.Columns[0].Visible       := false;
  grdVen.Columns[1].Title.Caption := 'Código';
  grdVen.Columns[2].Title.Caption := 'Descrição do produto';
  grdVen.Columns[3].Title.Caption := 'Quantidade';
  grdVen.Columns[4].Title.Caption := 'Valor unitário';
  grdVen.Columns[5].Title.Caption := 'Total do item';
  grdVen.Columns[1].Title.Alignment := TAlignment.taCenter;

  TIntegerField(DMvendas.qryVen.FieldByName('idproduto')).Alignment        := TAlignment.taCenter;
  TFloatField(DMvendas.qryVen.FieldByName('valor_total')).DisplayFormat    := '###,##0.#0';
  TFloatField(DMvendas.qryVen.FieldByName('valor_unitario')).DisplayFormat := '###,##0.#0';
  TFloatField(DMvendas.qryVen.FieldByName('quantidade')).DisplayFormat     := '#,##0.#00';
end;

procedure TfrmVendas.limpaCliente;
begin
  LabeledEdit1.Text := '';
  LabeledEdit6.Text := '';
  LabeledEdit7.Text := '';
  LabeledEdit8.Text := '';
  TotPedido.Text    := '';
end;

procedure TfrmVendas.consultaPedidos;
begin
  if Length(LabeledEdit1.Text)=0 then
  begin
    spbConsulta.Visible := True;
    spdCancela.Visible  := True;
    edtPedido.Visible   := False;
    PedAtual.Text       := '-9999';
    pegaItens;
    PedAtual.Text       := '';
    limpaCliente;
  end else
  begin
    spbConsulta.Visible := False;
    spdCancela.Visible  := False;
    edtPedido.Visible   := False;
  end;
end;

end.

