unit UFiltros.Consulta.Endereco;

interface

uses
  UFiltros.Consulta.Intf;

type
  TFiltrosConsultaEndereco = class(TInterfacedObject, IFiltrosConsultaInterface)
  private
    FsUF: string;
    FsLocalidade: string;
    FsLogradouro: string;

    function getCEP: string;
    function getUF: string;
    function getLocalidade: string;
    function getLogradouro: string;
  public
    constructor Create(const UF, Localidade, Logradouro: String);
  end;

implementation

uses
  System.SysUtils;

{ TFiltrosConsultaEndereco }

constructor TFiltrosConsultaEndereco.Create(const UF, Localidade,
  Logradouro: String);
begin
  FsUF := UF;
  FsLocalidade := Localidade;
  FsLogradouro := Logradouro;
end;

function TFiltrosConsultaEndereco.getCEP: string;
begin
  raise Exception.Create('Filtro de Endereço não possui CEP');
end;

function TFiltrosConsultaEndereco.getUF: string;
begin
  result := FsUF;
end;

function TFiltrosConsultaEndereco.getLocalidade: string;
begin
  result := FsLocalidade;
end;

function TFiltrosConsultaEndereco.getLogradouro: string;
begin
  result := FsLogradouro;
end;

end.
