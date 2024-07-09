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

function TConsultaXMLIndy.getErro: boolean;
begin
  result := FbErro;
end;

function TConsultaXMLIndy.getMensagemErro: String;
begin
  result := FsMensagemErro;
end;

function TConsultaXMLIndy.ConsultarSitePorCEP
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

  result := TCEPParserXML.ParseCEP(sRetorno);
end;

function TConsultaXMLIndy.ConsultarSitePorEndereco
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

  result := TCEPParserXML.ParseEnderecos(sRetorno);
end;

end.
