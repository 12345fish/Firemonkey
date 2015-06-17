unit ViewPictureListFrame;

interface

uses
  System.SysUtils,uFuncCommon, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uSkinFireMonkeyButton, uSkinFireMonkeyControl, uSkinFireMonkeyPanel,
  uSkinItems,
  uUIFunction,
  uDrawCanvas,
  uBaseList,
  uBaseLog,
//  uPublic,
  Math,
  uDrawEngine,
  uSkinPicture,
  uDrawPicture,
//  MessageBoxFrame,
//  SelectListFrame,
  uSkinListBoxType,
  uSkinListViewType,
//  uInterfaceData,
//  PictureCommentFrame,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyListBox, uSkinFireMonkeyCheckBox,
  uSkinFireMonkeyLabel, uSkinFireMonkeyImage, uSkinFireMonkeyItemDesignerPanel,
  uSkinFireMonkeyListView, uSkinFireMonkeyImageListPlayer, uSkinImageList, uSkinFireMonkeyImageListViewer, uSkinAnimator, uSkinButtonType;

type
  TFrameViewPictureList = class(TFrame)
    imglistPlayer: TSkinImageList;
    imgPlayer: TSkinFMXImageListViewer;
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    cmaToolBar: TSkinControlMoveAnimator;
    cmaBottomBar: TSkinControlMoveAnimator;
    pnlBottomBar: TSkinFMXPanel;
    bgIndicator: TSkinFMXButtonGroup;
    procedure btnReturnClick(Sender: TObject);
    procedure btnViewPriorClick(Sender: TObject);
    procedure btnViewNextClick(Sender: TObject);
    procedure imgPlayerImageListSwitchEnd(Sender: TObject);
    procedure cmaToolBarAnimate(Sender: TObject);
    procedure btnShowBarClick(Sender: TObject);
    procedure btnHideBarClick(Sender: TObject);
    procedure cmaToolBarAnimateBegin(Sender: TObject);
    procedure cmaToolBarAnimateEnd(Sender: TObject);
    procedure cmaBottomBarAnimate(Sender: TObject);
    procedure cmaBottomBarAnimateBegin(Sender: TObject);
    procedure cmaBottomBarAnimateEnd(Sender: TObject);
    procedure imgPlayerStayClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure imgPlayerResize(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  public
    FrameHistroy:TFrameHistroy;
    function GetCurrentImageIndex:Integer;
    function GetCurrentImage:TSkinPicture;
  public
    BarVisible:Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Private declarations }
  public
    procedure ShowPicture(AIndex:Integer);
    { Public declarations }
  end;

var
  GlobalViewPictureListFrame:TFrameViewPictureList;


implementation

{$R *.fmx}


procedure TFrameViewPictureList.btnDelClick(Sender: TObject);
begin
  //
end;

procedure TFrameViewPictureList.btnHideBarClick(Sender: TObject);
begin
  BarVisible:=False;
  Self.cmaToolBar.GoBackward;
  Self.cmaBottomBar.GoForward;
end;

procedure TFrameViewPictureList.btnReturnClick(Sender: TObject);
begin
//  Self.imglistPlayer.PictureList.Clear(False);
//
//  HideFrame(Self);
//  ReturnFrame(FrameHistroy);
end;

constructor TFrameViewPictureList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  BarVisible:=True;
  Self.pnlToolBar.Align:=TAlignLayout.Top;
  Self.pnlBottomBar.Align:=TAlignLayout.Bottom;
//  btnShowBarClick(Self);
end;

destructor TFrameViewPictureList.Destroy;
begin
  Self.imglistPlayer.PictureList.Clear(False);
  inherited Destroy;
end;

procedure TFrameViewPictureList.FrameResize(Sender: TObject);
begin
  Self.bgIndicator.Position.Y:=Height-30;
end;

function TFrameViewPictureList.GetCurrentImage: TSkinPicture;
begin
  Result:=Self.imgPlayer.Properties.Picture.SkinImageList.PictureList[GetCurrentImageIndex];
end;

function TFrameViewPictureList.GetCurrentImageIndex: Integer;
begin
  Result:=Self.imgPlayer.Properties.Picture.ImageIndex;
end;

procedure TFrameViewPictureList.imgPlayerImageListSwitchEnd(Sender: TObject);
begin
  ShowPicture(Self.imgPlayer.Properties.Picture.ImageIndex);
end;

procedure TFrameViewPictureList.imgPlayerResize(Sender: TObject);
begin
  bgIndicator.Left:=(Self.imgPlayer.WidthInt-bgIndicator.WidthInt) div 2;
end;

procedure TFrameViewPictureList.imgPlayerStayClick(Sender: TObject);
begin
  if BarVisible then
  begin
    Self.btnHideBarClick(Sender);
  end
  else
  begin
    Self.btnShowBarClick(Sender);
  end;
end;

