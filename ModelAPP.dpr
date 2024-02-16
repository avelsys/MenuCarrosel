program ModelAPP;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  ModelApp.View.Main in 'src\view\ModelApp.View.Main.pas' {ViewMain},
  ModelAPP.View.Frame.Base in 'src\view\Frames\ModelAPP.View.Frame.Base.pas' {FmeBase: TFrame},
  ModelAPP.View.Frame.Home in 'src\view\Frames\ModelAPP.View.Frame.Home.pas' {FmeHome: TFrame},
  ModeloAPP.Model.Home in 'src\model\ModeloAPP.Model.Home.pas',
  ModeloAPP.Controller.Home in 'src\controller\ModeloAPP.Controller.Home.pas',
  ModeloAPP.Lib.Constantes in 'src\Lib\ModeloAPP.Lib.Constantes.pas';

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TViewMain, ViewMain);
  Application.Run;
end.
