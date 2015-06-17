unit NewFolderFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  Math,
  FMX.Dialogs,
  FMX.StdCtrls,
  uFileManage,
  uUIFunction,
  uFileCommon,
  uSkinFireMonkeyLabel,
  uSkinFireMonkeyButton,
  uSkinFireMonkeyControl,
  uSkinFireMonkeyImage, FMX.Edit, uSkinFireMonkeyPanel,
  FMX.Controls.Presentation;

type
  TFrameNewFolder = class(TFrame)
    SkinFMXPanel1: TSkinFMXPanel;
    imgNewFolder: TSkinFMXImage;
    edtFolderName: TEdit;
    ClearEditButton1: TClearEditButton;
    pnlToolBar: TSkinFMXPanel;
    lblFileName: TSkinFMXLabel;
    btnSave: TSkinFMXButton;
    btnCancel: TSkinFMXButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    FParentDir:TFileItem;
    FOnNewFolderCreate: TNotifyEvent;
    { Private declarations }
  public
    FrameHistroy:TFrameHistroy;
    procedure OnReturnFrame(FromFrame:TFrame);
  public
    constructor Create(AOwner:TComponent);override;
    function LoadFile(AParentDir:TFileItem):Boolean;
    property OnNewFolderCreate:TNotifyEvent read FOnNewFolderCreate write FOnNewFolderCreate;
    { Public declarations }
  end;

var
  GlobalNewFolderFrame:TFrameNewFolder;

implementation

{$R *.fmx}

procedure TFrameNewFolder.btnCancelClick(Sender: TObject);
begin
  //ȡ��
  HideFrame(Self);
  ReturnFrame(FrameHistroy);
end;

procedure TFrameNewFolder.btnSaveClick(Sender: TObject);
var
  I: Integer;
  HasSameNameDir:Boolean;
  ANewFoler:TFileItem;
  AFolderName:String;
begin
  AFolderName:=Trim(Self.edtFolderName.Text);

//  if GetValidFileName(AFolderName)<>AFolderName then
//  begin
//    MessageDlg('�ļ������ƴ��ڷǷ��ַ�!',TMsgDlgType.mtInformation,[TMsgDlgBtn.mbOK],0);
//    Exit;
//  end;


  HasSameNameDir:=False;
  for I := 0 to Self.FParentDir.ChildFileList.Count-1 do
  begin
    if SameText(Self.FParentDir.ChildFileList[I].FileName,AFolderName) then
    begin
      HasSameNameDir:=True;
      Break;
    end;
  end;

//  if HasSameNameDir then
//  begin
//    MessageDlg('��ͬ���ļ��������Ѵ���!',TMsgDlgType.mtInformation,[TMsgDlgBtn.mbOK],0);
//    Exit;
//  end;

  //�����ļ���
  if CreateDir(Self.FParentDir.FilePath+AFolderName)
  and DirectoryExists(Self.FParentDir.FilePath+AFolderName) then
  begin


    //����
    ANewFoler:=TFileItem(FParentDir.ChildFileList.Add);
    ANewFoler.FileName:=AFolderName;
    ANewFoler.FileType:=ftDir;
    ANewFoler.FileDate:=Now;
    ANewFoler.FilePath:=FParentDir.FilePath+AFolderName+PathDelim;


    //��ӵ��б�ؼ�
    if Assigned(FOnNewFolderCreate) then
    begin
      FOnNewFolderCreate(ANewFoler);
    end;

    //����
    HideFrame(Self);
    ReturnFrame(FrameHistroy);

    FreeAndNil(GlobalNewFolderFrame);

  end
  else
  begin

//    MessageDlg('�����ļ���ʧ��!',TMsgDlgType.mtError,[TMsgDlgBtn.mbOK],0);
//    Exit;


  end;

end;

constructor TFrameNewFolder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnResize:=FrameResize;
end;

procedure TFrameNewFolder.FrameResize(Sender: TObject);
begin
  imgNewFolder.Left:=Ceil(Width-imgNewFolder.Width) div 2;
  edtFolderName.Position.X:=Ceil(Width-edtFolderName.Width) div 2;
end;

function TFrameNewFolder.LoadFile(AParentDir: TFileItem): Boolean;
begin
  Result:=False;

  FParentDir:=AParentDir;

  lblFileName.Text:=FParentDir.FileName+PathDelim;

  Result:=True;
end;

procedure TFrameNewFolder.OnReturnFrame(FromFrame: TFrame);
begin
end;

end.
