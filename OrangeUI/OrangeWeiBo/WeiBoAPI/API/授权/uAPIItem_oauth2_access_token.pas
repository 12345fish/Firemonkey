//http://open.weibo.com/wiki/Oauth2/access_token
unit uAPIItem_oauth2_access_token;

interface

uses
  Classes,
  uOpenPlatform;

type
  TAPIResponse_oauth2_access_token=class(TAPIResponse)
  protected
    function ParseDataStructure:Boolean;override;
  public
    access_token:string;//	���ڵ���access_token���ӿڻ�ȡ��Ȩ���access token��
    expires_in:string;//	access_token���������ڣ���λ��������
    remind_in:string;//	access_token���������ڣ��ò���������������������ʹ��expires_in����
    uid:string;//	��ǰ��Ȩ�û���UID��
  end;

  TAPIItem_oauth2_access_token=class(TAPIItem)
  protected
    procedure Init;override;
  end;

implementation

{ TAPIItem_oauth2_access_token }

procedure TAPIItem_oauth2_access_token.Init;
begin
  inherited;
  Name:='oauth2/access_token';
  Descrip:='OAuth2��access_token�ӿ�';
  Url:='https://api.weibo.com/oauth2/access_token';
  HttpRequestMethods:=[hrmPost];
  ResponseDataType:=rdtData;
  ResponseDataFormat:=rdfJson;

  Self.ParamList.Add('client_id',true,'string','����Ӧ��ʱ�����AppKey��');
  Self.ParamList.Add('client_secret',true,'string','����Ӧ��ʱ�����AppSecret��');
  Self.ParamList.Add('grant_type',true,'string','��������ͣ�����Ϊauthorization_code��password��refresh_token��');

  Self.ParamList.Add('code',true,'string','����authorize��õ�codeֵ��');
  Self.ParamList.Add('redirect_uri',true,'string','�ص���ַ��������ע��Ӧ����Ļص���ַһ�¡�');

  Self.ParamList.Add('username',true,'string','��Ȩ�û����û�����');
  Self.ParamList.Add('password',true,'string','��Ȩ�û������롣');

end;

{ TAPIResponse_oauth2_access_token }

function TAPIResponse_oauth2_access_token.ParseDataStructure: Boolean;
begin
  Result:=False;

  if RootJson<>nil then
  begin
    access_token:=RootJson.S['access_token'];
    expires_in:=GetJsonStringValue(RootJson,'expires_in');
    remind_in:=GetJsonStringValue(RootJson,'remind_in');
    uid:=RootJson.S['uid'];
    Result:=True;
  end;

end;

initialization
  RegisterAPIItem('oauth2/access_token',TAPIItem_oauth2_access_token);


end.
