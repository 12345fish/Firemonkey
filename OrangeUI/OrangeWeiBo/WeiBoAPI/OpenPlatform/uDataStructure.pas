unit uDataStructure;

interface

uses
//  Windows,
  IniFiles,
  SysUtils,
  XSuperObject,
  uFuncCommon,
  uBaseList;


type
  int=Int64;
  _object=TObject;
  _object_array=array of _object;
 Tuser=class;
 Tgeo=class;




  Tstatus=class
  public
    destructor Destroy;override;
    function ParseFromJson(AJson: ISuperObject): Boolean;
  public
    created_at	:string	;//΢������ʱ��
    id	:int64	;//΢��ID
    mid	:int64	;//΢��MID
    idstr	:string	;//�ַ����͵�΢��ID
    text	:string	;//΢����Ϣ����
    source	:string	;//΢����Դ
    favorited	:boolean	;//�Ƿ����ղأ�true���ǣ�false����
    truncated	:boolean	;//�Ƿ񱻽ضϣ�true���ǣ�false����
    in_reply_to_status_id	:string	;//����δ֧�֣��ظ�ID
    in_reply_to_user_id	:string	;//����δ֧�֣��ظ���UID
    in_reply_to_screen_name	:string	;//����δ֧�֣��ظ����ǳ�
    thumbnail_pic	:string	;//����ͼƬ��ַ��û��ʱ�����ش��ֶ�
    bmiddle_pic	:string	;//�еȳߴ�ͼƬ��ַ��û��ʱ�����ش��ֶ�
    original_pic	:string	;//ԭʼͼƬ��ַ��û��ʱ�����ش��ֶ�
    geo	:Tgeo	;//������Ϣ�ֶ� ��ϸ
    user	:Tuser	;//΢�����ߵ��û���Ϣ�ֶ� ��ϸ
    retweeted_status	:Tstatus	;//��ת����ԭ΢����Ϣ�ֶΣ�����΢��Ϊת��΢��ʱ���� ��ϸ
    reposts_count	:int	;//ת����
    comments_count	:int	;//������
    attitudes_count	:int	;//��̬��
    mlevel	:int	;//��δ֧��
    visible	:_object	;//΢���Ŀɼ��Լ�ָ���ɼ�������Ϣ����object��typeȡֵ��0����ͨ΢����1��˽��΢����3��ָ������΢����4������΢����list_idΪ��������
    pic_urls	:_object	;//΢����ͼ��ַ����ͼʱ���ض�ͼ���ӡ�����ͼ���ء�[]��
    ad	:_object_array;//object array	;//΢�����ڵ��ƹ�΢��ID




  end;

  Tstatuses=class(TBaseList)
  private
    function GetItem(Index: Integer): Tstatus;
  public
//    function FindItemBytid(tid:Int64):TTrade;
//    function FindItemIndexBytid(tid:Int64):Integer;
    property Items[Index:Integer]:Tstatus read GetItem;default;
  end;


  Tcomment=class
  public
    destructor Destroy;override;
    function ParseFromJson(AJson: ISuperObject): Boolean;
  public

    created_at  :string;//  ���۴���ʱ��
    id  :int64;//  ���۵�ID
    text  :string;//  ���۵�����
    source  :string;//  ���۵���Դ
    user  :Tuser;//  �������ߵ��û���Ϣ�ֶ� ��ϸ
    mid  :string;//  ���۵�MID
    idstr  :string;//  �ַ����͵�����ID
    status  :Tstatus;//  ���۵�΢����Ϣ�ֶ� ��ϸ
    reply_comment  :_object;//  ������Դ���ۣ������������ڶ���һ���۵Ļظ�ʱ���ش��ֶ�

  end;



  Tcomments=class(TBaseList)
  private
    function GetItem(Index: Integer): Tcomment;
  public
