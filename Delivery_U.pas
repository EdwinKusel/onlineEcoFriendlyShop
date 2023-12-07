unit Delivery_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Shop_U, Vcl.ComCtrls;

type
  TfrmDelivery = class(TForm)
    lblCollection: TLabel;
    lblPayment: TLabel;
    btnCart: TSpeedButton;
    pnlCartSummary: TPanel;
    lblCartSummary: TLabel;
    btnPayment: TButton;
    redtAddress: TRichEdit;
    btnAddress: TButton;
    procedure lblCollectionClick(Sender: TObject);
    procedure btnCartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddressClick(Sender: TObject);
    procedure btnPaymentClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDelivery: TfrmDelivery;
  Delivery: TDelivery;

implementation

uses
  CollectionMethod_U, ShoppingCart_U, ChangeOrAddAddress_U, Payment_U;

{$R *.dfm}

procedure TfrmDelivery.btnCartClick(Sender: TObject);
begin
  frmDelivery.Hide;
  frmShoppingCart.Show;
end;

procedure TfrmDelivery.btnAddressClick(Sender: TObject);
begin
  frmDelivery.Hide;
  frmChangeAddress.Show;
end;

procedure TfrmDelivery.btnPaymentClick(Sender: TObject);
begin
  frmDelivery.Hide;
  frmPayment.Show;
end;

procedure TfrmDelivery.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmDelivery.FormShow(Sender: TObject);
begin
  lblCartSummary.Caption := 'Cart summary' + #10#10 + Purchase.DisplayCartSummary;

  redtAddress.Paragraph.TabCount := 1;
  redtAddress.Paragraph.Tab[0] := 80;
  redtAddress.Lines.Clear;
  redtAddress.Lines.Add('Current delivery address:' + #10#10 + Delivery.DisplayDeliveryInfo);

  if Delivery.DisplayDeliveryInfo = 'No address found' then
    btnAddress.Caption := 'Add address'
  else
  begin
    btnAddress.Caption := 'Change address';
    btnPayment.Enabled := True;
  end;
end;

procedure TfrmDelivery.lblCollectionClick(Sender: TObject);
begin
  frmDelivery.Hide;
  frmCollectionMethod.Show;
end;

end.
