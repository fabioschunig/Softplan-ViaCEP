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
    ExplicitLeft = 72
    ExplicitTop = 8
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
    object pcTipoConsulta: TPageControl
      Left = 167
      Top = 10
      Width = 602
      Height = 113
      ActivePage = tsCEP
      TabOrder = 1
      object tsCEP: TTabSheet
        Caption = 'Consultar por CEP'
        object Label1: TLabel
          Left = 64
          Top = 31
          Width = 24
          Height = 15
          Caption = 'CEP:'
        end
        object edCEP: TEdit
          Left = 96
          Top = 27
          Width = 129
          Height = 23
          TabOrder = 0
        end
        object bPesquisarCEP: TButton
          Left = 500
          Top = 16
          Width = 89
          Height = 48
          Caption = 'Pesquisar'
          TabOrder = 1
          OnClick = bPesquisarCEPClick
        end
      end
      object tsEndereco: TTabSheet
        Caption = 'Consultar por Endere'#231'o'
        ImageIndex = 1
        object Label2: TLabel
          Left = 43
          Top = 23
          Width = 17
          Height = 15
          Caption = 'UF:'
        end
        object Label3: TLabel
          Left = 168
          Top = 23
          Width = 40
          Height = 15
          Caption = 'Cidade:'
        end
        object Label4: TLabel
          Left = 8
          Top = 52
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
        object edEndereco: TEdit
          Left = 80
          Top = 48
          Width = 393
          Height = 23
          TabOrder = 1
        end
        object edCidade: TEdit
          Left = 216
          Top = 19
          Width = 257
          Height = 23
          TabOrder = 2
        end
        object bPesquisarEndereco: TButton
          Left = 500
          Top = 16
          Width = 89
          Height = 48
          Caption = 'Pesquisar'
          TabOrder = 3
          OnClick = bPesquisarEnderecoClick
        end
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
    ExplicitTop = 127
  end
end