//    function FindItemBytid(tid:Int64):TTrade;
//    function FindItemIndexBytid(tid:Int64):Integer;
    property Items[Index:Integer]:Tcomment read GetItem;default;
  end;




  Tuser=class
  public
    function LoadFromINI(AINIFilePath:String):Boolean;
    function SaveToINI(AINIFilePath:String):Boolean;
    function ParseFromJson(AJson: ISuperObject): Boolean;
  public
    id  :int64  ;//�û�UID
    idstr  :string  ;//�ַ����͵��û�UID
    screen_name  :string  ;//�û��ǳ�
    name  :string  ;//�Ѻ���ʾ����
    province  :int  ;//�û�����ʡ��ID
    city  :int  ;//�û����ڳ���ID
    location  :string  ;//�û����ڵ�
    description  :string  ;//�û���������
    url  :string  ;//�û����͵�ַ
    profile_image_url  :string  ;//�û�ͷ���ַ����ͼ����50��50����
    profile_url  :string  ;//�û���΢��ͳһURL��ַ
    domain  :string  ;//�û��ĸ��Ի�����
    weihao  :string  ;//�û���΢��
    gender  :string  ;//�Ա�m���С�f��Ů��n��δ֪
    followers_count  :int  ;//��˿��
    friends_count  :int  ;//��ע��
    statuses_count  :int  ;//΢����
    favourites_count  :int  ;//�ղ���
    created_at  :string  ;//�û�������ע�ᣩʱ��
    following  :boolean  ;//��δ֧��
    allow_all_act_msg  :boolean  ;//�Ƿ����������˸��ҷ�˽�ţ�true���ǣ�false����
    geo_enabled  :boolean  ;//�Ƿ������ʶ�û��ĵ���λ�ã�true���ǣ�false����
    verified  :boolean  ;//�Ƿ���΢����֤�û�������V�û���true���ǣ�false����
    verified_type  :int  ;//��δ֧��
    remark  :string  ;//�û���ע��Ϣ��ֻ���ڲ�ѯ�û���ϵʱ�ŷ��ش��ֶ�
    status  :_object  ;//�û������һ��΢����Ϣ�ֶ� ��ϸ
    allow_all_comment  :boolean  ;//�Ƿ����������˶��ҵ�΢���������ۣ�true���ǣ�false����
    avatar_large  :string  ;//�û�ͷ���ַ����ͼ����180��180����
    avatar_hd  :string  ;//�û�ͷ���ַ�����壩������ͷ��ԭͼ
    verified_reason  :string  ;//��֤ԭ��
    follow_me  :boolean  ;//���û��Ƿ��ע��ǰ��¼�û���true���ǣ�false����
    online_status  :int  ;//�û�������״̬��0�������ߡ�1������
    bi_followers_count  :int  ;//�û��Ļ�����
    lang  :string  ;//�û���ǰ�����԰汾��zh-cn���������ģ�zh-tw���������ģ�en��Ӣ��
  end;

  Tuser_count=class
  public
    function ParseFromJson(AJson: ISuperObject): Boolean;
  public
    //id  int64  ΢��ID
    //followers_count  int  ��˿��
    //friends_count  int  ��ע��
    //statuses_count  int  ΢����
    //private_friends_count  int  ��δ֧��
    id  :int64  ;//�û�UID
    followers_count  :int  ;//��˿��
    friends_count  :int  ;//��ע��
    statuses_count  :int  ;//΢����
//    private_friends_count  :int  ;//�ղ���
  end;

  Tuser_counts=class(TBaseList)
  private
    function GetItem(Index: Integer): Tuser_count;
  public
    property Items[Index:Integer]:Tuser_count read GetItem;default;
  end;

  Tgeo=class
  public
    function ParseFromJson(AJson: ISuperObject): Boolean;
  public
//    ������Ϣ��geo��
//    ����ֵ�ֶ�  �ֶ�����  �ֶ�˵��
    longitude  :string  ;//��������
    latitude  :string  ;//ά������
    city  :string  ;//���ڳ��еĳ��д���
    province  :string  ;//����ʡ�ݵ�ʡ�ݴ���
    city_name  :string  ;//���ڳ��еĳ�������
    province_name  :string  ;//����ʡ�ݵ�ʡ������
    address  :string  ;//���ڵ�ʵ�ʵ�ַ������Ϊ��
    pinyin  :string  ;//��ַ�ĺ���ƴ������������������᷵�ظ��ֶ�
    more  :string  ;//������Ϣ����������������᷵�ظ��ֶ�
  end;



implementation

//FLocalDateTime:=Rfc822ToDateTime(FDate,ParseDateSucc,FTimeZone,FUTCDateTime);

{ Tstatus }

destructor Tstatus.Destroy;
begin
  FreeAndNil(user);
  FreeAndNil(retweeted_status);
  inherited;
