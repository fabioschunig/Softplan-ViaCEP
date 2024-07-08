unit UConsultaEnderecos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, System.UITypes,
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
    function FormatoResposta: string;
    function ConfirmaAtualizacaoDados: boolean;
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
  bDadosArmazenados: boolean;
begin
  DSClient := TServerMethodsClient.Create(SQLConnection.DBXConnection);
  try
    mmResultado.Lines.Text := DSClient.ConsultaCEP(CEP, bDadosArmazenados,
      false, FormatoResposta);

    if bDadosArmazenados and ConfirmaAtualizacaoDados then
    begin
      mmResultado.Lines.Text := DSClient.ConsultaCEP(CEP, bDadosArmazenados,
        true, FormatoResposta);
    end;
  finally
    DSClient.Free;
  end;
end;

procedure TfConsultaEnderecos.ConsultaPorEndereco(const UF, Cidade,
  Endereco: String);
var
  DSClient: TServerMethodsClient;
  bDadosArmazenados: boolean;
begin
  DSClient := TServerMethodsClient.Create(SQLConnection.DBXConnection);
  try
    mmResultado.Lines.Text := DSClient.ConsultaEndereco(UF, Cidade, Endereco,
      bDadosArmazenados, false, FormatoResposta);

    if bDadosArmazenados and ConfirmaAtualizacaoDados then
    begin
      mmResultado.Lines.Text := DSClient.ConsultaEndereco(UF, Cidade, Endereco,
        bDadosArmazenados, true, FormatoResposta);
    end;
  finally
    DSClient.Free;
  end;
end;

function TfConsultaEnderecos.FormatoResposta: string;
begin
  result := 'xml';
  if rgFormatoResultado.ItemIndex = 0 then
    result := 'json';
end;

function TfConsultaEnderecos.ConfirmaAtualizacaoDados: boolean;
begin
  result := MessageDlg
    ('Deseja executar uma nova consulta para atualizar os resultados?',
    TMsgDlgType.mtConfirmation, mbYesNo, 0) = mrYes;
end;

end.
