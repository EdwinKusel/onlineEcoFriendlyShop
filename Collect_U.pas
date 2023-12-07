unit Collect_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmCollect = class(TForm)
    rgCollectPlace: TRadioGroup;
    pnlCartSummary: TPanel;
    lblCartSummary: TLabel;
    btnCancel: TButton;
    btnPayment: TButton;
    lblCollection: TLabel;
    lblPayment: TLabel;
    btnCart: TSpeedButton;
    procedure lblCollectionClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCartClick(Sender: TObject);
    procedure btnPaymentClick(Sender: TObject);
    procedure rgCollectPlaceClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCollect: TfrmCollect;

implementation

uses
  CollectionMethod_U, ShoppingCart_U, Payment_U;

{$R *.dfm}

procedure TfrmCollect.btnCancelClick(Sender: TObject);
begin
  frmCollect.Hide;
  frmCollectionMethod.Show;
end;

procedure TfrmCollect.btnCartClick(Sender: TObject);
begin
  frmCollect.Hide;
  frmShoppingCart.Show;
end;

procedure TfrmCollect.btnPaymentClick(Sender: TObject);
begin
  frmCollect.Hide;
  frmPayment.Show;
end;

procedure TfrmCollect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmCollect.FormShow(Sender: TObject);
begin
  lblCartSummary.Caption := 'Cart summary' + #10#10 + Purchase.DisplayCartSummary;
end;

procedure TfrmCollect.lblCollectionClick(Sender: TObject);
begin
  frmCollect.Hide;
  frmCollectionMethod.Show;
end;

procedure TfrmCollect.rgCollectPlaceClick(Sender: TObject);
begin
  btnPayment.Enabled := True;
end;

end.