end;

function Tstatus.ParseFromJson(AJson: ISuperObject): Boolean;
begin
  Result:=False;

  //created_at	string	΢������ʱ��
  created_at:=AJson.S['created_at'];
  //id	int64	΢��ID
  id:=AJson.I['id'];
  //mid	int64	΢��MID
//  mid:=AJson.I['mid'];
  //idstr	string	�ַ����͵�΢��ID
  idstr:=AJson.S['idstr'];
  //text	string	΢����Ϣ����
  text:=AJson.S['text'];
  //source	string	΢����Դ
  source:=AJson.S['source'];
  //favorited	boolean	�Ƿ����ղأ�true���ǣ�false����
  //truncated	boolean	�Ƿ񱻽ضϣ�true���ǣ�false����
  //in_reply_to_status_id	string	����δ֧�֣��ظ�ID
  in_reply_to_status_id:=AJson.S['in_reply_to_status_id'];
  //in_reply_to_user_id	string	����δ֧�֣��ظ���UID
  in_reply_to_user_id:=AJson.S['in_reply_to_user_id'];
  //in_reply_to_screen_name	string	����δ֧�֣��ظ����ǳ�
  in_reply_to_screen_name:=AJson.S['in_reply_to_screen_name'];
  //thumbnail_pic	string	����ͼƬ��ַ��û��ʱ�����ش��ֶ�
  thumbnail_pic:=AJson.S['thumbnail_pic'];
  //bmiddle_pic	string	�еȳߴ�ͼƬ��ַ��û��ʱ�����ش��ֶ�
  bmiddle_pic:=AJson.S['bmiddle_pic'];
  //original_pic	string	ԭʼͼƬ��ַ��û��ʱ�����ش��ֶ�
  original_pic:=AJson.S['original_pic'];
  //geo	object	������Ϣ�ֶ� ��ϸ
//  if AJson.Contains('geo') then
//  begin
//    geo:=Tgeo.Create;
//    Tgeo(geo).ParseFromJson(AJson.O['geo']);
//  end;
  //user	object	΢�����ߵ��û���Ϣ�ֶ� ��ϸ
  if AJson.Contains('user') then
  begin
    user:=Tuser.Create;
    Tuser(user).ParseFromJson(AJson.O['user']);
  end;
  //retweeted_status	object	��ת����ԭ΢����Ϣ�ֶΣ�����΢��Ϊת��΢��ʱ���� ��ϸ
  if AJson.Contains('retweeted_status') then
  begin
    retweeted_status:=Tstatus.Create;
    Tstatus(retweeted_status).ParseFromJson(AJson.O['retweeted_status']);
  end;
  //reposts_count	int	ת����
  reposts_count:=AJson.I['reposts_count'];
  //comments_count	int	������
  comments_count:=AJson.I['comments_count'];
  //attitudes_count	int	��̬��
  attitudes_count:=AJson.I['attitudes_count'];
  //mlevel	int	��δ֧��
  mlevel:=AJson.I['mlevel'];
  //visible	object	΢���Ŀɼ��Լ�ָ���ɼ�������Ϣ����object��typeȡֵ��0����ͨ΢����1��˽��΢����3��ָ������΢����4������΢����list_idΪ��������
  //pic_urls	object	΢����ͼ��ַ����ͼʱ���ض�ͼ���ӡ�����ͼ���ء�[]��
  //ad	object array	΢�����ڵ��ƹ�΢��ID



  Result:=True;
end;

{ Tstatuses }

function Tstatuses.GetItem(Index: Integer): Tstatus;
begin
  Result:=Tstatus(Inherited Items[Index]);
end;

{ Tuser }

function Tuser.LoadFromINI(AINIFilePath: String): Boolean;
var
  AIniFile:TIniFile;
begin
  Result:=False;

  AIniFile:=TIniFile.Create(AINIFilePath);

  //id  int64  �û�UID
  id:=AIniFile.ReadInteger('','id',0);
  //idstr  string  �ַ����͵��û�UID
  idstr:=AIniFile.ReadString('','idstr','');
  //screen_name  string  �û��ǳ�
  screen_name:=AIniFile.ReadString('','screen_name','');
  //name  string  �Ѻ���ʾ����
  name:=AIniFile.ReadString('','name','');