procedure TFrameViewPictureList.ShowPicture(AIndex: Integer);
begin
  //ָ����ǰ��ʾ��ͼƬ�±�
  Self.imgPlayer.Properties.Picture.ImageIndex:=AIndex;
  //��Ƭ��
  Self.pnlToolBar.Caption:='��Ƭ'+'('+IntToStr(AIndex+1)+'/'+IntToStr(Self.imglistPlayer.Count)+')';
end;

procedure TFrameViewPictureList.cmaBottomBarAnimate(Sender: TObject);
begin
  if Self.cmaBottomBar.DirectionType=TAnimateDirectionType.adtForward then
  begin
    //������
    Self.pnlBottomBar.Opacity:=(1-Self.cmaBottomBar.Progress/100)*0.6;
  end;
  if Self.cmaBottomBar.DirectionType=TAnimateDirectionType.adtBackward then
  begin
    //����ʾ
    Self.pnlBottomBar.Opacity:=(Self.cmaBottomBar.Progress/100)*0.6;
  end;
end;

procedure TFrameViewPictureList.cmaBottomBarAnimateBegin(Sender: TObject);
begin
  Self.pnlBottomBar.Align:=TAlignLayout.None;
  Self.pnlBottomBar.Width:=Width;
  Self.cmaBottomBar.Min:=Ceil(Self.Height)-pnlBottomBar.HeightInt;
  Self.cmaBottomBar.Max:=Ceil(Self.Height);
  if Self.cmaBottomBar.DirectionType=TAnimateDirectionType.adtForward then
  begin
    //����ʾ
    Self.pnlBottomBar.Top:=Self.cmaBottomBar.Min;
  end;
  if Self.cmaBottomBar.DirectionType=TAnimateDirectionType.adtBackward then
  begin
    //������
  end;
end;

procedure TFrameViewPictureList.cmaBottomBarAnimateEnd(Sender: TObject);
begin
  if Self.cmaBottomBar.DirectionType=TAnimateDirectionType.adtForward then
  begin
    //������
//    Self.pnlBottomBar.Top:=
//    Self.pnlBottomBar.Align:=TAlignLayout.None;
  end;
  if Self.cmaBottomBar.DirectionType=TAnimateDirectionType.adtBackward then
  begin
    //����ʾ
    Self.pnlBottomBar.Align:=TAlignLayout.Bottom;
  end;
end;

procedure TFrameViewPictureList.cmaToolBarAnimate(Sender: TObject);
begin
  if Self.cmaToolBar.DirectionType=TAnimateDirectionType.adtForward then
  begin
    //����ʾ
    Self.pnlToolBar.Opacity:=(Self.cmaToolBar.Progress/100)*0.6;
  end;
  if Self.cmaToolBar.DirectionType=TAnimateDirectionType.adtBackward then
  begin
    //������
    Self.pnlToolBar.Opacity:=(1-(Self.cmaToolBar.Progress/100))*0.6;
  end;
end;

procedure TFrameViewPictureList.cmaToolBarAnimateBegin(Sender: TObject);
begin
  Self.pnlToolBar.Align:=TAlignLayout.None;
  Self.pnlToolBar.Width:=Width;
  if Self.cmaToolBar.DirectionType=TAnimateDirectionType.adtForward then
  begin
    //����ʾ
  end;
  if Self.cmaToolBar.DirectionType=TAnimateDirectionType.adtBackward then
  begin
    //������
  end;
end;

procedure TFrameViewPictureList.cmaToolBarAnimateEnd(Sender: TObject);
begin
  if Self.cmaToolBar.DirectionType=TAnimateDirectionType.adtForward then
  begin
    //����ʾ
    Self.pnlToolBar.Align:=TAlignLayout.Top;
//    Self.pnlToolBar.Top:=
  end;
  if Self.cmaToolBar.DirectionType=TAnimateDirectionType.adtBackward then
  begin
    //������
//    Self.pnlToolBar.Align:=TAlignLayout.None;
  end;
end;

procedure TFrameViewPictureList.btnViewPriorClick(Sender: TObject);
begin
  //��һ��
  Self.imgPlayer.Properties.SwitchPrior;
//  if Self.imgPlayer.Properties.Picture.ImageIndex-1<0 then
//  begin
//    //ShowPicture(Self.imgPlayer.Properties.Picture.SkinImageList.Count-1);
//  end
//  else
//  begin
//    ShowPicture(Self.imgPlayer.Properties.Picture.ImageIndex-1);
//  end;
end;

procedure TFrameViewPictureList.btnShowBarClick(Sender: TObject);
begin
  BarVisible:=True;
  Self.cmaToolBar.GoForward;
  Self.cmaBottomBar.GoBackward;
end;

procedure TFrameViewPictureList.btnViewNextClick(Sender: TObject);
begin
  //��һ��
  Self.imgPlayer.Properties.SwitchNext;

//  if Self.imgPlayer.Properties.Picture.ImageIndex+1>
//    Self.imgPlayer.Properties.Picture.SkinImageList.Count-1 then
//  begin
//    ShowPicture(0);
//  end
//  else
//  begin
//    ShowPicture(Self.imgPlayer.Properties.Picture.ImageIndex+1);
//  end;
end;

end.

