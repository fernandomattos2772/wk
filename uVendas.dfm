object frmVendas: TfrmVendas
  Left = 0
  Top = 0
  Caption = 'Vendas ( teste pr'#225'tico WK )'
  ClientHeight = 441
  ClientWidth = 1284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1284
    Height = 441
    Align = alClient
    TabOrder = 0
    object grdVen: TDBGrid
      Left = 1
      Top = 96
      Width = 1282
      Height = 325
      Align = alClient
      DataSource = DMvendas.dsVen
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnKeyPress = grdVenKeyPress
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 1282
      Height = 45
      Align = alTop
      Color = clLightblue
      ParentBackground = False
      TabOrder = 1
      object spbConsulta: TSpeedButton
        Left = 1002
        Top = 15
        Width = 95
        Height = 23
        Cursor = crHandPoint
        Hint = 'Informe o n'#250'mero de pedido que deseja CONSULTAR'
        Caption = 'Consulta pedido'
        OnClick = spbConsultaClick
      end
      object spdCancela: TSpeedButton
        Tag = 1
        Left = 1100
        Top = 15
        Width = 95
        Height = 23
        Cursor = crHandPoint
        Hint = 'Informe o n'#250'mero do pedido que deseja CANCELAR'
        Caption = 'Cancela pedido'
        OnClick = spbConsultaClick
      end
      object LabeledEdit1: TLabeledEdit
        Tag = 1
        Left = 8
        Top = 19
        Width = 89
        Height = 23
        Hint = 
          'Digite apenas n'#250'meros + <Enter> para pesquizar pelo c'#243'digo do Cl' +
          'iente'
        HelpContext = 1
        EditLabel.Width = 79
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo Cliente'
        TabOrder = 0
        Text = ''
        OnEnter = LabeledEdit1Enter
        OnExit = LabeledEdit1Exit
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit6: TLabeledEdit
        Tag = 1
        Left = 97
        Top = 19
        Width = 392
        Height = 23
        Hint = 
          'Digite o nome inicial do Cliente + <Enter> para pesquizar pelo n' +
          'ome'
        EditLabel.Width = 90
        EditLabel.Height = 15
        EditLabel.Caption = 'Nome do Cliente'
        TabOrder = 1
        Text = ''
        OnEnter = LabeledEdit1Enter
        OnExit = LabeledEdit1Exit
        OnKeyPress = LabeledEdit6KeyPress
      end
      object LabeledEdit7: TLabeledEdit
        Left = 489
        Top = 19
        Width = 230
        Height = 23
        EditLabel.Width = 37
        EditLabel.Height = 15
        EditLabel.Caption = 'Cidade'
        ReadOnly = True
        TabOrder = 2
        Text = ''
        OnEnter = LabeledEdit7Enter
      end
      object LabeledEdit8: TLabeledEdit
        Left = 719
        Top = 19
        Width = 50
        Height = 23
        EditLabel.Width = 14
        EditLabel.Height = 15
        EditLabel.Caption = 'UF'
        ReadOnly = True
        TabOrder = 3
        Text = ''
        OnEnter = LabeledEdit7Enter
      end
      object TotPedido: TLabeledEdit
        Left = 769
        Top = 9
        Width = 137
        Height = 33
        Cursor = crHelp
        Hint = 'Valor total do pedido atual'
        Color = clBisque
        EditLabel.Width = 53
        EditLabel.Height = 33
        EditLabel.Caption = 'TotPedido'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Segoe UI'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        LabelPosition = lpRight
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 4
        Text = 'R$ 999.999,99'
        OnEnter = LabeledEdit1Enter
        OnKeyPress = LabeledEdit4KeyPress
      end
      object PedAtual: TLabeledEdit
        Left = 906
        Top = 9
        Width = 90
        Height = 33
        Cursor = crHelp
        Hint = 'N'#250'mero do pedido atual'
        Color = clBisque
        EditLabel.Width = 48
        EditLabel.Height = 33
        EditLabel.Caption = 'PedAtual'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -12
        EditLabel.Font.Name = 'Segoe UI'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        LabelPosition = lpRight
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 5
        Text = ' 999.999'
        OnEnter = LabeledEdit1Enter
        OnKeyPress = LabeledEdit4KeyPress
      end
      object edtPedido: TLabeledEdit
        Tag = 1
        Left = 996
        Top = 16
        Width = 22
        Height = 23
        Color = clYellow
        EditLabel.Width = 87
        EditLabel.Height = 15
        EditLabel.Caption = 'Consulta pedido'
        LabelSpacing = 2
        TabOrder = 6
        Text = ''
        Visible = False
        OnKeyPress = edtPedidoKeyPress
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 46
      Width = 1282
      Height = 50
      Align = alTop
      Color = clMoneyGreen
      ParentBackground = False
      TabOrder = 2
      object spdF8: TSpeedButton
        Left = 999
        Top = 23
        Width = 81
        Height = 23
        Cursor = crHandPoint
        Caption = 'F8=grava item'
        OnClick = F8gravaItemExecute
      end
      object LabeledEdit2: TLabeledEdit
        Tag = 1
        Left = 8
        Top = 24
        Width = 89
        Height = 23
        Hint = 
          'Digite apenas n'#250'meros + <Enter> para pesquizar pelo c'#243'digo do pr' +
          'oduto'
        EditLabel.Width = 39
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo'
        TabOrder = 0
        Text = ''
        OnEnter = LabeledEdit1Enter
        OnExit = LabeledEdit1Exit
        OnKeyPress = LabeledEdit2KeyPress
      end
      object LabeledEdit3: TLabeledEdit
        Tag = 1
        Left = 97
        Top = 24
        Width = 672
        Height = 23
        Hint = 
          'Digite o nome inicial do produto + <Enter> para pesquizar pela d' +
          'escri'#231#227'o'
        EditLabel.Width = 114
        EditLabel.Height = 15
        EditLabel.Caption = 'Descri'#231#227'o do produto'
        TabOrder = 1
        Text = ''
        OnEnter = LabeledEdit1Enter
        OnExit = LabeledEdit1Exit
        OnKeyPress = LabeledEdit3KeyPress
      end
      object LabeledEdit4: TLabeledEdit
        Left = 769
        Top = 24
        Width = 89
        Height = 23
        Hint = 
          'Digite a quantidade de venda do produto. Tecle <Enter> para grav' +
          'ar o registro'
        EditLabel.Width = 62
        EditLabel.Height = 15
        EditLabel.Caption = 'Quantidade'
        TabOrder = 2
        Text = ''
        OnEnter = LabeledEdit1Enter
        OnKeyPress = LabeledEdit4KeyPress
      end
      object LabeledEdit5: TLabeledEdit
        Left = 858
        Top = 24
        Width = 137
        Height = 23
        Hint = 
          'Digite o valor unit'#225'rio do produto. Tecle <Enter> para gravar o ' +
          'registro'
        EditLabel.Width = 70
        EditLabel.Height = 15
        EditLabel.Caption = 'Valor unit'#225'rio'
        TabOrder = 3
        Text = ''
        OnEnter = LabeledEdit1Enter
        OnKeyPress = LabeledEdit4KeyPress
      end
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 421
      Width = 1282
      Height = 19
      Panels = <
        item
          Alignment = taCenter
          Width = 500
        end>
    end
    object grdCli: TDBGrid
      Left = 521
      Top = 328
      Width = 238
      Height = 45
      DataSource = DMvendas.dsCli
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Visible = False
      OnExit = grdCliExit
      OnKeyPress = grdCliKeyPress
    end
    object grdPro: TDBGrid
      Left = 521
      Top = 256
      Width = 238
      Height = 45
      DataSource = DMvendas.dsPro
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Visible = False
      OnExit = grdCliExit
      OnKeyPress = grdProKeyPress
    end
  end
  object ActionManager1: TActionManager
    Left = 320
    Top = 192
    StyleName = 'Platform Default'
    object F8gravaItem: TAction
      Caption = 'F8gravaItem'
      ShortCut = 119
      OnExecute = F8gravaItemExecute
    end
    object Delete: TAction
      Caption = 'Delete'
      ShortCut = 46
      OnExecute = DeleteExecute
    end
  end
end
