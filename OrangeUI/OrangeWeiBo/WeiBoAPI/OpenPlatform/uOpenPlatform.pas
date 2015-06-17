unit uOpenPlatform;

interface
//{$I FrameWork.inc}

{$DEFINE FMX}


uses
//  System,
//  Windows,
  Classes,
  SysUtils,
  Variants,
  DateUtils,
  uPublic,
  XSuperObject,
  uUrlParam,
  INIFiles,

  uFuncCommon,

  {$IFDEF VCL}
  Forms,
  {$ENDIF}
  XMLDoc,
  XMLIntf,
  uBaseList
  {$IFDEF FMX}
  ,FMX.Forms
  {$ENDIF}
  ;

type
  //֧�ֵ�HTTP���󷽷�
  THTTPRequestMethod=(hrmGet,hrmPost);
  THTTPRequestMethods=set of THTTPRequestMethod;
  //�������ݸ�ʽ
  TReponseDataFormat=(rdfUrl,rdfJson,rdfXml);
  //�ӿ���Ҫ�ķ��ʼ���
  TAccessLevel=(alNormal);
  //������������
  TResponseDataType=(rdtRedirectUrl,rdtData);

  TValueScope=class
  public
    //����ȡֵ
    Value:Variant;
    //����˵��
    Descrip:String;
  end;

  TValueScopeList=class(TBaseList)
  private
    function GetItem(Index: Integer): TValueScope;
  public
    function Add(const Value:Variant;const Descrip:String):TValueScope;
    property Items[Index:Integer]:TValueScope read GetItem;default;
  end;

  TAPIParam=class
  public
    NeedUrlEncord:Boolean;
    //������
    Name:String;
    //��ѡ
    Need:Boolean;
    //���ͼ���Χ
    Kind:String;
    //˵��
    Descrip:String;
    //����ֵ
    Value:Variant;
    //������Χ
    ValueScoptList:TValueScopeList;
  public
    constructor Create;
    destructor Destroy;override;
  end;

  TAPIParamList=class(TBaseList)
  private
    function GetItem(Index: Integer): TAPIParam;
    function GetItemByName(const Name: String): TAPIParam;
  public
    //���API�����б��ֵ
    procedure ClearValue;
    procedure SetValue(const Name:String;const Value:Variant);
    property Items[Index:Integer]:TAPIParam read GetItem;default;
    property ItemByName[const Name:String]:TAPIParam read GetItemByName;
    //����ֵ
    function Add( const Name:String;
                  const Need:Boolean;
                  const Kind:String;
                  const Descrip:String
                  ):TAPIParam;
  end;

  TAPIResponse=class
  private
    function ParseFromStream(AResponseStream:TStream):Boolean;
  protected
    function ParseDataStructure:Boolean;virtual;abstract;
  public
    RootJson:ISuperObject;
  end;

  TAPIItem=class
  public
    //API����
    Name:String;
    //����
    Descrip:String;
    //URL
    URL:String;
    //������������
    ResponseDataType:TResponseDataType;
    //�������ݸ�ʽ
    ResponseDataFormat:TReponseDataFormat;
    //HTTP����ʽ
    HttpRequestMethods:THTTPRequestMethods;
    //�Ƿ���Ҫ��¼
    NeedLogin:Boolean;
    //������Ȩ����
    //���ʼ���
    AccessLevel:TAccessLevel;
    //Ƶ������
    TimesLimit:Boolean;
    //�����б�
    ParamList:TAPIParamList;
  protected
    procedure Init;virtual;abstract;
  public
    constructor Create;
    destructor Destroy;override;
  end;

  TAPIItemClass=class of TAPIItem;

  TAPIRegist=class
  public
    APIItemName:String;
    APIItemClass:TAPIItemClass;
  end;

  TAPIRegistList=class(TBaseList)
  private
    function GetItem(Index: Integer): TAPIRegist;
    function GetItemByName(const Name: String): TAPIRegist;
  public
    property ItemByName[const Name:String]:TAPIRegist read GetItemByName;
    function Add(const APIItemName:String;const APIItemClass:TAPIItemClass):TAPIRegist;
    property Items[Index:Integer]:TAPIRegist read GetItem;default;
  end;

  //App
  TApp=class
  public
    //Ӧ�õ�Key
    AppKey:String;
    //Ӧ�õ�Secret
    AppSecret:String;
    //��Ȩ�ص�ҳ
    CallBackUrl:String;
  public
