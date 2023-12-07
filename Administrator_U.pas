unit Administrator_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, dmData_U, Home_U, Vcl.Buttons, Shop_U,
  Vcl.Menus, Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmAdministrator = class(TForm)
    pgcAdministrator: TPageControl;
    tsRemoveUser: TTabSheet;
    tsEditProduct: TTabSheet;
    btnRemoveUser: TButton;
    lbledtUsersName: TLabeledEdit;
    lbledtUsersSurname: TLabeledEdit;
    lbledtProductName: TLabeledEdit;
    lbledtStock: TLabeledEdit;
    lbledtPrice: TLabeledEdit;
    lbledtCostPrice: TLabeledEdit;
    btnSearchForProduct: TButton;
    lblChanges: TLabel;
    lbledtSearchForAProduct: TLabeledEdit;
    btnMakeChanges: TButton;
    tsRestoreDatabase: TTabSheet;
    btnRestore: TBitBtn;
    lblRestoreDatabase: TLabel;
    tsAddProduct: TTabSheet;
    lbledtProductNameNew: TLabeledEdit;
    lbledtStockNew: TLabeledEdit;
    lbledtPriceNew: TLabeledEdit;
    lbledtCostPriceNew: TLabeledEdit;
    btnAddProduct: TButton;
    tsRemoveProduct: TTabSheet;
    lbledtProductNameRemove: TLabeledEdit;
    btnRemoveProduct: TButton;
    procedure btnRestoreClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRemoveUserClick(Sender: TObject);
    procedure btnSearchForProductClick(Sender: TObject);
    procedure btnMakeChangesClick(Sender: TObject);
    procedure btnAddProductClick(Sender: TObject);
    procedure btnRemoveProductClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdministrator: TfrmAdministrator;
  Admin: TAdmin;

implementation

{$R *.dfm}


procedure TfrmAdministrator.btnAddProductClick(Sender: TObject);
var
  bInvalid: Boolean;
begin
  with dmData do
  begin
    if lbledtProductNameNew.Text = '' then
    begin
      lbledtProductNameNew.EditLabel.Font.Color := clRed;
      bInvalid := True;
    end
    else
      lbledtProductNameNew.EditLabel.Font.Color := clBlack;
    if lbledtStockNew.Text = '' then
    begin
      lbledtStockNew.EditLabel.Font.Color := clRed;
      bInvalid := True;
    end
    else
      lbledtStockNew.EditLabel.Font.Color := clBlack;
    if lbledtPriceNew.Text = '' then
    begin
      lbledtPriceNew.EditLabel.Font.Color := clRed;
      bInvalid := True;
    end
    else
      lbledtPriceNew.EditLabel.Font.Color := clBlack;
    if lbledtCostPriceNew.Text = '' then
    begin
      lbledtCostPriceNew.EditLabel.Font.Color := clRed;
      bInvalid := True;
    end
    else
      lbledtCostPriceNew.EditLabel.Font.Color := clBlack;

    if bInvalid = False then
    begin
      Admin.NewProduct(lbledtProductNameNew.Text, lbledtStockNew.Text, lbledtPriceNew.Text, lbledtCostPriceNew.Text);
      lbledtProductNameNew.Text := '';
      lbledtStockNew.Text := '';
      lbledtPriceNew.Text := '';
      lbledtCostPriceNew.Text := '';
      lbledtProductNameNew.SetFocus;
    end;
  end;
end;

procedure TfrmAdministrator.btnMakeChangesClick(Sender: TObject);
begin
  Admin.ChangeProductInfo(lbledtProductName.Text, lbledtStock.Text, lbledtPrice.Text, lbledtCostPrice.Text);
end;

procedure TfrmAdministrator.btnRemoveProductClick(Sender: TObject);
var
  bFound: Boolean;
