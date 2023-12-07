object frmPayment: TfrmPayment
  Left = 0
  Top = 0
  Caption = 'Payment'
  ClientHeight = 369
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object lblCardDescription: TLabel
    Left = 5
    Top = 130
    Width = 92
    Height = 15
    Caption = 'E.g. my FNB Card'
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lblCollection: TLabel
    Left = 5
    Top = 28
    Width = 92
    Height = 25
    Caption = 'Collection/'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    OnClick = lblCollectionClick
  end
  object lblPayment: TLabel
    Left = 95
    Top = 28
    Width = 83
    Height = 25
    Caption = ' Payment'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblExpiryDate: TLabel
    Left = 5
    Top = 245
    Width = 61
    Height = 15
    Caption = 'Expiry date:'
  end
  object lbledtCardDescription: TLabeledEdit
    Left = 5
    Top = 105
    Width = 291
    Height = 23
    EditLabel.Width = 87
    EditLabel.Height = 15
    EditLabel.Caption = 'Card description'
    TabOrder = 0
    Text = ''
  end
  object pnlCartSummary: TPanel
    Left = 301
    Top = 105
    Width = 319
    Height = 203
    TabOrder = 1
    object lblCartSummary: TLabel
      Left = 8
      Top = 8
      Width = 4
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object lbledtNameOnCard: TLabeledEdit
    Left = 5
    Top = 165
    Width = 291
    Height = 23
    EditLabel.Width = 75
    EditLabel.Height = 15
    EditLabel.Caption = 'Name on card'
    TabOrder = 2
    Text = ''
  end
  object lbledtCardNumber: TLabeledEdit
    Left = 5
    Top = 210
    Width = 291
    Height = 23
    EditLabel.Width = 70
    EditLabel.Height = 15
    EditLabel.Caption = 'Card number'
    EditMask = '0000000000000000;1;_'
    MaxLength = 16
    TabOrder = 3
    Text = '                '
  end
  object cbbMonth: TComboBox
    Left = 71
    Top = 242
    Width = 110
    Height = 23
    TabOrder = 4
    Text = 'Month'
    OnChange = cbbMonthChange
    Items.Strings = (
      '01'
      '02'
      '03'
      '04'
      '05'
      '06'
      '07'
      '08'
      '09'
      '10'
      '11'
      '12')
  end
  object cbbYear: TComboBox
    Left = 186
    Top = 242
    Width = 110
    Height = 23
    TabOrder = 5
    Text = 'Year'
    OnChange = cbbYearChange
    Items.Strings = (
      '2023'
      '2024'
      '2025'
      '2026'
      '2027'
      '2028'
      '2029'
      '2030'
      '2031'
      '2032'
      '2033')
  end
  object lbledtCVV: TLabeledEdit
    Left = 5
    Top = 285
    Width = 60
    Height = 23
    EditLabel.Width = 22
    EditLabel.Height = 15
    EditLabel.Caption = 'CVV'
    EditMask = '000;1;_'
    MaxLength = 3
    TabOrder = 6
    Text = '   '
  end
  object btnCancel: TButton
    Left = 5
    Top = 313
    Width = 291
    Height = 51
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = btnCancelClick
  end
  object btnPay: TButton
    Left = 301
    Top = 313
    Width = 319
    Height = 51
    Caption = 'Pay'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = btnPayClick
  end
end
