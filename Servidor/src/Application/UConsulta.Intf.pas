unit UConsulta.Intf;

interface

uses
  UFiltros.Consulta.Intf,
  UCEP.Intf;

type
  IConsultaInterface = interface
    ['{C07B6347-7171-42BD-8E00-900ADF1D5A9A}']

    function ConsultarSitePorCEP(aFiltros: IFiltrosConsultaInterface)
      : ICEPInterface;
    function ConsultarSitePorEndereco(aFiltros: IFiltrosConsultaInterface)
      : TArray<ICEPInterface>;

    function getErro: boolean;
    function getMensagemErro: String;

    property Erro: boolean read getErro;
    property MensagemErro: String read getMensagemErro;
  end;

implementation

end.
