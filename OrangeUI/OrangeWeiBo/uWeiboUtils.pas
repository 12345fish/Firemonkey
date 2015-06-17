unit uWeiboUtils;

interface

uses
//  Windows,
  SysUtils,
//  WinSock,
  Math,
  IdGlobal,
  Classes,
  StrUtils//,
//  uStrUtils
//  uMailMessageLog
  ;

//const
//  //�ʼ����Ϳؼ�����
//  CONST_XMAILER_NAME        = 'FumaSoft SMTP Component V%VER%';
//const
//  //�ʼ����Ϳؼ��汾
//  CONST_XMAILER_VERSION     = 100;

//����������ת����UTC��ʽ�������ַ���
//function DateTimeToRfc822(t : TDateTime) : String;
//�������׼��ʽ�������ַ���ת���ɱ������ڸ�ʽ
function Rfc822ToDateTime(S: string;var Succ:Boolean;var TimeZone:String;var UTCDateTime:TDateTime): TDateTime;overload;
function Rfc822ToDateTime(S: string): TDateTime;overload;

//function WeiboRfc822ToDateTime(S: string;var Succ:Boolean;var TimeZone:String;var UTCDateTime:TDateTime): TDateTime;overload;
function WeiboRfc822ToDateTime(S: string): TDateTime;overload;


//function TimeZoneBiasDT : TDateTime;
//function TimeZoneBias : String;
////�����ʼ�ID
//function GenerateMessageID : String;
////����Boundary
//function GenerateMimePartBoundary : String;
////���ɹ�����Դ��ID
//function GenerateRelatedPartContentID : String;
////
//function GetXMailerValue(XMailer:String): String;
////�����ʼ�ID
//function GenerateGUID:String;
//function GenerateFUID:String;
//function GetValidFileName(AInvalidFileName:String):String;

//function GetSpeedStr(ASpeed:DWORD):String;
//
//function FMDateTimeToStr(const DateTime: TDateTime): string;
//function FMStrToDateTime(const S: string): TDateTime;
//
//
//{ Quoted-Printable ���� }
//function DecodeQuotedPrintableStream(InputStream:TStream;OutputStream:TStream):Integer;
//
//{ Quoted-Printable ���� }
//function EncodeQuotedPrintable(const Value: AnsiString): AnsiString;


function GetTimeZoneName(ATimeZone:String):String;

const
  TimeZoneNameArray:array [0..63] of String=(
  '-1200',
  '�������¿˵�,����ֻ���',
  '-1100',
  'ŵĸ,��;��,��Ħ��Ⱥ��',
  '-1000',
  '������',
  '-0900',
  '����˹��',
  '-0800',
  '������ʱ��',
  '-0700',
  '��ɽ��ʱ��',
  '-0600',
  '���в�ʱ��,ī�����',
  '-0500',
  '������ʱ��,�����,����,����',
  '-0400',
  '������ʱ��,������˹,����˹',
  '-0330',
  'Ŧ����',
  '-0300',
  '����,����ŵ˹����˹,���ζ�,������Ⱥ��',
  '-0200',
  '�������в�ʱ��,��ɭ�ɵ�,ʥ�����õ�',
  '-0100',
  '���ٶ�Ⱥ��,��ýǵ�',
  '+0000',
  '����������,������,������,�׶�,��˹��,����ά��',
  '-0000',
  '����������,������,������,�׶�,��˹��,����ά��',
  '0000',
  '����������,������,������,�׶�,��˹��,����ά��',
  '+0100',
  '����,��³����,�籾����,�����,����,����',
  '+0200',
  '����������,�Ϸ�,��ɳ',
  '+0300',
  '�͸��,���ŵ�,Ī˹��,���ޱ�',
  '+0330',
  '�º���',
  '+0400',
  '��������,�Ϳ�,��˹����,�ڱ���˹',
  '+0430',
  '������',
  '+0500',
  '��˹����,������,��ʲ��',
  '+0530',
  '����,�Ӷ�����,����,�µ���',
  '+0600',
  '����ľͼ,���ױ���,�￨',
  '+0700',
  '����,����,�żӴ�',
  '+0800',
  '����,���,��˹,�¼���,̨��',
  '+0900',
  '����, ����, ����, ����, �ſ�Ŀ�',
  '+0930',
  '��������, �����',
  '+1000',
  'ī����, �Ͳ����¼�����, Ϥ��, ��������˹�п�',
  '+1100',
  '��ӵ�, �¿��������, ������Ⱥ��',
  '+1200',
  '�¿���, �����, 쳼�, ���ܶ�Ⱥ��'

//  [-12:00]
//  �������п˵�, ����ֻ���
//  [-11:00]
//  ��;��, ��Ħ��Ⱥ��
//  [-10:00]
//  ������
//  [-9:00]
//  ����˹��
//  [-8:00]
//  ̫ƽ��ʱ��(�����ͼ��ô�), �Ừ��
//  [-7:00]
//  ɽ��ʱ��(�����ͼ��ô�), ����ɣ��
//  [-6:00]
//  �в�ʱ��(�����ͼ��ô�), ī�����
//  [-5:00]
//  ����ʱ��(�����ͼ��ô�), �����, ����, ����
//  [-4:00]
//  ������ʱ��(���ô�), ������˹, ����˹
//  [-3:30]
//  Ŧ����
//  [-3:00]
//  ��������, ����ŵ˹����˹, ���ζ�, ������Ⱥ��
//  [-2:00]
//  �д�����, ��ɭ��Ⱥ��, ʥ�����õ�
//  [-1:00]
//  ����Ⱥ��, ��ý�Ⱥ��
//  //[�������α�׼ʱ��] ������, �׶�, ��˹��, ����������
//  [+1:00]
//  ����, ��³����, �籾����, �����, ����, ����
//  [+2:00]
//  ����, �ն�����, ����������, �Ϸ�, ��ɳ
//  [+3:00]
//  �͸��, ���ŵ�, Ī˹��, �����
////  [+3:30] �º���
//  [+4:00]
//  ��������, �Ϳ�, ��˹����, �ر���˹
////  [+4:30] ������
//  [+5:00]
//  Ҷ�����ձ�, ��˹����, ������, ��ʲ��
////  [+5:30] ����, �Ӷ�����, �����˹, �µ���
////  [+5:45] �ӵ�����
//  [+6:00]
//  ����ľͼ, ������, �￨, ����������
////  [+5:45] ����
//  [+7:00]
//  ����, ����, �żӴ�
//  [+8:00]
//  ����, ���, ��˹, �¼���, ̨��
//  [+9:00]
//  ����, ����, ����, ����, �ſ�Ŀ�
////  [+9:30] ��������, �����
//  [+10:00]
//  ������, �ص�, ī����, Ϥ��, ������
//  [+11:00]
//  ��ӵ�, �¿��������, ������Ⱥ��
//  [+12:00]
//  �¿���, �����, 쳼�, ���ܶ�Ⱥ��

  );




implementation


