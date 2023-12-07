unit Register_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Shop_U;

type
  TfrmRegister = class(TForm)
    lbledtPassword: TLabeledEdit;
    btnRegister: TButton;
    lblPassword: TLabel;
    lbledtName: TLabeledEdit;
    lbledtSurname: TLabeledEdit;
    lbledtConfirmPassword: TLabeledEdit;
    lblAlready: TLabel;
    lblLogIn: TLabel;
    procedure btnRegisterClick(Sender: TObject);
    procedure lblLogInClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegister: TfrmRegister;
  User: TUser;

implementation

uses
  Login_U, Home_U;

{$R *.dfm}

procedure TfrmRegister.btnRegisterClick(Sender: TObject);
var
  bInvalid: Boolean;
begin
  lblPassword.Font.Color := clGray;

  if lbledtName.Text = '' then
  begin
    lbledtName.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtName.EditLabel.Font.Color := clBlack;
  if lbledtSurname.Text = '' then
  begin
    lbledtSurname.EditLabel.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtSurname.EditLabel.Font.Color := clBlack;
  if lbledtPassword.Text = '' then
  begin
    lbledtPassword.EditLabel.Font.Color := clRed;
    lblPassword.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtPassword.EditLabel.Font.Color := clBlack;
  if lbledtConfirmPassword.Text = '' then
  begin
    lbledtConfirmPassword.EditLabel.Font.Color := clRed;
    lblPassword.Font.Color := clRed;
    bInvalid := True;
  end
  else
    lbledtConfirmPassword.EditLabel.Font.Color := clBlack;

  if bInvalid = False then
  begin
    User := TUser.Create(lbledtName.Text,lbledtSurname.Text,lbledtPassword.Text,lbledtConfirmPassword.Text);
    frmHome.sUserStatus := User.fUserStatus;
    if frmHome.sUserStatus = 'Account registered' then
      frmRegister.Close
    else
      if frmHome.sUserStatus = 'Special or number' then
        lblPassword.Font.Color := clRed;
  end;
end;

procedure TfrmRegister.FormShow(Sender: TObject);
begin
  lblLogIn.Font.Color := clWebDeepskyBlue;

  lbledtName.Text := '';
  lbledtSurname.Text := '';
  lbledtPassword.Text := '';
  lbledtConfirmPassword.Text := '';
  lbledtName.SetFocus;
end;

procedure TfrmRegister.lblLogInClick(Sender: TObject);
begin
  frmRegister.Hide;
  frmLogin.Show;
end;

end.
