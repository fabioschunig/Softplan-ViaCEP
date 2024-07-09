unit UCEP.Repository.Intf;

interface

uses
  UCEP.Intf;

type
  ICEPRepository = interface
    ['{FD477C36-4DB3-4897-A4E5-35C855C52825}']

    function Salvar(aCEP: ICEPInterface): boolean;
    function BuscarPorCEP(const CEP: String; var Encontrou: boolean)
      : ICEPInterface;
    function BuscarPorEndereco(const UF, Localidade, Logradouro: String;
      var Encontrou: boolean): TArray<ICEPInterface>;
  end;

implementation

end.