function GetTimeZoneName(ATimeZone:String):String;
var
  I: Integer;
begin
  Result:='';
  I:=0;
  while I<Length(TimeZoneNameArray) do
  begin
    if TimeZoneNameArray[I]=ATimeZone then
    begin
      Result:=TimeZoneNameArray[I+1];
      Break;
    end;
    Inc(I,2);
  end;
end;


//function GetSpeedStr(ASpeed:DWORD):String;
//var
//  ASize:Extended;
//begin
//  ASize:=ASpeed;
//  if ASize<1024 then            {B}
//  begin
//    Result:=IntToStr(ASpeed)+'B';Exit;
//  end;
//  ASize:=ASize/1024;
//  if ASize<1024 then            {KB}
//  begin
//    Result:=FloatToStr( Roundto( ASize,-2)    )+'KB';exit;
//  end;
//  ASize:=ASize/1024;
//  if ASize<1024 then            {MB}
//  begin
//    Result:=FloatToStr( Roundto( ASize,-2)    )+'MB';exit;
//  end;
//  ASize:=ASize/1024;
//  if ASize<1024 then            {GB}
//  begin
//    Result:=FloatToStr( Roundto( ASize,-2)    )+'GB';exit;
//  end
//  else
//  begin
//    Result:='';
//  end;
//end;
//
//
//function FMStrToDateTime(const S: string): TDateTime;
//var
//  FFmtSettings: TFormatSettings;
//begin
//  FFmtSettings.ShortDateFormat := 'yyyy-MM-dd';
//  FFmtSettings.DateSeparator := '-';
//  FFmtSettings.LongTimeFormat := 'hh:mm:ss';
//  FFmtSettings.TimeSeparator := ':';
//  Result := StrToDateTime(S, FFmtSettings);
//end;
//
//function FMDateTimeToStr(const DateTime: TDateTime): string;
//var
//  FFmtSettings: TFormatSettings;
//begin
//  FFmtSettings.ShortDateFormat := 'yyyy-MM-dd';
//  FFmtSettings.DateSeparator := '-';
//  FFmtSettings.LongTimeFormat := 'hh:mm:ss';
//  FFmtSettings.TimeSeparator := ':';
//
//  Result := DateTimeToStr(DateTime, FFmtSettings);
//end;
//
//
//function GetValidFileName(AInvalidFileName:String):String;
//const
//  CONST_SPEC_CHAR='/\:*?"<>|'#9#13#10;
//var
//  I: Integer;
//  Index:Integer;
//begin
//  //���������ַ�
//  //    /\:*?"<>|
//  Result:=AInvalidFileName;
//  for I := 1 to Length(CONST_SPEC_CHAR) do
//  begin
//    Index:=Pos(CONST_SPEC_CHAR[I],Result);
//    while Index>0 do
//    begin
//      Result:=Copy(Result,1,Index-1)+Copy(Result,Index+1,Length(Result));
//      Index:=PosEx(CONST_SPEC_CHAR[I],Result,Index);
//    end;
//  end;
//end;

function TimeZoneToGmtOffsetStr(const ATimeZone: String): String;
type
  TimeZoneOffset = record
    TimeZone: String;
    Offset: String;
  end;
