object frmRegister: TfrmRegister
  Left = 0
  Top = 0
  Caption = 'Register'
  ClientHeight = 366
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OnShow = FormShow
  TextHeight = 15
  object lblPassword: TLabel
    Left = 5
    Top = 189
    Width = 275
    Height = 15
    Caption = 'At least 8 characters and 1 special character/number'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblAlready: TLabel
    Left = 8
    Top = 349
    Width = 135
    Height = 15
    Caption = 'Already have an account?'
  end
  object lblLogIn: TLabel
    Left = 149
    Top = 349
    Width = 33
    Height = 30
    Caption = 'Log in'#13#10
    OnClick = lblLogInClick
  end
  object lbledtPassword: TLabeledEdit
    Left = 5
    Top = 115
    Width = 279
    Height = 23
    EditLabel.Width = 50
    EditLabel.Height = 15
    EditLabel.Caption = 'Password'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Segoe UI Semibold'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    PasswordChar = '*'
    TabOrder = 2
    Text = ''
  end
  object btnRegister: TButton
    Left = 5
    Top = 227
    Width = 279
    Height = 90
    Caption = 'Register'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnRegisterClick
  end
  object lbledtName: TLabeledEdit
    Left = 5
    Top = 25
    Width = 279
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 15
    EditLabel.Caption = 'Name'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Segoe UI Semibold'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = ''
  end
  object lbledtSurname: TLabeledEdit
    Left = 5
    Top = 70
    Width = 279
    Height = 23
    EditLabel.Width = 48
    EditLabel.Height = 15
    EditLabel.Caption = 'Surname'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Segoe UI Semibold'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    TabOrder = 1
    Text = ''
  end
  object lbledtConfirmPassword: TLabeledEdit
    Left = 5
    Top = 160
    Width = 279
    Height = 23
    EditLabel.Width = 96
    EditLabel.Height = 15
    EditLabel.Caption = 'Confirm password'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -12
    EditLabel.Font.Name = 'Segoe UI Semibold'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    PasswordChar = '*'
    TabOrder = 3
    Text = ''
  end
end
