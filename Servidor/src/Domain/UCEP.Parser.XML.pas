unit UCEP.Parser.XML;

interface

uses
  System.SysUtils, System.Variants,
  XMLIntf, XMLDoc,
  UCEP.Intf, UCEP.Model;

type
  TCEPParserXML = class
  private
    class function criarCEP(node: IXMLNode): ICEPInterface;
  public
    class function ParseCEP(const Texto: String): ICEPInterface;
    class function ParseEnderecos(const Texto: String): TArray<ICEPInterface>;
  end;

implementation

{ TCEPParserXML }

class function TCEPParserXML.criarCEP(node: IXMLNode): ICEPInterface;
var
  aCEP: ICEPInterface;
begin
  aCEP := TCEPModel.Create;
  aCEP.Hydrate(
    node.ChildNodes.FindNode('cep').NodeValue,
    varToStr(node.ChildNodes.FindNode('logradouro').NodeValue),
    varToStr(node.ChildNodes.FindNode('complemento').NodeValue),
    varToStr(node.ChildNodes.FindNode('bairro').NodeValue),
    varToStr(node.ChildNodes.FindNode('localidade').NodeValue),
    varToStr(node.ChildNodes.FindNode('uf').NodeValue),
    NOW
  );

  result := aCEP;
end;

class function TCEPParserXML.ParseCEP(const Texto: String): ICEPInterface;
var
  XML: IXMLDocument;
  root: IXMLNode;
begin
  result := nil;

  XML := TXMLDocument.Create(nil);
  XML.LoadFromXML(Texto);

  root := XML.ChildNodes.FindNode('xmlcep');

  result := criarCEP(root);
end;

class function TCEPParserXML.ParseEnderecos(const Texto: String)
  : TArray<ICEPInterface>;
var
  XML: IXMLDocument;
  root, enderecos: IXMLNode;
  i: integer;
begin
  result := nil;

  XML := TXMLDocument.Create(nil);
  XML.LoadFromXML(Texto);

  root := XML.ChildNodes.FindNode('xmlcep');
  enderecos := root.ChildNodes.FindNode('enderecos');

  setLength(result, enderecos.ChildNodes.Count);

  for i := 0 to enderecos.ChildNodes.Count - 1 do
  begin
    result[i] := criarCEP(enderecos.ChildNodes[i]);
  end;
end;

end.
