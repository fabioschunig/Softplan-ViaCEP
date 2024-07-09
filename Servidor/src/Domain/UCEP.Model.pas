unit UCEP.Model;

interface

uses
  UCEP.Intf;

type
  TCEPModel = class(TInterfacedObject, ICEPInterface)
  private
    FsCEP: string;
    FsLogradouro: string;
    FsComplemento: string;
    FsBairro: string;
    FsLocalidade: string;
    FsUF: string;

    function getCEP: string;
    function getLogradouro: string;
    function getComplemento: string;
    function getBairro: string;
    function getLocalidade: string;
    function getUF: string;

    procedure setCEP(CEP: String);
    procedure setLogradouro(Logradouro: String);
    procedure setComplemento(Complemento: String);
    procedure setBairro(Bairro: String);
    procedure setLocalidade(Localidade: String);
    procedure setUF(UF: String);

    procedure Hydrate(const CEP, Logradouro, Complemento, Bairro, Localidade,
      UF: String);

    function FormataRegistro: String;
  end;

implementation

uses
  System.SysUtils;

{ TCEPModel }

function TCEPModel.getCEP: string;
begin
  result := FsCEP;
end;

function TCEPModel.getLogradouro: string;
begin
  result := FsLogradouro;
end;

function TCEPModel.getComplemento: string;
begin
  result := FsComplemento;
end;

function TCEPModel.getBairro: string;
begin
  result := FsBairro;
end;

function TCEPModel.getLocalidade: string;
begin
  result := FsLocalidade;
end;

function TCEPModel.getUF: string;
begin
  result := FsUF;
end;

procedure TCEPModel.setCEP(CEP: String);
begin
  FsCEP := CEP;
end;

procedure TCEPModel.setLogradouro(Logradouro: String);
begin
  FsLogradouro := Logradouro;
end;

procedure TCEPModel.setComplemento(Complemento: String);
begin
  FsComplemento := Complemento;
end;

procedure TCEPModel.setBairro(Bairro: String);
begin
  FsBairro := Bairro;
end;

procedure TCEPModel.setLocalidade(Localidade: String);
begin
  FsLocalidade := Localidade;
end;

procedure TCEPModel.setUF(UF: String);
begin
  FsUF := UF;
end;

procedure TCEPModel.Hydrate(const CEP, Logradouro, Complemento, Bairro,
  Localidade, UF: String);
begin
  setCEP(CEP);
  setLogradouro(Logradouro);
  setComplemento(Complemento);
  setBairro(Bairro);
  setLocalidade(Localidade);
  setUF(UF);
end;

function TCEPModel.FormataRegistro: String;
begin
  result := Format(
    'CEP: %s ' + sLineBreak +
    'Logradouro: %s - %s ' + sLineBreak +
    'Bairro: %s ' + sLineBreak +
    'Localidade / UF: %s / %s ' + sLineBreak,
    [FsCEP, FsLogradouro, FsComplemento, FsBairro, FsLocalidade, FsUF]);
end;

end.
