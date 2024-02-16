unit ModeloAPP.Controller.Home;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.StrUtils,
  System.AnsiStrings,
  System.TypInfo,
  RTTI,
  FMX.Forms,
  FMX.Layouts,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Ani,
  FMX.Utils,
  FMX.Graphics,
  FMX.Controls,
  FMX.Types,
  FMX.Dialogs,
  ModeloAPP.Model.Home,
  Generics.Collections,
  ModeloAPP.Lib.Constantes,
  FireDAC.Comp.Client;
type
  TControllerHome = class(TInterfacedObject, IModelHome)
  private
    FFrame: TFrame;
    FBTNPlantio: TButton;
    FBTNMovimentacao: TButton;
    FBTNFinalizado: TButton;
    FBTNAcao: TButton;
    FANIAcao: TFloatAnimation;
    FPTHAcao: TPath;
    FVSBLista: TVertScrollBox;
    FAbreBotoes: Boolean;
    function InjetarComponentesFrame<T:TComponent>(const ANomeControle: string):T;
    procedure CriaAnimacaoBotoes(AbtnAcao: TButton);
    procedure ConfigurarPosicaoBtnsControle(ABotaoControle: TButton; APosX,
      APosY: Integer);
    procedure ChamarBtnsControle(ABotaoControle: TButton; AVisivel: Boolean);
    procedure CriarItensListaProdutos(const AIdProduto: integer);
    procedure MontarBotaoStart(const AidProduto: integer);
    procedure MontarBotaoFinaliza(const AidProduto: integer);
    procedure MontarLayoutsItem;
    procedure MontarLayoutDescricao;
    procedure MontarLayoutAcoes;
    procedure MontarDescricao;
    procedure DoUsuariosTap(Sender: TObject; const Point: TPointF);
    procedure DoClienteap(Sender: TObject; const Point: TPointF);
    procedure DoVendasTap(Sender: TObject; const Point: TPointF);
  protected
    procedure OnFinishBtnAcao(Sender: TObject);
    procedure DoBtnClickWindows(Sender: TObject);
    procedure DoTapBotaoStart(Sender: TObject; const Point: TPointF);
    procedure DoTapBotaoFinaliza(Sender: TObject; const Point: TPointF);
  public
    constructor Create(AFrameEmbedded: TFrame);
    destructor Destroy; override;
    class function New(AFrameEmbedded: TFrame): IModelHome;

    function MontarListaProdutos: IModelHome;
    function RenderizarPosicaoBotaoControle: IModelHome;
    function ChamarAnimacaoBtns(Sender: TObject): IModelHome;
  end;

var
  LrctItens: TRectangle;
  LlytAcoes, LlytDescricao: TLayout;
  LbtnStart, LbtnFinaliza: TButton;
  LlblDescricao, LlblDetatlhe: TLabel;
  LpthStar, LpthFinaliza: TPath;

implementation

const
  csFORMAT_NOME_BOTAO_START    = 'btnStart_%s';
  csFORMAT_SVG_PATH_START      = 'pthStart_%s';
  csFORMAT_NOME_BOTAO_FINALIZA = 'btnFinaliza_%s';
  csFORMAT_SVG_PATH_FINALIZA   = 'pthFinaliza_%s';