////  //province  int  �û�����ʡ��ID
////  province:=AJson.I['province'];
////  //city  int  �û����ڳ���ID
////  city:=AJson.I['city'];
//  //location  string  �û����ڵ�
//  location:=AJson.S['location'];
//  //description  string  �û���������
//  description:=AJson.S['description'];
//  //url  string  �û����͵�ַ
//  url:=AJson.S['url'];
//  //profile_image_url  string  �û�ͷ���ַ����ͼ����50��50����
//  profile_image_url:=AJson.S['profile_image_url'];
//  //profile_url  string  �û���΢��ͳһURL��ַ
//  profile_url:=AJson.S['profile_url'];
//  //domain  string  �û��ĸ��Ի�����
//  domain:=AJson.S['domain'];
//  //weihao  string  �û���΢��
//  weihao:=AJson.S['weihao'];
//  //gender  string  �Ա�m���С�f��Ů��n��δ֪
//  gender:=AJson.S['gender'];
  //followers_count  int  ��˿��
  followers_count:=AIniFile.ReadInteger('','followers_count',0);
  //friends_count  int  ��ע��
  friends_count:=AIniFile.ReadInteger('','friends_count',0);
  //statuses_count  int  ΢����
  statuses_count:=AIniFile.ReadInteger('','statuses_count',0);
  //favourites_count  int  �ղ���
  favourites_count:=AIniFile.ReadInteger('','favourites_count',0);
//  //created_at  string  �û�������ע�ᣩʱ��
//  created_at:=AJson.S['created_at'];
//  //following  boolean  ��δ֧��
//  following:=AJson.B['following'];
//  //allow_all_act_msg  boolean  �Ƿ����������˸��ҷ�˽�ţ�true���ǣ�false����
//  allow_all_act_msg:=AJson.B['allow_all_act_msg'];
//  //geo_enabled  boolean  �Ƿ������ʶ�û��ĵ���λ�ã�true���ǣ�false����
//  geo_enabled:=AJson.B['geo_enabled'];
//  //verified  boolean  �Ƿ���΢����֤�û�������V�û���true���ǣ�false����
//  verified:=AJson.B['verified'];
//  //verified_type  int  ��δ֧��
//  verified_type:=AJson.I['verified_type'];
//  //remark  string  �û���ע��Ϣ��ֻ���ڲ�ѯ�û���ϵʱ�ŷ��ش��ֶ�
//  remark:=AJson.S['remark'];
////  //status  object  �û������һ��΢����Ϣ�ֶ� ��ϸ
////  status:=AJson.S['status'];
//  //allow_all_comment  boolean  �Ƿ����������˶��ҵ�΢���������ۣ�true���ǣ�false����
//  allow_all_comment:=AJson.B['allow_all_comment'];
//  //avatar_large  string  �û�ͷ���ַ����ͼ����180��180����
//  avatar_large:=AJson.S['avatar_large'];
//  //avatar_hd  string  �û�ͷ���ַ�����壩������ͷ��ԭͼ
//  avatar_hd:=AJson.S['avatar_hd'];
//  //verified_reason  string  ��֤ԭ��
//  verified_reason:=AJson.S['verified_reason'];
//  //follow_me  boolean  ���û��Ƿ��ע��ǰ��¼�û���true���ǣ�false����
//  follow_me:=AJson.B['follow_me'];
//  //online_status  int  �û�������״̬��0�������ߡ�1������
//  online_status:=AJson.I['online_status'];
//  //bi_followers_count  int  �û��Ļ�����
//  bi_followers_count:=AJson.I['bi_followers_count'];
//  //lang  string  �û���ǰ�����԰汾��zh-cn���������ģ�zh-tw���������ģ�en��Ӣ��
//  lang:=AJson.S['lang'];
//


//  Self.UserId:=AIniFile.ReadString('','UserId','');
//  Self.Password:=AIniFile.ReadString('','Password','');
//  Self.Uid:=AIniFile.ReadString('','Uid','');
//  Self.AccessToken:=AIniFile.ReadString('','AccessToken','');
//  Self.Remind_In:=AIniFile.ReadString('','Remind_In','');
//  Self.Expires_In:=AIniFile.ReadString('','Expires_In','');
//  Self.LastAuthTime:=StandardStrToDateTime(AIniFile.ReadString('','LastAuthTime',''));

  FreeAndNil(AIniFile);

  Result:=True;