const
  cTimeZones: array[0..89] of TimeZoneOffset = (
    (TimeZone:'A';    Offset:'+0100'), // Alpha Time Zone - Military                             {do not localize}
    (TimeZone:'ACDT'; Offset:'+1030'), // Australian Central Daylight Time                       {do not localize}
    (TimeZone:'ACST'; Offset:'+0930'), // Australian Central Standard Time                       {do not localize}
    (TimeZone:'ADT';  Offset:'-0300'), // Atlantic Daylight Time - North America                 {do not localize}
    (TimeZone:'AEDT'; Offset:'+1100'), // Australian Eastern Daylight Time                       {do not localize}
    (TimeZone:'AEST'; Offset:'+1000'), // Australian Eastern Standard Time                       {do not localize}
    (TimeZone:'AKDT'; Offset:'-0800'), // Alaska Daylight Time                                   {do not localize}
    (TimeZone:'AKST'; Offset:'-0900'), // Alaska Standard Time                                   {do not localize}
    (TimeZone:'AST';  Offset:'-0400'), // Atlantic Standard Time - North America                 {do not localize}
    (TimeZone:'AWDT'; Offset:'+0900'), // Australian Western Daylight Time                       {do not localize}
    (TimeZone:'AWST'; Offset:'+0800'), // Australian Western Standard Time                       {do not localize}
    (TimeZone:'B';    Offset:'+0200'), // Bravo Time Zone - Military                             {do not localize}
    (TimeZone:'BST';  Offset:'+0100'), // British Summer Time - Europe                           {do not localize}
    (TimeZone:'C';    Offset:'+0300'), // Charlie Time Zone - Military                           {do not localize}
    (TimeZone:'CDT';  Offset:'+1030'), // Central Daylight Time - Australia                      {do not localize}
    (TimeZone:'CDT';  Offset:'-0500'), // Central Daylight Time - North America                  {do not localize}
    (TimeZone:'CEDT'; Offset:'+0200'), // Central European Daylight Time                         {do not localize}
    (TimeZone:'CEST'; Offset:'+0200'), // Central European Summer Time                           {do not localize}
    (TimeZone:'CET';  Offset:'+0100'), // Central European Time                                  {do not localize}
    (TimeZone:'CST';  Offset:'+1030'), // Central Summer Time - Australia                        {do not localize}
    (TimeZone:'CST';  Offset:'+0930'), // Central Standard Time - Australia                      {do not localize}
    (TimeZone:'CST';  Offset:'-0600'), // Central Standard Time - North America                  {do not localize}
    (TimeZone:'CXT';  Offset:'+0700'), // Christmas Island Time - Australia                      {do not localize}
    (TimeZone:'D';    Offset:'+0400'), // Delta Time Zone - Military                             {do not localize}
    (TimeZone:'E';    Offset:'+0500'), // Echo Time Zone - Military                              {do not localize}
    (TimeZone:'EDT';  Offset:'+1100'), // Eastern Daylight Time - Australia                      {do not localize}
    (TimeZone:'EDT';  Offset:'-0400'), // Eastern Daylight Time - North America                  {do not localize}
    (TimeZone:'EEDT'; Offset:'+0300'), // Eastern European Daylight Time                         {do not localize}
    (TimeZone:'EEST'; Offset:'+0300'), // Eastern European Summer Time                           {do not localize}
    (TimeZone:'EET';  Offset:'+0200'), // Eastern European Time                                  {do not localize}
    (TimeZone:'EST';  Offset:'+1100'), // Eastern Summer Time - Australia                        {do not localize}
    (TimeZone:'EST';  Offset:'+1000'), // Eastern Standard Time - Australia                      {do not localize}
    (TimeZone:'EST';  Offset:'-0500'), // Eastern Standard Time - North America                  {do not localize}
    (TimeZone:'F';    Offset:'+0600'), // Foxtrot Time Zone - Military                           {do not localize}
    (TimeZone:'G';    Offset:'+0700'), // Golf Time Zone - Military                              {do not localize}
    (TimeZone:'GMT';  Offset:'+0000'), // Greenwich Mean Time - Europe                           {do not localize}
    (TimeZone:'H';    Offset:'+0800'), // Hotel Time Zone - Military                             {do not localize}
    (TimeZone:'HAA';  Offset:'-0300'), // Heure Avanc�e de l'Atlantique - North America          {do not localize}
    (TimeZone:'HAC';  Offset:'-0500'), // Heure Avanc�e du Centre - North America                {do not localize}
    (TimeZone:'HADT'; Offset:'-0900'), // Hawaii-Aleutian Daylight Time - North America          {do not localize}
    (TimeZone:'HAE';  Offset:'-0400'), // Heure Avanc�e de l'Est - North America                 {do not localize}
    (TimeZone:'HAP';  Offset:'-0700'), // Heure Avanc�e du Pacifique - North America             {do not localize}
    (TimeZone:'HAR';  Offset:'-0600'), // Heure Avanc�e des Rocheuses - North America            {do not localize}
    (TimeZone:'HAST'; Offset:'-1000'), // Hawaii-Aleutian Standard Time - North America          {do not localize}
    (TimeZone:'HAT';  Offset:'-0230'), // Heure Avanc�e de Terre-Neuve - North America           {do not localize}
    (TimeZone:'HAY';  Offset:'-0800'), // Heure Avanc�e du Yukon - North America                 {do not localize}
    (TimeZone:'HNA';  Offset:'-0400'), // Heure Normale de l'Atlantique - North America          {do not localize}
    (TimeZone:'HNC';  Offset:'-0600'), // Heure Normale du Centre - North America                {do not localize}
    (TimeZone:'HNE';  Offset:'-0500'), // Heure Normale de l'Est - North America                 {do not localize}
    (TimeZone:'HNP';  Offset:'-0800'), // Heure Normale du Pacifique - North America             {do not localize}
    (TimeZone:'HNR';  Offset:'-0700'), // Heure Normale des Rocheuses - North America            {do not localize}
    (TimeZone:'HNT';  Offset:'-0330'), // Heure Normale de Terre-Neuve - North America           {do not localize}
    (TimeZone:'HNY';  Offset:'-0900'), // Heure Normale du Yukon - North America                 {do not localize}
    (TimeZone:'I';    Offset:'+0900'), // India Time Zone - Military                             {do not localize}
    (TimeZone:'IST';  Offset:'+0100'), // Irish Summer Time - Europe                             {do not localize}
    (TimeZone:'K';    Offset:'+1000'), // Kilo Time Zone - Military                              {do not localize}
    (TimeZone:'L';    Offset:'+1100'), // Lima Time Zone - Military                              {do not localize}
    (TimeZone:'M';    Offset:'+1200'), // Mike Time Zone - Military                              {do not localize}
    (TimeZone:'MDT';  Offset:'-0600'), // Mountain Daylight Time - North America                 {do not localize}
    (TimeZone:'MEHSZ';Offset:'+0300'), // Mitteleurop�ische Hochsommerzeit - Europe              {do not localize}
    (TimeZone:'MESZ'; Offset:'+0200'), // Mitteleuro�ische Sommerzeit - Europe                   {do not localize}
    (TimeZone:'MEZ';  Offset:'+0100'), // Mitteleurop�ische Zeit - Europe                        {do not localize}
    (TimeZone:'MSD';  Offset:'+0400'), // Moscow Daylight Time - Europe                          {do not localize}
    (TimeZone:'MSK';  Offset:'+0300'), // Moscow Standard Time - Europe                          {do not localize}
    (TimeZone:'MST';  Offset:'-0700'), // Mountain Standard Time - North America                 {do not localize}
    (TimeZone:'N';    Offset:'-0100'), // November Time Zone - Military                          {do not localize}
    (TimeZone:'NDT';  Offset:'-0230'), // Newfoundland Daylight Time - North America             {do not localize}
    (TimeZone:'NFT';  Offset:'+1130'), // Norfolk (Island), Time - Australia                      {do not localize}
    (TimeZone:'NST';  Offset:'-0330'), // Newfoundland Standard Time - North America             {do not localize}
    (TimeZone:'O';    Offset:'-0200'), // Oscar Time Zone - Military                             {do not localize}
    (TimeZone:'P';    Offset:'-0300'), // Papa Time Zone - Military                              {do not localize}
    (TimeZone:'PDT';  Offset:'-0700'), // Pacific Daylight Time - North America                  {do not localize}
    (TimeZone:'PST';  Offset:'-0800'), // Pacific Standard Time - North America                  {do not localize}
    (TimeZone:'Q';    Offset:'-0400'), // Quebec Time Zone - Military                            {do not localize}
    (TimeZone:'R';    Offset:'-0500'), // Romeo Time Zone - Military                             {do not localize}
    (TimeZone:'S';    Offset:'-0600'), // Sierra Time Zone - Military                            {do not localize}
    (TimeZone:'T';    Offset:'-0700'), // Tango Time Zone - Military                             {do not localize}
    (TimeZone:'U';    Offset:'-0800'), // Uniform Time Zone - Military                           {do not localize}
    (TimeZone:'UTC';  Offset:'+0000'), // Coordinated Universal Time - Europe                    {do not localize}
    (TimeZone:'V';    Offset:'-0900'), // Victor Time Zone - Military                            {do not localize}
    (TimeZone:'W';    Offset:'-1000'), // Whiskey Time Zone - Military                           {do not localize}
    (TimeZone:'WDT';  Offset:'+0900'), // Western Daylight Time - Australia                      {do not localize}
    (TimeZone:'WEDT'; Offset:'+0100'), // Western European Daylight Time - Europe                {do not localize}
    (TimeZone:'WEST'; Offset:'+0100'), // Western European Summer Time - Europe                  {do not localize}
    (TimeZone:'WET';  Offset:'+0000'), // Western European Time - Europe                         {do not localize}
    (TimeZone:'WST';  Offset:'+0900'), // Western Summer Time - Australia                        {do not localize}
    (TimeZone:'WST';  Offset:'+0800'), // Western Standard Time - Australia                      {do not localize}
    (TimeZone:'X';    Offset:'-1100'), // X-ray Time Zone - Military                             {do not localize}
    (TimeZone:'Y';    Offset:'-1200'), // Yankee Time Zone - Military                            {do not localize}
    (TimeZone:'Z';    Offset:'+0000')  // Zulu Time Zone - Military                              {do not localize}
  );
var
  I: Integer;
begin
  for I := Low(cTimeZones) to High(cTimeZones) do
  begin
    if SameText(ATimeZone, cTimeZones[I].TimeZone) then
    begin
      Result := cTimeZones[I].Offset;
      Exit;
    end;
  end;
  Result := '-0000'
