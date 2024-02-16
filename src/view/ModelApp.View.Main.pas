unit ModelApp.View.Main;

interface

uses
  {$IF DEFINED(ANDROID) AND (RTLVersion >= 33)}
    Androidapi.Helpers,
    Androidapi.JNI.Os,
    System.Permissions,
  {$ENDIF}
  FMX.Controls,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.Media,
  FMX.Platform,
  FMX.Types,
  FMX.Layouts,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.FMXUI.Wait,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Async,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Pool,
  FireDAC.UI.Intf,
  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants;

type
  TProcKeybord = Procedure of object;
  TViewMain = class(TForm)
    stybPrincipal: TStyleBook;
    MediaPlayer: TMediaPlayer;
    lytBase: TLayout;
    public
       constructor Create(AOwner: TComponent); override;
    end;

var
  ViewMain: TViewMain;

implementation

{$R *.fmx}

uses
  FMX.VirtualKeyboard,
  ModelAPP.View.Frame.Home;

constructor TViewMain.Create(AOwner: TComponent);
var
  LFmeHome: TFmeHome;
begin
  inherited;
  LFmeHome:= TFmeHome.Create(lytBase);
  LFmeHome.Align := TAlignLayout.Client;
  lytBase.AddObject(LFmeHome);
end;

end.