end;

function Tuser.SaveToINI(AINIFilePath: String): Boolean;
var
  AIniFile:TIniFile;
begin

  Result:=False;
  AIniFile:=TIniFile.Create(AINIFilePath);

  //id  int64  �û�UID
  AIniFile.WriteInteger('','id',id);
  //idstr  string  �ַ����͵��û�UID
  AIniFile.WriteString('','idstr',idstr);
  //screen_name  string  �û��ǳ�
  AIniFile.WriteString('','screen_name',screen_name);
  //name  string  �Ѻ���ʾ����
  AIniFile.WriteString('','name',name);
////  //province  int  �û�����ʡ��ID
////  province:=AJson.I['province'];
////  //city  int  �û����ڳ���ID
////  city:=AJson.I['city'];
//  //location  string  �û����ڵ�
//  location:=AJson.S['location'];
//  //description  string  �û���������
//  description:=AJson.S['description'];
//  //url  string  �û����͵�ַ
//  url:=AJson.S['url'];
//  //profile_image_url  string  �û�ͷ���ַ����ͼ����50��50����
//  profile_image_url:=AJson.S['profile_image_url'];
//  //profile_url  string  �û���΢��ͳһURL��ַ
//  profile_url:=AJson.S['profile_url'];
//  //domain  string  �û��ĸ��Ի�����
//  domain:=AJson.S['domain'];
//  //weihao  string  �û���΢��
//  weihao:=AJson.S['weihao'];
//  //gender  string  �Ա�m���С�f��Ů��n��δ֪
//  gender:=AJson.S['gender'];
  //followers_count  int  ��˿��
  AIniFile.WriteInteger('','followers_count',followers_count);
  //friends_count  int  ��ע��
  AIniFile.WriteInteger('','friends_count',friends_count);
  //statuses_count  int  ΢����
  AIniFile.WriteInteger('','statuses_count',statuses_count);
  //favourites_count  int  �ղ���
  AIniFile.WriteInteger('','favourites_count',favourites_count);
//  //created_at  string  �û�������ע�ᣩʱ��
//  created_at:=AJson.S['created_at'];
//  //following  boolean  ��δ֧��
//  following:=AJson.B['following'];
//  //allow_all_act_msg  boolean  �Ƿ����������˸��ҷ�˽�ţ�true���ǣ�false����
//  allow_all_act_msg:=AJson.B['allow_all_act_msg'];
//  //geo_enabled  boolean  �Ƿ������ʶ�û��ĵ���λ�ã�true���ǣ�false����
//  geo_enabled:=AJson.B['geo_enabled'];
//  //verified  boolean  �Ƿ���΢����֤�û�������V�û���true���ǣ�false����
//  verified:=AJson.B['verified'];
//  //verified_type  int  ��δ֧��
//  verified_type:=AJson.I['verified_type'];
//  //remark  string  �û���ע��Ϣ��ֻ���ڲ�ѯ�û���ϵʱ�ŷ��ش��ֶ�
//  remark:=AJson.S['remark'];
////  //status  object  �û������һ��΢����Ϣ�ֶ� ��ϸ
////  status:=AJson.S['status'];
//  //allow_all_comment  boolean  �Ƿ����������˶��ҵ�΢���������ۣ�true���ǣ�false����
//  allow_all_comment:=AJson.B['allow_all_comment'];
//  //avatar_large  string  �û�ͷ���ַ����ͼ����180��180����
//  avatar_large:=AJson.S['avatar_large'];
//  //avatar_hd  string  �û�ͷ���ַ�����壩������ͷ��ԭͼ
//  avatar_hd:=AJson.S['avatar_hd'];
//  //verified_reason  string  ��֤ԭ��
//  verified_reason:=AJson.S['verified_reason'];
//  //follow_me  boolean  ���û��Ƿ��ע��ǰ��¼�û���true���ǣ�false����
//  follow_me:=AJson.B['follow_me'];
//  //online_status  int  �û�������״̬��0�������ߡ�1������
//  online_status:=AJson.I['online_status'];
//  //bi_followers_count  int  �û��Ļ�����
//  bi_followers_count:=AJson.I['bi_followers_count'];
//  //lang  string  �û���ǰ�����԰汾��zh-cn���������ģ�zh-tw���������ģ�en��Ӣ��
//  lang:=AJson.S['lang'];
//



