unit MainForm;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  IdContext,
  IdBaseComponent,
  IdComponent,
  IdCustomTCPServer,
  IdTCPServer,
  IdCmdTCPServer,
  IdExplicitTLSClientServerBase,
  IdFTPServer,
  IdReply,
  IdFTPListOutput,
  uFileManage,
  uFileCommon,
  uUIFunction,
  HintFrame,
  IdFTPList, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdIPWatch;

type
  TfrmMain = class(TForm)
    IdFTPServer1: TIdFTPServer;
    IdIPWatch1: TIdIPWatch;
    procedure IdFTPServer1UserLogin(ASender: TIdFTPServerContext;
      const AUsername, APassword: string; var AAuthenticated: Boolean);
    procedure IdFTPServer1RemoveDirectory(ASender: TIdFTPServerContext;
      var VDirectory: string);
    procedure IdFTPServer1MakeDirectory(ASender: TIdFTPServerContext;
      var VDirectory: string);
    procedure IdFTPServer1RetrieveFile(ASender: TIdFTPServerContext;
      const AFileName: string; var VStream: TStream);
    procedure IdFTPServer1GetFileSize(ASender: TIdFTPServerContext;
      const AFilename: string; var VFileSize: Int64);
    procedure IdFTPServer1StoreFile(ASender: TIdFTPServerContext;
      const AFileName: string; AAppend: Boolean; var VStream: TStream);
    procedure IdFTPServer1ListDirectory(ASender: TIdFTPServerContext;
      const APath: string; ADirectoryListing: TIdFTPListOutput; const ACmd,
      ASwitches: string);
    procedure IdFTPServer1DeleteFile(ASender: TIdFTPServerContext;
      const APathName: string);
    procedure IdFTPServer1ChangeDirectory(ASender: TIdFTPServerContext;
      var VDirectory: string);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdFTPServer1UserAccount(ASender: TIdFTPServerContext;
      const AUsername, APassword, AAcount: string; var AAuthenticated: Boolean);
    procedure IdFTPServer1CRCFile(ASender: TIdFTPServerContext;
      const AFileName: string; var VStream: TStream);
    procedure IdFTPServer1CompleteDirSize(ASender: TIdFTPServerContext;
      const APathName: string; var VIsAFile: Boolean; var VSpace: Int64);
    procedure IdFTPServer1FileExistCheck(ASender: TIdFTPServerContext;
      const APathName: string; var VExist: Boolean);
    procedure IdFTPServer1RenameFile(ASender: TIdFTPServerContext;
      const ARenameFromFile, ARenameToFile: string);
    procedure IdFTPServer1AfterCommandHandler(ASender: TIdCmdTCPServer;
      AContext: TIdContext);
  private
    FJustStoreFile:Boolean;
    { Private declarations }
  public
    procedure OnReturnFrame(FromFrame:TFrame);
  public
    { Public declarations }
    function ReplaceChars(APath: String): String;
  end;

var
  frmMain: TfrmMain;



implementation

uses
  FileManageFrame;



{$R *.fmx}


procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Width:=320;
  Self.Height:=480;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  //���ظ�Ŀ¼�ļ��б�
  LoadChildFileList(GlobalRootDir);


  //��ʾ�ļ��б����
  ShowFrame(TFrame(GlobalFileManageFrame),TFrameFileManage,frmMain,nil,nil,OnReturnFrame,Application);
  GlobalFileManageFrame.FrameHistroy:=CurrentFrameHistroy;
  GlobalFileManageFrame.LoadFileList(GlobalRootDir);
  CurrentFileManageFrame:=GlobalFileManageFrame;

end;

function TfrmMain.ReplaceChars(APath:String):String;
var
 s:string;
begin
  s := StringReplace(APath, '/', PathDelim, [rfReplaceAll]);
  s := StringReplace(s, '\\', PathDelim, [rfReplaceAll]);
  Result := s;
end;
procedure TfrmMain.IdFTPServer1AfterCommandHandler(ASender: TIdCmdTCPServer;
  AContext: TIdContext);
begin
  //
  if FJustStoreFile then
  begin
    FJustStoreFile:=False;
    //���½���
    if CurrentFileManageFrame<>nil then
    begin
      CurrentFileManageFrame.UpdateFileList;
    end;
  end;
//  AContext.Data
end;

procedure TfrmMain.IdFTPServer1ChangeDirectory(
  ASender: TIdFTPServerContext; var VDirectory: string);
begin
  //���ô����ӿͻ��˵ĵ�ǰĿ¼
  ASender.CurrentDir := VDirectory;
end;

procedure TfrmMain.IdFTPServer1CompleteDirSize(ASender: TIdFTPServerContext;
  const APathName: string; var VIsAFile: Boolean; var VSpace: Int64);
begin
  //
end;

procedure TfrmMain.IdFTPServer1CRCFile(ASender: TIdFTPServerContext;
  const AFileName: string; var VStream: TStream);
begin
  //
end;

