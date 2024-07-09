unit UFiltros.Consulta.CEP;

interface

uses
  UFiltros.Consulta.Intf;

type
  TFiltrosConsultaCEP = class(TInterfacedObject, IFiltrosConsultaInterface)
  private
    FsCEP: string;

    function getCEP: string;
    function getUF: string;
    function getLocalidade: string;
    function getLogradouro: string;
  public
    constructor Create(const CEP: String);
  end;

implementation

uses
  System.SysUtils;

{ TFiltrosConsultaCEP }

constructor TFiltrosConsultaCEP.Create(const CEP: String);
begin
  FsCEP := CEP;
end;

function TFiltrosConsultaCEP.getCEP: string;
begin
  result := FsCEP;
end;

function TFiltrosConsultaCEP.getUF: string;
begin
  raise Exception.Create('Filtro de CEP n�o possui UF');
end;

function TFiltrosConsultaCEP.getLocalidade: string;
begin
  raise Exception.Create('Filtro de CEP n�o possui Localidade');
end;

function TFiltrosConsultaCEP.getLogradouro: string;
begin
  raise Exception.Create('Filtro de CEP n�o possui Logradouro');
end;

end.
