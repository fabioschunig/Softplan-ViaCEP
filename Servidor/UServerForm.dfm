object fServerForm: TfServerForm
  Left = 0
  Top = 0
  Caption = 'Server Form'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object DSServer: TDSServer
    Left = 96
    Top = 56
  end
  object DSServerClass: TDSServerClass
    Server = DSServer
    Left = 96
    Top = 120
  end
  object DSTCPServerTransport: TDSTCPServerTransport
    Server = DSServer
    Filters = <>
    Left = 96
    Top = 184
  end
end
