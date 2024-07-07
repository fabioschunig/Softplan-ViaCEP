program Cliente;

uses
  Vcl.Forms,
  UConsultaEnderecos in 'UConsultaEnderecos.pas' {fConsultaEnderecos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfConsultaEnderecos, fConsultaEnderecos);
  Application.Run;
end.
