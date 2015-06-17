//http://open.weibo.com/wiki/2/statuses/show
unit uAPIItem_statuses_show;

interface

uses
  Classes,
  SysUtils,
  XSuperObject,
  uDataStructure,
  uFuncCommon,
  uOpenPlatform;

type
  TAPIResponse_statuses_show=class(TAPIResponse)
  protected
    function ParseDataStructure:Boolean;override;
  public
    status:Tstatus;

    constructor Create;
    destructor Destroy;override;
  end;

  TAPIItem_statuses_show=class(TAPIItem)
  protected
    procedure Init;override;
  end;

implementation

{ TAPIItem_statuses_show }

procedure TAPIItem_statuses_show.Init;
begin
  inherited;
  Name:='statuses/show';
  Descrip:='����΢��ID��ȡ����΢������';
  Url:='https://api.weibo.com/2/statuses/show.json';
  HttpRequestMethods:=[hrmGet];
  ResponseDataType:=rdtData;
  ResponseDataFormat:=rdfJson;
  NeedLogin:=True;

  Self.ParamList.Add('source',false,'string','����OAuth��Ȩ��ʽ����Ҫ�˲�����������Ȩ��ʽΪ�����������ֵΪӦ�õ�AppKey��  ');
  Self.ParamList.Add('access_token',false,'string','����OAuth��Ȩ��ʽΪ���������������Ȩ��ʽ����Ҫ�˲�����OAuth��Ȩ���á�  ');
  Self.ParamList.Add('id',true,'int64','��Ҫ��ȡ��΢��ID ');


end;

{ TAPIResponse_statuses_show }

constructor TAPIResponse_statuses_show.Create;
begin
  status:=Tstatus.Create;
end;

destructor TAPIResponse_statuses_show.Destroy;
begin
  FreeAndNil(status);
  inherited;
end;

function TAPIResponse_statuses_show.ParseDataStructure: Boolean;
begin
  Result:=False;

  if RootJson<>nil then
  begin
    status.ParseFromJson(RootJson);
  end;

  Result:=True;
end;


initialization
  RegisterAPIItem('statuses/show',TAPIItem_statuses_show);

end.