end;

function GmtOffsetStrToDateTime(const S: string;var TimeZone:String): TDateTime;
var
  sTmp: String;
begin
  Result := 0.0;
  TimeZone:='';
  sTmp := Trim(S);
  sTmp := Fetch(sTmp);
  if Length(sTmp) > 0 then
  begin
    if (sTmp[1] <> '-') and (sTmp[1] <> '+') then
    begin
      sTmp := TimeZoneToGmtOffsetStr(sTmp);
    end;
    if (Length(sTmp) = 5) and ((sTmp[1] = '-') or (sTmp[1] = '+')) then
    begin
      try
        TimeZone:=sTmp;
        Result := EncodeTime(IndyStrToInt(Copy(sTmp, 2, 2)), IndyStrToInt(Copy(sTmp, 4, 2)), 0, 0);
        if sTmp[1] = '-' then
        begin
          Result := -Result;
        end;
      except
        Result := 0.0;
      end;
    end;
  end;
end;


function StrToDay(const ADay: string): Byte;
begin
  Result := Succ(
    PosInStrArray(ADay,
      ['SUN','MON','TUE','WED','THU','FRI','SAT'],
      False));
end;

function StrToMonth(const AMonth: string): Byte;
const
  // RLebeau 1/7/09: using Char() for #128-#255 because in D2009, the compiler
  // may change characters >= #128 from their Ansi codepage value to their true
  // Unicode codepoint value, depending on the codepage used for the source code.
  // For instance, #128 may become #$20AC...
  Months: array[0..7] of array[1..12] of string = (

    // English
    ('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'),

    // English - alt. 4 letter abbreviations (Netware Print Services may return a 4 char month such as Sept)
    ('',    '',    '',    '',    '',   'JUNE','JULY', '',   'SEPT', '',    '',    ''),

    // German
    ('',    '',    'MRZ', '',    'MAI', '',    '',    '',    '',    'OKT', '',    'DEZ'),

    // Spanish
    ('ENO', 'FBRO','MZO', 'AB',  '',    '',    '',    'AGTO','SBRE','OBRE','NBRE','DBRE'),

    // Dutch
    ('',    '',    'MRT', '',    'MEI', '',    '',    '',    '',    'OKT', '',    ''),

    // French
    ('JANV','F'+Char($C9)+'V', 'MARS','AVR', 'MAI', 'JUIN','JUIL','AO'+Char($DB), 'SEPT','',    '',    'D'+Char($C9)+'C'),

    // French (alt)
    ('',    'F'+Char($C9)+'VR','',    '',    '',    '',    'JUI',    'AO'+Char($DB)+'T','',    '',    '',    ''),

    // Slovenian
    ('',    '',     '',   '', 'MAJ',    '',    '',       '',     'AVG',    '',    '',  ''));
var
  i: Integer;
begin
  if AMonth <> '' then begin
    for i := Low(Months) to High(Months) do begin
      for Result := Low(Months[i]) to High(Months[i]) do begin
        if TextIsSame(AMonth, Months[i][Result]) then begin
          Exit;
        end;
      end;
	  end;
  end;
  Result := 0;
end;

function RawStrInternetToDateTime(var Value: string; var VDateTime: TDateTime): Boolean;
var
  i: Integer;
  Dt, Mo, Yr, Ho, Min, Sec: Word;
  sYear, sTime, sDelim: string;
  //flags for if AM/PM marker found
  LAM, LPM : Boolean;
  OldValue:String;
  procedure ParseDayOfMonth;
  begin
    Dt :=  IndyStrToInt( Fetch(Value, sDelim), 1);
    Value := TrimLeft(Value);
  end;

  procedure ParseMonth;
  begin
    Mo := StrToMonth( Fetch (Value, sDelim)  );
    Value := TrimLeft(Value);
  end;

begin
  Result := False;
  VDateTime := 0.0;
  OldValue:=Value;

  LAM := False;
  LPM := False;

  Value := Trim(Value);
  if Length(Value) = 0 then
  begin
    VDateTime:=Now;
    Exit;
  end;

  try
    {Day of Week}
    if StrToDay(Copy(Value, 1, 3)) > 0 then begin
      //workaround in case a space is missing after the initial column
      if CharEquals(Value, 4, ',') and (not CharEquals(Value, 5, ' ')) then begin
        Insert(' ', Value, 5);
      end;
      Fetch(Value);
      Value := TrimLeft(Value);
    end;

    // Workaround for some buggy web servers which use '-' to separate the date parts.    {Do not Localize}
    if (Pos('-', Value) > 1) and (Pos('-', Value) < Pos(' ', Value)) then begin    {Do not Localize}
      sDelim := '-';    {Do not Localize}
    end else begin
      sDelim := ' ';    {Do not Localize}
    end;

    //workaround for improper dates such as 'Fri, Sep 7 2001'    {Do not Localize}
    //RFC 2822 states that they should be like 'Fri, 7 Sep 2001'    {Do not Localize}
    if StrToMonth(Fetch(Value, sDelim, False)) > 0 then begin
      {Month}
      ParseMonth;
      {Day of Month}
      ParseDayOfMonth;
    end else begin
      {Day of Month}
      ParseDayOfMonth;
      {Month}
      ParseMonth;
    end;

    {Year}
    // There is some strange date/time formats like
    // DayOfWeek Month DayOfMonth Time Year
    sYear := Fetch(Value);
    Yr := IndyStrToInt(sYear, High(Word));
    if Yr = High(Word) then
    begin // Is sTime valid Integer?
      sTime := sYear;
      sYear := Fetch(Value);
      Value := TrimRight(sTime + ' ' + Value);
      Yr := IndyStrToInt(sYear);
    end;

    // RLebeau: According to RFC 2822, Section 4.3:
    //
    // "Where a two or three digit year occurs in a date, the year is to be
    // interpreted as follows: If a two digit year is encountered whose
    // value is between 00 and 49, the year is interpreted by adding 2000,
    // ending up with a value between 2000 and 2049.  If a two digit year is
    // encountered with a value between 50 and 99, or any three digit year
    // is encountered, the year is interpreted by adding 1900."
    if Length(sYear) = 2 then begin
      if {(Yr >= 0) and} (Yr <= 49) then begin
        Inc(Yr, 2000);
      end
      else if (Yr >= 50) and (Yr <= 99) then begin
        Inc(Yr, 1900);
      end;
    end
    else if Length(sYear) = 3 then begin
      Inc(Yr, 1900);
    end;

    VDateTime := EncodeDate(Yr, Mo, Dt);
    // SG 26/9/00: Changed so that ANY time format is accepted
    if Pos('AM', Value) > 0 then begin{do not localize}
      LAM := True;
      Value := Fetch(Value, 'AM');  {do not localize}
    end
    else if Pos('PM', Value) > 0 then begin {do not localize}
      LPM := True;
      Value := Fetch(Value, 'PM');  {do not localize}
    end;

    // RLebeau 03/04/2009: some countries use dot instead of colon
    // for the time separator
    i := Pos('.', Value);       {do not localize}
    if i > 0 then begin
      sDelim := '.';                {do not localize}
    end else begin
      sDelim := ':';                {do not localize}
    end;
    i := Pos(sDelim, Value);
    if i > 0 then begin
      // Copy time string up until next space (before GMT offset)
      sTime := Fetch(Value, ' ');  {do not localize}
      {Hour}
      Ho  := IndyStrToInt( Fetch(sTime, sDelim), 0);
      {Minute}
      Min := IndyStrToInt( Fetch(sTime, sDelim), 0);
      {Second}
      Sec := IndyStrToInt( Fetch(sTime), 0);
      {AM/PM part if present}
      Value := TrimLeft(Value);
      if LAM then
      begin
        if Ho = 12 then
        begin
          Ho := 0;
        end;
      end
      else if LPM then
      begin
        //in the 12 hour format, afternoon is 12:00PM followed by 1:00PM
        //while midnight is written as 12:00 AM
        //Not exactly technically correct but pretty accurate
        if Ho < 12 then
        begin
          Inc(Ho, 12);
        end;
      end;
      {The date and time stamp returned}
      VDateTime := VDateTime + EncodeTime(Ho, Min, Sec, 0);
    end;
    Value := TrimLeft(Value);
    Result := True;
  except
    On E:Exception do
    begin
