unit UDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client;

type
  TfDataModule = class(TDataModule)
    FDConnection: TFDConnection;
    procedure DataModuleDestroy(Sender: TObject);
  private
    function TabelaCEP: string;
  public
    procedure PrepararBancoDeDados;
  end;

var
  fDataModule: TfDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TfDataModule }

procedure TfDataModule.DataModuleDestroy(Sender: TObject);
begin
  FDConnection.Connected := false;
end;

procedure TfDataModule.PrepararBancoDeDados;
begin
  FDConnection.Connected := true;

  // por ser um banco de dados muito simples,
  // não foi criado um script ou classes de migration
  FDConnection.ExecSQL(TabelaCEP);
end;

function TfDataModule.TabelaCEP: string;
begin
   result :=
    'create table if not exists CEP ('+
    '  ID integer primary key, '+
    '  DATA datetime default current_timestamp not null, '+
    '  CEP text not null, '+
    '  LOGRADOURO text not null, '+
    '  COMPLEMENTO text, '+
    '  BAIRRO text, '+
    '  LOCALIDADE text, '+
    '  UF text, '+
    '  constraint CEP_UNIQUE unique (CEP) '+
    '); ';
end;

end.