//    {$IFDEF VCL}
//    function LoadFromXML(AXMLFilePath:String):Boolean;
//    function SaveToXML(AXMLFilePath:String):Boolean;
//    function LoadFromXMLNode(AXMLNode:IXMLNode):Boolean;
//    function SaveToXMLNode(AXMLNode:IXMLNode):Boolean;
//    {$ENDIF}
    function LoadFromINI(AINIFilePath:String):Boolean;
    function SaveToINI(AINIFilePath:String):Boolean;
  end;

  TOAuth2User=class
  public
    UserId:String;
    Password:String;
    //��ǰ��Ȩ�û���UID��
    Uid:String;
    //��ȡ����AccessToken
    AccessToken:String;
    //access_token���������ڣ��ò���������������������ʹ��expires_in����
    Remind_In:string;
    //access_token���������ڣ���λ��������
    Expires_In:string;

    //�ϴ���Ȩʱ��
    LastAuthTime:TDateTime;
    //��ε���ʱ��
    function ExpiresTime:TDateTime;
  public
    constructor Create;
  public
//    {$IFDEF VCL}
//    function LoadFromXML(AXMLFilePath:String):Boolean;
//    function SaveToXML(AXMLFilePath:String):Boolean;
//    function LoadFromXMLNode(AXMLNode:IXMLNode):Boolean;
//    function SaveToXMLNode(AXMLNode:IXMLNode):Boolean;
//    {$ENDIF}

    function LoadFromINI(AINIFilePath:String):Boolean;
    function SaveToINI(AINIFilePath:String):Boolean;
  end;

  THttpControl=class
//  private
//    //�ٽ���
//    FHttpLock:TRTLCriticalSection;
  public
    procedure Lock;
    procedure UnLock;
    constructor Create;virtual;
    destructor Destroy;override;
    function Get(const HttpUrl:String;AResponseStream:TStream):Boolean;overload;virtual;abstract;
    function Get(const HttpUrl:String):String;overload;virtual;abstract;
    function Post(const HttpUrl:String;ARequestStream:TStream;AResponseStream:TStream):Boolean;overload;virtual;abstract;
    function Post(const HttpUrl:String;ARequestStream:TStream):String;overload;virtual;abstract;
  end;

  TOpenPlatform=class
  public
    //��ȡAPI������Url
    function GetCallAPIUrl(App:TApp;OAuth2User:TOAuth2User;APIItem:TAPIItem):String;
    //����API
    function CallAPI( App:TApp;
                      OAuth2User:TOAuth2User;
                      APIItem:TAPIItem;
                      HttpControl:THttpControl;
                      AResponseStream:TStream):Boolean;overload;
    function CallAPI( App:TApp;
                      OAuth2User:TOAuth2User;
                      APIItem:TAPIItem;
                      HttpControl:THttpControl;
                      APIResponse:TAPIResponse):Boolean;overload;

  end;


procedure RegisterAPIItem(const APIItemName:String;const APIItemClass:TAPIItemClass);
function CreateAPIItem(const APIItemName:String):TAPIItem;






//function UrlEncode(URL: string): string;
//function FuncUrlEncode(const S : AnsiString) : String;
function UrlEncodeUTF8(URL: String): string;
function FuncUrlEncodeUTF8(const S : String) : String;

function GetJsonStringValue(AJson: ISuperObject;Name:String):String;

implementation


uses
  //��Ȩ�ӿ�
  uAPIItem_oauth2_authorize,
  uAPIItem_oauth2_access_token,

  //΢���ӿ�

  //��ȡ�ӿ�
  uAPIItem_statuses_home_timeline,
  uAPIItem_statuses_public_timeline,
  uAPIItem_statuses_show,
  uAPIItem_comments_show,
  uAPIItem_statuses_repost_timeline,

  //д��ӿ�
  uAPIItem_statuses_update;


