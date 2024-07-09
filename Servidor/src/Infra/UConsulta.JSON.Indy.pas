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
    FBuscaEnderecoCEP: TBuscaEnderecoCEP;
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

function TConsultaJSONIndy.ConsultarSitePorCEP
  (aFiltros: IFiltrosConsultaInterface): ICEPInterface;
var
  sRetorno: string;
begin
  sRetorno := FBuscaEnderecoCEP.BuscarPorCEP(aFiltros.CEP);

  result := TCEPParserJSON.ParseCEP(sRetorno);
end;

function TConsultaJSONIndy.ConsultarSitePorEndereco
  (aFiltros: IFiltrosConsultaInterface): TArray<ICEPInterface>;
var
  sRetorno: string;
begin
  sRetorno := FBuscaEnderecoCEP.BuscarPorEndereco(aFiltros.UF,
    aFiltros.Localidade, aFiltros.Logradouro);

  result := TCEPParserJSON.ParseEnderecos(sRetorno);
end;

end.
