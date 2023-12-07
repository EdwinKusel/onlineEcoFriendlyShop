unit ChangeOrAddAddress_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Shop_U,
  Vcl.Buttons;

type
  TfrmChangeAddress = class(TForm)
    lbledtStreetAddress: TLabeledEdit;
    lblStreetAddress: TLabel;
    lbledtSuburb: TLabeledEdit;
    lbledtCityTown: TLabeledEdit;
    cbbProvince: TComboBox;
    lbledtPostalCode: TLabeledEdit;
    btnCancel: TButton;
    btnSaveAddress: TButton;
    pnlCartSummary: TPanel;
    lblCartSummary: TLabel;
    lblCollection: TLabel;
    lblPayment: TLabel;
    btnCart: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lblCollectionClick(Sender: TObject);
    procedure btnCartClick(Sender: TObject);
    procedure btnSaveAddressClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbbProvinceChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChangeAddress: TfrmChangeAddress;
  Purchase: TPurchase;
  Delivery: TDelivery;

implementation

uses
  CollectionMethod_U, Home_U, ShoppingCart_U, Delivery_U;

{$R *.dfm}

procedure TfrmChangeAddress.btnCancelClick(Sender: TObject);
begin
  frmChangeAddress.Hide;
  frmCollectionMethod.Show;
end;

procedure TfrmChangeAddress.btnCartClick(Sender: TObject);
begin
  frmChangeAddress.Hide;
  frmShoppingCart.Show;
end;

procedure TfrmChangeAddress.btnSaveAddressClick(Sender: TObject);
var
  bInvalid: Boolean;
begin
  if lbledtStreetAddress.Text = '' then
  begin
    lbledtStreetAddress.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtStreetAddress.EditLabel.Font.Color := clBlack;
  if lbledtSuburb.Text = '' then
  begin
    lbledtSuburb.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtSuburb.EditLabel.Font.Color := clBlack;
  if lbledtCityTown.Text = '' then
  begin
    lbledtCityTown.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtCityTown.EditLabel.Font.Color := clBlack;
  if lbledtPostalCode.Text = '    ' then
  begin
    lbledtPostalCode.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtPostalCode.EditLabel.Font.Color := clBlack;
  if cbbProvince.Text = 'Province' then
  begin
    cbbProvince.Font.Color := clRed;
    bInvalid := True;
  end
  else
    cbbProvince.Font.Color := clBlack;

  if bInvalid = False then
  begin
    Delivery.ChangeOrAddAddress(lbledtStreetAddress.Text,lbledtSuburb.Text,lbledtCityTown.Text,cbbProvince.Text,StrToInt(lbledtPostalCode.Text));

    if frmDelivery.btnAddress.Caption = 'Add address' then
      ShowMessage('Address saved');
    if frmDelivery.btnAddress.Caption = 'Change address' then
      ShowMessage('Address changed');

    frmDelivery.Show;
    frmChangeAddress.Hide;
  end;
end;

procedure TfrmChangeAddress.cbbProvinceChange(Sender: TObject);
begin
  if cbbProvince.Text = 'Province' then
    cbbProvince.Font.Color := clRed
  else
    cbbProvince.Font.Color := clBlack;
end;

procedure TfrmChangeAddress.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmChangeAddress.FormShow(Sender: TObject);
begin
  lblCartSummary.Caption := 'Cart summary' + #10#10 + Purchase.DisplayCartSummary;
  lbledtSuburb.Text := '';
  lbledtSuburb.Text := '';
  lbledtCityTown.Text := '';
  lbledtPostalCode.Text := '';
  cbbProvince.Text := 'Province';
end;

procedure TfrmChangeAddress.lblCollectionClick(Sender: TObject);
begin
  frmChangeAddress.Hide;
  frmCollectionMethod.Show;
end;

end.