//      //HandleException(E, 'MailParse', 'uMailMessageUtils', 'RawStrInternetToDateTime','','');
      Result:=TryStrToDateTime(OldValue,VDateTime);
    end;
  end;
end;

//function WeiboRawStrInternetToDateTime(var Value: string; var VDateTime: TDateTime): Boolean;
//var
//  i: Integer;
//  Dt, Mo, Yr, Ho, Min, Sec: Word;
//  sYear, sTime, sDelim: string;
//  //flags for if AM/PM marker found
//  LAM, LPM : Boolean;
//  OldValue:String;
//  procedure ParseDayOfMonth;
//  begin
//    Dt :=  IndyStrToInt( Fetch(Value, sDelim), 1);
//    Value := TrimLeft(Value);
//  end;
//
//  procedure ParseMonth;
//  begin
//    Mo := StrToMonth( Fetch (Value, sDelim)  );
//    Value := TrimLeft(Value);
//  end;
//
//begin
//  Result := False;
//  VDateTime := 0.0;
//  OldValue:=Value;
//
//  LAM := False;
//  LPM := False;
//
//  Value := Trim(Value);
//  if Length(Value) = 0 then
//  begin
//    VDateTime:=Now;
//    Exit;
//  end;
//
//  //Thu Jul 24 16:39:18 +0800 2014
//  try
//    {Day of Week}
//    if StrToDay(Copy(Value, 1, 3)) > 0 then begin
//      //workaround in case a space is missing after the initial column
//      if CharEquals(Value, 4, ',') and (not CharEquals(Value, 5, ' ')) then begin
//        Insert(' ', Value, 5);
//      end;
//      Fetch(Value);
//      Value := TrimLeft(Value);
//    end;
//
//    // Workaround for some buggy web servers which use '-' to separate the date parts.    {Do not Localize}
//    if (Pos('-', Value) > 1) and (Pos('-', Value) < Pos(' ', Value)) then begin    {Do not Localize}
//      sDelim := '-';    {Do not Localize}
//    end else begin
//      sDelim := ' ';    {Do not Localize}
//    end;
//
//    //workaround for improper dates such as 'Fri, Sep 7 2001'    {Do not Localize}
//    //RFC 2822 states that they should be like 'Fri, 7 Sep 2001'    {Do not Localize}
//    if StrToMonth(Fetch(Value, sDelim, False)) > 0 then begin
//      {Month}
//      ParseMonth;
//      {Day of Month}
//      ParseDayOfMonth;
//    end else begin
//      {Day of Month}
//      ParseDayOfMonth;
//      {Month}
//      ParseMonth;
//    end;
//
//    {Year}
//    // There is some strange date/time formats like
//    // DayOfWeek Month DayOfMonth Time Year
//    sYear := Fetch(Value);
//    Yr := IndyStrToInt(sYear, High(Word));
//    if Yr = High(Word) then
//    begin // Is sTime valid Integer?
//      sTime := sYear;
//      sYear := Fetch(Value);
//      Value := TrimRight(sTime + ' ' + Value);
//      Yr := IndyStrToInt(sYear);
//    end;
//
//    // RLebeau: According to RFC 2822, Section 4.3:
//    //
//    // "Where a two or three digit year occurs in a date, the year is to be
//    // interpreted as follows: If a two digit year is encountered whose
//    // value is between 00 and 49, the year is interpreted by adding 2000,
//    // ending up with a value between 2000 and 2049.  If a two digit year is
//    // encountered with a value between 50 and 99, or any three digit year
//    // is encountered, the year is interpreted by adding 1900."
//    if Length(sYear) = 2 then begin
//      if {(Yr >= 0) and} (Yr <= 49) then begin
//        Inc(Yr, 2000);
//      end
//      else if (Yr >= 50) and (Yr <= 99) then begin
//        Inc(Yr, 1900);
//      end;
//    end
//    else if Length(sYear) = 3 then begin
//      Inc(Yr, 1900);
//    end;
//
//    VDateTime := EncodeDate(Yr, Mo, Dt);
//    // SG 26/9/00: Changed so that ANY time format is accepted
//    if Pos('AM', Value) > 0 then begin{do not localize}
//      LAM := True;
//      Value := Fetch(Value, 'AM');  {do not localize}
//    end
//    else if Pos('PM', Value) > 0 then begin {do not localize}
//      LPM := True;
//      Value := Fetch(Value, 'PM');  {do not localize}
//    end;
//
//    // RLebeau 03/04/2009: some countries use dot instead of colon
//    // for the time separator
//    i := Pos('.', Value);       {do not localize}
//    if i > 0 then begin
//      sDelim := '.';                {do not localize}
//    end else begin
//      sDelim := ':';                {do not localize}
//    end;
//    i := Pos(sDelim, Value);
//    if i > 0 then begin
//      // Copy time string up until next space (before GMT offset)
//      sTime := Fetch(Value, ' ');  {do not localize}
//      {Hour}
//      Ho  := IndyStrToInt( Fetch(sTime, sDelim), 0);
//      {Minute}
//      Min := IndyStrToInt( Fetch(sTime, sDelim), 0);
//      {Second}
//      Sec := IndyStrToInt( Fetch(sTime), 0);
//      {AM/PM part if present}
//      Value := TrimLeft(Value);
//      if LAM then
//      begin
//        if Ho = 12 then
//        begin
//          Ho := 0;
//        end;
//      end
//      else if LPM then
//      begin
//        //in the 12 hour format, afternoon is 12:00PM followed by 1:00PM
//        //while midnight is written as 12:00 AM
//        //Not exactly technically correct but pretty accurate
//        if Ho < 12 then
//        begin
//          Inc(Ho, 12);
//        end;
//      end;
//      {The date and time stamp returned}
//      VDateTime := VDateTime + EncodeTime(Ho, Min, Sec, 0);
//    end;
//    Value := TrimLeft(Value);
//    Result := True;
//  except
//    On E:Exception do
//    begin
////      //HandleException(E, 'MailParse', 'uMailMessageUtils', 'RawStrInternetToDateTime','','');
//      Result:=TryStrToDateTime(OldValue,VDateTime);
//    end;
//  end;
//end;

