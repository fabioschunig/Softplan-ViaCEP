unit UConsulta.Builder.Indy;

interface

uses
  UConsulta.Intf;

type
  TConsultaBuilderIndy = class
    class function Create(const Formato: String): IConsultaInterface;
  end;

implementation

uses
  System.SysUtils,
  UConsulta.XML.Indy, UConsulta.JSON.Indy;

{ TConsultaBuilderIndy }

class function TConsultaBuilderIndy.Create(const Formato: String)
  : IConsultaInterface;
begin
  if UpperCase(Formato) = 'XML' then
    result := TConsultaXMLIndy.Create
  else if UpperCase(Formato) = 'JSON' then
    result := TConsultaJSONIndy.Create
  else
    raise Exception.Create('Formato inválido para criação de consulta');
end;

end.
