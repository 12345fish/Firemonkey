unit uIdHttpControl;

interface

uses
  Classes,
  SysUtils,
  uFuncCommon,
  IdBaseComponent,
  IdComponent,
  IdHttp,
  uBaseLog,
  SyncObjs,
  uInterfaceClass;


type
  TIdHttpControl=class(THttpControl)
  private
    FIdHttp:TIdHttp;
    FCriticalSection:TCriticalSection;
    procedure ReCreateIdHttp;
  public
//    procedure Lock;
//    procedure UnLock;
    constructor Create;override;
    destructor Destroy;override;
    function Get(const HttpUrl:String;AResponseStream:TStream):Boolean;overload;override;
    function Get(const HttpUrl:String):String;overload;override;
    function Post(const HttpUrl:String;ARequestStream:TStream;AResponseStream:TStream):Boolean;overload;override;
    function Post(const HttpUrl:String;ARequestStream:TStream):String;overload;override;
  end;

implementation

{ TIdHttpControl }

constructor TIdHttpControl.Create;
begin
  Inherited Create;
  FCriticalSection:=TCriticalSection.Create;
  ReCreateIdHttp;
end;

destructor TIdHttpControl.Destroy;
begin
  FreeAndNil(FCriticalSection);
  FreeAndNil(FIdHttp);
  inherited;
end;

function TIdHttpControl.Get(const HttpUrl: String): String;
begin
  FCriticalSection.Enter;
  try

    try
      Result:=FIdHttp.Get(HttpUrl);
    except
      on E:Exception do
      begin
        uBaseLog.HandleException(E,'Main','uIdHttpControl','TIdHttpControl.Get',HttpUrl);
        if Pos('Connection reset by peer.',E.Message)>0 then
        begin
          ReCreateIdHttp;

          //����
          try
            Result:=FIdHttp.Get(HttpUrl);
          except
            on E:Exception do
            begin
              uBaseLog.HandleException(E,'Main','uIdHttpControl','TIdHttpControl.Get',HttpUrl);
              ReCreateIdHttp;
            end;
          end;



        end;
      end;
    end;



  finally
    FCriticalSection.Leave;
  end;
end;

//procedure TIdHttpControl.Lock;
//begin
//
//end;

function TIdHttpControl.Get(const HttpUrl: String;AResponseStream: TStream): Boolean;
begin
  Result:=False;
  FCriticalSection.Enter;
  try

    try
      FIdHttp.Get(HttpUrl,AResponseStream);
      Result:=True;
    except
      on E:Exception do
      begin
//('Socket Error # 10054'#$D#$A'Connection reset by peer.', 0, nil, nil, False)
        uBaseLog.HandleException(E,'Main','uIdHttpControl','TIdHttpControl.Get',HttpUrl);
        if Pos('Connection reset by peer.',E.Message)>0 then
        begin
          ReCreateIdHttp;


          //����
          try
            FIdHttp.Get(HttpUrl,AResponseStream);
            Result:=True;
          except
            on E:Exception do
            begin
      //('Socket Error # 10054'#$D#$A'Connection reset by peer.', 0, nil, nil, False)
              uBaseLog.HandleException(E,'Main','uIdHttpControl','TIdHttpControl.Get',HttpUrl);
              if Pos('Connection reset by peer.',E.Message)>0 then
              begin
                ReCreateIdHttp;
              end;
            end;
          end;


        end;
      end;
    end;


  finally
    FCriticalSection.Leave;
  end;
end;

function TIdHttpControl.Post(const HttpUrl: String; ARequestStream,AResponseStream: TStream): Boolean;
begin
  Result:=False;
  FCriticalSection.Enter;
  try


    try
      FIdHttp.Post(HttpUrl,ARequestStream,AResponseStream);
      Result:=True;
    except
      on E:Exception do
      begin
        uBaseLog.HandleException(E,'Main','uIdHttpControl','TIdHttpControl.Get',HttpUrl);
        if Pos('Connection reset by peer.',E.Message)>0 then
        begin
          ReCreateIdHttp;


          //����
          try
            FIdHttp.Post(HttpUrl,ARequestStream,AResponseStream);
            Result:=True;
          except
            on E:Exception do
            begin
              uBaseLog.HandleException(E,'Main','uIdHttpControl','TIdHttpControl.Get',HttpUrl);
              if Pos('Connection reset by peer.',E.Message)>0 then
              begin
                ReCreateIdHttp;
              end;
            end;
          end;


        end;
      end;
    end;


  finally
    FCriticalSection.Leave;
  end;
end;

function TIdHttpControl.Post(const HttpUrl: String;ARequestStream: TStream): String;
begin
  FCriticalSection.Enter;
  try

    try
      Result:=FIdHttp.Post(HttpUrl,ARequestStream);
    except
      on E:Exception do
      begin
        uBaseLog.HandleException(E,'Main','uIdHttpControl','TIdHttpControl.Get',HttpUrl);
        if Pos('Connection reset by peer.',E.Message)>0 then
        begin
          ReCreateIdHttp;

          //����
          try
            Result:=FIdHttp.Post(HttpUrl,ARequestStream);
          except
            on E:Exception do
            begin
              uBaseLog.HandleException(E,'Main','uIdHttpControl','TIdHttpControl.Get',HttpUrl);
              if Pos('Connection reset by peer.',E.Message)>0 then
              begin
                ReCreateIdHttp;
              end;
            end;
          end;




        end;
      end;
    end;



  finally
    FCriticalSection.Leave;
  end;
end;




procedure TIdHttpControl.ReCreateIdHttp;
begin
  FreeAndNil(FIdHttp);


  FIdHttp:=TIdHttp.Create(nil);
  FIdHttp.ReadTimeout:=60*1000;//һ����
//  FIdHttp.AllowCookies:=True;
//  FIdHttp.ProxyParams.BasicAutheSntication:=False;
//  FIdHttp.ProxyParams.ProxyPort:=0;
//  FIdHttp.Request.ContentLength:=-1;
//  FIdHttp.Request.ContentRangeEnd:=0;
//  FIdHttp.Request.ContentRangeStart:=0;
//  FIdHttp.Request.ContentType:='application/x-www-form-urlencoded';
//  FIdHttp.Request.Accept:='text/html, */*';

  FIdHttp.Request.BasicAuthentication:=True;//False;
  FIdHttp.Request.ContentType:='application/json';

//  FIdHttp.Request.UserAgent:='Mozilla/3.0 (compatible; Indy Library)';
//  FIdHttp.HTTPOptions:=[hoForceEncodeParams];
//URL��֯��ʽ��http://jg.czfood360.cn/mobile/news/detail/id/���ŵ�ID
//��������Ϊ��HTML

end;

//procedure TIdHttpControl.UnLock;
//begin
//
//end;

end.
