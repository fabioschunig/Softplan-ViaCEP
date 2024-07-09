unit UServerMethods;

interface

uses Classes;

type
{$METHODINFO ON}
  TServerMethods = class(TComponent)
    function ConsultaCEP(const CEP: String; var DadosArmazenados: boolean;
      const AtualizarDados: boolean; const Formato: String): String;
    function ConsultaEndereco(const UF, Localidade, Logradouro: String;
      var DadosArmazenados: boolean; const AtualizarDados: boolean;
      const Formato: String): String;
  end;
{$METHODINFO OFF}

implementation

uses
  UDataModule, FireDAC.DApt,
  UCEP.Intf,
  UCEP.Repository.Intf, UCEP.Repository.FireDAC,
  UConsulta.Intf, UConsulta.Builder.Indy,
  UFiltros.Consulta.Intf, UFiltros.Consulta.CEP, UFiltros.Consulta.Endereco;

{ TServerMethods }

function TServerMethods.ConsultaCEP(const CEP: String;
  var DadosArmazenados: boolean; const AtualizarDados: boolean;
  const Formato: String): String;
var
  repo: ICEPRepository;
  aCEP: ICEPInterface;
  aConsulta: IConsultaInterface;
  aFiltros: IFiltrosConsultaInterface;
begin
  result := '';
  DadosArmazenados := false;

  aConsulta := TConsultaBuilderIndy.Create(Formato);
  aFiltros := TFiltrosConsultaCEP.Create(CEP);
  repo := TCEPRepositoryFireDAC.Create(fDataModule.FDConnection);

  if not AtualizarDados then
  begin
    // busca na base de dados o CEP consultado previamente
    aCEP := repo.BuscarPorCEP(CEP, DadosArmazenados);
  end;

  // solicitado atualização forçada ou não foi encontrado na base de dados
  if AtualizarDados or (not DadosArmazenados) then
  begin
    aCEP := aConsulta.ConsultarSitePorCEP(aFiltros);

    if aConsulta.Erro then
    begin
      result := aConsulta.MensagemErro;
      exit;
    end;

    repo.Salvar(aCEP);
  end;

  result := aCEP.FormataRegistro;
end;

function TServerMethods.ConsultaEndereco(const UF, Localidade,
  Logradouro: String; var DadosArmazenados: boolean;
  const AtualizarDados: boolean; const Formato: String): String;
var
  repo: ICEPRepository;
  listaCEP: TArray<ICEPInterface>;
  iCont: integer;
  aConsulta: IConsultaInterface;
  aFiltros: IFiltrosConsultaInterface;
begin
  result := '';
  DadosArmazenados := false;

  aConsulta := TConsultaBuilderIndy.Create(Formato);
  aFiltros := TFiltrosConsultaEndereco.Create(UF, Localidade, Logradouro);
  repo := TCEPRepositoryFireDAC.Create(fDataModule.FDConnection);

  if not AtualizarDados then
  begin
    // busca na base de dados o CEP consultado previamente
    listaCEP := repo.BuscarPorEndereco(UF, Localidade, Logradouro,
      DadosArmazenados);
  end;

  // solicitado atualização forçada ou não foi encontrado na base de dados
  if AtualizarDados or (not DadosArmazenados) then
  begin
    listaCEP := aConsulta.ConsultarSitePorEndereco(aFiltros);

    if aConsulta.Erro then
    begin
      result := aConsulta.MensagemErro;
      exit;
    end;

    for iCont := 0 to length(listaCEP) - 1 do
    begin
      repo.Salvar(listaCEP[iCont]);
    end;
  end;

  for iCont := 0 to length(listaCEP) - 1 do
  begin
    result := result + listaCEP[iCont].FormataRegistro + sLineBreak;
  end;
end;

end.
