unit UConsulta.JSON.Indy;

interface

uses
  UConsulta.Intf, UFiltros.Consulta.Intf,
  UCEP.Intf,
  UBuscaEnderecoCEP,
  UCEP.Parser.JSON;

type
  TConsultaJSONIndy = class(TInterfacedObject, IConsultaInterface)
  private
    FbErro: boolean;
    FsMensagemErro: String;

    FBuscaEnderecoCEP: TBuscaEnderecoCEP;

    function getErro: boolean;
    function getMensagemErro: String;
  public
    constructor Create;
    destructor Destroy; override;

    function ConsultarSitePorCEP(aFiltros: IFiltrosConsultaInterface)
      : ICEPInterface;
    function ConsultarSitePorEndereco(aFiltros: IFiltrosConsultaInterface)
      : TArray<ICEPInterface>;
  end;

implementation

{ TConsultaJSONIndy }

constructor TConsultaJSONIndy.Create;
begin
  FBuscaEnderecoCEP := TBuscaEnderecoCEP.Create(nil);
  FBuscaEnderecoCEP.FormatoResultado := frJSON;
end;

destructor TConsultaJSONIndy.Destroy;
begin
  FBuscaEnderecoCEP.Free;

  inherited;
end;

function TConsultaJSONIndy.getErro: boolean;
begin
  result := FbErro;
end;

function TConsultaJSONIndy.getMensagemErro: String;
begin
  result := FsMensagemErro;
end;

function TConsultaJSONIndy.ConsultarSitePorCEP
  (aFiltros: IFiltrosConsultaInterface): ICEPInterface;
var
  sRetorno: string;
begin
  result := nil;

  sRetorno := FBuscaEnderecoCEP.BuscarPorCEP(aFiltros.CEP);

  if FBuscaEnderecoCEP.Erro then
  begin
    FbErro := True;
    FsMensagemErro := sRetorno;

    exit;
  end;

  result := TCEPParserJSON.ParseCEP(sRetorno);
end;

function TConsultaJSONIndy.ConsultarSitePorEndereco
  (aFiltros: IFiltrosConsultaInterface): TArray<ICEPInterface>;
var
  sRetorno: string;
begin
  result := nil;

  sRetorno := FBuscaEnderecoCEP.BuscarPorEndereco(aFiltros.UF,
    aFiltros.Localidade, aFiltros.Logradouro);

  if FBuscaEnderecoCEP.Erro then
  begin
    FbErro := True;
    FsMensagemErro := sRetorno;

    exit;
  end;

  result := TCEPParserJSON.ParseEnderecos(sRetorno);
end;

end.