//function OffsetFromUTC: TDateTime;
////var
////  iBias: Integer;
////  tmez: TTimeZoneInformation;
//begin
//  Result:=8;
////  case GetTimeZoneInformation(tmez) of
////    TIME_ZONE_ID_INVALID  :
////      ;//raise EIdFailedToRetreiveTimeZoneInfo.Create(RSFailedTimeZoneInfo);
////    TIME_ZONE_ID_UNKNOWN  :
////       iBias := tmez.Bias;
////    TIME_ZONE_ID_DAYLIGHT :
////      iBias := tmez.Bias + tmez.DaylightBias;
////    TIME_ZONE_ID_STANDARD :
////      iBias := tmez.Bias + tmez.StandardBias;
////    else
////    begin
////      //raise EIdFailedToRetreiveTimeZoneInfo.Create(RSFailedTimeZoneInfo);
////    end;
////  end;
////  {We use ABS because EncodeTime will only accept positive values}
////  Result := EncodeTime(Abs(iBias) div 60, Abs(iBias) mod 60, 0, 0);
////  {The GetTimeZone function returns values oriented towards converting
////   a GMT time into a local time.  We wish to do the opposite by returning
////   the difference between the local time and GMT.  So I just make a positive
////   value negative and leave a negative value as positive}
////  if iBias > 0 then begin
////    Result := 0.0 - Result;
////  end;
//end;


function Rfc822ToDateTime(S: string;var Succ:Boolean;var TimeZone:String;var UTCDateTime:TDateTime): TDateTime;
var
  DateTimeOffset: TDateTime;
begin
  Succ:=False;
  if RawStrInternetToDateTime(S, Result) then
  begin
    UTCDateTime:=Result;
    Succ:=True;
    DateTimeOffset := GmtOffsetStrToDateTime(S,TimeZone);
    {-Apply GMT offset here}
    if DateTimeOffset < 0.0 then
    begin
      Result := Result + Abs(DateTimeOffset);
    end
    else
    begin
      Result := Result - DateTimeOffset;
    end;
    // Apply local offset
    Result := Result + OffsetFromUTC;
  end;
end;

function Rfc822ToDateTime(S: string): TDateTime;
var
  DateTimeOffset: TDateTime;
  var Succ:Boolean;var TimeZone:String;var UTCDateTime:TDateTime;
begin
  Succ:=False;
  if RawStrInternetToDateTime(S, Result) then
  begin
    UTCDateTime:=Result;
    Succ:=True;
    DateTimeOffset := GmtOffsetStrToDateTime(S,TimeZone);
    {-Apply GMT offset here}
    if DateTimeOffset < 0.0 then
    begin
      Result := Result + Abs(DateTimeOffset);
    end
    else
    begin
      Result := Result - DateTimeOffset;
    end;
    // Apply local offset
    Result := Result + OffsetFromUTC;
  end;
end;


//function WeiBoRfc822ToDateTime(S: string;var Succ:Boolean;var TimeZone:String;var UTCDateTime:TDateTime): TDateTime;
//var
//  DateTimeOffset: TDateTime;
//begin
//  Succ:=False;
//  if RawStrInternetToDateTime(S, Result) then
//  begin
//    UTCDateTime:=Result;
//    Succ:=True;
//    DateTimeOffset := GmtOffsetStrToDateTime(S,TimeZone);
//    {-Apply GMT offset here}
//    if DateTimeOffset < 0.0 then
//    begin
//      Result := Result + Abs(DateTimeOffset);
//    end
//    else
//    begin
//      Result := Result - DateTimeOffset;
//    end;
//    // Apply local offset
//    Result := Result + OffsetFromUTC;
//  end;
//end;

function WeiBoRfc822ToDateTime(S: string): TDateTime;
var
  DateTimeOffset: TDateTime;
  var Succ:Boolean;var TimeZone:String;var UTCDateTime:TDateTime;
begin
  //�����ַ���
  //Thu Jul 24 16:39:18 +0800 2014
  S:=Copy(S,1,Length(S)-10)
      +Copy(S,Length(S)-3,4)
      +' '
      +Copy(S,Length(S)-9,5);

  Succ:=False;
  if RawStrInternetToDateTime(S, Result) then
  begin
    UTCDateTime:=Result;
    Succ:=True;
    DateTimeOffset := GmtOffsetStrToDateTime(S,TimeZone);
    {-Apply GMT offset here}
    if DateTimeOffset < 0.0 then
    begin
      Result := Result + Abs(DateTimeOffset);
    end
    else
    begin
      Result := Result - DateTimeOffset;
    end;
    // Apply local offset
    Result := Result + OffsetFromUTC;
  end;
end;

//function GetXMailerValue(XMailer:String): String;
//var
//  VerNum : String;
//begin
//  VerNum := IntToStr(CONST_XMAILER_VERSION div 100) + '.' +
//            IntToStr(CONST_XMAILER_VERSION mod 100);
//  Result := StringReplace(XMailer, '%VER%', VerNum,
//                          [rfReplaceAll, rfIgnoreCase]);
//end;


