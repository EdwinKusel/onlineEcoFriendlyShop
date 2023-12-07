unit CollectionMethod_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, pngimage, Vcl.Buttons, Shop_U;

type
  TfrmCollectionMethod = class(TForm)
    lblCollection: TLabel;
    lblPayment: TLabel;
    pnlDelivery: TPanel;
    imgDelivery: TImage;
    pnlCollect: TPanel;
    imgCollect: TImage;
    btnDelivery: TButton;
    btnCollect: TButton;
    lblDelivery: TLabel;
    lblCollect: TLabel;
    lblDeliveryInfo: TLabel;
    lblCollectInfo: TLabel;
    pnlCartSummary: TPanel;
    lblCartSummary: TLabel;
    btnCart: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnCartClick(Sender: TObject);
    procedure btnDeliveryClick(Sender: TObject);
    procedure btnCollectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCollectionMethod: TfrmCollectionMethod;
  Purchase: TPurchase;

implementation

uses
  Home_U, ShoppingCart_U, Delivery_U, Collect_U;

{$R *.dfm}

procedure TfrmCollectionMethod.btnCartClick(Sender: TObject);
begin
  frmShoppingCart.Show;
  frmCollectionMethod.Hide;
end;

procedure TfrmCollectionMethod.btnCollectClick(Sender: TObject);
begin
  frmCollectionMethod.Hide;
  frmCollect.Show;
end;

procedure TfrmCollectionMethod.btnDeliveryClick(Sender: TObject);
begin
  frmCollectionMethod.Hide;
  frmDelivery.Show;
end;

procedure TfrmCollectionMethod.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmCollectionMethod.FormShow(Sender: TObject);
begin
  lblCartSummary.Caption := 'Cart summary' + #10#10 + Purchase.DisplayCartSummary;
end;

end.
