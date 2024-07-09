//
// Created by the DataSnap proxy generator.
// 08/07/2024 17:03:18
//

unit UDSClienteMethods;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethodsClient = class(TDSAdminClient)
  private
    FConsultaCEPCommand: TDBXCommand;
    FConsultaEnderecoCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function ConsultaCEP(CEP: string; var DadosArmazenados: Boolean; AtualizarDados: Boolean; Formato: string): string;
    function ConsultaEndereco(UF: string; Localidade: string; Logradouro: string; var DadosArmazenados: Boolean; AtualizarDados: Boolean; Formato: string): string;
  end;

implementation

function TServerMethodsClient.ConsultaCEP(CEP: string; var DadosArmazenados: Boolean; AtualizarDados: Boolean; Formato: string): string;
begin
  if FConsultaCEPCommand = nil then
  begin
    FConsultaCEPCommand := FDBXConnection.CreateCommand;
    FConsultaCEPCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FConsultaCEPCommand.Text := 'TServerMethods.ConsultaCEP';
    FConsultaCEPCommand.Prepare;
  end;
  FConsultaCEPCommand.Parameters[0].Value.SetWideString(CEP);
  FConsultaCEPCommand.Parameters[1].Value.SetBoolean(DadosArmazenados);
  FConsultaCEPCommand.Parameters[2].Value.SetBoolean(AtualizarDados);
  FConsultaCEPCommand.Parameters[3].Value.SetWideString(Formato);
  FConsultaCEPCommand.ExecuteUpdate;
  DadosArmazenados := FConsultaCEPCommand.Parameters[1].Value.GetBoolean;
  Result := FConsultaCEPCommand.Parameters[4].Value.GetWideString;
end;

function TServerMethodsClient.ConsultaEndereco(UF: string; Localidade: string; Logradouro: string; var DadosArmazenados: Boolean; AtualizarDados: Boolean; Formato: string): string;
begin
  if FConsultaEnderecoCommand = nil then
  begin
    FConsultaEnderecoCommand := FDBXConnection.CreateCommand;
    FConsultaEnderecoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FConsultaEnderecoCommand.Text := 'TServerMethods.ConsultaEndereco';
    FConsultaEnderecoCommand.Prepare;
  end;
  FConsultaEnderecoCommand.Parameters[0].Value.SetWideString(UF);
  FConsultaEnderecoCommand.Parameters[1].Value.SetWideString(Localidade);
  FConsultaEnderecoCommand.Parameters[2].Value.SetWideString(Logradouro);
  FConsultaEnderecoCommand.Parameters[3].Value.SetBoolean(DadosArmazenados);
  FConsultaEnderecoCommand.Parameters[4].Value.SetBoolean(AtualizarDados);
  FConsultaEnderecoCommand.Parameters[5].Value.SetWideString(Formato);
  FConsultaEnderecoCommand.ExecuteUpdate;
  DadosArmazenados := FConsultaEnderecoCommand.Parameters[3].Value.GetBoolean;
  Result := FConsultaEnderecoCommand.Parameters[6].Value.GetWideString;
end;

constructor TServerMethodsClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TServerMethodsClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TServerMethodsClient.Destroy;
begin
  FConsultaCEPCommand.Free;
  FConsultaEnderecoCommand.Free;
  inherited;
end;

end.

