unit UBuscaEnderecoCEPTest;

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  UBuscaEnderecoCEP;

type

  [TestFixture]
  TBuscaEnderecoCEPTest = class
  private
    FaBuscaEnderecoCEP: TBuscaEnderecoCEP;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    [TestCase('CEP Vazio', '')]
    [TestCase('CEP 1 espaço em branco', ' ')]
    [TestCase('CEP 1 caractere', '9')]
    [TestCase('CEP 2 caracteres', '79')]
    [TestCase('CEP 7 caracteres', '1234567')]
    procedure TestCEP_Invalido_Tamanho(const CEP: string);

    [Test]
    [TestCase('CEP com letras', '1234567A')]
    [TestCase('CEP com espaço no meio', '123 5678')]
    procedure TestCEP_Invalido_Conteudo(const CEP: string);

    [Test]
    [TestCase('UF Vazio', '')]
    [TestCase('UF 1 espaço em branco', ' ')]
    [TestCase('UF 1 caractere', 'X')]
    [TestCase('UF 3 caracteres', 'XYZ')]
    procedure TestUF_Tamanho(const UF: string);

    [Test]
    [TestCase('Cidade Vazia', 'SC,')]
    [TestCase('Cidade 1 espaço em branco', 'SC, ')]
    [TestCase('Cidade 1 caractere', 'SC,X')]
    [TestCase('Cidade 2 caracteres', 'SC,XY')]
    procedure TestCidade_Tamanho(const UF, Cidade: string);

    [Test]
    [TestCase('Endereço Vazio', 'SC,Florianópolis,')]
    [TestCase('Endereço 1 espaço em branco', 'SC,Florianópolis, ')]
    [TestCase('Florianópolis 1 caractere', 'SC,Florianópolis,X')]
    [TestCase('Florianópolis 2 caracteres', 'SC,Florianópolis,XY')]
    procedure TestEndereco_Tamanho(const UF, Cidade, Endereco: string);
  end;

implementation

procedure TBuscaEnderecoCEPTest.Setup;
begin
  FaBuscaEnderecoCEP := TBuscaEnderecoCEP.create(nil);
end;

procedure TBuscaEnderecoCEPTest.TearDown;
begin
  FaBuscaEnderecoCEP.Free;
end;

procedure TBuscaEnderecoCEPTest.TestCEP_Invalido_Tamanho(const CEP: string);
var
  sRetorno: string;
begin
  sRetorno := FaBuscaEnderecoCEP.BuscarPorCEP(CEP);
  Assert.IsTrue(FaBuscaEnderecoCEP.Erro);
  Assert.AreEqual(RS_MSG_ERRO_CEP_TAMANHO, sRetorno);
end;

procedure TBuscaEnderecoCEPTest.TestCEP_Invalido_Conteudo(const CEP: string);
var
  sRetorno: string;
begin
  sRetorno := FaBuscaEnderecoCEP.BuscarPorCEP(CEP);
  Assert.IsTrue(FaBuscaEnderecoCEP.Erro);
  Assert.AreEqual(sRetorno, Format(RS_MSG_ERRO_CEP_INVALIDO, [CEP]));
end;

procedure TBuscaEnderecoCEPTest.TestUF_Tamanho(const UF: string);
var
  sRetorno: string;
begin
  sRetorno := FaBuscaEnderecoCEP.BuscarPorEndereco(UF, '', '');
  Assert.IsTrue(FaBuscaEnderecoCEP.Erro);
  Assert.AreEqual(sRetorno, RS_MSG_ERRO_UF_TAMANHO);
end;

procedure TBuscaEnderecoCEPTest.TestCidade_Tamanho(const UF, Cidade: string);
var
  sRetorno: string;
begin
  sRetorno := FaBuscaEnderecoCEP.BuscarPorEndereco(UF, Cidade, '');
  Assert.IsTrue(FaBuscaEnderecoCEP.Erro);
  Assert.AreEqual(sRetorno, RS_MSG_ERRO_CIDADE_TAMANHO);
end;

procedure TBuscaEnderecoCEPTest.TestEndereco_Tamanho(const UF, Cidade,
  Endereco: string);
var
  sRetorno: string;
begin
  sRetorno := FaBuscaEnderecoCEP.BuscarPorEndereco(UF, Cidade, Endereco);
  Assert.IsTrue(FaBuscaEnderecoCEP.Erro);
  Assert.AreEqual(sRetorno, RS_MSG_ERRO_ENDERECO_TAMANHO);
end;

initialization

TDUnitX.RegisterTestFixture(TBuscaEnderecoCEPTest);

end.