var
  GlobalAPIRegistList:TAPIRegistList;

function GetJsonStringValue(AJson: ISuperObject;Name:String):String;
begin
//  if AJson.Null[Name]=jNull then
//  begin
//    Result:='';
//  end
//  else
//  begin
//    Result:=AJson.V[Name];
//  end;
  if VarIsNull(AJson.V[Name]) then
  begin
    Result:='';
  end
  else
  begin
    Result:=AJson.V[Name];
  end;

end;
function CreateAPIItem(const APIItemName:String):TAPIItem;
begin
  Result:=GlobalAPIRegistList.ItemByName[APIItemName].APIItemClass.Create;
end;

procedure RegisterAPIItem(const APIItemName:String;const APIItemClass:TAPIItemClass);
begin
  if GlobalAPIRegistList=nil then
  begin
    GlobalAPIRegistList:=TAPIRegistList.Create;
  end;
  GlobalAPIRegistList.Add(APIItemName,APIItemClass);
end;

function _IntToHex(Value: Integer; Digits: Integer): String;
begin
  Result := SysUtils.IntToHex(Value, Digits);
end;

function XDigit(Ch : Char) : Integer;
begin
  if (Ch >= '0') and (Ch <= '9') then
      Result := Ord(Ch) - Ord('0')
  else
      Result := (Ord(Ch) and 15) + 9;
end;


function IsXDigit(Ch : Char) : Boolean;
begin
  Result := ((Ch >= '0') and (Ch <= '9')) or
            ((Ch >= 'a') and (Ch <= 'f')) or
            ((Ch >= 'A') and (Ch <= 'F'));
end;

function htoin(Value : PChar; Len : Integer) : Integer;
var
  I : Integer;
begin
  Result := 0;
  I      := 0;
  while (I < Len) and (Value[I] = ' ') do
      I := I + 1;
  while (I < len) and (IsXDigit(Value[I])) do begin
      Result := Result * 16 + XDigit(Value[I]);
      I := I + 1;
  end;
end;

function htoi2(Value : PChar) : Integer;
begin
  Result := htoin(Value, 2);
end;

//function FuncUrlEncode(const S : AnsiString) : String;
//var
//  I : Integer;
//  Ch : AnsiChar;
//begin
//  Result := '';
//  for I := 1 to Length(S) do begin
//      Ch := S[I];
//      if ((Ch >= '0') and (Ch <= '9')) or
//         ((Ch >= 'a') and (Ch <= 'z')) or
//         ((Ch >= 'A') and (Ch <= 'Z')) or
//         (Ch = '.') or (Ch = '-') or (Ch = '_') or (Ch = '~')then
//          Result := Result + Ch
//      else
//          Result := Result + '%' + _IntToHex(Ord(Ch), 2);
//  end;
//end;

function FuncUrlEncodeUTF8(const S : String) : String;
var
  I : Integer;
  Ch : Char;
  RawS : UnicodeString;
  {$IFDEF FMX}
  RawSB:array of Byte;
  {$ENDIF}
  {$IFDEF VCL}
  RawSB:RawByteString;
  {$ENDIF}
begin
  Result := '';
  RawS:=S;
  {$IFDEF FMX}
  UTF8Encode(RawS,RawSB);
  {$ENDIF}
  {$IFDEF VCL}
  RawSB:=UTF8Encode(RawS);
  {$ENDIF}

  for I := 1 to Length(RawSB) do begin
      Ch := Char(RawSB[I]);
      if ((Ch >= '0') and (Ch <= '9')) or
         ((Ch >= 'a') and (Ch <= 'z')) or
         ((Ch >= 'A') and (Ch <= 'Z')) or
         (Ch = '.') or (Ch = '-') or (Ch = '_') or (Ch = '~')then
          Result := Result + Ch
      else
          Result := Result + '%' + _IntToHex(Ord(Ch), 2);
  end;


end;


//function urlEncode(URL: string): string;
//var
//  URL1: string;
//begin
//  URL1 := FuncUrlEncode(URL);
//  URL1 := StringReplace(URL1, '+', ' ', [rfReplaceAll, rfIgnoreCase]);
//  result := URL1;
//end;

