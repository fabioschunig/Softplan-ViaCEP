unit UConsultaEnderecos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfConsultaEnderecos = class(TForm)
    pnFiltros: TPanel;
    rgFormatoResultado: TRadioGroup;
    pcTipoConsulta: TPageControl;
    tsCEP: TTabSheet;
    tsEndereco: TTabSheet;
    pnResultados: TPanel;
    Label1: TLabel;
    edCEP: TEdit;
    Label2: TLabel;
    edUF: TEdit;
    edEndereco: TEdit;
    edCidade: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    bPesquisarCEP: TButton;
    bPesquisarEndereco: TButton;
    procedure bPesquisarCEPClick(Sender: TObject);
    procedure bPesquisarEnderecoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fConsultaEnderecos: TfConsultaEnderecos;

implementation

{$R *.dfm}

procedure TfConsultaEnderecos.bPesquisarCEPClick(Sender: TObject);
begin
  //
end;

procedure TfConsultaEnderecos.bPesquisarEnderecoClick(Sender: TObject);
begin
  //
end;

end.
