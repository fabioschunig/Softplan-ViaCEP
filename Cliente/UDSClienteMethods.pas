//
// Created by the DataSnap proxy generator.
// 07/07/2024 20:34:54
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
    function ConsultaCEP(CEP: string): string;
    function ConsultaEndereco(UF: string; Cidade: string; Endereco: string): string;
  end;

implementation

function TServerMethodsClient.ConsultaCEP(CEP: string): string;
begin
  if FConsultaCEPCommand = nil then
  begin
    FConsultaCEPCommand := FDBXConnection.CreateCommand;
    FConsultaCEPCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FConsultaCEPCommand.Text := 'TServerMethods.ConsultaCEP';
    FConsultaCEPCommand.Prepare;
  end;
  FConsultaCEPCommand.Parameters[0].Value.SetWideString(CEP);
  FConsultaCEPCommand.ExecuteUpdate;
  Result := FConsultaCEPCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.ConsultaEndereco(UF: string; Cidade: string; Endereco: string): string;
begin
  if FConsultaEnderecoCommand = nil then
  begin
    FConsultaEnderecoCommand := FDBXConnection.CreateCommand;
    FConsultaEnderecoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FConsultaEnderecoCommand.Text := 'TServerMethods.ConsultaEndereco';
    FConsultaEnderecoCommand.Prepare;
  end;
  FConsultaEnderecoCommand.Parameters[0].Value.SetWideString(UF);
  FConsultaEnderecoCommand.Parameters[1].Value.SetWideString(Cidade);
  FConsultaEnderecoCommand.Parameters[2].Value.SetWideString(Endereco);
  FConsultaEnderecoCommand.ExecuteUpdate;
  Result := FConsultaEnderecoCommand.Parameters[3].Value.GetWideString;
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
