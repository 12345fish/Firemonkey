//http://open.weibo.com/wiki/2/statuses/home_timeline
unit uAPIItem_statuses_home_timeline;

interface
//{$I FrameWork.inc}

{$DEFINE FMX}

uses
  Classes,
  SysUtils,
  XSuperObject,
  uFuncCommon,
  uDataStructure,
  uOpenPlatform;

type
  TAPIResponse_statuses_home_timeline=class(TAPIResponse)
  protected
    function ParseDataStructure:Boolean;override;
  public
    statuses:Tstatuses;
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

  TAPIItem_statuses_home_timeline=class(TAPIItem)
  protected
    procedure Init;override;
  end;
//{$I FrameWork.inc}

implementation

{ TAPIItem_statuses_home_timeline }

procedure TAPIItem_statuses_home_timeline.Init;
begin
  inherited;
  Name:='statuses/home_timeline';
  Descrip:='��ȡ��ǰ��¼�û���������ע�û�������΢��';
  Url:='https://api.weibo.com/2/statuses/home_timeline.json';
  HttpRequestMethods:=[hrmGet];
  ResponseDataType:=rdtData;
  ResponseDataFormat:=rdfJson;
  NeedLogin:=True;

  Self.ParamList.Add('source',false,'string','����OAuth��Ȩ��ʽ����Ҫ�˲�����������Ȩ��ʽΪ�����������ֵΪӦ�õ�AppKey��');
  Self.ParamList.Add('access_token',false,'string','����OAuth��Ȩ��ʽΪ���������������Ȩ��ʽ����Ҫ�˲�����OAuth��Ȩ���á�');
  Self.ParamList.Add('since_id',false,'int64','��ָ���˲������򷵻�ID��since_id���΢��������since_idʱ�����΢������Ĭ��Ϊ0��');
  Self.ParamList.Add('max_id',false,'int64','��ָ���˲������򷵻�IDС�ڻ����max_id��΢����Ĭ��Ϊ0��');
  Self.ParamList.Add('count',false,'int','��ҳ���صļ�¼��������󲻳���100��Ĭ��Ϊ20��');
  Self.ParamList.Add('page',false,'int','���ؽ����ҳ�룬Ĭ��Ϊ1��');
  Self.ParamList.Add('base_app',false,'int','�Ƿ�ֻ��ȡ��ǰӦ�õ����ݡ�0Ϊ���������ݣ���1Ϊ�ǣ�����ǰӦ�ã���Ĭ��Ϊ0��');
  Self.ParamList.Add('feature',false,'int','��������ID��0��ȫ����1��ԭ����2��ͼƬ��3����Ƶ��4�����֣�Ĭ��Ϊ0��');
  Self.ParamList.Add('trim_user',false,'int','����ֵ��user�ֶο��أ�0����������user�ֶΡ�1��user�ֶν�����user_id��Ĭ��Ϊ0��');


end;

{ TAPIResponse_statuses_home_timeline }

constructor TAPIResponse_statuses_home_timeline.Create;
begin
  statuses:=Tstatuses.Create;
end;

destructor TAPIResponse_statuses_home_timeline.Destroy;
begin
  FreeAndNil(statuses);
  inherited;
end;

function TAPIResponse_statuses_home_timeline.ParseDataStructure: Boolean;
var
  I: Integer;
  Astatus:Tstatus;
  AstatusJson:ISuperObject;
  AstatusesJson:ISuperArray;
begin
  Result:=False;

  statuses.Clear(True);

  if (RootJson<>nil) and RootJson.Contains('statuses') then
  begin

//    {$IFDEF VCL}
//    AstatusesJson:=RootJson.A['statuses'];
//    if AstatusesJson<>nil then
//    begin
//      for I := 0 to AstatusesJson.Length - 1 do
//      begin
//        AstatusJson:=AstatusesJson[I];
//        if AstatusJson<>nil then
//        begin
//          Astatus:=Tstatus.Create;
//          Astatus.ParseFromJson(AstatusJson);
//          statuses.Add(Astatus);
//        end;
//      end;
//    end;
//    {$ENDIF}
//
//    {$IFDEF FMX}
    AstatusesJson:=RootJson.A['statuses'];
    if AstatusesJson<>nil then
    begin
      for I := 0 to AstatusesJson.Length - 1 do
      begin
        AstatusJson:=AstatusesJson.O[I];
//        AstatusJson:=RootJson.O['"statuses"[0]'];
        if AstatusJson<>nil then
        begin
          Astatus:=Tstatus.Create;
          Astatus.ParseFromJson(AstatusJson);
          statuses.Add(Astatus);
        end;
      end;
    end;
//    {$ENDIF}



//    hasvisible:=RootJson.B['hasvisible'];//":false,
    previous_cursor:=RootJson.I['previous_cursor'];//":0,
    next_cursor:=RootJson.I['next_cursor'];//":3669625160565342,
    total_number:=RootJson.I['total_number'];//":2020
  end;

  Result:=True;
end;


initialization
  RegisterAPIItem('statuses/home_timeline',TAPIItem_statuses_home_timeline);

end.
