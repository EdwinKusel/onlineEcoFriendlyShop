program OnlineShop_U;

uses
  Vcl.Forms,
  Home_U in 'Home_U.pas' {frmHome},
  dmData_U in 'dmData_U.pas' {dmData: TDataModule},
  Administrator_U in 'Administrator_U.pas' {frmAdministrator},
  Shop_U in 'Shop_U.pas',
  ShoppingCart_U in 'ShoppingCart_U.pas' {frmShoppingCart},
  Login_U in 'Login_U.pas' {frmLogin},
  Register_U in 'Register_U.pas' {frmRegister},
  CollectionMethod_U in 'CollectionMethod_U.pas' {frmCollectionMethod},
  ChangeOrAddAddress_U in 'ChangeOrAddAddress_U.pas' {frmChangeAddress},
  Collect_U in 'Collect_U.pas' {frmCollect},
  Delivery_U in 'Delivery_U.pas' {frmDelivery},
  Payment_U in 'Payment_U.pas' {frmPayment};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TfrmHome, frmHome);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmAdministrator, frmAdministrator);
  Application.CreateForm(TfrmShoppingCart, frmShoppingCart);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmRegister, frmRegister);
  Application.CreateForm(TfrmCollectionMethod, frmCollectionMethod);
  Application.CreateForm(TfrmChangeAddress, frmChangeAddress);
  Application.CreateForm(TfrmCollect, frmCollect);
  Application.CreateForm(TfrmDelivery, frmDelivery);
  Application.CreateForm(TfrmPayment, frmPayment);
  Application.Run;
end.
