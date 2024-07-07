unit UBuscaEnderecoCEP;

interface

uses
  System.SysUtils, System.Classes,
  IdHTTP, IdSSLOpenSSL,
  NetEncoding;

type
  TFormatoResultado = (frJSON, frXML);

  TBuscaEnderecoCEP = class(TComponent)
  private
    FbErro: boolean;

    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;

    FFormatoResultado: TFormatoResultado;

    function ValidarCEP(const CEP: string): string;
    function ValidarEndereco(const UF, Cidade, Endereco: string): string;
    function ErroRetorno(const Codigo: integer; const Texto: string): boolean;

    function SufixoFormato: string;
    function Buscar(const Filtro: string): string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function BuscarPorCEP(const CEP: string): string;
    function BuscarPorEndereco(const UF, Cidade, Endereco: string): string;

    property Erro: boolean read FbErro;
  published
    property FormatoResultado: TFormatoResultado read FFormatoResultado
      write FFormatoResultado;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Softplan', [TBuscaEnderecoCEP]);
end;

{ TBuscaEnderecoCEP }

constructor TBuscaEnderecoCEP.Create(AOwner: TComponent);
begin
  inherited;

  FbErro := false;

  FIdHTTP := TIdHTTP.Create;
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions :=
    [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
end;

destructor TBuscaEnderecoCEP.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHTTP.Free;

  inherited;
end;

function TBuscaEnderecoCEP.SufixoFormato: string;
begin
  result := 'xml';
  if FFormatoResultado = frJSON then
    result := 'json';
end;

function TBuscaEnderecoCEP.ValidarCEP(const CEP: string): string;
var
  v: integer;
begin
  result := '';

  if (Length(Trim(CEP)) <> 8) then
    result := 'CEP deve ter 8 caracteres';

  if not TryStrToInt(CEP, v) then
    result := 'CEP não possui um formato válido: ' + CEP;

  if (result <> '') then
    FbErro := True;
end;

function TBuscaEnderecoCEP.ValidarEndereco(const UF, Cidade,
  Endereco: string): string;
begin
  result := '';

  if (Length(Trim(UF)) <> 2) then
    result := 'CEP deve ter 2 caracteres';

  if (Length(Trim(Cidade)) < 3) then
    result := 'Cidade deve ter no mínimo 3 caracteres';

  if (Length(Trim(Endereco)) < 3) then
    result := 'Endereço deve ter no mínimo 3 caracteres';

  if (result <> '') then
    FbErro := True;
end;

function TBuscaEnderecoCEP.ErroRetorno(const Codigo: integer;
  const Texto: string): boolean;
begin
  result := (Codigo <> 200) or
    (Texto.Contains('erro') and Texto.Contains('true'));
end;

function TBuscaEnderecoCEP.Buscar(const Filtro: string): string;
const
  C_URL = 'https://viacep.com.br/ws/%s/%s';
var
  sURL: string;
  aStream: TStringStream;
begin
  aStream := TStringStream.Create;

  sURL := Format(C_URL, [Filtro, SufixoFormato]);

  try
    try
      FIdHTTP.Get(sURL, aStream);
      FbErro := ErroRetorno(FIdHTTP.ResponseCode, aStream.DataString);
      result := UTF8ToString(AnsiString(aStream.DataString));
    except
      FbErro := True;
      result := ExceptObject.ToString;
    end;
  finally
    FreeAndNil(aStream);
  end;
end;

function TBuscaEnderecoCEP.BuscarPorCEP(const CEP: string): string;
begin
  FbErro := false;

  result := ValidarCEP(CEP);
  if FbErro then
    Exit;

  result := Buscar(CEP);
end;

function TBuscaEnderecoCEP.BuscarPorEndereco(const UF, Cidade,
  Endereco: string): string;
const
  C_BUSCA_ENDERECO = '%s/%s/%s';
var
  sFiltro: string;
begin
  FbErro := false;

  result := ValidarEndereco(UF, Cidade, Endereco);
  if FbErro then
    Exit;

  sFiltro := Format(C_BUSCA_ENDERECO, [UF, Cidade, Endereco]);
  sFiltro := TNetEncoding.URL.Encode(sFiltro);
  result := Buscar(sFiltro);
end;

end.