procedure TfrmMain.IdFTPServer1ListDirectory(ASender: TIdFTPServerContext;
  const APath: string; ADirectoryListing: TIdFTPListOutput; const ACmd,
  ASwitches: string);
var
  I:Integer;
  FileItem:TFileItem;
  LFTPItem :TIdFTPListItem;
begin
  ADirectoryListing.DirFormat := doUnix;

  FileItem:=TFileItem.Create;
  try
    FileItem.FilePath:=ReplaceChars(FTPRootDir + APath);
    FileItem.FileName:=ExtractFileName(FileItem.FilePath);
    FileItem.FileType:=ftDir;

    LoadChildFileList(FileItem);

    for I := 0 to FileItem.ChildFileList.Count-1 do
    begin
      LFTPItem := ADirectoryListing.Add;
      LFTPItem.FileName := FileItem.ChildFileList[I].FileName;
      LFTPItem.Size := FileItem.ChildFileList[I].Size;
      LFTPItem.ModifiedDate := FileItem.ChildFileList[I].FileDate;
      if FileItem.ChildFileList[I].FileType = ftDir then
      begin
        LFTPItem.ItemType   := ditDirectory;
      end
      else
      begin
        LFTPItem.ItemType   := ditFile;
      end;
    end;

  finally
    FileItem.Free;
  end;
end;




procedure TfrmMain.IdFTPServer1StoreFile(ASender: TIdFTPServerContext;
  const AFileName: string; AAppend: Boolean; var VStream: TStream);
begin
  //�����ļ�
  if not Aappend then
  begin
    VStream := TFileStream.Create(ReplaceChars(FTPRootDir+AFilename),fmCreate);
  end
  else
  begin
    VStream := TFileStream.Create(ReplaceChars(FTPRootDir+AFilename),fmOpenWrite);
  end;

  FJustStoreFile:=True;
//  //���½���
//  if CurrentFileManageFrame<>nil then
//  begin
//    CurrentFileManageFrame.UpdateFileList;
//  end;
end;

procedure TfrmMain.IdFTPServer1MakeDirectory(ASender: TIdFTPServerContext;
  var VDirectory: string);
begin
  //ɾ���ļ���
  if ForceDirectories(ReplaceChars(FTPRootDir + VDirectory)) then
  begin
    //���½���
    if CurrentFileManageFrame<>nil then
    begin
      CurrentFileManageFrame.UpdateFileList;
    end;
  end;
end;

procedure TfrmMain.IdFTPServer1RemoveDirectory(ASender: TIdFTPServerContext;
  var VDirectory: string);
Var
  LFile : String;
begin
  //ɾ������Ŀ¼
  LFile := ReplaceChars(FTPRootDir + VDirectory);
  RemoveDir(LFile);
  //���½���
  if CurrentFileManageFrame<>nil then
  begin
    CurrentFileManageFrame.UpdateFileList;
  end;
end;

procedure TfrmMain.IdFTPServer1RenameFile(ASender: TIdFTPServerContext;
  const ARenameFromFile, ARenameToFile: string);
begin
  //
end;

procedure TfrmMain.IdFTPServer1DeleteFile(ASender: TIdFTPServerContext;
  const APathName: string);
begin
  //ɾ��ָ���ļ�
  DeleteFile(ReplaceChars(FTPRootDir+ASender.CurrentDir+PathDelim+APathname));
  //���½���
  if CurrentFileManageFrame<>nil then
  begin
    CurrentFileManageFrame.UpdateFileList;
  end;
end;



procedure TfrmMain.IdFTPServer1FileExistCheck(ASender: TIdFTPServerContext;
  const APathName: string; var VExist: Boolean);
begin
  //
end;

procedure TfrmMain.IdFTPServer1GetFileSize(ASender: TIdFTPServerContext;
  const AFilename: string; var VFileSize: Int64);
Var
  LFile : String;
begin
  LFile := ReplaceChars( FTPRootDir + AFilename );
  try
    If FileExists(LFile) then
    begin
      VFileSize :=  GetSizeOfFile(LFile);
    end
    else
    begin
      VFileSize := 0;
    end;
  except
    VFileSize := 0;
  end;
end;

procedure TfrmMain.IdFTPServer1RetrieveFile(ASender: TIdFTPServerContext;
  const AFileName: string; var VStream: TStream);
begin
  //��ͻ��˴����ļ�
  VStream := TFileStream.Create(ReplaceChars(FTPRootDir+AFilename),fmOpenRead);
end;

procedure TfrmMain.IdFTPServer1UserAccount(ASender: TIdFTPServerContext;
  const AUsername, APassword, AAcount: string; var AAuthenticated: Boolean);
begin
  AAuthenticated:=True;
end;

procedure TfrmMain.IdFTPServer1UserLogin(ASender: TIdFTPServerContext;
  const AUsername, APassword: string; var AAuthenticated: Boolean);
begin
  AAuthenticated := True;
end;




procedure TfrmMain.OnReturnFrame(FromFrame: TFrame);
begin
end;

end.
