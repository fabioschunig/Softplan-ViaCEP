object fConsultaEnderecos: TfConsultaEnderecos
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Consulta de Endere'#231'os'
  ClientHeight = 561
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object pnFiltros: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 129
    Align = alTop
    TabOrder = 0
    object rgFormatoResultado: TRadioGroup
      Left = 16
      Top = 8
      Width = 145
      Height = 113
      Caption = ' Formato do Resultado '
      ItemIndex = 0
      Items.Strings = (
        'JSON'
        'XML')
      TabOrder = 0
    end
    object gbCEP: TGroupBox
      Left = 167
      Top = 8
      Width = 185
      Height = 113
      Caption = ' Consulta por CEP '
      TabOrder = 1
      object bPesquisarCEP: TButton
        Left = 24
        Top = 64
        Width = 137
        Height = 34
        Caption = 'Pesquisar'
        TabOrder = 1
        OnClick = bPesquisarCEPClick
      end
      object edCEP: TEdit
        Left = 24
        Top = 29
        Width = 137
        Height = 23
        TabOrder = 0
      end
    end
    object gbEndereco: TGroupBox
      Left = 358
      Top = 8
      Width = 489
      Height = 113
      Caption = ' Consulta por Endere'#231'o '
      TabOrder = 2
      object Label2: TLabel
        Left = 56
        Top = 23
        Width = 17
        Height = 15
        Caption = 'UF:'
      end
      object Label3: TLabel
        Left = 33
        Top = 55
        Width = 40
        Height = 15
        Caption = 'Cidade:'
      end
      object Label4: TLabel
        Left = 21
        Top = 87
        Width = 52
        Height = 15
        Caption = 'Endere'#231'o:'
      end
      object edUF: TEdit
        Left = 80
        Top = 19
        Width = 57
        Height = 23
        TabOrder = 0
      end
      object edLogradouro: TEdit
        Left = 80
        Top = 83
        Width = 217
        Height = 23
        TabOrder = 2
      end
      object edLocalidade: TEdit
        Left = 80
        Top = 51
        Width = 217
        Height = 23
        TabOrder = 1
      end
      object bPesquisarEndereco: TButton
        Left = 311
        Top = 29
        Width = 102
        Height = 67
        Caption = 'Pesquisar'
        TabOrder = 3
        OnClick = bPesquisarEnderecoClick
      end
    end
  end
  object pnResultados: TPanel
    Left = 0
    Top = 129
    Width = 784
    Height = 432
    Align = alClient
    TabOrder = 1
    object mmResultado: TMemo
      Left = 1
      Top = 1
      Width = 782
      Height = 430
      Align = alClient
      TabOrder = 0
    end
  end
  object SQLConnection: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b')
    Left = 48
    Top = 193
    UniqueId = '{241E0DB2-A8AC-4827-BC49-454BB0C5F24E}'
  end
end
