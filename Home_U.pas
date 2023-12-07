unit Home_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, System.UITypes,
  Data.DB, Vcl.Grids, Vcl.DBGrids, dmData_U, pngimage, Vcl.Samples.Spin, Login_U, Register_U,
  Vcl.Buttons, Vcl.Mask, Shop_U;

type
  TfrmHome = class(TForm)
    dbgrdDisplay: TDBGrid;
    imgProduct: TImage;
    btnAddtoCart: TButton;
    seAmount: TSpinEdit;
    btnCart: TSpeedButton;
    lbledtSearch: TLabeledEdit;
    cbbMinimum: TComboBox;
    cbbMaximum: TComboBox;
    lblAmount: TLabel;
    btnProfile: TSpeedButton;
    procedure btnAddtoCartClick(Sender: TObject);
    procedure dbgrdDisplayCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure btnCartClick(Sender: TObject);
    procedure lbledtSearchChange(Sender: TObject);
    procedure cbbMinimumChange(Sender: TObject);
    procedure cbbMaximumChange(Sender: TObject);
    procedure btnProfileClick(Sender: TObject);
  private
    procedure FormatForm;
  public
    sUserStatus: string;
    procedure ConnectDatabase;
  end;

var
  frmHome: TfrmHome;
  Purchase: TPurchase;

implementation

uses
  ShoppingCart_U, Administrator_U;

{$R *.dfm}

procedure TfrmHome.btnCartClick(Sender: TObject);
begin
  frmShoppingCart.Show;
  frmHome.Hide;
end;

procedure TfrmHome.btnProfileClick(Sender: TObject);
begin
  if sUserStatus = 'Admin' then
    begin
      frmHome.Hide;
      frmAdministrator.Show;
    end
  else
    if sUserStatus = 'Account registered' then
      ShowMessage('Already registered and signed in')
    else
      if sUserStatus = 'Client' then
        ShowMessage('Already signed in')
      else
        frmLogin.Show;
end;

procedure TfrmHome.cbbMaximumChange(Sender: TObject);
begin
  if (cbbMaximum.Text <> 'Maximum price') and (cbbMinimum.Text <> 'Minimum price') then
    if StrToInt(cbbMinimum.Text) > StrToInt(cbbMaximum.Text) then
      cbbMinimum.Text := 'Minimum price';
  Purchase.SearchMinimumMaximum(lbledtSearch.Text,cbbMinimum.Text,cbbMaximum.Text);
  FormatForm;
end;

procedure TfrmHome.cbbMinimumChange(Sender: TObject);
begin
  if (cbbMaximum.Text <> 'Maximum price') and (cbbMinimum.Text <> 'Minimum price') then
    if StrToInt(cbbMinimum.Text) > StrToInt(cbbMaximum.Text) then
      cbbMaximum.Text := 'Maximum price';
  Purchase.SearchMinimumMaximum(lbledtSearch.Text,cbbMinimum.Text,cbbMaximum.Text);
  FormatForm;
end;

procedure TfrmHome.btnAddtoCartClick(Sender: TObject);
begin
  with dmData do
  begin
    tblProductInformation.RecNo := Purchase.fItemNumber;
    if (seAmount.Value = seAmount.MaxValue) and (tblProductInformation['Product name'] = dbgrdDisplay.SelectedField.AsString) then
    begin
      if MessageDlg('There is only ' + IntToStr(tblProductInformation['Stock Available']) + ' left, would you like to purchase the rest?', mtCustom, [mbYes, mbNo], 0) = mrYes then
      begin
        Purchase.AddToCart(seAmount.Value);
        btnCart.Enabled := True;
      end;
    end
    else
    begin
      Purchase.AddToCart(seAmount.Value);
      btnCart.Enabled := True;
    end;
  end;
end;

procedure TfrmHome.ConnectDatabase;
begin
  with dmData do
  begin
    dbgrdDisplay.DataSource := dscqryProductInformation;

    qryProductInformation.Close;
    qryProductInformation.SQL.Text := 'Select [Product name], [Stock available], Price from tblProductInformation where [Stock available] > 0 order by [Product Name]';
    qryProductInformation.Open;
  end;
end;

procedure TfrmHome.dbgrdDisplayCellClick(Column: TColumn);
begin
  try
    imgProduct.Picture.LoadFromFile(dbgrdDisplay.SelectedField.AsString + '.png');

    Purchase := TPurchase.Create(dbgrdDisplay.SelectedField.AsString);
    seAmount.MaxValue := Purchase.fMaxValue;
    seAmount.Enabled := True;
    btnAddtoCart.Enabled := True;
  except
    ShowMessage('Click on a product''s name');
  end;
end;

procedure TfrmHome.FormShow(Sender: TObject);
begin
  seAmount.Text := '1';
  lbledtSearch.Text := '';

  cbbMinimum.Text := 'Minimum price';
  cbbMaximum.Text := 'Maximum price';

  ConnectDatabase;
  FormatForm;
end;

procedure TfrmHome.lbledtSearchChange(Sender: TObject);
begin
  Purchase.SearchMinimumMaximum(lbledtSearch.Text,cbbMinimum.Text,cbbMaximum.Text);
  FormatForm;
end;

procedure TfrmHome.FormatForm;
begin
  dbgrdDisplay.Columns[0].Width := 230;
  dbgrdDisplay.Columns[1].Width := 85;
  dbgrdDisplay.Columns[2].Width := 35;

  imgProduct.Picture := nil;
end;

end.