begin
  with dmData do
  begin
    if lbledtProductNameRemove.Text = '' then
      lbledtProductNameRemove.EditLabel.Font.Color := clRed
    else
    begin
      lbledtProductNameRemove.EditLabel.Font.Color := clBlack;
      tblProductInformation.First;
      while not tblProductInformation.Eof do
      begin
        if tblProductInformation['Product name'] = lbledtProductNameRemove.Text then
        begin
          bFound := True;
          qryProductInformation.Close;
          qryProductInformation.SQL.Clear;
          qryProductInformation.SQL.Add('DELETE FROM tblProductInformation WHERE [Product name] = ' + QuotedStr(lbledtProductNameRemove.Text));
          qryProductInformation.ExecSQL;
          ShowMessage('Product ''''' + lbledtProductNameRemove.Text + ''''' removed');
          Break;
        end;
        tblProductInformation.Next;
      end;
    end;
    if bFound = False then
      ShowMessage('Product ''''' + lbledtProductNameRemove.Text + ''''' was not found');
    lbledtProductNameRemove.Text := '';
  end;
end;

procedure TfrmAdministrator.btnRemoveUserClick(Sender: TObject);
var
  bInvalid, bFound: Boolean;
begin
  if lbledtUsersName.Text = '' then
  begin
    lbledtUsersName.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtUsersName.EditLabel.Font.Color := clBlack;
  if lbledtUsersSurname.Text = '' then
  begin
    lbledtUsersSurname.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtUsersSurname.EditLabel.Font.Color := clBlack;

  if bInvalid = False then
  begin
    Admin.RemoveUser(lbledtUsersName.Text, lbledtUsersSurname.Text);
    lbledtUsersName.Text := '';
    lbledtUsersSurname.Text := '';
    lbledtUsersName.SetFocus;
  end;
end;

procedure TfrmAdministrator.btnRestoreClick(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to restore the database', mtCustom, [mbYes, mbNo], 0) = mrYes then
  begin
    dmData.RestoreDataBase;
    frmHome.ConnectDatabase;
    ShowMessage('Database restored');
  end;
end;

procedure TfrmAdministrator.btnSearchForProductClick(Sender: TObject);
var
  bFound: Boolean;
begin
  with dmData do
  begin
    lbledtProductName.Text := '';
    lbledtStock.Text := '';
    lbledtPrice.Text := '';
    lbledtCostPrice.Text := '';

    if lbledtSearchForAProduct.Text = '' then
      lbledtSearchForAProduct.EditLabel.Font.Color := clRed
    else
    begin
      lbledtSearchForAProduct.EditLabel.Font.Color := clBlack;
      tblProductInformation.First;
      while not tblProductInformation.Eof do
      begin
        if UpperCase(tblProductInformation['Product name']) = UpperCase(lbledtSearchForAProduct.Text) then
        begin
          bFound := True;
          lbledtProductName.Text := tblProductInformation['Product name'];
          lbledtStock.Text := IntToStr(tblProductInformation['Stock Available']);
          lbledtPrice.Text := FloatToStr(tblProductInformation['Price']);
          lbledtCostPrice.Text := FloatToStr(tblProductInformation['Cost price']);
          lblChanges.Enabled := True;
          btnMakeChanges.Enabled := True;
          lbledtProductName.Enabled := True;
          lbledtStock.Enabled := True;
          lbledtPrice.Enabled := True;
          lbledtCostPrice.Enabled := True;
          Break;
        end;
        tblProductInformation.Next;
      end;
      if bFound = False then
        ShowMessage('Product ''''' + lbledtSearchForAProduct.Text + ''''' not found');
    end;

    tblProductInformation.First;
    while not tblProductInformation.Eof do
    begin
      if UpperCase(tblProductInformation['Product name']) = UpperCase(lbledtSearchForAProduct.Text) then
      begin
        bFound := True;
        lbledtProductName.Text := tblProductInformation['Product name'];
        lbledtStock.Text := IntToStr(tblProductInformation['Stock Available']);
        lbledtPrice.Text := FloatToStr(tblProductInformation['Price']);
        lbledtCostPrice.Text := FloatToStr(tblProductInformation['Cost price']);
        lblChanges.Enabled := True;
        btnMakeChanges.Enabled := True;
        lbledtProductName.Enabled := True;
        lbledtStock.Enabled := True;
        lbledtPrice.Enabled := True;
        lbledtCostPrice.Enabled := True;
        Break;
      end;
      tblProductInformation.Next;
    end;
  end;
end;

procedure TfrmAdministrator.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.Terminate;
end;

end.
