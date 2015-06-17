unit MainForm;

interface

uses
  System.SysUtils,uFuncCommon, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  uTimerTask,
  uFileCommon,
  uInterfaceCollection,
  uInterfaceData,
  uInterfaceClass,
  uInterfaceManager,
  uBaseLog,
  uUIFunction,
  NewsHomeFrame;

type
  TfrmMain = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}


procedure TfrmMain.FormShow(Sender: TObject);
begin

  //�����û�
  GlobalInterfaceManager.UserName:='czadmin';

  //��ʾ����������
  ShowFrame(TFrame(GlobalNewsHomeFrame),TFrameNewsHome,frmMain,nil,nil,nil,Application);
  GlobalNewsHomeFrame.FrameHistroy:=CurrentFrameHistroy;

end;



end.

