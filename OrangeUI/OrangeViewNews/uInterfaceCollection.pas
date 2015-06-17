unit uInterfaceCollection;

interface


uses
  SysUtils,
  uFuncCommon,
  Classes,
  uBaseLog,
  XSuperJson,
  XSuperObject,
  uInterfaceData,
  uInterfaceClass;

type


  {$Region '���Žӿ�'}
  //��ȡ����δ������
  TInterface_GetUnReadNewsCount=class(TInterfaceItem)
  public
    status:Boolean;
    result_:Integer;
  protected
    function ParseResponseData:Boolean;override;
  public
    constructor Create;override;
    destructor Destroy;override;
  end;



//  //��ȡ���ŵ�����ֵ�
//  TInterface_GetNewsCategory=class(TInterfaceItem)
//  public
//    status:Boolean;
//    result_:TNewsCategoryList;
//  protected
//    function ParseResponseData:Boolean;override;
//  public
//    constructor Create;override;
//    destructor Destroy;override;
//  end;



  //��ȡ�����б�
  TInterface_GetNewsList=class(TInterfaceItem)
  public
    status:Boolean;
    total:Integer;
    result_:TNewsList;
  protected
    function ParseResponseData:Boolean;override;
  public
    constructor Create;override;
    destructor Destroy;override;
  end;




  //������ϸҳ
  TInterface_GetNewsDetail=class(TInterfaceItem)
  public
  public
    constructor Create;override;
    destructor Destroy;override;
  end;
  {$EndRegion}


  {$Region '�ֵ�ӿ�'}
  //��ȡ�ֵ��б�
  TInterface_GetDictList=class(TInterfaceItem)
  public
    status:Boolean;
    error:String;
    result_:TDictList;
  protected
    function ParseResponseData:Boolean;override;
  public
    constructor Create;override;
    destructor Destroy;override;
  end;
  {$EndRegion}





implementation




{ TInterface_GetDictList }

constructor TInterface_GetDictList.Create;
begin
  inherited;
//  Self.Name:='GetDictList';
  Self.URL:='/rest/dict/index/';
  Self.Descrip:='��ȡ�ֵ��б�';
  Self.HttpRequestMethods:=[hrmGet];

end;

destructor TInterface_GetDictList.Destroy;
begin
//  FreeAndNil(modified);
  FreeAndNil(result_);
  inherited;
end;

function TInterface_GetDictList.ParseResponseData: Boolean;
var
  I: Integer;
  ADict:TDict;
//  ADickJson:ISuperObject;
  ADictListJson:ISuperArray;
begin
  Result:=False;
//  FreeAndNil(modified);
  FreeAndNil(result_);

  if (ResponseJson<>nil) and ResponseJson.Contains('status') then
  begin

    status:=ResponseJson.B['status'];
    error:=ResponseJson.S['error'];

//    modified:=TModifiedTime.Create;
//    modified.ParseFromJson(ResponseJson.o['modified']);


    if status then
    begin
      result_:=TDictList.Create;
      ADictListJson:=ResponseJson.A['result'];
      for I := 0 to ADictListJson.Length - 1 do
      begin
//        ADictJson:=ADictListJson.O[I];

        ADict:=TDict.Create;
        ADict.ParseFromJson(ADictListJson.O[I]);
        result_.Add(ADict);

      end;
    end;

    Result:=True;
  end;
end;


{ TInterface_GetNewsDetail }

constructor TInterface_GetNewsDetail.Create;
begin
  inherited;
//  Self.Name:='GetNewsDetail';
  Self.URL:='/mobile/news/detail/';
  Self.Descrip:='������ϸҳ';
  Self.HttpRequestMethods:=[hrmGet];

  ResponseDataType:=rdtHtml;

  Self.UrlParamList.Add('id','����ID');
//URL��֯��ʽ��http://jg.czfood360.cn/mobile/news/detail/id/���ŵ�ID
//��������Ϊ��HTML
end;

destructor TInterface_GetNewsDetail.Destroy;
begin
  inherited;
end;





{ TInterface_GetNewsList }

