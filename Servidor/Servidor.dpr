program Servidor;

uses
  Vcl.Forms,
  UServerForm in 'UServerForm.pas' {fServerForm},
  UServerMethods in 'UServerMethods.pas',
  UCEP.Model in 'src\Domain\UCEP.Model.pas',
  UCEP.Repository.Intf in 'src\Domain\UCEP.Repository.Intf.pas',
  UDataModule in 'UDataModule.pas' {fDataModule: TDataModule},
  UCEP.Repository.FireDAC in 'src\Infra\UCEP.Repository.FireDAC.pas',
  UCEP.Intf in 'src\Domain\UCEP.Intf.pas',
  UConsulta.Intf in 'src\Application\UConsulta.Intf.pas',
  UConsulta.Builder.Indy in 'src\Infra\UConsulta.Builder.Indy.pas',
  UConsulta.XML.Indy in 'src\Infra\UConsulta.XML.Indy.pas',
  UConsulta.JSON.Indy in 'src\Infra\UConsulta.JSON.Indy.pas',
  UFiltros.Consulta.Intf in 'src\Application\UFiltros.Consulta.Intf.pas',
  UFiltros.Consulta.CEP in 'src\Application\UFiltros.Consulta.CEP.pas',
  UFiltros.Consulta.Endereco in 'src\Application\UFiltros.Consulta.Endereco.pas',
  UCEP.Parser.XML in 'src\Domain\UCEP.Parser.XML.pas',
  UCEP.Parser.JSON in 'src\Domain\UCEP.Parser.JSON.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfServerForm, fServerForm);
  Application.CreateForm(TfDataModule, fDataModule);

  // prepara aplicação para rodar
  try
    fDataModule.PrepararBancoDeDados;
  except
    Application.Terminate;
  end;

  Application.Run;
end.
