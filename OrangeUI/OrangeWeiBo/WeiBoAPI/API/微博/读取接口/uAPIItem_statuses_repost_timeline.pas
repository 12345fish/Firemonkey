//http://open.weibo.com/wiki/2/statuses/repost_timeline
unit uAPIItem_statuses_repost_timeline;

interface

uses
  Classes,
  SysUtils,
  XSuperObject,
  uFuncCommon,
  uDataStructure,
  uOpenPlatform;

type
  TAPIResponse_statuses_repost_timeline=class(TAPIResponse)
  protected
    function ParseDataStructure:Boolean;override;
  public
    reposts:Tstatuses;
//    "hasvisible":false,
//    "previous_cursor":0,
//    "next_cursor":3669625160565342,
//    "total_number":2020
//    hasvisible:boolean;//":false,
    previous_cursor:int;//":0,
    next_cursor:int;//":3669625160565342,
    total_number:int;//":2020
    constructor Create;
    destructor Destroy;override;
  end;

  TAPIItem_statuses_repost_timeline=class(TAPIItem)
  protected
    procedure Init;override;
  end;

implementation

{ TAPIItem_statuses_repost_timeline }

procedure TAPIItem_statuses_repost_timeline.Init;
begin
  inherited;
  Name:='statuses/repost_timeline';
  Descrip:='��ȡָ��΢����ת��΢���б�';
  Url:='https://api.weibo.com/2/statuses/repost_timeline.json';
  HttpRequestMethods:=[hrmGet];
  ResponseDataType:=rdtData;
  ResponseDataFormat:=rdfJson;
  NeedLogin:=True;

  Self.ParamList.Add('source',false,'string','����OAuth��Ȩ��ʽ����Ҫ�˲�����������Ȩ��ʽΪ�����������ֵΪӦ�õ�AppKey��  ');
  Self.ParamList.Add('access_token',false,'string','����OAuth��Ȩ��ʽΪ���������������Ȩ��ʽ����Ҫ�˲�����OAuth��Ȩ���á�  ');
  Self.ParamList.Add('id',true,'int64','��Ҫ��ѯ��΢��ID��  ');
  Self.ParamList.Add('since_id',false,'int64','��ָ���˲������򷵻�ID��since_id���΢��������since_idʱ�����΢������Ĭ��Ϊ0��  ');
  Self.ParamList.Add('max_id',false,'int64','��ָ���˲������򷵻�IDС�ڻ����max_id��΢����Ĭ��Ϊ0��  ');
  Self.ParamList.Add('count',false,'int','��ҳ���صļ�¼��������󲻳���200��Ĭ��Ϊ20��  ');
  Self.ParamList.Add('page',false,'int','���ؽ����ҳ�룬Ĭ��Ϊ1��  ');
  Self.ParamList.Add('filter_by_author',false,'int','����ɸѡ���ͣ�0��ȫ����1���ҹ�ע���ˡ�2��İ���ˣ�Ĭ��Ϊ0��  ');

end;

{ TAPIResponse_statuses_repost_timeline }

constructor TAPIResponse_statuses_repost_timeline.Create;
begin
  reposts:=Tstatuses.Create;
end;

destructor TAPIResponse_statuses_repost_timeline.Destroy;
begin
  FreeAndNil(reposts);
  inherited;
end;

function TAPIResponse_statuses_repost_timeline.ParseDataStructure: Boolean;
var
  I: Integer;
  Astatus:Tstatus;
  AstatusJson:ISuperObject;
  AstatusesJson:ISuperObject;
begin
  Result:=False;

  reposts.Clear(True);

  if RootJson<>nil then
  begin
    AstatusesJson:=RootJson.O['reposts'];
    if AstatusesJson<>nil then
    begin
//      for I := 0 to AstatusesJson.AsArray.Length - 1 do
//      begin
//        AstatusJson:=AstatusesJson.AsArray[I];
//        if AstatusJson<>nil then
//        begin
//          Astatus:=Tstatus.Create;
//          Astatus.ParseFromJson(AstatusJson);
//          reposts.Add(Astatus);
//        end;
//      end;
    end;

//    hasvisible:=RootJson.B['hasvisible'];//":false,
    previous_cursor:=RootJson.I['previous_cursor'];//":0,
    next_cursor:=RootJson.I['next_cursor'];//":3669625160565342,
    total_number:=RootJson.I['total_number'];//":2020
  end;

  Result:=True;
end;


initialization
  RegisterAPIItem('statuses/repost_timeline',TAPIItem_statuses_repost_timeline);

end.