constructor TInterface_GetNewsList.Create;
begin
  inherited;
//  Self.Name:='GetNewsList';
  Self.URL:='/rest/news/mobile/';
  Self.Descrip:='��ȡ�����б�';
  Self.HttpRequestMethods:=[hrmGet];

//  Self.UrlParamList.Add('region_code','������');

  Self.UrlParamList.Add('offset','�����ƫ����');
  Self.UrlParamList.Add('limit','ÿҳ�ļ�¼��');
  Self.UrlParamList.Add('category','����');

end;

destructor TInterface_GetNewsList.Destroy;
begin
  FreeAndNil(result_);
  inherited;
end;

function TInterface_GetNewsList.ParseResponseData: Boolean;
var
  I: Integer;
  ANews:TNews;
//  ANewsJson:ISuperObject;
  ANewsListJson:ISuperArray;
begin
  Result:=False;
  FreeAndNil(result_);

  if (ResponseJson<>nil) and ResponseJson.Contains('status') then
  begin

    status:=ResponseJson.B['status'];
    total:=ResponseJson.I['total'];

    if status then
    begin
      result_:=TNewsList.Create;
      ANewsListJson:=ResponseJson.A['result'];
      for I := 0 to ANewsListJson.Length - 1 do
      begin
//        ANewsJson:=ANewsListJson.O[I];

        ANews:=TNews.Create;
        ANews.ParseFromJson(ANewsListJson.O[I]);
        result_.Add(ANews);

      end;
    end;

    Result:=True;
  end;
end;


//{ TInterface_GetNewsCategory }
//
//constructor TInterface_GetNewsCategory.Create;
//begin
//  inherited;
////  Self.Name:='GetNewsCategory';
//  Self.URL:='/rest/dict/items/module/news/code/category/';
//  Self.Descrip:='��ȡ���ŵ�����ֵ�';
//  Self.HttpRequestMethods:=[hrmGet];
//
//end;
//
//destructor TInterface_GetNewsCategory.Destroy;
//begin
////  FreeAndNil(modified);
//  FreeAndNil(result_);
//  inherited;
//end;
//
//function TInterface_GetNewsCategory.ParseResponseData: Boolean;
//var
//  I: Integer;
//  ANewsCategory:TNewsCategory;
////  ANewsCategoryJson:ISuperObject;
//  ANewsCategoriesJson:ISuperArray;
//begin
//  Result:=False;
////  FreeAndNil(modified);
//  FreeAndNil(result_);
//
//  if (ResponseJson<>nil) and ResponseJson.Contains('status') then
//  begin
//
//    status:=ResponseJson.B['status'];
////    modified:=TModifiedTime.Create;
////    modified.ParseFromJson(ResponseJson.o['modified']);
//
//    if status then
//    begin
//      result_:=TNewsCategoryList.Create;
//      ANewsCategoriesJson:=ResponseJson.A['result'];
//      for I := 0 to ANewsCategoriesJson.Length - 1 do
//      begin
////        ANewsCategoryJson:=ANewsCategoriesJson.O[I];
//
//        ANewsCategory:=TNewsCategory.Create;
//        ANewsCategory.ParseFromJson(ANewsCategoriesJson.O[I]);
//        result_.Add(ANewsCategory);
//
//      end;
//    end;
//
//    Result:=True;
//  end;
//
//end;



{ TInterface_GetUnReadNewsCount }

constructor TInterface_GetUnReadNewsCount.Create;
begin
  inherited;
//  Self.Name:='GetUnReadNewsCount';
  Self.URL:='/rest/news/unread/';
  Self.Descrip:='��ȡ����δ������';
  Self.HttpRequestMethods:=[hrmGet];



end;

destructor TInterface_GetUnReadNewsCount.Destroy;
begin
  inherited;
end;

function TInterface_GetUnReadNewsCount.ParseResponseData: Boolean;
begin

  Result:=False;

  if (ResponseJson<>nil) and ResponseJson.Contains('status') then
  begin

    status:=ResponseJson.B['status'];
    result_:=ResponseJson.I['result'];

    Result:=True;
  end;

end;



end.



