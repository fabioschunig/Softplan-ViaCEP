unit UConsulta.XML.Indy;

interface

uses
  UConsulta.Intf, UFiltros.Consulta.Intf,
  UCEP.Intf,
  UBuscaEnderecoCEP,
  UCEP.Parser.XML;

type
  TConsultaXMLIndy = class(TInterfacedObject, IConsultaInterface)
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

{ TConsultaXMLIndy }

constructor TConsultaXMLIndy.Create;
begin
  FBuscaEnderecoCEP := TBuscaEnderecoCEP.Create(nil);
  FBuscaEnderecoCEP.FormatoResultado := frXML;
end;

destructor TConsultaXMLIndy.Destroy;
begin
  FBuscaEnderecoCEP.Free;

  inherited;
end;

function TConsultaXMLIndy.ConsultarSitePorCEP
  (aFiltros: IFiltrosConsultaInterface): ICEPInterface;
var
  sRetorno: string;
begin
  sRetorno := FBuscaEnderecoCEP.BuscarPorCEP(aFiltros.CEP);

  result := TCEPParserXML.ParseCEP(sRetorno);
end;

function TConsultaXMLIndy.ConsultarSitePorEndereco
  (aFiltros: IFiltrosConsultaInterface): TArray<ICEPInterface>;
var
  sRetorno: string;
begin
  sRetorno := FBuscaEnderecoCEP.BuscarPorEndereco(aFiltros.UF,
    aFiltros.Localidade, aFiltros.Logradouro);

  result := TCEPParserXML.ParseEnderecos(sRetorno);
end;

end.
