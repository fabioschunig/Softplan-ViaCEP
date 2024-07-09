unit UCEP.Parser.JSON;

interface

uses
  System.SysUtils,
  System.JSON, System.Generics.Collections,
  UCEP.Intf, UCEP.Model;

type
  TCEPParserJSON = class
  private
    class function criarCEP(JSON: TJSonValue): ICEPInterface;
  public
    class function ParseCEP(const Texto: String): ICEPInterface;
    class function ParseEnderecos(const Texto: String): TArray<ICEPInterface>;
  end;

implementation

{ TCEPParserJSON }

class function TCEPParserJSON.criarCEP(JSON: TJSonValue): ICEPInterface;
var
  aCEP: ICEPInterface;
begin
  aCEP := TCEPModel.Create;
  aCEP.Hydrate(
    JSON.FindValue('cep').Value,
    JSON.FindValue('logradouro').Value,
    JSON.FindValue('complemento').Value,
    JSON.FindValue('bairro').Value,
    JSON.FindValue('localidade').Value,
    JSON.FindValue('uf').Value,
    NOW
  );

  result := aCEP;
end;

class function TCEPParserJSON.ParseCEP(const Texto: String): ICEPInterface;
var
  JSONValue: TJSonValue;
begin
  result := nil;

  JSONValue := TJSonObject.ParseJSONValue(Texto);
  try
    result := criarCEP(JSONValue);
  finally
    JSONValue.Free;
  end;
end;

class function TCEPParserJSON.ParseEnderecos(const Texto: String)
  : TArray<ICEPInterface>;
var
  JSONValue: TJSonValue;
  JSONArray: TJSONArray;
  i: integer;
begin
  result := nil;

  JSONValue := TJSonObject.ParseJSONValue(Texto);
  try
    JSONArray := (JSONValue as TJSONArray);

    setLength(result, JSONArray.Count);

    for i := 0 to JSONArray.Count - 1 do
    begin
      result[i] := criarCEP(JSONArray[i]);
    end;
  finally
    JSONValue.Free;
  end;
end;

end.
