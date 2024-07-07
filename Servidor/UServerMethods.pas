unit UServerMethods;

interface

uses Classes;

type
{$METHODINFO ON}
  TServerMethods = class(TComponent)
    function ConsultaCEP(const CEP: String): String;
    function ConsultaEndereco(const UF, Cidade, Endereco: String): String;
  end;
{$METHODINFO OFF}

implementation

{ TServerMethods }

function TServerMethods.ConsultaCEP(const CEP: String): String;
begin
  // TODO: implementar o m�todo para buscar por CEP
  Result := 'Consulta de CEP';
end;

function TServerMethods.ConsultaEndereco(const UF, Cidade,
  Endereco: String): String;
begin
  // TODO: implementar o m�todo para buscar por Endere�o
  Result := 'Consulta de Endere�o';
end;

end.