//function TimeZoneBias : String;
//const
//    Time_Zone_ID_DayLight = 2;
//var
//    TZI       : tTimeZoneInformation;
//    TZIResult : Integer;
//    aBias     : Integer;
//begin
//    TZIResult := GetTimeZoneInformation(TZI);
//    if TZIResult = -1 then
//        Result := '-0000'
//    else begin
//         if TZIResult = Time_Zone_ID_DayLight then   { 10/05/99 }
//             aBias := TZI.Bias + TZI.DayLightBias
//         else
//             aBias := TZI.Bias + TZI.StandardBias;
//         Result := Format('-%.2d%.2d', [Abs(aBias) div 60, Abs(aBias) mod 60]);
//         if aBias < 0 then
//             Result[1] := '+';
//    end;
//end;
//
//Function LocalHostName : String;
//var
//  s : Array[0..255] Of WideChar;
//  u : cardinal;
//Begin
//  u := 255;
//  FillChar(s,Sizeof(WideChar)*u,0);
//  GetComputerName(@s, u);
//  Result := s;
//End;
//
//Function ASCII_LocalHostName : String;
//var
//  I:Integer;
//Begin
//  Result := LocalHostName;
//  for I := 1 to Length(Result) do
//  begin
//    if Word(Result[I])>127 then
//    begin
//      Result:='C';
//    end;
//  end;
//  //ȥ���������
//  Result:=ReplaceValidChar(Result,'/\:*?"<>|- ');
//End;
//
//function TimeZoneBiasDT : TDateTime;
//const
//  Time_Zone_ID_DayLight = 2;
//var
//  TZI       : tTimeZoneInformation;
//  TZIResult : Integer;
//  aBias     : Integer;
//begin
//  TZIResult := GetTimeZoneInformation(TZI);
//  if TZIResult = -1 then
//    Result := 0
//  else
//  begin
//    if TZIResult = Time_Zone_ID_DayLight then
//      aBias := TZI.Bias + TZI.DayLightBias
//    else
//      aBias := TZI.Bias + TZI.StandardBias;
//    Result := EncodeTime(Abs(aBias) div 60, Abs(aBias) mod 60, 0, 0);
//    if aBias < 0 then
//      Result := -Result;
//  end;
//end;
//
//function DateTimeToRfc822(t : TDateTime) : String;
//var
//  I                   : Integer;
//  SaveShortDayNames   : array[1..7] of string;
//  SaveShortMonthNames : array[1..12] of string;
//const
//  MyShortDayNames: array[1..7] of string =
//      ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');
//  MyShortMonthNames: array[1..12] of string =
//      ('Jan', 'Feb', 'Mar', 'Apr',
//       'May', 'Jun', 'Jul', 'Aug',
//       'Sep', 'Oct', 'Nov', 'Dec');
//begin
//  if ShortDayNames[1] = MyShortDayNames[1] then
//  begin
//    Result := FormatDateTime('ddd, d mmm yyyy hh":"mm":"ss', t) +
//              ' ' + TimeZoneBias
//  end
//  else
//  begin
//    { We used a localized Delphi version, the day and month names are no }
//    { more english names ! We need to save and replace them              }
//    for I := Low(ShortDayNames) to High(ShortDayNames) do
//    begin
//      SaveShortDayNames[I] := ShortDayNames[I];
//      ShortDayNames[I]     := MyShortDayNames[I];
//    end;
//
//    for I := Low(ShortMonthNames) to High(ShortMonthNames) do
//    begin
//      SaveShortMonthNames[I] := ShortMonthNames[I];
//      ShortMonthNames[I]     := MyShortMonthNames[I];
//    end;
//
//    Result := FormatDateTime('ddd, d mmm yyyy hh":"mm":"ss', t) +' ' + TimeZoneBias;
//
//    for I := Low(ShortDayNames) to High(ShortDayNames) do
//      ShortDayNames[I] := SaveShortDayNames[I];
//
//    for I := Low(ShortMonthNames) to High(ShortMonthNames) do
//      ShortMonthNames[I] := SaveShortMonthNames[I];
//  end;
//end;

//function GenerateMessageID : String;
//begin
//  Result := FormatDateTime('yyyymmddhhnnsszzz', Now + TimeZoneBiasDT) + '.' +
//            IntToHex(Random(32767), 4) + IntToHex(Random(32767), 4) +
//            IntToHex(Random(32767), 4) + IntToHex(Random(32767), 4) +
//            '@' + ASCII_LocalHostName;
//end;
//
////����Boundary
//function GenerateMimePartBoundary : String;
//begin
//  Result := FormatDateTime('yyyymmddhhnnsszzz', Now + TimeZoneBiasDT) + '.' +
//            IntToHex(Random(32767), 4) + IntToHex(Random(32767), 4) +
//            IntToHex(Random(32767), 4) + IntToHex(Random(32767), 4) ;
//end;

//function GenerateGUID:String;
//var
//  GUID:TGUID;
//  GUIDStr:String;
//begin
//  CreateGUID(GUID);
//  GUIDStr:=GUIDToString(GUID);
//  Result:=Copy(GUIDStr,2,8)+Copy(GUIDStr,11,4)+Copy(GUIDStr,16,4)+Copy(GUIDStr,21,4)+Copy(GUIDStr,26,12);
//end;
//
//function GenerateFUID:String;
//var
//  GUID:TGUID;
//  FUIDStr:String;
//begin
//  CreateGUID(GUID);
//  FUIDStr:=GUIDToString(GUID);
//  Result:=FUIDStr;//Copy(FUIDStr,2,Length(FUIDStr)-2);
//end;
//
////���ɹ�����Դ��ID
//function GenerateRelatedPartContentID : String;
//begin
//  Result := GenerateGUID;
//end;

