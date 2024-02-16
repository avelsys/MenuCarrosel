unit ModelAPP.View.Frame.Base;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Objects;

type
  TFmeBase = class(TFrame)
    rctBase: TRectangle;
    lytContent: TLayout;
    lytFooter: TLayout;
    rctFundoFooter: TRectangle;
    rctFundoDialog: TRectangle;
    lytDialog: TLayout;
    procedure DoBtnClickWindows(Sender: TObject);
  end;

implementation

uses
  FMX.Skia;

{$R *.fmx}

{ TFmeBase }

procedure TFmeBase.DoBtnClickWindows(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if Assigned(TControl(Sender).OnTap) then
   TControl(Sender).OnTap(Sender, TPointF.Create(0,0));
  {$ENDIF}
end;


end.
