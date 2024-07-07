unit UServerForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerServer, Datasnap.DSCommonServer,
  Datasnap.DSTCPServerTransport, Datasnap.DSServer, UServerMethods;

type
  TfServerForm = class(TForm)
    DSServer: TDSServer;
    DSServerClass: TDSServerClass;
    DSTCPServerTransport: TDSTCPServerTransport;
    procedure DSServerClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fServerForm: TfServerForm;

implementation

{$R *.dfm}

procedure TfServerForm.DSServerClassGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := TServerMethods;
end;

end.