function UrlEncodeUTF8(URL: String): string;
var
  URL1: string;
begin
  URL1 := FuncUrlEncodeUTF8(URL);
  URL1 := StringReplace(URL1, '+', ' ', [rfReplaceAll, rfIgnoreCase]);
  result := URL1;
end;

{ TOAuth2User }

//{$IFDEF VCL}
//function TOAuth2User.LoadFromXMLNode(AXMLNode: IXMLNode): Boolean;
//begin
//  Result:=False;
//  Self.UserId:=AXMLNode.Attributes['UserId'];
//  Self.Password:=AXMLNode.Attributes['Password'];
//  Self.Uid:=AXMLNode.Attributes['Uid'];
//  Self.AccessToken:=AXMLNode.Attributes['AccessToken'];
//  Self.Remind_In:=AXMLNode.Attributes['Remind_In'];
//  Self.Expires_In:=AXMLNode.Attributes['Expires_In'];
//  Self.LastAuthTime:=StandardStrToDateTime(AXMLNode.Attributes['LastAuthTime']);
//  Result:=True;
//end;
//
//function TOAuth2User.SaveToXMLNode(AXMLNode: IXMLNode): Boolean;
//begin
//  Result:=False;
//  AXMLNode.Attributes['UserId']:=Self.UserId;
//  AXMLNode.Attributes['Password']:=Self.Password;
//  AXMLNode.Attributes['Uid']:=Self.Uid;
//  AXMLNode.Attributes['AccessToken']:=Self.AccessToken;
//  AXMLNode.Attributes['Remind_In']:=Self.Remind_In;
//  AXMLNode.Attributes['Expires_In']:=Self.Expires_In;
//  AXMLNode.Attributes['LastAuthTime']:=StandardDateTimeToStr(Self.LastAuthTime);
//  Result:=True;
//end;
//
//function TOAuth2User.LoadFromXML(AXMLFilePath: String): Boolean;
//var
//  XMLDoc:TXMLDocument;
//  XMLDocNode:IXMLNode;
//begin
//  Result:=False;
//  if Not FileExists(AXMLFilePath) then Exit;
//  XMLDoc:=TXMLDocument.Create(Application);
//  try
//    XMLDoc.LoadFromFile(AXMLFilePath);
//    XMLDoc.Active := True;
//    XMLDocNode:=XMLDoc.DocumentElement;
//    Result:=LoadFromXMLNode(XMLDocNode);
//  finally
//    XMLDoc.Free;
//  end;
//end;
//
//
//function TOAuth2User.SaveToXML(AXMLFilePath: String): Boolean;
//var
//  XMLDoc:TXMLDocument;
//  XMLDocNode:IXMLNode;
//begin
//  Result:=False;
//  XMLDoc:=TXMLDocument.Create(Application);
//  try
//    XMLDoc.Active := True;
//    XMLDoc.Version := '1.0';
//    XMLDoc.Encoding := 'UTF-8';
//    XMLDocNode:=XMLDoc.AddChild('OAuth2User');
//    Result:=SaveToXMLNode(XMLDocNode);
//    XMLDoc.SaveToFile(AXMLFilePath);
//  finally
//    XMLDoc.Free;
//  end;
//end;
//{$ENDIF}

constructor TOAuth2User.Create;
begin
  LastAuthTime:=0;
end;

function TOAuth2User.ExpiresTime: TDateTime;
begin
  Result:=DateUtils.IncSecond(Self.LastAuthTime,StrToInt64(Self.Expires_In));
end;

function TOAuth2User.LoadFromINI(AINIFilePath:String):Boolean;
var
  AIniFile:TIniFile;
begin
  Result:=False;

  AIniFile:=TIniFile.Create(AINIFilePath);

  Self.UserId:=AIniFile.ReadString('','UserId','');
  Self.Password:=AIniFile.ReadString('','Password','');
  Self.Uid:=AIniFile.ReadString('','Uid','');
  Self.AccessToken:=AIniFile.ReadString('','AccessToken','');
  Self.Remind_In:=AIniFile.ReadString('','Remind_In','');
  Self.Expires_In:=AIniFile.ReadString('','Expires_In','');
  Self.LastAuthTime:=StandardStrToDateTime(AIniFile.ReadString('','LastAuthTime',''));

  FreeAndNil(AIniFile);

  Result:=True;

