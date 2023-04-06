unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, System.Notification;

type
  TfrmMain = class(TForm)
    btnSendNot: TButton;
    btnSendScheduleNot: TButton;
    btnCancelSchedule: TButton;
    btnCancelAll: TButton;
    memLog: TMemo;
    NotificationCenter: TNotificationCenter;
    procedure NotificationCenterReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure btnSendNotClick(Sender: TObject);
    procedure btnSendScheduleNotClick(Sender: TObject);
    procedure btnCancelScheduleClick(Sender: TObject);
    procedure btnCancelAllClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.btnCancelAllClick(Sender: TObject);
begin
  // cancelar todas las notificaciones.
  if NotificationCenter.Supported then
  begin
    // Si hay notificaciones pendientes
    NotificationCenter.CancelAll;
  end;
end;

procedure TfrmMain.btnCancelScheduleClick(Sender: TObject);
begin
  // si hay notificaciones pendientes
  if NotificationCenter.Supported then
  begin
    NotificationCenter.CancelNotification('MyNotification');
  end;
end;

procedure TfrmMain.btnSendNotClick(Sender: TObject);
var
  Notification: TNotification;
begin
  { verify if the service is actually supported }
  Notification := NotificationCenter.CreateNotification;
  try
    Notification.Name := 'MyNotification';
    Notification.AlertBody := 'Delphi for Mobile is here!';
    Notification.FireDate := Now;
    { Send notification in Notification Center }
    NotificationCenter.PresentNotification(Notification);
  finally
    Notification.DisposeOf;
  end;
end;

procedure TfrmMain.btnSendScheduleNotClick(Sender: TObject);
var
  Notification: TNotification;
begin
  { verify if the service is actually supported }
  Notification := NotificationCenter.CreateNotification;
  try
    Notification.Name := 'MyNotification';
    Notification.AlertBody :=
      'Notificación desde Delphi for Mobile (Scheduled 10 sec)';
    { Fired in 10 second }
    Notification.FireDate := Now + EncodeTime(0, 0, 10, 0);
    { Send notification in Notification Center }
    NotificationCenter.ScheduleNotification(Notification);
  finally
    Notification.DisposeOf;
  end;
end;

procedure TfrmMain.NotificationCenterReceiveLocalNotification(Sender: TObject;
  ANotification: TNotification);
begin
  memLog.Lines.Add(ANotification.AlertBody);
end;

end.