procedure TControllerHome.DoBtnClickWindows(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if Assigned(TControl(Sender).OnTap) then
   TControl(Sender).OnTap(Sender, TPointF.Create(0,0));
  {$ENDIF}
end;

constructor TControllerHome.Create(AFrameEmbedded: TFrame);
begin
  FFrame          := AFrameEmbedded;
  FVSBLista       := InjetarComponentesFrame<TVertScrollBox>('vsbListagem');
  FBTNPlantio     := InjetarComponentesFrame<TButton>('btnPlantio');
  FBTNMovimentacao:= InjetarComponentesFrame<TButton>('btnMovimentacao');
  FBTNFinalizado  := InjetarComponentesFrame<TButton>('btnFinalizado');
  FBTNAcao        := InjetarComponentesFrame<TButton>('btnAcao');
  FANIAcao        := InjetarComponentesFrame<TFloatAnimation>('aniAcao');
  FPTHAcao        := InjetarComponentesFrame<TPath>('pthAcao');

  CriaAnimacaoBotoes(FBTNPlantio);
  CriaAnimacaoBotoes(FBTNMovimentacao);
  CriaAnimacaoBotoes(FBTNFinalizado);

  FBTNPlantio.OnClick := DoBtnClickWindows;
  FBTNPlantio.OnTap   := DoUsuariosTap;

  FBTNMovimentacao.OnClick := DoBtnClickWindows;
  FBTNMovimentacao.OnTap   := DoClienteap;

  FBTNFinalizado.OnClick := DoBtnClickWindows;
  FBTNFinalizado.OnTap   := DoVendasTap;

end;

procedure TControllerHome.DoVendasTap(Sender: TObject; const Point: TPointF);
begin
  ShowMessage('Usuário');
  ChamarAnimacaoBtns(Sender);
end;

procedure TControllerHome.DoClienteap(Sender: TObject; const Point: TPointF);
begin
  ShowMessage('Cliente');
  ChamarAnimacaoBtns(Sender);
end;

procedure TControllerHome.DoUsuariosTap(Sender: TObject; const Point: TPointF);
begin
  ShowMessage('Usuário');
  ChamarAnimacaoBtns(Sender);
end;


procedure TControllerHome.CriaAnimacaoBotoes(AbtnAcao: TButton);
var
  LAnimacaoPosX, LAnimacaoPosY, LAnimacaoRotacao: TFloatAnimation;
begin
  LAnimacaoPosX                 := TFloatAnimation.Create(AbtnAcao);
  LAnimacaoPosX.AnimationType   := TAnimationType.In;
  LAnimacaoPosX.Duration        := 0.5;
  LAnimacaoPosX.Interpolation   := TInterpolationType.Sinusoidal;
  LAnimacaoPosX.Name            := Format(csNOME_ACAO_POSICAOX,[AbtnAcao.Name]) ;
  LAnimacaoPosX.PropertyName    := csPROPRIEDADE_ANIMACAO_POSICAO_X;
  LAnimacaoPosX.Trigger         := csBOTAO_PRESSIONADO;
  LAnimacaoPosX.TriggerInverse  := csBOTAO_NAO_PRESSIONADO;
  AbtnAcao.AddObject(LAnimacaoPosX);

  LAnimacaoPosY                 := TFloatAnimation.Create(AbtnAcao);
  LAnimacaoPosY.AnimationType   := TAnimationType.In;
  LAnimacaoPosY.Duration        := 0.5;
  LAnimacaoPosY.Interpolation   := TInterpolationType.Sinusoidal;
  LAnimacaoPosY.Name            := Format(csNOME_ACAO_POSICAOY,[AbtnAcao.Name]) ;
  LAnimacaoPosY.PropertyName    := csPROPRIEDADE_ANIMACAO_POSICAO_Y;
  LAnimacaoPosY.Trigger         := csBOTAO_PRESSIONADO;
  LAnimacaoPosY.TriggerInverse  := csBOTAO_NAO_PRESSIONADO;
  AbtnAcao.AddObject(LAnimacaoPosY);

  LAnimacaoRotacao               := TFloatAnimation.Create(AbtnAcao);
  LAnimacaoRotacao.AnimationType := TAnimationType.In;
  LAnimacaoRotacao.Duration      := 0.5;
  LAnimacaoRotacao.Interpolation := TInterpolationType.Sinusoidal;
  LAnimacaoRotacao.Name          := Format(csNOME_ACAO_ROTACAO,[AbtnAcao.Name]) ;
  LAnimacaoRotacao.PropertyName  := csPROPRIEDADE_ANIMACAO_ROTACAO;
  LAnimacaoRotacao.Trigger       := csBOTAO_PRESSIONADO;
  LAnimacaoRotacao.TriggerInverse:= csBOTAO_NAO_PRESSIONADO;
  AbtnAcao.AddObject(LAnimacaoRotacao);
end;

function TControllerHome.InjetarComponentesFrame<T>(const ANomeControle: string): T;
var
  LContextoRtti: TRttiContext;
  LTipoRtti:TRttiType;
begin
  Result := nil;
  LContextoRtti:= TRttiContext.Create;
  try
    try
      LTipoRtti := LContextoRtti.GetType(FFrame.ClassType);
      Result    := LTipoRtti.GetField(ANomeControle)
                      .GetValue(FFrame)
                      .AsType<T>;
    except on E:Exception do
      begin
        Abort;
      end;
    end;
  finally
    LContextoRtti.Free;
  end;
end;

procedure TControllerHome.MontarDescricao;
begin
  LlblDescricao             := TLabel.Create(LlytDescricao);
  LlblDescricao.Align       := TAlignLayout.Top;
  LlblDescricao.Margins.Top := 15;
  LlblDescricao.Text        := 'Descrição a ser inserida';
  LlblDescricao.TextSettings.Font.Family := csFONTE_PADRAO;
  LlblDescricao.TextSettings.Font.Size   := 20;
  LlblDescricao.TextSettings.FontColor   := TAlphaColorRec.Black;
  LlblDescricao.TextSettings.Font.Style  := [TFontStyle.fsBold];
  LlblDescricao.StyledSettings           := [TStyledSetting.FontColor];

  LlblDetatlhe              := TLabel.Create(LlytDescricao);
  LlblDetatlhe.Align        := TAlignLayout.Top;
  LlblDetatlhe.Margins.Top  := 5;
  LlblDetatlhe.Text         := 'Detalhe a ser inserido';
  LlblDetatlhe.TextSettings.Font.Family := csFONTE_PADRAO;
  LlblDetatlhe.TextSettings.Font.Size   := 12;
  LlblDetatlhe.TextSettings.FontColor   := TAlphaColorRec.Darkgoldenrod;
  LlblDetatlhe.TextSettings.Font.Style  := [];
  LlblDetatlhe.StyledSettings           := [TStyledSetting.FontColor];

  LlytDescricao.AddObject(LlblDescricao);
  LlytDescricao.AddObject(LlblDetatlhe);

end;

procedure TControllerHome.MontarLayoutAcoes;
begin
  LlytAcoes := TLayout.Create(LrctItens);
  LlytAcoes.Align := TAlignLayout.Left;
  LlytAcoes.Width := 120;
  LrctItens.AddObject(LlytAcoes);
end;

procedure TControllerHome.MontarLayoutDescricao;
begin
  LlytDescricao := TLayout.Create(LrctItens);
  LlytDescricao.Align := TAlignLayout.Client;
  LrctItens.AddObject(LlytDescricao);
  MontarDescricao;
end;

procedure TControllerHome.MontarLayoutsItem;
begin
  LrctItens               := TRectangle.Create(FVSBLista);
  LrctItens.Align         := TAlignLayout.Top;
  LrctItens.Height        := 50;
  LrctItens.Fill.Color    := TAlphaColorRec.White;
  LrctItens.Stroke.Kind   := TBrushKind.None;
  Lrctitens.Margins.Bottom:= 15;
  FVSBLista.AddObject(LrctItens);
end;

procedure TControllerHome.MontarBotaoFinaliza(const AidProduto: integer);
begin
  LbtnFinaliza                := TButton.Create(LlytAcoes);
  LbtnFinaliza.Text           := EmptyStr;
  LbtnFinaliza.Align          := TAlignLayout.Left;
  LbtnFinaliza.Height         := csTAMANHO_BOTOES_ACAO;
  LbtnFinaliza.Width          := csTAMANHO_BOTOES_ACAO;
  LbtnFinaliza.Margins.Left   := csESPACO_BOTOES_ACAO;
  LbtnFinaliza.Margins.top    := csESPACO_BOTOES_ACAO;
  LbtnFinaliza.Margins.Right  := csESPACO_BOTOES_ACAO;
  LbtnFinaliza.Margins.bottom := csESPACO_BOTOES_ACAO;
  LbtnFinaliza.Name           := format(csFORMAT_NOME_BOTAO_FINALIZA,[AidProduto.ToString]);
  LbtnFinaliza.Tag            := AidProduto;
  LbtnFinaliza.Tagfloat       := 0;
  LbtnFinaliza.StyleLookup    := csSTILO_BOTAO_ACAO;
  LbtnFinaliza.OnClick        := DoBtnClickWindows;
  LbtnFinaliza.OnTap          := DoTapBotaoFinaliza;
  LlytAcoes.AddObject(LbtnFinaliza);

  LpthFinaliza                := TPath.Create(LbtnFinaliza);
  LpthFinaliza.Name           := format(csFORMAT_SVG_PATH_FINALIZA,[AidProduto.ToString]);
  LpthFinaliza.Align          := TAlignLayout.Client;
  LpthFinaliza.Data.Data      := csBOTAO_STOP;
  LpthFinaliza.Fill.Color     := TAlphaColorRec.Red;
  LpthFinaliza.Stroke.Kind    := TBrushKind.none;
  LpthFinaliza.HitTest        := False;
  LbtnFinaliza.AddObject(LpthFinaliza);

  LbtnFinaliza.TagObject      := LpthFinaliza;
end;

procedure TControllerHome.MontarBotaoStart(const AidProduto: integer);
begin
  LbtnStart               := TButton.Create(LlytAcoes);
  LbtnStart.Text          := EmptyStr;
  LbtnStart.Align         := TAlignLayout.Left;
  LbtnStart.Height        := csTAMANHO_BOTOES_ACAO;
  LbtnStart.Width         := csTAMANHO_BOTOES_ACAO;
  LbtnStart.Margins.Left  := csESPACO_BOTOES_ACAO;
  LbtnStart.Margins.top   := csESPACO_BOTOES_ACAO;
  LbtnStart.Margins.Right := csESPACO_BOTOES_ACAO;
  LbtnStart.Margins.bottom:= csESPACO_BOTOES_ACAO;
  LbtnStart.Name          := format(csFORMAT_NOME_BOTAO_START,[AidProduto.ToString]);
  LbtnStart.Tag           := AidProduto;
  LbtnStart.TagFloat      := 0;
  LbtnStart.StyleLookup   := csSTILO_BOTAO_ACAO;
  LbtnStart.OnClick       := DoBtnClickWindows;
  LbtnStart.OnTap         := DoTapBotaoStart;
  LlytAcoes.AddObject(LbtnStart);

  LpthStar                := TPath.Create(LbtnStart);
  LpthStar.Name           := format(csFORMAT_SVG_PATH_START,[AidProduto.ToString]);
  LpthStar.Align          := TAlignLayout.Client;
  LpthStar.Data.Data      := csBOTAO_START;
  LpthStar.Fill.Color     := TAlphaColorRec.Green;
  LpthStar.Stroke.Kind    := TBrushKind.none;
  LpthStar.HitTest        := False;
  LbtnStart.AddObject(LpthStar);

  LbtnStart.TagObject     := LpthStar;
end;

function TControllerHome.ChamarAnimacaoBtns(Sender: TObject): IModelHome;
begin
  inherited;
  FAbreBotoes:= FAbreBotoes = false;
  if FAbreBotoes then
    FANIAcao.AnimationType := TAnimationType.in
  else
    FANIAcao.AnimationType := TAnimationType.Out;
  FANIAcao.Start;

  ChamarBtnsControle(FbtnPlantio,      FAbreBotoes);
  ChamarBtnsControle(FbtnMovimentacao, FAbreBotoes);
  ChamarBtnsControle(FbtnFinalizado,   FAbreBotoes);
end;

function TControllerHome.RenderizarPosicaoBotaoControle: IModelHome;
begin
  inherited;
  result := Self;
  ConfigurarPosicaoBtnsControle(FbtnPlantio,      -40,  70);
  ConfigurarPosicaoBtnsControle(FbtnMovimentacao,  40,  50);
  ConfigurarPosicaoBtnsControle(FbtnFinalizado,    70, -20);
end;

procedure TControllerHome.ConfigurarPosicaoBtnsControle(ABotaoControle: TButton;
  APosX, APosY: Integer);
var
  LAnimacao: TFloatAnimation;
  LCoontrole: TComponent;
begin
  for LCoontrole in ABotaoControle.Children do
  begin
    if not (LCoontrole is TFloatAnimation) then
      Continue;

    LAnimacao := (LCoontrole as TFloatAnimation);
    case AnsiIndexStr(LAnimacao.PropertyName,
      [csPROPRIEDADE_ANIMACAO_POSICAO_X
      ,csPROPRIEDADE_ANIMACAO_POSICAO_Y
      ,csPROPRIEDADE_ANIMACAO_ROTACAO]) of
      0 :
        begin
          LAnimacao.StartValue      := FbtnAcao.Position.X + 10;
          LAnimacao.StopValue       := FbtnAcao.Position.X - (APosX + 10);
          ABotaoControle.Position.X := FbtnAcao.Position.X + 10;
        end;
      1 :
        begin
          LAnimacao.StartValue      := FbtnAcao.Position.Y + 10;
          LAnimacao.StopValue       := FbtnAcao.Position.Y - (APosY + 10);
          ABotaoControle.Position.y := FbtnAcao.Position.Y + 10;
        end;
      2 :
        begin
          LAnimacao.StartValue      := 720;
          LAnimacao.StopValue       := 0;
        end;
    end;

  end;
end;

procedure TControllerHome.ChamarBtnsControle(ABotaoControle: TButton; AVisivel: Boolean);
var
  LAnimacao: TFloatAnimation;
  LCoontrole: TComponent;
  LListaAnimacao: TList<TFloatAnimation>;
begin
  LListaAnimacao:= TList<TFloatAnimation>.Create;
  try
    ABotaoControle.IsPressed := AVisivel;
    for LCoontrole in ABotaoControle.Children do
    begin
      if not (LCoontrole is TFloatAnimation) then
        Continue;

        LAnimacao := (LCoontrole as TFloatAnimation);
        LAnimacao.Inverse := not AVisivel;
        LListaAnimacao.Add(LAnimacao);
    end;

    for LAnimacao in LListaAnimacao do
    begin
      LAnimacao.Start;
      LAnimacao.Trigger := EmptyStr;
      LAnimacao.TriggerInverse := EmptyStr;
    end;
  finally
    LListaAnimacao.Free;
  end;
end;

destructor TControllerHome.Destroy;
begin
  inherited;
end;

function TControllerHome.MontarListaProdutos: IModelHome;
var
  I: Integer;
begin
  result := Self;
  for I := 0 to 10 do
    CriarItensListaProdutos(I);
end;

class function TControllerHome.New (AFrameEmbedded: TFrame) : IModelHome;
begin
  Result := Self.Create(AFrameEmbedded);
end;

procedure TControllerHome.CriarItensListaProdutos(const AIdProduto: integer);
begin
  MontarLayoutsItem;
  MontarLayoutAcoes;
  MontarBotaoFinaliza(AIdProduto);
  MontarBotaoStart(AIdProduto);
  MontarLayoutDescricao;
end;

procedure TControllerHome.OnFinishBtnAcao(Sender: TObject);
var
  LAnimacao: TFloatAnimation absolute Sender;
begin
  inherited;
  if LAnimacao.AnimationType = TAnimationType.Out then
    FPTHAcao.Data.Data := csBOTAO_ACAO_ATIVO
  else
    FPTHAcao.Data.Data := csBOTAO_ACAO_INATIVO;
end;

procedure TControllerHome.DoTapBotaoStart(Sender: TObject; const Point: TPointF);
var
  LBotaoStart: TButton absolute Sender;
  LPathStartSub: TPath;
begin
  LPathStartSub := LBotaoStart.TagObject as TPath;
  if LBotaoStart.TagFloat = 0 then
  begin
    if not Assigned(LPathStartSub) then
      Exit;
    LPathStartSub.Data.Data := csBOTAO_PAUSE;
    LPathStartSub.Fill.Color:= TAlphaColorRec.Yellow;
    LBotaoStart.TagFloat := 1;
  end else
  begin
    if not Assigned(LPathStartSub) then
      Exit;

    LPathStartSub.Data.Data := csBOTAO_START;
    LPathStartSub.Fill.Color:= TAlphaColorRec.Green;
    LBotaoStart.TagFloat := 0;
  end;
end;

procedure TControllerHome.DoTapBotaoFinaliza(Sender: TObject; const Point: TPointF);
begin
//
end;

end.