end;

function TOAuth2User.SaveToINI(AINIFilePath:String):Boolean;
var
  AIniFile:TIniFile;
begin

  Result:=False;
  AIniFile:=TIniFile.Create(AINIFilePath);

  AIniFile.WriteString('','UserId',Self.UserId);
  AIniFile.WriteString('','Password',Self.Password);
  AIniFile.WriteString('','Uid',Self.Uid);
  AIniFile.WriteString('','AccessToken',Self.AccessToken);
  AIniFile.WriteString('','Remind_In',Self.Remind_In);
  AIniFile.WriteString('','Expires_In',Self.Expires_In);
  AIniFile.WriteString('','LastAuthTime',StandardDateTimeToStr(Self.LastAuthTime));

  FreeAndNil(AIniFile);
  Result:=True;

end;

{ TOpenPlatform }

function TOpenPlatform.CallAPI(App: TApp;
                                OAuth2User: TOAuth2User;
                                APIItem: TAPIItem;
                                HttpControl: THttpControl;
                                AResponseStream: TStream): Boolean;
var
  HttpUrl:String;
  ARequestStream:TMemoryStream;
begin
  Result:=False;

  HttpUrl:=Self.GetCallAPIUrl(App,OAuth2User,APIItem);

  if hrmGet in APIItem.HttpRequestMethods then
  begin
    Result:=HttpControl.Get(HttpUrl,AResponseStream);
  end
  else
  begin
    ARequestStream:=TMemoryStream.Create;
    try
      Result:=HttpControl.Post(HttpUrl,ARequestStream,AResponseStream);
    finally
      FreeAndNil(ARequestStream);
    end;
  end;

//  Result:=True;
end;

function TOpenPlatform.CallAPI( App:TApp;
                  OAuth2User:TOAuth2User;
                  APIItem:TAPIItem;
                  HttpControl:THttpControl;
                  APIResponse:TAPIResponse):Boolean;
var
  AResponseStream:TMemoryStream;
begin
  Result:=False;
  AResponseStream:=TMemoryStream.Create;
  if Not Self.CallAPI(App,OAuth2User,APIItem,HttpControl,AResponseStream) then
  begin
    FreeAndNil(AResponseStream);
  end
  else
  begin
    AResponseStream.SaveToFile(GetResponseTempDir+FormatDateTime('YYYY-MM-DD HH-MM-SS-ZZZ',Now)+'.txt');
    AResponseStream.Position:=0;
    Result:=APIResponse.ParseFromStream(AResponseStream);
    FreeAndNil(AResponseStream);
  end;
end;

function TOpenPlatform.GetCallAPIUrl(App: TApp;
                                      OAuth2User: TOAuth2User;
                                      APIItem: TAPIItem): String;
var
  I: Integer;
  AUrlParamList:TUrlParamList;
begin
  Result:='';
  AUrlParamList:=TUrlParamList.Create;
  Try
    for I := 0 to APIItem.ParamList.Count - 1 do
    begin
      if Not VarIsNull(APIItem.ParamList[I].Value) then
      begin
        if Not APIItem.ParamList[I].NeedUrlEncord then
        begin
          AUrlParamList.AddUrlParam(APIItem.ParamList[I].Name,APIItem.ParamList[I].Value);
        end
        else
        begin
          AUrlParamList.AddUrlParam(APIItem.ParamList[I].Name,UrlEncodeUTF8(APIItem.ParamList[I].Value));
        end;
      end;
    end;
    Result:=APIItem.URL+'?'+AUrlParamList.GetUrlParamListStr;
  Finally
    AUrlParamList.Clear(True);
    FreeAndNil(AUrlParamList);
  End;
end;

{ TValueScopeList }

function TValueScopeList.Add(const Value: Variant;
                              const Descrip: String): TValueScope;
