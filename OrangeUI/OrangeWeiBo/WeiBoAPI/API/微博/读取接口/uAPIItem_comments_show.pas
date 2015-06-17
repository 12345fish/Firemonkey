//http://open.weibo.com/wiki/2/comments/show
unit uAPIItem_comments_show;

interface

uses
  Classes,
  SysUtils,
  XSuperObject,
  uFuncCommon,
  uDataStructure,
  uOpenPlatform;

type
  TAPIResponse_comments_show=class(TAPIResponse)
  protected
    function ParseDataStructure:Boolean;override;
  public
    comments:Tcomments;
//    "previous_cursor":0,
//    "next_cursor":3669625160565342,
//    "total_number":2020
    previous_cursor:int;//":0,
    next_cursor:int;//":3669625160565342,
    total_number:int;//":2020
    constructor Create;
    destructor Destroy;override;
  end;

  TAPIItem_comments_show=class(TAPIItem)
  protected
    procedure Init;override;
  end;

implementation

{ TAPIItem_comments_show }

procedure TAPIItem_comments_show.Init;
begin
  inherited;
  Name:='comments/show';
  Descrip:='����΢��ID����ĳ��΢���������б�';
  Url:='https://api.weibo.com/2/comments/show.json';
  HttpRequestMethods:=[hrmGet];
  ResponseDataType:=rdtData;
  ResponseDataFormat:=rdfJson;
  NeedLogin:=True;

  Self.ParamList.Add('source',false,'string','����OAuth��Ȩ��ʽ����Ҫ�˲�����������Ȩ��ʽΪ�����������ֵΪӦ�õ�AppKey��  ');
  Self.ParamList.Add('access_token',false,'string','����OAuth��Ȩ��ʽΪ���������������Ȩ��ʽ����Ҫ�˲�����OAuth��Ȩ���á�  ');
  Self.ParamList.Add('id',true,'int64','��Ҫ��ѯ��΢��ID��  ');
  Self.ParamList.Add('since_id',false,'int64','��ָ���˲������򷵻�ID��since_id������ۣ�����since_idʱ��������ۣ���Ĭ��Ϊ0��  ');
  Self.ParamList.Add('max_id',false,'int64','��ָ���˲������򷵻�IDС�ڻ����max_id�����ۣ�Ĭ��Ϊ0��  ');
  Self.ParamList.Add('count',false,'int','��ҳ���صļ�¼������Ĭ��Ϊ50��  ');
  Self.ParamList.Add('page',false,'int','���ؽ����ҳ�룬Ĭ��Ϊ1��  ');
  Self.ParamList.Add('filter_by_author',false,'int','����ɸѡ���ͣ�0��ȫ����1���ҹ�ע���ˡ�2��İ���ˣ�Ĭ��Ϊ0��  ');


end;

{ TAPIResponse_comments_show }

constructor TAPIResponse_comments_show.Create;
begin
  comments:=Tcomments.Create;
end;

destructor TAPIResponse_comments_show.Destroy;
begin
  FreeAndNil(comments);
  inherited;
end;

function TAPIResponse_comments_show.ParseDataStructure: Boolean;
var
  I: Integer;
  Acomment:Tcomment;
  AcommentJson:ISuperObject;
  AcommentsJson:ISuperObject;
begin
  Result:=False;

  comments.Clear(True);

  if RootJson<>nil then
  begin
    AcommentsJson:=RootJson.O['comments'];
    if AcommentsJson<>nil then
    begin
//      for I := 0 to AcommentsJson.AsArray.Length - 1 do
//      begin
//        AcommentJson:=AcommentsJson.AsArray[I];
//        if AcommentJson<>nil then
//        begin
//          Acomment:=Tcomment.Create;
//          Acomment.ParseFromJson(AcommentJson);
//          comments.Add(Acomment);
//        end;
//      end;
    end;

    previous_cursor:=RootJson.I['previous_cursor'];//":0,
    next_cursor:=RootJson.I['next_cursor'];//":3669625160565342,
    total_number:=RootJson.I['total_number'];//":2020
  end;

  Result:=True;
end;


initialization
  RegisterAPIItem('comments/show',TAPIItem_comments_show);

end.
