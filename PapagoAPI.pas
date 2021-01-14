unit PapagoAPI;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Net.HttpClient,
  System.Net.HttpClientComponent;

type
  TPapago = class
  strict private
    type
      TLanguage = record
        Code: string;
        Name: string;
      end;

    const
      Languages: array[0..12] of TLanguage = (
        (Code: 'ko'; Name: '한국어'),
        (Code: 'en'; Name: '영어'),
        (Code: 'ja'; Name: '일본어'),
        (Code: 'zh-CN'; Name: '중국어 간체'),
        (Code: 'zh-TW'; Name: '중국어 번체'),
        (Code: 'vi'; Name: '베트남어'),
        (Code: 'id'; Name: '인도네시아어'),
        (Code: 'th'; Name: '태국어'),
        (Code: 'de'; Name: '독일어'),
        (Code: 'ru'; Name: '러시아어'),
        (Code: 'es'; Name: '스페인어'),
        (Code: 'it'; Name: '이탈리아어'),
        (Code: 'fr'; Name: '프랑스어')
      );
  private
    FClientID: string;
    FClientSecret: string;
    FHttpClient: TNetHttpClient;
    FURL: string;

    function  GetClientID: string;
    function  GetClientSecret: string;
    procedure SetClientID(const Value: string);
    procedure SetClientSecret(const Value: string);
  public
    constructor Create;

    function  Execute(const ASource, ATarget, AText: string): string;
    procedure FillItem(AItems: TStrings);
    function  GetCode(const AIndex: Integer): string;

    property ClientID: string read GetClientID write SetClientID;
    property ClientSecret: string read GetClientSecret write SetClientSecret;
    property URL: string read FURL write FURL;
  end;

implementation

uses
  System.JSON;

{ TPapago }

constructor TPapago.Create;
begin
  FClientID := '';
  FClientSecret := '';
  FHttpClient := TNetHTTPClient.Create(nil);
  FHttpClient.ContentType := 'application/x-www-form-urlencoded; charset=UTF-8';
  FURL := 'https://openapi.naver.com/v1/papago/n2mt';
end;

function TPapago.Execute(const ASource, ATarget, AText: string): string;
var
  LResponse: IHTTPResponse;
  LSource: TStringStream;
  LTarget: TStringStream;
  LJSON: TJSONObject;
begin
  Result := 'ERROR!!';

  LSource := TStringStream.Create(Format('source=%s&target=%s&text=%s', [ASource, ATarget, AText]), TEncoding.UTF8);
  LTarget := TStringStream.Create('', TEncoding.UTF8);

  try
    LResponse := FHttpClient.Post(URL, LSource, LTarget);
    if LResponse.StatusCode = 200 then
    begin
      LJSON := TJSONObject.ParseJSONValue(LTarget.DataString) as TJSONObject;
      Result := TJSONObject(LJSON.Get('message').JsonValue).Get('result').JsonValue.P['translatedText'].ToString;
      Result := Result.DeQuotedString('"');
      LJSON.Free;
    end;
  finally
    LSource.Free;
    LTarget.Free;
  end;
end;

procedure TPapago.FillItem(AItems: TStrings);
var
  i: Integer;
begin
  for i := 0 to High(Languages) do
    AItems.Add(Languages[i].Name);
end;

function TPapago.GetClientID: string;
begin
  Result := FHttpClient.CustomHeaders['X-Naver-Client-Id'];
end;

function TPapago.GetClientSecret: string;
begin
  Result := FHttpClient.CustomHeaders['X-Naver-Client-Secret'];
end;

function TPapago.GetCode(const AIndex: Integer): string;
begin
  Result := Languages[AIndex].Code;
end;

procedure TPapago.SetClientID(const Value: string);
begin
  FHttpClient.CustomHeaders['X-Naver-Client-Id'] := Value;
end;

procedure TPapago.SetClientSecret(const Value: string);
begin
  FHttpClient.CustomHeaders['X-Naver-Client-Secret'] := Value;
end;

end.
