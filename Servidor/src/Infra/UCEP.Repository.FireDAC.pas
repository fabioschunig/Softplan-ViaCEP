unit UCEP.Repository.FireDAC;

interface

uses
  UCEP.Repository.Intf, UCEP.Intf, UCEP.Model,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.Param;

type
  TCEPRepositoryFireDAC = class(TInterfacedObject, ICEPRepository)
  private
    FConexao: TFDConnection;
    FQuery: TFDQuery;
  public
    constructor Create(Conexao: TFDConnection);
    destructor Destroy; override;

    function Salvar(aCEP: ICEPInterface): boolean;
    function BuscarPorCEP(const CEP: String; var Encontrou: boolean)
      : ICEPInterface;
    function BuscarPorEndereco(const UF, Localidade, Logradouro: String;
      var Encontrou: boolean): TArray<ICEPInterface>;
  end;

implementation

uses
  System.SysUtils;

{ TCEPRepositoryFireDAC }

constructor TCEPRepositoryFireDAC.Create(Conexao: TFDConnection);
begin
  FConexao := Conexao;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
end;

destructor TCEPRepositoryFireDAC.Destroy;
begin
  FQuery.Free;
  FConexao := nil;

  inherited;
end;

function TCEPRepositoryFireDAC.Salvar(aCEP: ICEPInterface): boolean;
begin
  result := false;

  if aCEP = nil then
    exit;

  FQuery.Close;

  FQuery.SQL.Clear;
  FQuery.SQL.Add('select ID, DATA, CEP, LOGRADOURO, COMPLEMENTO, BAIRRO, LOCALIDADE, UF');
  FQuery.SQL.Add('from CEP');
  FQuery.SQL.Add('where CEP = :PCEP');

  FQuery.Params.ParamByName('PCEP').AsString := aCEP.CEP;

  try
    FQuery.Open;
    if FQuery.isEmpty then
    begin
      FQuery.Append;
      FQuery.FieldByName('CEP').AsString := aCEP.CEP;
    end
    else
    begin
      FQuery.Edit;
    end;

    FQuery.FieldByName('DATA').AsDateTime := NOW;
    FQuery.FieldByName('LOGRADOURO').AsString := aCEP.Logradouro;
    FQuery.FieldByName('COMPLEMENTO').AsString := aCEP.Complemento;
    FQuery.FieldByName('BAIRRO').AsString := aCEP.Bairro;
    FQuery.FieldByName('LOCALIDADE').AsString := aCEP.Localidade;
    FQuery.FieldByName('UF').AsString := aCEP.UF;

    FQuery.Post;

    result := true;
  finally
    FQuery.Close;
  end;

end;

function TCEPRepositoryFireDAC.BuscarPorCEP(const CEP: String;
  var Encontrou: boolean): ICEPInterface;
var
  aCEP: ICEPInterface;
begin
  result := nil;
  Encontrou := false;

  if Trim(CEP) = '' then
    exit;

  FQuery.Close;

  FQuery.SQL.Clear;
  FQuery.SQL.Add('select CEP, LOGRADOURO, COMPLEMENTO, BAIRRO, LOCALIDADE, UF, DATA');
  FQuery.SQL.Add('from CEP');
  FQuery.SQL.Add('where CEP = :PCEP');

  FQuery.Params.ParamByName('PCEP').AsString := CEP;

  try
    FQuery.Open;
    if FQuery.isEmpty then
      exit;

    Encontrou := true;

    aCEP := TCEPModel.Create;
    aCEP.Hydrate(
      FQuery.FieldByName('CEP').AsString,
      FQuery.FieldByName('LOGRADOURO').AsString,
      FQuery.FieldByName('COMPLEMENTO').AsString,
      FQuery.FieldByName('BAIRRO').AsString,
      FQuery.FieldByName('LOCALIDADE').AsString,
      FQuery.FieldByName('UF').AsString,
      FQuery.FieldByName('DATA').AsDateTime
    );

    result := aCEP;
  finally
    FQuery.Close;
  end;
end;

function TCEPRepositoryFireDAC.BuscarPorEndereco(const UF, Localidade,
  Logradouro: String; var Encontrou: boolean): TArray<ICEPInterface>;
var
  aCEP: ICEPInterface;
begin
  result := nil;
  Encontrou := false;

  if (Trim(UF) = '') or (Trim(Localidade) = '') or (Trim(Logradouro) = '') then
    exit;

  FQuery.Close;

  FQuery.SQL.Clear;
  FQuery.SQL.Add('select CEP, LOGRADOURO, COMPLEMENTO, BAIRRO, LOCALIDADE, UF, DATA');
  FQuery.SQL.Add('from CEP');
  FQuery.SQL.Add('where UF = :PUF and');
  FQuery.SQL.Add('localidade like :PLOCALIDADE and');
  FQuery.SQL.Add('logradouro like :PLOGRADOURO');
  FQuery.SQL.Add('order by CEP');

  FQuery.Params.ParamByName('PUF').AsString := UF;
  FQuery.Params.ParamByName('PLOCALIDADE').AsString := '%' + Localidade + '%';
  FQuery.Params.ParamByName('PLOGRADOURO').AsString := '%' + Logradouro + '%';

  try
    FQuery.Open;
    if FQuery.isEmpty then
      exit;

    Encontrou := true;

    FQuery.First;
    while not FQuery.EoF do
    begin
      aCEP := TCEPModel.Create;
      aCEP.Hydrate(
        FQuery.FieldByName('CEP').AsString,
        FQuery.FieldByName('LOGRADOURO').AsString,
        FQuery.FieldByName('COMPLEMENTO').AsString,
        FQuery.FieldByName('BAIRRO').AsString,
        FQuery.FieldByName('LOCALIDADE').AsString,
        FQuery.FieldByName('UF').AsString,
        FQuery.FieldByName('DATA').AsDateTime
      );

      setLength(result, length(result) + 1);
      result[length(result) - 1] := aCEP;

      FQuery.Next;
    end;
  finally
    FQuery.Close;
  end;
end;

end.
