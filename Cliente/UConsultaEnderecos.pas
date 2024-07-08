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
    pnResultados: TPanel;
    SQLConnection: TSQLConnection;
    mmResultado: TMemo;
    gbCEP: TGroupBox;
    bPesquisarCEP: TButton;
    edCEP: TEdit;
    gbEndereco: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edUF: TEdit;
    edLogradouro: TEdit;
    edLocalidade: TEdit;
    bPesquisarEndereco: TButton;
    procedure bPesquisarCEPClick(Sender: TObject);
    procedure bPesquisarEnderecoClick(Sender: TObject);
  private
    procedure ConsultaPorCEP(const CEP: String);
    procedure ConsultaPorEndereco(const UF, Localidade, Logradouro: String);
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
  ConsultaPorEndereco(edUF.Text, edLocalidade.Text, edLogradouro.Text);
end;

procedure TfConsultaEnderecos.ConsultaPorCEP(const CEP: String);
var
  DSClient: TServerMethodsClient;
  bDadosArmazenados: boolean;
begin
  SQLConnection.Connected := true;
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

procedure TfConsultaEnderecos.ConsultaPorEndereco(const UF, Localidade,
  Logradouro: String);
var
  DSClient: TServerMethodsClient;
  bDadosArmazenados: boolean;
begin
  SQLConnection.Connected := true;
  DSClient := TServerMethodsClient.Create(SQLConnection.DBXConnection);
  try
    mmResultado.Lines.Text := DSClient.ConsultaEndereco(UF, Localidade,
      Logradouro, bDadosArmazenados, false, FormatoResposta);

    if bDadosArmazenados and ConfirmaAtualizacaoDados then
    begin
      mmResultado.Lines.Text := DSClient.ConsultaEndereco(UF, Localidade,
        Logradouro, bDadosArmazenados, true, FormatoResposta);
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
