unit UBuscaEnderecoCEP;

interface

uses
  System.SysUtils, System.Classes;

type
  TBuscaEnderecoCEP = class(TComponent)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Softplan', [TBuscaEnderecoCEP]);
end;

end.
