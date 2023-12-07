unit ShoppingCart_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Shop_U,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmShoppingCart = class(TForm)
    redtCart: TRichEdit;
    btnRemoveItem: TButton;
    pnlCartSummary: TPanel;
    lblCartSummary: TLabel;
    btnCheckout: TButton;
    imgShoppingBag: TImage;
    lblCartInfo: TLabel;
    btnProfile: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnCheckoutClick(Sender: TObject);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure imgShoppingBagClick(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShoppingCart: TfrmShoppingCart;
  Purchase: TPurchase;

implementation

uses
  Home_U, Login_U, CollectionMethod_U;

{$R *.dfm}

procedure TfrmShoppingCart.btnCheckoutClick(Sender: TObject);
begin
  if Purchase.DisplayCartSummary =  ('Total:(0 items) ' + #9 + 'R0') then
    ShowMessage('You cannot proceed to checkout, there are currently no items in your cart.')
  else
    if frmHome.sUserStatus = 'Client' then
    begin
      frmCollectionMethod.Show;
      frmShoppingCart.Hide;
    end
    else
      frmLogin.Show;
end;

procedure TfrmShoppingCart.btnProfileClick(Sender: TObject);
begin
  if frmHome.sUserStatus = 'Client' then
    ShowMessage('Already signed in')
  else
    frmLogin.Show;
end;

procedure TfrmShoppingCart.btnRemoveItemClick(Sender: TObject);
begin
  if Purchase.DisplayCartSummary =  ('Total:(0 items) ' + #9 + 'R0') then
    ShowMessage('You cannot remove any more items, your cart is empty.')
  else
    Purchase.RemoveAnItem(StrToInt(InputBox('Remove an item','Amount you would like to remove','')),InputBox('Remove an item','Item would you like to remove:',''));

  redtCart.Clear;
  redtCart.Lines.Add(Purchase.DisplayCart);

  lblCartSummary.Caption := 'Cart summary' + #10#10 + Purchase.DisplayCartSummary;
end;

procedure TfrmShoppingCart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmShoppingCart.FormShow(Sender: TObject);
begin
  redtCart.Clear;
  redtCart.Lines.Add(Purchase.DisplayCart);

  lblCartSummary.Caption := 'Cart summary' + #10#10 + Purchase.DisplayCartSummary;
end;

procedure TfrmShoppingCart.imgShoppingBagClick(Sender: TObject);
begin
  frmHome.Show;
  frmShoppingCart.Hide;
end;

end.
