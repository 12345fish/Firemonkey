//http://open.weibo.com/wiki/Oauth2/authorize
unit uAPIItem_oauth2_authorize;

interface

uses
  Classes,
  uOpenPlatform;

type
  TAPIItem_oauth2_authorize=class(TAPIItem)
  protected
    procedure Init;override;
  end;

implementation

{ TAPIItem_oauth2_authorize }

procedure TAPIItem_oauth2_authorize.Init;
begin
  inherited;
  Name:='oauth2/authorize';
  Descrip:='OAuth2��authorize�ӿ�';
  Url:='https://api.weibo.com/oauth2/authorize';
  HttpRequestMethods:=[hrmGet,hrmPost];
  ResponseDataType:=rdtRedirectUrl;
  ResponseDataFormat:=rdfUrl;

  Self.ParamList.Add('client_id',true,'string','����Ӧ��ʱ�����AppKey��');
  Self.ParamList.Add('redirect_uri',true,'string','��Ȩ�ص���ַ��վ��Ӧ���������õĻص���ַһ�£�վ��Ӧ������дcanvas page�ĵ�ַ��');
  Self.ParamList.Add('scope',false,'string','����scopeȨ�������������һ��������scopeȨ�ޣ��ö��ŷָ���ʹ���ĵ�');
  Self.ParamList.Add('state',false,'string','���ڱ�������ͻص���״̬���ڻص�ʱ������Query Parameter�лش��ò����������߿��������������֤������Ч�ԣ�Ҳ���Լ�¼�û�������Ȩҳǰ��λ�á�������������ڷ�ֹ��վ����α�죨CSRF������');
  Self.ParamList.Add('display',false,'string','��Ȩҳ����ն����ͣ�ȡֵ�������˵����');
  Self.ParamList.Add('forcelogin',false,'boolean','�Ƿ�ǿ���û����µ�¼��true���ǣ�false����Ĭ��false��');
  Self.ParamList.Add('language',false,'string','��Ȩҳ���ԣ�ȱʡΪ���ļ���棬enΪӢ�İ档Ӣ�İ�����У��������κ�����ɷ����� @΢��API');
  Self.ParamList.Add('response_type',true,'string','');


  Self.ParamList.ItemByName['display'].ValueScoptList.Add('default','Ĭ�ϵ���Ȩҳ�棬������web�������');
  Self.ParamList.ItemByName['display'].ValueScoptList.Add('mobile','�ƶ��ն˵���Ȩҳ�棬������֧��html5���ֻ���');
  Self.ParamList.ItemByName['display'].ValueScoptList.Add('wap1.2','Ĭ�ϵ���Ȩҳ�棬wap1.2����Ȩҳ�档');
  Self.ParamList.ItemByName['display'].ValueScoptList.Add('wap2.0','wap2.0����Ȩҳ�档');
  Self.ParamList.ItemByName['display'].ValueScoptList.Add('apponweibo','Ĭ�ϵ�վ��Ӧ����Ȩҳ����Ȩ�󲻷���access_token��ֻˢ��վ��Ӧ�ø���ܡ�');

//default  Ĭ�ϵ���Ȩҳ�棬������web�������
//mobile  �ƶ��ն˵���Ȩҳ�棬������֧��html5���ֻ���ע��ʹ�ô˰���Ȩҳ���� https://open.weibo.cn/oauth2/authorize ��Ȩ�ӿ�
//wap  wap����Ȩҳ�棬�����ڷ������ֻ���
//client  �ͻ��˰汾��Ȩҳ�棬������PC����Ӧ�á�
//apponweibo  Ĭ�ϵ�վ��Ӧ����Ȩҳ����Ȩ�󲻷���access_token��ֻˢ��վ��Ӧ�ø���ܡ�


end;

initialization
  RegisterAPIItem('oauth2/authorize',TAPIItem_oauth2_authorize);

end.
