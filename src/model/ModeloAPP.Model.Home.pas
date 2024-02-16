unit ModeloAPP.Model.Home;

interface

type
  IModelHome = interface
    ['{BDA51EFD-A0E1-4836-AE40-82C4C6A79E8C}']
    function MontarListaProdutos: IModelHome;
    function RenderizarPosicaoBotaoControle: IModelHome;
    function ChamarAnimacaoBtns(Sender: TObject): IModelHome;
  end;

implementation

end.