//function HexToInt(const S: String): DWORD;
//asm
//PUSH EBX
//PUSH ESI
//
//MOV ESI, EAX //�ַ�����ַ
//MOV EDX, [EAX-4] //��ȡ�ַ�������
//
//XOR EAX, EAX //��ʼ������ֵ
//XOR ECX, ECX //��ʱ����
//
//TEST ESI, ESI //�ж��Ƿ�Ϊ��ָ��
//JZ @@2
//TEST EDX, EDX //�ж��ַ����Ƿ�Ϊ��
//JLE @@2
//MOV BL, $20
//@@0:
//MOV CL, [ESI]
//INC ESI
//
//OR CL, BL //�������ĸ��ת��ΪСд��ĸ
//SUB CL, '0'
//JB @@2 // < '0' ���ַ�
//CMP CL, $09
//JBE @@1 // '0'..'9' ���ַ�
//SUB CL, 'a'-'0'-10
//CMP CL, $0A
//JB @@2 // < 'a' ���ַ�
//CMP CL, $0F
//JA @@2 // > 'f' ���ַ�
//@@1: // '0'..'9', 'A'..'F', 'a'..'f'
//SHL EAX, 4
//OR EAX, ECX
//DEC EDX
//JNZ @@0
//JMP @@3
//@@2:
//XOR EAX, EAX // �Ƿ�16�����ַ���
//@@3:
//POP ESI
//POP EBX
//RET
//end;
//
//
//
//const
//{ BASE64��� }
//Base64CodeTable: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
//
//type
//  TSpecials = set of Char;
//
//const
//
//SpecialChar: TSpecials =
//  ['=', '(', ')', '[', ']', '<', '>', ':', ';', ',', '@', '/', '?', '\',
//  '"', '_'];
//NonAsciiChar: TSpecials =
//  [Char(0)..Char(31), Char(127)..Char(255)];
//URLFullSpecialChar: TSpecials =
//  [';', '/', '?', ':', '@', '=', '&', '#', '+'];
//URLSpecialChar: TSpecials =
//  [#$00..#$20, '_', '<', '>', '"', '%', '{', '}', '|', '\', '^', '~', '[', ']',
//  '`', #$7F..#$FF];
//TableBase64 =
//  'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
//TableBase64mod =
//  'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,=';
//TableUU =
//  '`!"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_';
//TableXX =
//  '+-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
//ReTablebase64 =
//  #$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$3E +#$40
//  +#$40 +#$40 +#$3F +#$34 +#$35 +#$36 +#$37 +#$38 +#$39 +#$3A +#$3B +#$3C
//  +#$3D +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$00 +#$01 +#$02 +#$03
//  +#$04 +#$05 +#$06 +#$07 +#$08 +#$09 +#$0A +#$0B +#$0C +#$0D +#$0E +#$0F
//  +#$10 +#$11 +#$12 +#$13 +#$14 +#$15 +#$16 +#$17 +#$18 +#$19 +#$40 +#$40
//  +#$40 +#$40 +#$40 +#$40 +#$1A +#$1B +#$1C +#$1D +#$1E +#$1F +#$20 +#$21
//  +#$22 +#$23 +#$24 +#$25 +#$26 +#$27 +#$28 +#$29 +#$2A +#$2B +#$2C +#$2D
//  +#$2E +#$2F +#$30 +#$31 +#$32 +#$33 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40;
//ReTableUU =
//  #$01 +#$02 +#$03 +#$04 +#$05 +#$06 +#$07 +#$08 +#$09 +#$0A +#$0B +#$0C
//  +#$0D +#$0E +#$0F +#$10 +#$11 +#$12 +#$13 +#$14 +#$15 +#$16 +#$17 +#$18
//  +#$19 +#$1A +#$1B +#$1C +#$1D +#$1E +#$1F +#$20 +#$21 +#$22 +#$23 +#$24
//  +#$25 +#$26 +#$27 +#$28 +#$29 +#$2A +#$2B +#$2C +#$2D +#$2E +#$2F +#$30
//  +#$31 +#$32 +#$33 +#$34 +#$35 +#$36 +#$37 +#$38 +#$39 +#$3A +#$3B +#$3C
//  +#$3D +#$3E +#$3F +#$00 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40
//  +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40
//  +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40;
//ReTableXX =
//  #$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$00 +#$40
//  +#$01 +#$40 +#$40 +#$02 +#$03 +#$04 +#$05 +#$06 +#$07 +#$08 +#$09 +#$0A
//  +#$0B +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$40 +#$0C +#$0D +#$0E +#$0F
//  +#$10 +#$11 +#$12 +#$13 +#$14 +#$15 +#$16 +#$17 +#$18 +#$19 +#$1A +#$1B
//  +#$1C +#$1D +#$1E +#$1F +#$20 +#$21 +#$22 +#$23 +#$24 +#$25 +#$40 +#$40
//  +#$40 +#$40 +#$40 +#$40 +#$26 +#$27 +#$28 +#$29 +#$2A +#$2B +#$2C +#$2D
//  +#$2E +#$2F +#$30 +#$31 +#$32 +#$33 +#$34 +#$35 +#$36 +#$37 +#$38 +#$39
//  +#$3A +#$3B +#$3C +#$3D +#$3E +#$3F +#$40 +#$40 +#$40 +#$40 +#$40 +#$40;
//
//function EncodeTriplet(const Value: AnsiString; Delimiter: AnsiChar;
//Specials: TSpecials): AnsiString;
//var
//  n, l: Integer;
//  s: AnsiString;
//  c: AnsiChar;
//begin
//  SetLength(Result, Length(Value) * 3);
//  l := 1;
//  for n := 1 to Length(Value) do
//  begin
//    c := Value[n];
//    if c in Specials then
//    begin
//      Result[l] := Delimiter;
//      Inc(l);
//      s := IntToHex(Ord(c), 2);
//      Result[l] := s[1];
//      Inc(l);
//      Result[l] := s[2];
//      Inc(l);
//    end
//    else
//    begin
//      Result[l] := c;
//      Inc(l);
//    end;
//  end;
//  Dec(l);
//  SetLength(Result, l);
//end;
//
//{==============================================================================}
//
//function EncodeQuotedPrintable(const Value: AnsiString): AnsiString;
//begin
//Result := EncodeTriplet(Value, '=', ['='] + NonAsciiChar);
//end;
//
//
//function HexToInt(AString: string): Integer;
//begin
//  if AString='' then
//    Result:=0
//  else if AString[1] = '$' then
//    Result := StrToInt(AString)
//  else
//    Result := StrToInt('$' + AString);
//end;



//{ DecodeQuotedPrintable }
//
//function DecodeQuotedPrintableStream(InputStream:TStream;OutputStream:TStream):Integer;
//var
//  I, O: Integer;
//  S: String;
//  Str: AnsiString;
//  ResultStr:AnsiString;
//begin
//  SetLength(Str,InputStream.Size);
//  InputStream.Read(Str[1],InputStream.Size);
//
//  ResultStr := '';
//  I := 1;
//  while I<=Length(Str) do
//  begin
//    if (Str[I]=#10) or (Str[I]=#13) then
//    begin
//      Inc(I);
//    end
//    else
//    begin
//      Break;
//    end;
//  end;
//
//
//  while I<=Length(Str) do
//  begin
//    S := Str[I];
//    Inc(I);
//
//    if S<>'=' then
//    begin
//      ResultStr := ResultStr + S
//    end
//    else
//    begin
//      S := '';
//      if (I<Length(Str)) then
//      begin
//        S := Str[I];
//        Inc(I);
//        if (I<Length(Str)) then
//        begin
//          S := S + Str[I];
//          if S<>#13#10 then
//          begin
//            O := HexToInt(S);
//            if (O>0) and (O<255) then
//            begin
//              S := Char(O);
//              ResultStr := ResultStr + S;
//            end;
//          end;
//          Inc(I);
//        end
//        else
//        begin
//          if not (S[1] in [#13, #10]) then
//          begin
//            ResultStr := ResultStr + '=';
//          end;
//          Dec(I);
//        end;
//      end
//      else
//      begin
//        ResultStr := ResultStr + '=';
//      end;
//    end;
//  end;
//
//  OutputStream.Write(ResultStr[1],Length(ResultStr));
//  Result:=1;
//end;

//function DecodeQuotedPrintableStream(Str:TStream): TStream;
//var
//  O: Integer;
//  S: AnsiChar;
//begin
//  Result := TMemoryStream.Create;
//  Str.Position:=0;
//  while I<=Str.Size do
//  begin
//  Str.Read(S,1);
//  if S<>'=' then
//  begin
//  Result.Write(S,1);
//  end
//  else
//  begin
//  S := '';
//  if (Str.Position<Str.Size) then
//  begin
//  Result.Write(S,1);
//  if (Str.Position<Str.Size) then
//  begin
//  S := S + Str[I];
//  if S<>#13#10 then
//  begin
//  O := HexToInt(S);
//  if (O>0) and (O<255) then
//  begin
//  S := AnsiChar(O);
//  Result := Result + S;
//  end;
//  end;
//  Inc(I);
//  end else
//  begin
//  if not (S[1] in [#13, #10]) then
//  Result := Result + '=';
//  Dec(I);
//  end;
//  end else
//  Result := Result + '=';
//  end;
//  end;
//end;
//
//function FindInTable(CSource:char):integer;
//begin
//result:=Pos(string(CSource),Base64CodeTable)-1;
//end;



end.



