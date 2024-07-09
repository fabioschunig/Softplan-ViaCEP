unit UFiltros.Consulta.Intf;

interface

type
  IFiltrosConsultaInterface = interface
    ['{1AD2A43E-E3D8-40D1-8BC0-3461D6876E0F}']

    function getCEP: string;
    function getUF: string;
    function getLocalidade: string;
    function getLogradouro: string;

    property CEP: string read getCEP;
    property UF: string read getUF;
    property Localidade: string read getLocalidade;
    property Logradouro: string read getLogradouro;
  end;

implementation

end.
