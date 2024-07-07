program Cliente;

uses
  Vcl.Forms,
  UConsultaEnderecos in 'UConsultaEnderecos.pas' {fConsultaEnderecos},
  UDSClienteMethods in 'UDSClienteMethods.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfConsultaEnderecos, fConsultaEnderecos);
  Application.Run;
end.