//  AIniFile.WriteString('','UserId',Self.UserId);
//  AIniFile.WriteString('','Password',Self.Password);
//  AIniFile.WriteString('','Uid',Self.Uid);
//  AIniFile.WriteString('','AccessToken',Self.AccessToken);
//  AIniFile.WriteString('','Remind_In',Self.Remind_In);
//  AIniFile.WriteString('','Expires_In',Self.Expires_In);
//  AIniFile.WriteString('','LastAuthTime',StandardDateTimeToStr(Self.LastAuthTime));

  FreeAndNil(AIniFile);
  Result:=True;

end;

function Tuser.ParseFromJson(AJson: ISuperObject): Boolean;
begin
  //id  int64  �û�UID
  id:=AJson.I['id'];
  //idstr  string  �ַ����͵��û�UID
  idstr:=AJson.S['idstr'];
  //screen_name  string  �û��ǳ�
  screen_name:=AJson.S['screen_name'];
  //name  string  �Ѻ���ʾ����
  name:=AJson.S['name'];
//  //province  int  �û�����ʡ��ID
//  province:=AJson.I['province'];
//  //city  int  �û����ڳ���ID
//  city:=AJson.I['city'];
  //location  string  �û����ڵ�
  location:=AJson.S['location'];
  //description  string  �û���������
  description:=AJson.S['description'];
  //url  string  �û����͵�ַ
  url:=AJson.S['url'];
  //profile_image_url  string  �û�ͷ���ַ����ͼ����50��50����
  profile_image_url:=AJson.S['profile_image_url'];
  //profile_url  string  �û���΢��ͳһURL��ַ
  profile_url:=AJson.S['profile_url'];
  //domain  string  �û��ĸ��Ի�����
  domain:=AJson.S['domain'];
  //weihao  string  �û���΢��
  weihao:=AJson.S['weihao'];
  //gender  string  �Ա�m���С�f��Ů��n��δ֪
  gender:=AJson.S['gender'];
  //followers_count  int  ��˿��
  followers_count:=AJson.I['followers_count'];
  //friends_count  int  ��ע��
  friends_count:=AJson.I['friends_count'];
  //statuses_count  int  ΢����
  statuses_count:=AJson.I['statuses_count'];
  //favourites_count  int  �ղ���
  favourites_count:=AJson.I['favourites_count'];
  //created_at  string  �û�������ע�ᣩʱ��
  created_at:=AJson.S['created_at'];
  //following  boolean  ��δ֧��
  following:=AJson.B['following'];
  //allow_all_act_msg  boolean  �Ƿ����������˸��ҷ�˽�ţ�true���ǣ�false����
  allow_all_act_msg:=AJson.B['allow_all_act_msg'];
  //geo_enabled  boolean  �Ƿ������ʶ�û��ĵ���λ�ã�true���ǣ�false����
  geo_enabled:=AJson.B['geo_enabled'];
  //verified  boolean  �Ƿ���΢����֤�û�������V�û���true���ǣ�false����
  verified:=AJson.B['verified'];
  //verified_type  int  ��δ֧��
  verified_type:=AJson.I['verified_type'];
  //remark  string  �û���ע��Ϣ��ֻ���ڲ�ѯ�û���ϵʱ�ŷ��ش��ֶ�
  remark:=AJson.S['remark'];
//  //status  object  �û������һ��΢����Ϣ�ֶ� ��ϸ
//  status:=AJson.S['status'];
  //allow_all_comment  boolean  �Ƿ����������˶��ҵ�΢���������ۣ�true���ǣ�false����
  allow_all_comment:=AJson.B['allow_all_comment'];
  //avatar_large  string  �û�ͷ���ַ����ͼ����180��180����
  avatar_large:=AJson.S['avatar_large'];
  //avatar_hd  string  �û�ͷ���ַ�����壩������ͷ��ԭͼ
  avatar_hd:=AJson.S['avatar_hd'];
  //verified_reason  string  ��֤ԭ��
  verified_reason:=AJson.S['verified_reason'];
  //follow_me  boolean  ���û��Ƿ��ע��ǰ��¼�û���true���ǣ�false����
  follow_me:=AJson.B['follow_me'];
  //online_status  int  �û�������״̬��0�������ߡ�1������
  online_status:=AJson.I['online_status'];
  //bi_followers_count  int  �û��Ļ�����
  bi_followers_count:=AJson.I['bi_followers_count'];
  //lang  string  �û���ǰ�����԰汾��zh-cn���������ģ�zh-tw���������ģ�en��Ӣ��
  lang:=AJson.S['lang'];





