//http://open.weibo.com/wiki/2/users/show
unit uAPIItem_users_show;

interface

uses
  Classes,
  SysUtils,
  XSuperObject,
  uDataStructure,
  uFuncCommon,
  uOpenPlatform;

type
  TAPIResponse_users_show=class(TAPIResponse)
  protected
    function ParseDataStructure:Boolean;override;
  public
    user:Tuser;
    constructor Create;
    destructor Destroy;override;
  end;

  TAPIItem_users_show=class(TAPIItem)
  protected
    procedure Init;override;
  end;

implementation

{ TAPIItem_users_show }

procedure TAPIItem_users_show.Init;
begin
  inherited;
  Name:='users/show';
  Descrip:='��ȡ�û���Ϣ';
  Url:='https://api.weibo.com/2/users/show.json';
  HttpRequestMethods:=[hrmGet];
  ResponseDataType:=rdtData;
  ResponseDataFormat:=rdfJson;
  NeedLogin:=True;

  Self.ParamList.Add('source',false,'string','����OAuth��Ȩ��ʽ����Ҫ�˲�����������Ȩ��ʽΪ�����������ֵΪӦ�õ�AppKey��  ');
  Self.ParamList.Add('access_token',false,'string','����OAuth��Ȩ��ʽΪ���������������Ȩ��ʽ����Ҫ�˲�����OAuth��Ȩ���á�  ');
  Self.ParamList.Add('uid',false,'int64','��Ҫ��ѯ���û�ID��  ');
  Self.ParamList.Add('screen_name',false,'string','��Ҫ��ѯ���û��ǳơ�  ');


end;

{ TAPIResponse_users_show }

constructor TAPIResponse_users_show.Create;
begin
end;

destructor TAPIResponse_users_show.Destroy;
begin
  FreeAndNil(user);
  inherited;
end;

function TAPIResponse_users_show.ParseDataStructure: Boolean;
begin
  Result:=False;

  if RootJson<>nil then
  begin
    user:=Tuser.Create;
    user.ParseFromJson(RootJson);
  end;

  Result:=True;
end;


initialization
  RegisterAPIItem('users/show',TAPIItem_users_show);

end.
