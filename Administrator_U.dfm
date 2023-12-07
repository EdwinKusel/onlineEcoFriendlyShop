object frmAdministrator: TfrmAdministrator
  Left = 0
  Top = 0
  Caption = 'Administrator'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OnClose = FormClose
  TextHeight = 15
  object pgcAdministrator: TPageControl
    Left = 24
    Top = 152
    Width = 585
    Height = 209
    ActivePage = tsAddProduct
    TabOrder = 0
    object tsRemoveUser: TTabSheet
      Caption = 'Remove a user'
      object btnRemoveUser: TButton
        Left = 16
        Top = 128
        Width = 121
        Height = 25
        Caption = 'Remove user'
        TabOrder = 2
        OnClick = btnRemoveUserClick
      end
      object lbledtUsersName: TLabeledEdit
        Left = 16
        Top = 32
        Width = 121
        Height = 23
        EditLabel.Width = 69
        EditLabel.Height = 15
        EditLabel.Caption = 'Users'#39's name'
        TabOrder = 0
        Text = ''
      end
      object lbledtUsersSurname: TLabeledEdit
        Left = 16
        Top = 88
        Width = 121
        Height = 23
        EditLabel.Width = 80
        EditLabel.Height = 15
        EditLabel.Caption = 'User'#39's surname'
        TabOrder = 1
        Text = ''
      end
    end
    object tsEditProduct: TTabSheet
      Caption = 'Edit product information'
      ImageIndex = 1
      object lblChanges: TLabel
        Left = 19
        Top = 56
        Width = 44
        Height = 15
        Caption = 'Change:'
        Visible = False
      end
      object lbledtProductName: TLabeledEdit
        Left = 19
        Top = 96
        Width = 121
        Height = 23
        EditLabel.Width = 83
        EditLabel.Height = 15
        EditLabel.Caption = 'Product'#39's name'
        Enabled = False
        TabOrder = 2
        Text = ''
      end
      object lbledtStock: TLabeledEdit
        Left = 171
        Top = 96
        Width = 121
        Height = 23
        EditLabel.Width = 78
        EditLabel.Height = 15
        EditLabel.Caption = 'Stock available'
        Enabled = False
        TabOrder = 3
        Text = ''
      end
      object lbledtPrice: TLabeledEdit
        Left = 19
        Top = 153
        Width = 121
        Height = 23
        EditLabel.Width = 26
        EditLabel.Height = 15
        EditLabel.Caption = 'Price'
        Enabled = False
        TabOrder = 4
        Text = ''
      end
      object lbledtCostPrice: TLabeledEdit
        Left = 171
        Top = 153
        Width = 121
        Height = 23
        EditLabel.Width = 53
        EditLabel.Height = 15
        EditLabel.Caption = 'Cost price'
        Enabled = False
        TabOrder = 5
        Text = ''
      end
      object btnSearchForProduct: TButton
        Left = 171
        Top = 24
        Width = 123
        Height = 25
        Caption = 'Search for product'
        TabOrder = 1
        OnClick = btnSearchForProductClick
      end
      object lbledtSearchForAProduct: TLabeledEdit
        Left = 19
        Top = 27
        Width = 121
        Height = 23
        EditLabel.Width = 107
        EditLabel.Height = 15
        EditLabel.Caption = 'Search for a product'
        TabOrder = 0
        Text = ''
      end
      object btnMakeChanges: TButton
        Left = 333
        Top = 73
        Width = 113
        Height = 25
        Caption = 'Make changes'
        TabOrder = 6
        Visible = False
        OnClick = btnMakeChangesClick
      end
    end
    object tsRestoreDatabase: TTabSheet
      Caption = 'Restore the database'
      ImageIndex = 2
      object lblRestoreDatabase: TLabel
        Left = 104
        Top = 24
        Width = 206
        Height = 15
        Caption = 'Restore the databse to it'#39's original state'
      end
      object btnRestore: TBitBtn
        Left = 144
        Top = 58
        Width = 129
        Height = 25
        Caption = 'Restore database'
        Kind = bkRetry
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnRestoreClick
      end
    end
    object tsAddProduct: TTabSheet
      Caption = 'Add a new product'
      ImageIndex = 3
      object lbledtProductNameNew: TLabeledEdit
        Left = 64
        Top = 84
        Width = 121
        Height = 23
        EditLabel.Width = 83
        EditLabel.Height = 15
        EditLabel.Caption = 'Product'#39's name'
        TabOrder = 0
        Text = ''
      end
      object lbledtStockNew: TLabeledEdit
        Left = 224
        Top = 87
        Width = 121
        Height = 23
        EditLabel.Width = 78
        EditLabel.Height = 15
        EditLabel.Caption = 'Stock available'
        TabOrder = 1
        Text = ''
      end
      object lbledtPriceNew: TLabeledEdit
        Left = 64
        Top = 137
        Width = 121
        Height = 23
        EditLabel.Width = 26
        EditLabel.Height = 15
        EditLabel.Caption = 'Price'
        TabOrder = 2
        Text = ''
      end
      object lbledtCostPriceNew: TLabeledEdit
        Left = 224
        Top = 137
        Width = 121
        Height = 23
        EditLabel.Width = 53
        EditLabel.Height = 15
        EditLabel.Caption = 'Cost price'
        TabOrder = 3
        Text = ''
      end
      object btnAddProduct: TButton
        Left = 400
        Top = 112
        Width = 89
        Height = 25
        Caption = 'Add product'
        TabOrder = 4
        OnClick = btnAddProductClick
      end
    end
    object tsRemoveProduct: TTabSheet
      Caption = 'Remove a product'
      ImageIndex = 4
      object lbledtProductNameRemove: TLabeledEdit
        Left = 72
        Top = 92
        Width = 121
        Height = 23
        EditLabel.Width = 83
        EditLabel.Height = 15
        EditLabel.Caption = 'Product'#39's name'
        TabOrder = 0
        Text = ''
      end
      object btnRemoveProduct: TButton
        Left = 272
        Top = 88
        Width = 97
        Height = 25
        Caption = 'Remove product'
        TabOrder = 1
        OnClick = btnRemoveProductClick
      end
    end
  end
end
