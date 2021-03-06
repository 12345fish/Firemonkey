unit dmMain;

interface

uses
  System.SysUtils, System.Classes, Data.Bind.GenData, IPPeerClient,
  IPPeerServer, System.Tether.Manager, System.Tether.AppProfile,
  Data.Bind.Components, Data.Bind.ObjectScope, Fmx.Bind.GenData,
  unitGamePlayer, System.Actions, FMX.ActnList;

type
  TTetheringStatus = class
  private
    FStatus: string;
  public
    property Status : string read FStatus write FStatus;
  end;

  TdataMain = class(TDataModule)
    pbsPlayer: TPrototypeBindSource;
    pbsScoreboard: TPrototypeBindSource;
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    pbsStatus: TPrototypeBindSource;
    ActionList1: TActionList;
    actGetScores: TAction;
    procedure TetheringManager1RequestManagerPassword(const Sender: TObject;
      const RemoteIdentifier: string; var Password: string);
    procedure TetheringManager1RemoteManagerShutdown(const Sender: TObject;
      const ManagerIdentifier: string);
    procedure TetheringManager1EndAutoConnect(Sender: TObject);
    procedure pbsStatusCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure pbsPlayerCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure TetheringAppProfile1ResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure pbsScoreboardCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
  private
    { Private declarations }
    FScoreBoard : TGamePlayerList;
    FStatusObj : TTetheringStatus;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure CheckConnections;
    procedure ConnectToScoreboard;
    procedure SendScore;
  end;

var
  dataMain: TdataMain;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses Rest.JSON, FMX.Dialogs;

{$R *.dfm}

procedure TdataMain.CheckConnections;
var
  I: Integer;
  ConnectedProfiles : String;
begin
  if TetheringManager1.RemoteProfiles.Count > 0 then
  begin
    for I := 0 to TetheringManager1.RemoteProfiles.Count - 1 do
    begin
      ConnectedProfiles := ConnectedProfiles + ' - ' + TetheringManager1.RemoteProfiles.Items[I].ProfileText;
    end;
    if Assigned(FStatusObj) then
      FStatusObj.Status := 'Working with :' + ConnectedProfiles;
    actGetScores.Execute;
  end
  else
  begin
    if Assigned(FStatusObj) then
      FStatusObj.Status := 'You are not connected';
  end;
  pbsStatus.ApplyUpdates;
end;


procedure TdataMain.ConnectToScoreboard;
begin
  TetheringManager1.AutoConnect;
  CheckConnections;
end;

constructor TdataMain.Create(AOwner: TComponent);
begin
  FScoreBoard := TGamePlayerList.Create(True);
  FStatusObj := TTetheringStatus.Create;
  inherited Create(AOwner);
end;

destructor TdataMain.destroy;
begin
  inherited;
end;

procedure TdataMain.pbsPlayerCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter := TObjectBindSourceAdapter<TGamePlayer>.Create(Self,TGamePlayer.Create('Annonymous'),True);
end;

procedure TdataMain.pbsScoreboardCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter := TListBindSourceAdapter<TGamePlayer>.Create(Self,FScoreBoard,True);
end;

procedure TdataMain.pbsStatusCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  ABindSourceAdapter := TObjectBindSourceAdapter<TTetheringStatus>.Create(Self,FStatusObj,True);
end;

procedure TdataMain.SendScore;
begin
  if TetheringManager1.RemoteProfiles.Count > 0 then
    TetheringAppProfile1.SendString(TetheringManager1.RemoteProfiles.Items[0], 'TGamePlayer', TJson.ObjectToJsonString(TGamePlayer(pbsPlayer.InternalAdapter.Current)));
end;

procedure TdataMain.TetheringAppProfile1ResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
var
  TopPlayers: TStringList;
  PlayerObj: TGamePlayer;
  PlayerJSON : string;
begin
  pbsScoreboard.Active := False;
  FScoreBoard.Clear;
  TopPlayers := TStringList.Create;
  try
    TopPlayers.Delimiter := Data_Delimiter;
    TopPlayers.DelimitedText := AResource.Value.AsString;
    for PlayerJSON in TopPlayers do begin
      PlayerObj := TJson.JsonToObject<TGamePlayer>(PlayerJSON);
      FScoreBoard.Add(PlayerObj);
    end;
  finally
    TopPlayers.Free;
  end;
  pbsScoreboard.Active := True;
end;

procedure TdataMain.TetheringManager1EndAutoConnect(Sender: TObject);
begin
  CheckConnections;
end;

procedure TdataMain.TetheringManager1RemoteManagerShutdown(
  const Sender: TObject; const ManagerIdentifier: string);
begin
  CheckConnections;
end;

procedure TdataMain.TetheringManager1RequestManagerPassword(
  const Sender: TObject; const RemoteIdentifier: string; var Password: string);
begin
  Password := '1234';
end;

end.
