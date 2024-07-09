object fDataModule: TfDataModule
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'Database=database.sqlite')
    LoginPrompt = False
    Left = 72
    Top = 64
  end
end
