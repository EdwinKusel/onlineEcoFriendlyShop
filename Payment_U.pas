unit Payment_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,  Shop_U;

type
  TfrmPayment = class(TForm)
    lbledtCardDescription: TLabeledEdit;
    lblCardDescription: TLabel;
    pnlCartSummary: TPanel;
    lblCartSummary: TLabel;
    lblCollection: TLabel;
    lblPayment: TLabel;
    lbledtNameOnCard: TLabeledEdit;
    lbledtCardNumber: TLabeledEdit;
    lblExpiryDate: TLabel;
    cbbMonth: TComboBox;
    cbbYear: TComboBox;
    lbledtCVV: TLabeledEdit;
    btnCancel: TButton;
    btnPay: TButton;
    procedure lblCollectionClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnPayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbbMonthChange(Sender: TObject);
    procedure cbbYearChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPayment: TfrmPayment;
  Payment: TPayment;

implementation

uses
  CollectionMethod_U, Home_U;

{$R *.dfm}

procedure TfrmPayment.btnCancelClick(Sender: TObject);
begin
  frmCollectionMethod.Show;
  frmPayment.Hide;
end;

procedure TfrmPayment.btnPayClick(Sender: TObject);
var
  bInvalid: Boolean;
begin
  if lbledtCardDescription.Text = '' then
  begin
    lbledtCardDescription.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtCardDescription.EditLabel.Font.Color := clBlack;
  if lbledtNameOnCard.Text = '' then
  begin
    lbledtNameOnCard.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtNameOnCard.EditLabel.Font.Color := clBlack;
  if lbledtCardNumber.Text = '                ' then
  begin
    lbledtCardNumber.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtCardNumber.EditLabel.Font.Color := clBlack;
  if lbledtCVV.Text = '   ' then
  begin
    lbledtCVV.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtCVV.EditLabel.Font.Color := clBlack;
  if cbbMonth.Text = 'Month' then
  begin
    cbbMonth.Font.Color := clRed;
    bInvalid := True;
  end
  else
    cbbMonth.Font.Color := clBlack;
  if cbbYear.Text = 'Year' then
  begin
    cbbYear.Font.Color := clRed;
    bInvalid := True;
  end
  else
    cbbYear.Font.Color := clBlack;

  if bInvalid = False then
  begin
    ShowMessage('Thanks for shopping by us.');
    Payment.UpdateDatabase;
    Payment.ResetShop;
    Payment.UpdateAuditTrail;
    frmPayment.Hide;
    frmHome.Show;
  end;
end;

procedure TfrmPayment.cbbMonthChange(Sender: TObject);
begin
  if cbbMonth.Text = 'Month' then
    cbbMonth.Font.Color := clRed
  else
    cbbMonth.Font.Color := clBlack;
end;

procedure TfrmPayment.cbbYearChange(Sender: TObject);
begin
  if cbbYear.Text = 'Year' then
    cbbYear.Font.Color := clRed
  else
    cbbYear.Font.Color := clBlack;
end;

procedure TfrmPayment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmPayment.FormShow(Sender: TObject);
begin
  lblCartSummary.Caption := 'Cart summary' + #10#10 + Purchase.DisplayCartSummary;
end;

procedure TfrmPayment.lblCollectionClick(Sender: TObject);
begin
  frmPayment.Hide;
  frmCollectionMethod.Show;
end;

end.