begin
  Result:=TValueScope.Create;
  Result.Value:=Value;
  Result.Descrip:=Descrip;
end;

function TValueScopeList.GetItem(Index: Integer): TValueScope;
begin
  Result:=TValueScope(Inherited Items[Index]);
end;

{ TAPIParam }

constructor TAPIParam.Create;
begin
  NeedUrlEncord:=False;
  ValueScoptList:=TValueScopeList.Create;
end;

destructor TAPIParam.Destroy;
begin
  ValueScoptList.Clear(True);
  FreeAndNil(ValueScoptList);
  inherited;
end;

{ TAPIItem }

constructor TAPIItem.Create;
begin
  ParamList:=TAPIParamList.Create;
  Init;
end;

destructor TAPIItem.Destroy;
begin
  ParamList.Clear(True);
  FreeAndNil(ParamList);
  inherited;
end;

{ TAPIParamList }

function TAPIParamList.Add(const Name: String;
                            const Need: Boolean;
                            const Kind: String;
                            const Descrip: String): TAPIParam;
begin
  Result:=TAPIParam.Create;
  Inherited Add(Result);
  Result.Name:=Name;
  Result.Need:=Need;
  Result.Kind:=Kind;
  Result.Descrip:=Descrip;
end;

procedure TAPIParamList.ClearValue;
var
  I:Integer;
begin
  For I:=0 to Self.Count-1 do
  begin
    //varEmpty��varNull
    //Items[I].Value:=varNull;
    FindVarData(Items[I].Value)^.VType := varNull;
  end;
end;

function TAPIParamList.GetItem(Index: Integer): TAPIParam;
begin
  Result:=TAPIParam(Inherited Items[Index]);
end;

function TAPIParamList.GetItemByName(const Name: String): TAPIParam;
var
  I:Integer;
begin
  Result:=nil;
  For I:=0 to Self.Count-1 do
  begin
    if Items[I].Name=Name then
    begin
      Result:=Items[I];
      Break;
    end;
  end;
end;

procedure TAPIParamList.SetValue(const Name: String; const Value: Variant);
begin
  ItemByName[Name].Value:=Value;
end;

{ TAPIRegistList }

function TAPIRegistList.Add(const APIItemName: String;
  const APIItemClass: TAPIItemClass): TAPIRegist;
begin
  Result:=TAPIRegist.Create;
  Inherited Add(Result);
  Result.APIItemName:=APIItemName;
  Result.APIItemClass:=APIItemClass;
end;

function TAPIRegistList.GetItem(Index: Integer): TAPIRegist;
begin
  Result:=TAPIRegist(inherited Items[Index]);
end;

function TAPIRegistList.GetItemByName(const Name: String): TAPIRegist;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to Self.Count - 1 do
  begin
    if Items[I].APIItemName=Name then
    begin
      Result:=Items[I];
      Break;
    end;
  end;
end;

{ TAPIResponse }

//function TAPIResponse.ParseDataStructure: Boolean;
//begin
//  Result:=True;
//end;

function TAPIResponse.ParseFromStream(AResponseStream: TStream): Boolean;
var
  I:Integer;
  AString:String;
  AStingList:TStringList;
  AStringStream:TStringStream;
begin
  Result:=False;
  AResponseStream.Position:=0;
  AStingList:=TStringList.Create;
  AStingList.LoadFromStream(AResponseStream,TEncoding.UTF8);
  AString:='';
  for I := 0 to AStingList.Count - 1 do
  begin
    AString:=AString+AStingList[I]+#13#10;
  end;

  {$IFDEF FMX}
//  AResponseStream.Position:=0;
//  RootJson:=TSuperObject.ParseStream(AResponseStream);
  AStringStream:=TStringStream.Create;
//  AStingList.SaveToStream(AStringStream);
  AStringStream.WriteString(AString);
  AStringStream.Position:=0;
  RootJson:=TSuperObject.ParseStream(AStringStream);
  FreeAndNil(AStringStream);
  {$ENDIF}
  {$IFDEF VCL}
  RootJson:=TSuperObject.ParseString(PWideChar(AString),True);
  {$ENDIF}
  //�����Զ�ʶ��༭������
