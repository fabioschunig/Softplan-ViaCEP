unit UConsultaEnderecos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Data.DB, Data.SqlExpr, Data.DBXDataSnap, Data.DBXCommon, IPPeerClient;

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
    SQLConnection: TSQLConnection;
    mmResultado: TMemo;
    procedure bPesquisarCEPClick(Sender: TObject);
    procedure bPesquisarEnderecoClick(Sender: TObject);
  private
    procedure ConsultaPorCEP(const CEP: String);
    procedure ConsultaPorEndereco(const UF, Cidade, Endereco: String);
  end;

var
  fConsultaEnderecos: TfConsultaEnderecos;

implementation

uses UDSClienteMethods;

{$R *.dfm}

procedure TfConsultaEnderecos.bPesquisarCEPClick(Sender: TObject);
begin
  ConsultaPorCEP(edCEP.Text);
end;

procedure TfConsultaEnderecos.bPesquisarEnderecoClick(Sender: TObject);
begin
  ConsultaPorEndereco(edUF.Text, edCidade.Text, edEndereco.Text);
end;

procedure TfConsultaEnderecos.ConsultaPorCEP(const CEP: String);
var
  DSClient: TServerMethodsClient;
begin
  DSClient := TServerMethodsClient.Create(SQLConnection.DBXConnection);
  try
    mmResultado.Lines.Text := DSClient.ConsultaCEP(CEP);
  finally
    DSClient.Free;
  end;
end;

procedure TfConsultaEnderecos.ConsultaPorEndereco(const UF, Cidade,
  Endereco: String);
var
  DSClient: TServerMethodsClient;
begin
  DSClient := TServerMethodsClient.Create(SQLConnection.DBXConnection);
  try
    mmResultado.Lines.Text := DSClient.ConsultaEndereco(UF, Cidade, Endereco);
  finally
    DSClient.Free;
  end;
end;

end.
