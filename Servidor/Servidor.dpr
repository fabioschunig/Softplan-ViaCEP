program Servidor;

uses
  Vcl.Forms,
  UServerForm in 'UServerForm.pas' {fServerForm},
  UServerMethods in 'UServerMethods.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfServerForm, fServerForm);
  Application.Run;
end.