end;

{ Tgeo }

function Tgeo.ParseFromJson(AJson: ISuperObject): Boolean;
begin
//    ������Ϣ��geo��
//    ����ֵ�ֶ�  �ֶ�����  �ֶ�˵��
  longitude  :=AJson.S['longitude']  ;//��������
  latitude  :=AJson.S['latitude']  ;//ά������
  city  :=AJson.S['city']  ;//���ڳ��еĳ��д���
  province  :=AJson.S['province']  ;//����ʡ�ݵ�ʡ�ݴ���
  city_name  :=AJson.S['city_name']  ;//���ڳ��еĳ�������
  province_name  :=AJson.S['province_name']  ;//����ʡ�ݵ�ʡ������
  address  :=AJson.S['address']  ;//���ڵ�ʵ�ʵ�ַ������Ϊ��
  pinyin  :=AJson.S['pinyin']  ;//��ַ�ĺ���ƴ������������������᷵�ظ��ֶ�
  more  :=AJson.S['more']  ;//������Ϣ����������������᷵�ظ��ֶ�

end;

{ Tcomment }

destructor Tcomment.Destroy;
begin
  FreeAndNil(user);
  FreeAndNil(status);

  inherited;
end;

function Tcomment.ParseFromJson(AJson: ISuperObject): Boolean;
begin
//    created_at  :string;//  ���۴���ʱ��
//    id  :int64;//  ���۵�ID
//    text  :string;//  ���۵�����
//    source  :string;//  ���۵���Դ
//    user  :_object;//  �������ߵ��û���Ϣ�ֶ� ��ϸ
//    mid  :string;//  ���۵�MID
//    idstr  :string;//  �ַ����͵�����ID
//    status  :_object;//  ���۵�΢����Ϣ�ֶ� ��ϸ
//    reply_comment  :_object;//  ������Դ���ۣ������������ڶ���һ���۵Ļظ�ʱ���ش��ֶ�

    created_at  :=AJson.S['created_at'];//  ���۴���ʱ��
    id  :=AJson.I['id'];//  ���۵�ID
    text  :=AJson.S['text'];//  ���۵�����
    source  :=AJson.S['source'];//  ���۵���Դ

//    user  :=AJson.S['user'];//  �������ߵ��û���Ϣ�ֶ� ��ϸ
    if AJson.Contains('user') then
    begin
      user:=Tuser.Create;
      Tuser(user).ParseFromJson(AJson.O['user']);
    end;

    mid  :=AJson.S['mid'];//  ���۵�MID
    idstr  :=AJson.S['idstr'];//  �ַ����͵�����ID
//    status  :=AJson.S['pinyin'];//  ���۵�΢����Ϣ�ֶ� ��ϸ
    if AJson.Contains('status') then
    begin
      status:=Tstatus.Create;
      Tstatus(status).ParseFromJson(AJson.O['status']);
    end;

//    reply_comment  :=AJson.S['pinyin'];//  ������Դ���ۣ������������ڶ���һ���۵Ļظ�ʱ���ش��ֶ�

end;

{ TTcomment }

function Tcomments.GetItem(Index: Integer): Tcomment;
begin
  Result:=Tcomment(Inherited Items[Index]);
end;





{ Tuser_count }

function Tuser_count.ParseFromJson(AJson: ISuperObject): Boolean;
begin
  //id  int64  �û�UID
  id:=AJson.I['id'];
  //followers_count  int  ��˿��
  followers_count:=AJson.I['followers_count'];
  //friends_count  int  ��ע��
  friends_count:=AJson.I['friends_count'];
  //statuses_count  int  ΢����
  statuses_count:=AJson.I['statuses_count'];


end;

{ Tuser_counts }

function Tuser_counts.GetItem(Index: Integer): Tuser_count;
begin
  Result:=Tuser_count(Inherited Items[Index]);
end;

end.
