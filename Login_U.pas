unit Login_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.ExtCtrls, Vcl.StdCtrls, GIFImg, Shop_U;

type
  TfrmLogin = class(TForm)
    lbledtName: TLabeledEdit;
    lbledtPassword: TLabeledEdit;
    imgCaptcha: TImage;
    btnLogin: TButton;
    lblNoAccount: TLabel;
    lblRegister: TLabel;
    lbledtSurname: TLabeledEdit;
    lblCaptcha: TLabel;
    lblAdmin: TLabel;
    lblAminSur: TLabel;
    lblAdminP: TLabel;
    procedure FormShow(Sender: TObject);
    procedure imgCaptchaClick(Sender: TObject);
    procedure lblRegisterClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    bCaptcha: Boolean;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;
  User: TUser;

implementation

uses
  Register_U, Administrator_U, Home_U;

{$R *.dfm}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  lblCaptcha.Visible := False;

  if lbledtName.Text = '' then
    lbledtName.EditLabel.Font.Color := clRed
  else
    lbledtName.EditLabel.Font.Color := clBlack;
  if lbledtSurname.Text = '' then
    lbledtSurname.EditLabel.Font.Color := clRed
  else
    lbledtSurname.EditLabel.Font.Color := clBlack;
  if lbledtPassword.Text = '' then
    lbledtPassword.EditLabel.Font.Color := clRed
  else
    lbledtPassword.EditLabel.Font.Color := clBlack;

  User := TUser.Create(lbledtName.Text,lbledtSurname.Text,lbledtPassword.Text);
  frmHome.sUserStatus := User.fUserStatus;

  if bCaptcha = False then
    lblCaptcha.Visible := True
  else
    if frmHome.sUserStatus = 'Admin' then
    begin
      frmLogin.Close;
      frmAdministrator.Show;
      frmHome.Hide;
    end
    else
      if frmHome.sUserStatus = 'Client' then
      begin
        ShowMessage('Signed in');
        frmLogin.CLose;
      end
      else
        ShowMessage('Wrong name, surname or password');
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  lblRegister.Font.Color := clWebDeepskyBlue;

  (imgCaptcha.Picture.Graphic as TGIFImage).AnimateLoop := glDisabled;
  (imgCaptcha.Picture.Graphic as TGIFImage).Animate := False;

  //lbledtName.Text := '';
  //lbledtSurname.Text := '';
  //lbledtPassword.Text := '';
  lbledtName.SetFocus;
end;

procedure TfrmLogin.imgCaptchaClick(Sender: TObject);
begin
  bCaptcha := True;
  (imgCaptcha.Picture.Graphic as TGIFImage).Animate := True;
  (imgCaptcha.Picture.Graphic as TGIFImage).Animate := False;
end;

procedure TfrmLogin.lblRegisterClick(Sender: TObject);
begin
  frmLogin.Hide;
  frmRegister.Show;
end;

end.
