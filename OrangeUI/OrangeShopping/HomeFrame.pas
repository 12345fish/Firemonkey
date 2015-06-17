unit HomeFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uUIFunction, uSkinFireMonkeyControl, uSkinFireMonkeyPanel,
  uSkinItems,
  uSkinListBoxType,
  ProductInfoFrame,
  KindProductListFrame,
  uSkinFireMonkeyLabel, uSkinFireMonkeyImage, uSkinFireMonkeyScrollControl,
  uSkinFireMonkeyListBox, uSkinFireMonkeyItemDesignerPanel, uSkinImageList,
  uSkinFireMonkeyButton, uSkinButtonType, uSkinFireMonkeyImageListViewer,
  uDrawPicture;

type
  TFrameHome = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    imgSearch: TSkinFMXImage;
    imgLogo: TSkinFMXImage;
    lbHome: TSkinFMXListBox;
    ItemHeader: TSkinFMXItemDesignerPanel;
    imgPlayer: TSkinFMXImageListViewer;
    imglistPlayer: TSkinImageList;
    bgIndicator: TSkinFMXButtonGroup;
    ItemFooter: TSkinFMXItemDesignerPanel;
    imglistLeft: TSkinImageList;
    pnlFooterHeader: TSkinFMXPanel;
    imglistRight: TSkinImageList;
    pnlFooterSign: TSkinFMXPanel;
    lblFooterCaption: TSkinFMXLabel;
    pnlFooterDevide: TSkinFMXPanel;
    ItemSearchBar: TSkinFMXItemDesignerPanel;
    imgSearchBarRightTop: TSkinFMXImage;
    imgSearchBarLeft: TSkinFMXImage;
    imgSearchBarRightBottom: TSkinFMXImage;
    ItemDefault: TSkinFMXItemDesignerPanel;
    imglistProduct: TSkinImageList;
    imgDefaultIcon: TSkinFMXImage;
    SkinFMXPanel4: TSkinFMXPanel;
    lblDefaultCaption: TSkinFMXLabel;
    lblDefaultPrice: TSkinFMXLabel;
    imgDefaultFrom: TSkinFMXImage;
    ItemLoadNextData: TSkinFMXItemDesignerPanel;
    btnLoadNextData: TSkinFMXButton;
    tmrLoading: TTimer;
    procedure btnLoadNextDataClick(Sender: TObject);
    procedure tmrLoadingTimer(Sender: TObject);
    procedure imgPlayerStayClick(Sender: TObject);
    procedure imgSearchBarLeftStayClick(Sender: TObject);
    procedure imgSearchBarRightTopStayClick(Sender: TObject);
    procedure imgSearchBarRightBottomStayClick(Sender: TObject);
    procedure lbHomeClickItem(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    { Public declarations }
  end;

var
  GlobalHomeFrame:TFrameHome;

implementation

{$R *.fmx}

uses
  MainForm,
  MainFrame;

{ TFrameHome }

procedure TFrameHome.btnLoadNextDataClick(Sender: TObject);
begin
  //���ڼ���
  if not tmrLoading.Enabled then
  begin
    tmrLoading.Enabled:=True;
    btnLoadNextData.Caption:='��������...';
  end;
end;

constructor TFrameHome.Create(AOwner: TComponent);
begin
  inherited;

  Self.lbHome.VertScrollBar.Properties.ControlGestureManager.IsUseDecideFirstMouseMoveKind:=True;
  Self.lbHome.VertScrollBar.Properties.ControlGestureManager.DecideFirstMouseMoveKindPrecision:=30;


//  Self.lbHome.HorzScrollBar.Properties.ControlGestureManager.IsUseDecideFirstMouseMoveKind:=True;
//  Self.lbHome.HorzScrollBar.Properties.ControlGestureManager.DecideFirstMouseMoveKindPrecision:=30;


  tmrLoadingTimer(Self);

end;

procedure TFrameHome.imgPlayerStayClick(Sender: TObject);
begin
  HideFrame(GlobalMainFrame);

  //��ʾ��Ʒ�б����
  ShowFrame(TFrame(GlobalKindProductListFrame),TFrameKindProductList,frmMain,nil,nil,nil,Application);
  GlobalKindProductListFrame.FrameHistroy:=CurrentFrameHistroy;

end;

procedure TFrameHome.imgSearchBarLeftStayClick(Sender: TObject);
begin

  HideFrame(GlobalMainFrame);

  //��ʾ��Ʒ�б����
  ShowFrame(TFrame(GlobalKindProductListFrame),TFrameKindProductList,frmMain,nil,nil,nil,Application);
  GlobalKindProductListFrame.FrameHistroy:=CurrentFrameHistroy;
end;

procedure TFrameHome.imgSearchBarRightBottomStayClick(Sender: TObject);
begin
  HideFrame(GlobalMainFrame);

  //��ʾ��Ʒ�б����
  ShowFrame(TFrame(GlobalKindProductListFrame),TFrameKindProductList,frmMain,nil,nil,nil,Application);
  GlobalKindProductListFrame.FrameHistroy:=CurrentFrameHistroy;

end;

procedure TFrameHome.imgSearchBarRightTopStayClick(Sender: TObject);
begin
  HideFrame(GlobalMainFrame);

  //��ʾ��Ʒ�б����
  ShowFrame(TFrame(GlobalKindProductListFrame),TFrameKindProductList,frmMain,nil,nil,nil,Application);
  GlobalKindProductListFrame.FrameHistroy:=CurrentFrameHistroy;

end;

procedure TFrameHome.lbHomeClickItem(Sender: TObject);
begin
  if TSkinItem(Sender).ItemType=sitDefault then
  begin
    HideFrame(GlobalMainFrame);

    //��ʾ��Ʒ��Ϣ����
    ShowFrame(TFrame(GlobalProductInfoFrame),TFrameProductInfo,frmMain,nil,nil,nil,Application);
    GlobalProductInfoFrame.FrameHistroy:=CurrentFrameHistroy;
  end;
end;

procedure TFrameHome.tmrLoadingTimer(Sender: TObject);
var
  I: Integer;
  AListBoxItem:TSkinListBoxItem;
begin
  Self.tmrLoading.Enabled:=False;
  btnLoadNextData.Properties.IsPushed:=False;
  btnLoadNextData.Caption:='��ʾ��20��';


  Self.lbHome.Properties.Items.BeginUpdate;
  try
    for I := 1 to 20 do
    begin
      AListBoxItem:=Self.lbHome.Properties.Items.Insert(Self.lbHome.Properties.Items.Count-1);

      AListBoxItem.Caption:='��������'+IntToStr(I);
      AListBoxItem.Detail:='��563($90.00)';
      AListBoxItem.Icon.StaticImageIndex:=I Mod 12;

    end;
  finally
    Self.lbHome.Properties.Items.EndUpdate;
  end;

end;

end.

