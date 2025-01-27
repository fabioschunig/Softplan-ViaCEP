unit UCEP.Intf;

interface

type
  ICEPInterface = interface
    ['{97F2B011-06EE-458D-82C7-57BD1CE31E5D}']
    function getCEP: string;
    function getLogradouro: string;
    function getComplemento: string;
    function getBairro: string;
    function getLocalidade: string;
    function getUF: string;
    function getData: TDateTime;

    procedure setCEP(CEP: String);
    procedure setLogradouro(Logradouro: String);
    procedure setComplemento(Complemento: String);
    procedure setBairro(Bairro: String);
    procedure setLocalidade(Localidade: String);
    procedure setUF(UF: String);
    procedure setData(Data: TDateTime);

    property CEP: string read getCEP write setCEP;
    property Logradouro: string read getLogradouro write setLogradouro;
    property Complemento: string read getComplemento write setComplemento;
    property Bairro: string read getBairro write setBairro;
    property Localidade: string read getLocalidade write setLocalidade;
    property UF: string read getUF write setUF;
    property Data: TDateTime read getData write setData;

    procedure Hydrate(const CEP, Logradouro, Complemento, Bairro, Localidade,
      UF: String; Data: TDateTime);

    function FormataRegistro: String;
  end;

implementation

end.
