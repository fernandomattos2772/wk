object DMvendas: TDMvendas
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    ConnectionName = 'testewk'
    Params.Strings = (
      'Password=root27'
      'User_Name=root'
      'DriverID=MySQL'
      'Database=testewk'
      'Server=localhost'
      'UseSSL=True'
      'SSL_ca=ca-cert.pem'
      'SSL_cert=client-cert.pem'
      'SSL_key=client-key.pem')
    LoginPrompt = False
    BeforeConnect = FDConnection1BeforeConnect
    Left = 56
    Top = 16
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\samue\Documents\WinAcer2024\Doctos\AndressaWolf\libmysq' +
      'l.dll'
    Left = 56
    Top = 80
  end
  object qryCli: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from clientes')
    Left = 184
    Top = 16
  end
  object dsCli: TDataSource
    DataSet = qryCli
    Left = 184
    Top = 80
  end
  object qryPro: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from clientes')
    Left = 248
    Top = 16
  end
  object dsPro: TDataSource
    DataSet = qryPro
    Left = 248
    Top = 80
  end
  object qryVen: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      '')
    Left = 306
    Top = 16
  end
  object dsVen: TDataSource
    DataSet = qryVen
    Left = 306
    Top = 80
  end
  object gravaReg: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      '')
    Left = 368
    Top = 16
  end
  object qryGeral: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      '')
    Left = 432
    Top = 16
  end
  object dsGeral: TDataSource
    DataSet = qryGeral
    Left = 432
    Top = 80
  end
end
