//http://open.weibo.com/wiki/2/statuses/public_timeline
unit uAPIItem_statuses_public_timeline;

interface

uses
  Classes,
  SysUtils,
  XSuperObject,
  uDataStructure,
  uFuncCommon,
  uOpenPlatform;

type
  TAPIResponse_statuses_public_timeline=class(TAPIResponse)
  protected
    function ParseDataStructure:Boolean;override;
  public
    statuses:Tstatuses;
//    "previous_cursor": 0,                    // ��δ֧��
//    "next_cursor": 11488013766,     // ��δ֧��
//    "total_number": 81655

    previous_cursor:int;//": 0,                    // ��δ֧��
    next_cursor:int;//": 11488013766,     // ��δ֧��
    total_number:int;//": 81655

    constructor Create;
    destructor Destroy;override;
  end;

  TAPIItem_statuses_public_timeline=class(TAPIItem)
  protected
    procedure Init;override;
  end;

implementation

{ TAPIItem_statuses_public_timeline }

procedure TAPIItem_statuses_public_timeline.Init;
begin
  inherited;
  Name:='statuses/public_timeline';
  Descrip:='�������µ�200������΢�������ؽ������ȫʵʱ';
  Url:='https://api.weibo.com/2/statuses/public_timeline.json';
  HttpRequestMethods:=[hrmGet];
  ResponseDataType:=rdtData;
  ResponseDataFormat:=rdfJson;
  NeedLogin:=True;

  Self.ParamList.Add('source',false,'string','����OAuth��Ȩ��ʽ����Ҫ�˲�����������Ȩ��ʽΪ�����������ֵΪӦ�õ�AppKey��');
  Self.ParamList.Add('access_token',false,'string','����OAuth��Ȩ��ʽΪ���������������Ȩ��ʽ����Ҫ�˲�����OAuth��Ȩ���á�');
  Self.ParamList.Add('count',false,'int','��ҳ���صļ�¼��������󲻳���200��Ĭ��Ϊ20��');


end;

{ TAPIResponse_statuses_public_timeline }

constructor TAPIResponse_statuses_public_timeline.Create;
begin
  statuses:=Tstatuses.Create;
end;

destructor TAPIResponse_statuses_public_timeline.Destroy;
begin
  FreeAndNil(statuses);
  inherited;
end;

function TAPIResponse_statuses_public_timeline.ParseDataStructure: Boolean;
var
  I: Integer;
  Astatus:Tstatus;
  AstatusJson:ISuperObject;
  AstatusesJson:ISuperObject;
begin
  Result:=False;

  statuses.Clear(True);

  if RootJson<>nil then
  begin
    AstatusesJson:=RootJson.O['statuses'];
    if AstatusesJson<>nil then
    begin
//      for I := 0 to AstatusesJson.AsArray.Length - 1 do
//      begin
//        AstatusJson:=AstatusesJson.AsArray[I];
//        if AstatusJson<>nil then
//        begin
//          Astatus:=Tstatus.Create;
//          Astatus.ParseFromJson(AstatusJson);
//          statuses.Add(Astatus);
//        end;
//      end;
    end;

    previous_cursor:=RootJson.I['previous_cursor'];
    next_cursor:=RootJson.I['next_cursor'];
    total_number:=RootJson.I['total_number'];
  end;

  Result:=True;
end;


initialization
  RegisterAPIItem('statuses/public_timeline',TAPIItem_statuses_public_timeline);

end.
