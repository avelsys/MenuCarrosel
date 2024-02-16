unit ModelAPP.View.Frame.Home;

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
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.Ani,
  FMX.Effects,
  FMX.Edit,
  FMX.EditBox,
  FMX.SpinBox,
  Generics.Collections,
  ModeloAPP.Model.Home,
  ModelAPP.View.Frame.Base;

type
  TFmeHome = class(TFmeBase)
    btnPlantio: TButton;
    btnMovimentacao: TButton;
    btnFinalizado: TButton;
    PthPlantio: TPath;
    pthMovimentacao: TPath;
    pthFinalizado: TPath;
    btnAcao: TButton;
    pthAcao: TPath;
    aniAcao: TFloatAnimation;
    recBaseGridPrincipal: TRectangle;
    lytGridHeader: TLayout;
    lblGridAcoes: TLabel;
    lblGridDescricao: TLabel;
    vsbListagem: TVertScrollBox;
    rctLegendaGrid: TRectangle;
    lytgLegendas: TGridLayout;
    lytLegendaStart: TLayout;
    pthLegStart: TPath;
    lblLegStart: TLabel;
    lytLegendaPause: TLayout;
    pthLegPause: TPath;
    lblLegPause: TLabel;
    lytLegendaFinaliza: TLayout;
    pthLegFinaliza: TPath;
    lblLegFinaliza: TLabel;
    lytFechado: TLayout;
    pthLegFechado: TPath;
    lblLegFechado: TLabel;
    lytRodape: TLayout;
    rctFundoHeader: TRectangle;
    aniFinalizado: TFloatAnimation;
    aniMovimentacao: TFloatAnimation;
    aniPlantio: TFloatAnimation;
    lytPaginacao: TGridLayout;
    Layout1: TLayout;
    lblTotalPagina: TLabel;
    Layout3: TLayout;
    Label3: TLabel;
    SpinBox1: TSpinBox;
    procedure btnAcaoTap(Sender: TObject; const Point: TPointF);
    procedure FrameResize(Sender: TObject);
    procedure FrameResized(Sender: TObject);
  public
    FController: IModelHome;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  ModeloAPP.Controller.Home;

{$R *.fmx}

procedure TFmeHome.btnAcaoTap(Sender: TObject; const Point: TPointF);
begin
  inherited;
  FController
    .ChamarAnimacaoBtns(Sender);
end;

constructor TFmeHome.Create;
begin
  inherited;
  FController := TControllerHome.New(Self);
  FController
    .MontarListaProdutos;
end;

procedure TFmeHome.FrameResize(Sender: TObject);
begin
  inherited;
  if Assigned(FController) then
    FController
      .RenderizarPosicaoBotaoControle;
end;

procedure TFmeHome.FrameResized(Sender: TObject);
begin
  inherited;
  if Assigned(FController) then
    FController
      .RenderizarPosicaoBotaoControle;
end;

end.
