unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  uBaseList,
  uFileCommon,
  uDrawCanvas,
  uSkinItems,
  uFuncCommon,
  uSkinPicture,
  uDrawEngine,
  uSkinListBoxType,

  uSkinFireMonkeyImage, uSkinFireMonkeyButton, uSkinFireMonkeyLabel,
  uSkinFireMonkeyPanel, uSkinFireMonkeyItemDesignerPanel,
  uSkinFireMonkeyControl, uSkinFireMonkeyScrollControl, uSkinFireMonkeyListBox,
  uDrawPicture, uSkinImageList, uSkinFireMonkeyVirtualList;

type
  TMyData=class
  public
    //���ͼƬ�ļ�(�浽ListBoxItem.Icon����)
    LeftPicFileName:String;
    //����ͼƬ�ļ�
    RightTopPicFileName:String;
    RightTopPicture:TSkinPicture;
    //����ͼƬ�ļ�
    RightBottomPicFileName:String;
    RightBottomPicture:TSkinPicture;
  public
    destructor Destroy;override;
  end;


  TfrmMain = class(TForm)
    lbExample: TSkinFMXListBox;
    ItemItem: TSkinFMXItemDesignerPanel;
    imgSearchBarLeft: TSkinFMXImage;
    imgSearchBarRightBottom: TSkinFMXImage;
    imgSearchBarRightTop: TSkinFMXImage;
    imglistRightTop: TSkinImageList;
    imglistRightBottom: TSkinImageList;
    imglistLeft: TSkinImageList;
    procedure lbExamplePrepareDrawItem(Sender: TObject; Canvas: TDrawCanvas;
      ItemDesignerPanel: TSkinFMXItemDesignerPanel; Item: TSkinItem;
      ItemRect: TRect);
  private
    FMyDataList:TBaseList;
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

{ TfrmMain }

constructor TfrmMain.Create(AOwner: TComponent);
var
  AMyData:TMyData;
  AListItem:TSkinListBoxItem;
  I: Integer;
begin
  inherited;
  FMyDataList:=TBaseList.Create;


  //�Ȱ�ImageList�е�ͼƬ���浽�ļ��У���ΪDEMO����
  for I := 0 to Self.imglistLeft.PictureList.Count-1 do
  begin
    imglistLeft.PictureList[I].SaveToFile(uFileCommon.GetApplicationPath+'Left_'+IntToStr(I)+'.png');
  end;
  for I := 0 to Self.imglistRightTop.PictureList.Count-1 do
  begin
    imglistRightTop.PictureList[I].SaveToFile(uFileCommon.GetApplicationPath+'RightTop_'+IntToStr(I)+'.png');
  end;
  for I := 0 to Self.imglistRightBottom.PictureList.Count-1 do
  begin
    imglistRightBottom.PictureList[I].SaveToFile(uFileCommon.GetApplicationPath+'RightBottom_'+IntToStr(I)+'.png');
  end;



  //�����Զ������ݰ�ListItem
  Self.lbExample.Properties.Items.BeginUpdate;
  try
    for I := 0 to 12 do
    begin

      AListItem:=Self.lbExample.Properties.Items.Add;


      //�����Զ�������
      AMyData:=TMyData.Create;
      AMyData.LeftPicFileName:='Left_'+IntToStr(I)+'.png';
      AMyData.RightTopPicFileName:='RightTop_'+IntToStr(I)+'.png';
      AMyData.RightBottomPicFileName:='RightBottom_'+IntToStr(I)+'.png';


      //���Զ������󶨵�ListBoxItem��Data������
      AListItem.DataObject:=AMyData;

    end;
  finally
    Self.lbExample.Properties.Items.EndUpdate();
  end;

end;

destructor TfrmMain.Destroy;
begin
  FreeAndNil(FMyDataList);
  inherited;
end;

procedure TfrmMain.lbExamplePrepareDrawItem(Sender: TObject;
  Canvas: TDrawCanvas; ItemDesignerPanel: TSkinFMXItemDesignerPanel;
  Item: TSkinItem; ItemRect: TRect);
var
  AMyData:TMyData;
begin
  //�����¼�
  AMyData:=TMyData(Item.DataObject);

  //�ж���û�м��ع�ͼƬ��
  //������ع��Ͳ��ټ���
  //���û�м��أ���ô�ͼ���һ��
  if Item.Icon.IsEmpty then
  begin
    //����
    Item.Icon.LoadFromFile(uFileCommon.GetApplicationPath+AMyData.LeftPicFileName);
  end;

  if AMyData.RightTopPicture=nil then
  begin
    AMyData.RightTopPicture:=uDrawEngine.CreateCurrentEngineSkinPicture;
    AMyData.RightTopPicture.LoadFromFile(uFileCommon.GetApplicationPath+AMyData.RightTopPicFileName);
  end;

  if AMyData.RightBottomPicture=nil then
  begin
    AMyData.RightBottomPicture:=uDrawEngine.CreateCurrentEngineSkinPicture;
    AMyData.RightBottomPicture.LoadFromFile(uFileCommon.GetApplicationPath+AMyData.RightBottomPicFileName);
  end;


  Self.imgSearchBarLeft.Properties.Picture.PictureDrawType:=pdtReference;
  Self.imgSearchBarLeft.Properties.Picture.RefPicture:=Item.Icon;

  Self.imgSearchBarRightTop.Properties.Picture.PictureDrawType:=pdtReference;
  Self.imgSearchBarRightTop.Properties.Picture.RefPicture:=AMyData.RightTopPicture;

  Self.imgSearchBarRightBottom.Properties.Picture.PictureDrawType:=pdtReference;
  Self.imgSearchBarRightBottom.Properties.Picture.RefPicture:=AMyData.RightBottomPicture;


end;

{ TMyData }

destructor TMyData.Destroy;
begin
  //����ͼƬ�ļ�
  FreeAndNil(RightTopPicture);
  //����ͼƬ�ļ�
  FreeAndNil(RightBottomPicture);

  inherited;
end;

end.