//  RootJson:=TSuperObject.ParseStream(AResponseStream,True);
  Result:=ParseDataStructure;
  FreeAndNil(AStingList);
end;

{ THttpControl }

constructor THttpControl.Create;
begin
//  InitializeCriticalSection(FHttpLock);
end;

destructor THttpControl.Destroy;
begin
//  DeleteCriticalSection(FHttpLock);
  inherited;
end;

procedure THttpControl.Lock;
begin
//  EnterCriticalSection(FHttpLock);
end;

procedure THttpControl.UnLock;
begin
//  LeaveCriticalSection(FHttpLock);
end;



{ TApp }

//{$IFDEF VCL}
//
//function TApp.LoadFromXMLNode(AXMLNode: IXMLNode): Boolean;
//begin
//  Result:=False;
//  Self.AppKey:=AXMLNode.Attributes['AppKey'];
//  Self.AppSecret:=AXMLNode.Attributes['AppSecret'];
//  Self.CallBackUrl:=AXMLNode.Attributes['CallBackUrl'];
//  Result:=True;
//end;
//
//function TApp.SaveToXMLNode(AXMLNode: IXMLNode): Boolean;
//begin
//  Result:=False;
//  AXMLNode.Attributes['AppKey']:=Self.AppKey;
//  AXMLNode.Attributes['AppSecret']:=Self.AppSecret;
//  AXMLNode.Attributes['CallBackUrl']:=Self.CallBackUrl;
//  Result:=True;
//end;
//
//function TApp.LoadFromXML(AXMLFilePath: String): Boolean;
//var
//  XMLDoc:TXMLDocument;
//  XMLDocNode:IXMLNode;
//begin
//  Result:=False;
//  if Not FileExists(AXMLFilePath) then Exit;
//  XMLDoc:=TXMLDocument.Create(Application);
//  try
//    XMLDoc.LoadFromFile(AXMLFilePath);
//    XMLDoc.Active := True;
//    XMLDocNode:=XMLDoc.DocumentElement;
//    Result:=LoadFromXMLNode(XMLDocNode);
//  finally
//    XMLDoc.Free;
//  end;
//end;
//
//function TApp.SaveToXML(AXMLFilePath: String): Boolean;
//var
//  XMLDoc:TXMLDocument;
//  XMLDocNode:IXMLNode;
//begin
//  Result:=False;
//  XMLDoc:=TXMLDocument.Create(Application);
//  try
//    XMLDoc.Active := True;
//    XMLDoc.Version := '1.0';
//    XMLDoc.Encoding := 'UTF-8';
//    XMLDocNode:=XMLDoc.AddChild('App');
//    Result:=SaveToXMLNode(XMLDocNode);
//    XMLDoc.SaveToFile(AXMLFilePath);
//  finally
//    XMLDoc.Free;
//  end;
//end;
//{$ENDIF}


function TApp.LoadFromINI(AINIFilePath:String):Boolean;
var
  AIniFile:TIniFile;
begin
  Result:=False;

  AIniFile:=TIniFile.Create(AINIFilePath);

  Self.AppKey:=AIniFile.ReadString('','AppKey','');
  Self.AppSecret:=AIniFile.ReadString('','AppSecret','');
  Self.CallBackUrl:=AIniFile.ReadString('','CallBackUrl','');

  FreeAndNil(AIniFile);

  Result:=True;

end;

function TApp.SaveToINI(AINIFilePath:String):Boolean;
var
  AIniFile:TIniFile;
begin

  Result:=False;
  AIniFile:=TIniFile.Create(AINIFilePath);

  AIniFile.WriteString('','AppKey',Self.AppKey);
  AIniFile.WriteString('','AppSecret',Self.AppSecret);
  AIniFile.WriteString('','CallBackUrl',Self.CallBackUrl);

  FreeAndNil(AIniFile);
  Result:=True;

end;


initialization

finalization
  if GlobalAPIRegistList<>nil then
  begin
    GlobalAPIRegistList.Clear(True);
    FreeAndNil(GlobalAPIRegistList);
  end;



end.


