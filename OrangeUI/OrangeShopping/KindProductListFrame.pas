unit KindProductListFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  uUIFunction,
  uSkinItems,
  uSkinListBoxType,
  ProductInfoFrame, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uSkinFireMonkeyControl, uSkinFireMonkeyPanel, uSkinFireMonkeyButton,
  uSkinImageList, uSkinFireMonkeyLabel, uSkinButtonType,
  uSkinFireMonkeyImageListViewer, uSkinFireMonkeyItemDesignerPanel,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyListBox, uSkinFireMonkeyImage,
  uDrawPicture, uSkinFireMonkeyVirtualList;

type
  TFrameKindProductList = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    SkinFMXPanel2: TSkinFMXPanel;
    imglistState: TSkinImageList;
    btnReturn: TSkinFMXButton;
    lbProductList: TSkinFMXListBox;
    ItemHeader: TSkinFMXItemDesignerPanel;
    ItemDefault: TSkinFMXItemDesignerPanel;
    imgDefaultIcon: TSkinFMXImage;
    SkinFMXPanel4: TSkinFMXPanel;
    lblDefaultCaption: TSkinFMXLabel;
    lblDefaultPrice: TSkinFMXLabel;
    imgDefaultFrom: TSkinFMXImage;
    ItemLoadNextData: TSkinFMXItemDesignerPanel;
    btnLoadNextData: TSkinFMXButton;
    tmrLoading: TTimer;
    imglistProduct: TSkinImageList;
    SkinFMXImage1: TSkinFMXImage;
    procedure btnReturnClick(Sender: TObject);
    procedure btnLoadNextDataClick(Sender: TObject);
    procedure tmrLoadingTimer(Sender: TObject);
    procedure lbProductListClickItem(Sender: TObject);
  private
    { Private declarations }
  public
    FrameHistroy:TFrameHistroy;
    constructor Create(AOwner:TComponent);override;
    { Public declarations }
  end;


var
  GlobalKindProductListFrame:TFrameKindProductList;

implementation

{$R *.fmx}

uses
  MainForm,MainFrame;

procedure TFrameKindProductList.btnLoadNextDataClick(Sender: TObject);
begin
  //���ڼ���
  if not tmrLoading.Enabled then
  begin
    tmrLoading.Enabled:=True;
    btnLoadNextData.Caption:='��������...';
  end;
end;

procedure TFrameKindProductList.btnReturnClick(Sender: TObject);
begin
  HideFrame(Self);
  ReturnFrame(FrameHistroy);

end;

constructor TFrameKindProductList.Create(AOwner: TComponent);
begin
  inherited;

  tmrLoadingTimer(Self);

end;

procedure TFrameKindProductList.lbProductListClickItem(Sender: TObject);
begin
  if TSkinItem(Sender).ItemType=sitDefault then
  begin
    //�鿴��Ʒ��Ϣ
    HideFrame(Self);

    //��ʾ��Ʒ��Ϣ����
    ShowFrame(TFrame(GlobalProductInfoFrame),TFrameProductInfo,frmMain,nil,nil,nil,Application);
    GlobalProductInfoFrame.FrameHistroy:=CurrentFrameHistroy;

  end;
end;

procedure TFrameKindProductList.tmrLoadingTimer(Sender: TObject);
var
  I: Integer;
  AListBoxItem:TSkinListBoxItem;
begin
  Self.tmrLoading.Enabled:=False;
  btnLoadNextData.Properties.IsPushed:=False;
  btnLoadNextData.Caption:='��ʾ��20��';


  Self.lbProductList.Properties.Items.BeginUpdate;
  try
    for I := 1 to 20 do
    begin
      AListBoxItem:=Self.lbProductList.Properties.Items.Insert(Self.lbProductList.Properties.Items.Count-1);

      AListBoxItem.Caption:='��������'+IntToStr(I);
      AListBoxItem.Detail:='��563($90.00)';
      AListBoxItem.Icon.StaticImageIndex:=I Mod 12;

    end;
  finally
    Self.lbProductList.Properties.Items.EndUpdate;
  end;
end;

end.
