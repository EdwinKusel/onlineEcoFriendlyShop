unit Shop_U;

interface

uses
  dmData_U, system.SysUtils, Vcl.Dialogs, Vcl.Controls, System.Math, System.Variants;

type
  TCart = class
  private
    fItemName: string;
  public
    fItemNumber, fMaxValue: Integer;
    procedure SearchMinimumMaximum(pSearch, pMinimum, pMaximum: string);
    procedure AddToCart(pAmountPurchased: Integer);
    function DisplayCart: string;
    constructor Create(pItemName: string);
  end;
  TUser = class
    fUserStatus: string;
    constructor Create(pName, pSurname, pPassword: string); overload;
    constructor Create(pName, pSurname, pPassword, pConfirmPassword: string); overload;
  end;
  TPurchase = class(TCart)
    function DisplayCartSummary: string;
    procedure RemoveAnItem(iAmount: Integer; sItem: string);
  end;
  TDelivery = class
    function DisplayDeliveryInfo: string;
    procedure ChangeOrAddAddress(pStreetAddress, pSuburb, pCityOrTown, pProvince: string; pPostalCode: Integer);
  end;
  TPayment = class
    procedure ResetShop;
    procedure UpdateDatabase;
    procedure UpdateAuditTrail;
  end;
  TAdmin = class
    procedure RemoveUser(pName, pSurname: string);
    procedure ChangeProductInfo(pChangeProductName, pChangeStock, pPrice, pCostPrice: string);
    procedure NewProduct(pNewProductName, pStock, pPrice, pCostPrice: string);
  end;

implementation

  var
    iUserRecordNumber: Integer;
    arrItem: array of string;
    arrAmount, arrItemAmount: array of Integer;
    tAuditTrail: TextFile;

{ TCart }

procedure TCart.AddToCart(pAmountPurchased: Integer);
var
  bSame: Boolean;
begin
  with dmData do
  begin
    tblProductInformation.RecNo := fItemNumber;
    for var I := 0 to Length(arrItem)-1 do
    begin
      if fItemName = arrItem[I] then
      begin
        bSame := True;
        arrAmount[I] := arrAmount[I] + pAmountPurchased;
        arrItemAmount[I] := arrItemAmount[I] + tblProductInformation['Price']*pAmountPurchased;
        Break;
      end;
    end;
    if bSame = False then
    begin
      arrItem[Length(arrItem)-1] := fItemName;
      arrAmount[Length(arrItem)-1] := pAmountPurchased;
      arrItemAmount[Length(arrItem)-1] := tblProductInformation['Price']*pAmountPurchased;
      SetLength(arrItem,Length(arrItem)+1);
      SetLength(arrAmount,Length(arrAmount)+1);
      SetLength(arrItemAmount,Length(arrItemAmount)+1);
    end;
  end;
end;

constructor TCart.Create(pItemName: string);
begin
  with dmData do
  begin
    fItemName := pItemName;
    tblProductInformation.First;
    while not tblProductInformation.Eof do
    begin
      if tblProductInformation['Product name'] = fItemName then
      begin
        fItemNumber := tblProductInformation.RecNo;
        fMaxValue := tblProductInformation['Stock available'];
        Break;
      end;
      tblProductInformation.Next;
    end;
  end;
end;

function TCart.DisplayCart: string;
begin
  for var I := 0 to Length(arrItem)-2 do
    Result := Result + 'Item added to cart: ' + arrItem[I] + #10 + 'Amount added to cart: ' + IntToStr(arrAmount[I]) + #10 + 'Amount for item: R' + IntToStr(arrItemAmount[I]) + #10;
end;

procedure TCart.SearchMinimumMaximum(pSearch, pMinimum, pMaximum: string);
begin
  with dmData do
  begin
    qryProductInformation.Close;
    if (pMinimum = 'Minimum price') and (pMaximum = 'Maximum price') then
      qryProductInformation.SQL.Text := ' SELECT [Product name], [Stock available], Price FROM tblProductInformation WHERE [Product name] LIKE "%' + pSearch + '%"' + ' ORDER BY [Product Name]';
    if (pMinimum <> 'Minimum price') and (pMaximum = 'Maximum price') then
      qryProductInformation.SQL.Text := ' SELECT [Product name], [Stock available], Price FROM tblProductInformation WHERE [Product name] LIKE "%' + pSearch + '%" AND Price >= ' + pMinimum + ' ORDER BY [Product Name]';
    if (pMinimum = 'Minimum price') and (pMaximum <> 'Maximum price') then
      qryProductInformation.SQL.Text := ' SELECT [Product name], [Stock available], Price FROM tblProductInformation WHERE [Product name] LIKE "%' + pSearch + '%" AND Price <= ' + pMaximum + ' ORDER BY [Product Name]';
    if (pMinimum <> 'Minimum price') and (pMaximum <> 'Maximum price') then
      qryProductInformation.SQL.Text := ' SELECT [Product name], [Stock available], Price FROM tblProductInformation WHERE [Product name] LIKE "%' + pSearch + '%" AND Price >= ' + pMinimum + ' AND Price <= ' + pMaximum + ' ORDER BY [Product Name]';
    qryProductInformation.Open;
  end;

  AssignFile(tAuditTrail,'AuditTrail.txt');

  Reset(tAuditTrail);
  Append(tAuditTrail);
  Writeln(tAuditTrail,'pop');

  CloseFile(tAuditTrail);

end;

{ TPurchase }

function TPurchase.DisplayCartSummary: string;
begin
  Result := 'Total:(' + IntToStr(SumInt(arrAmount)) + ' items) '+ #9 + 'R' + IntToStr(SumInt(arrItemAmount));
end;

procedure TPurchase.RemoveAnItem(iAmount: Integer; sItem: string);
var
  bFound: Boolean;
begin
  for var I := 0 to Length(arrItem)-2 do
  begin
    if UpperCase(sItem) = UpperCase(arrItem[I]) then
    begin
      if Abs(iAmount) >= arrAmount[I] then
      begin
        Delete(arrItemAmount,I,1);
        Delete(arrItem,I,1);
        Delete(arrAmount,I,1);
      end
      else
      begin
        arrItemAmount[I] := Round(arrItemAmount[I]/arrAmount[I]*(arrAmount[I]-Abs(iAmount)));
        arrAmount[I] := arrAmount[I] - Abs(iAmount);
      end;
      bFound := True;
      Break;
    end;
  end;
  if bFound = False then
    ShowMessage('Product not found');
end;

{ TDelivery }

procedure TDelivery.ChangeOrAddAddress(pStreetAddress, pSuburb, pCityOrTown, pProvince: string; pPostalCode: Integer);
begin
  with dmData do
  begin
    qryClientInformation.Close;
    qryClientInformation.SQL.Clear;
    qryClientInformation.SQL.Add('UPDATE tblClientInformation SET [Street address] = ' + QuotedStr(pStreetAddress) + ', Suburb = ' + QuotedStr(pSuburb) + ', City = ' + QuotedStr(pCityOrTown) + ', Province = ' + QuotedStr(pProvince) + ', [Postal code] = ' + IntToStr(pPostalCode) + ' WHERE ClientID = ' + IntToStr(iUserRecordNumber));
    qryClientInformation.ExecSQL;
  end;
end;

function TDelivery.DisplayDeliveryInfo: string;
begin
  with dmData do
  begin
    tblClientInformation.RecNo := iUserRecordNumber;
    if tblClientInformation['Street address'] <> null then
      Result := 'Street Address:' + #9 + tblClientInformation['Street address'] + #10 + 'Suburb:' + #9 + tblClientInformation['Suburb'] + #10 + 'City:' + #9 + tblClientInformation['City'] + #10 + 'Province:' + #9 + tblClientInformation['Province'] + #10 + 'Postal code:' + #9 + IntToStr(tblClientInformation['Postal code'])
    else
      Result := 'No address found';
  end;
end;

{ TUser }

constructor TUser.Create(pName, pSurname, pPassword: string);
begin
  with dmData do
  begin
    tblClientInformation.First;
    while not tblClientInformation.Eof do
    begin
      if (tblClientInformation['Name'] = pName) and (tblClientInformation['Surname'] = pSurname) and (tblClientInformation['Password'] = pPassword) then
      begin
        if tblClientInformation['Admin'] then
          fUserStatus := 'Admin'
        else
          fUserStatus := 'Client';
        iUserRecordNumber := tblClientInformation.RecNo;
        Break;
      end;
      tblClientInformation.Next;
    end;
  end;
end;

constructor TUser.Create(pName, pSurname, pPassword, pConfirmPassword: string);
var
  bSpecialOrNumber: Boolean;
begin
  bSpecialOrNumber := False;
  if pPassword = pConfirmPassword then
  begin
    for var I := 1 to Length(pPassword) do
      if pPassword[I] in ['!','@','#','$','%','1'..'9'] then
      begin
        bSpecialOrNumber := True;
        Break;
      end;
    if not ((Length(pPassword) >= 8) and bSpecialOrNumber) then
      fUserStatus := 'Special or number';
    if (Length(pPassword) >= 8) and bSpecialOrNumber then
    begin
      fUserStatus := 'Account registered';
      ShowMessage(fUserStatus);
      with dmData do
      begin
        iUserRecordNumber := tblClientInformation.RecordCount + 1;
        qryClientInformation.Close;
        qryClientInformation.SQL.Clear;
        qryClientInformation.SQL.Add('INSERT INTO tblClientInformation (ClientID, [Name], Surname, [Password]) VALUES (' + IntToStr(tblClientInformation.RecordCount + 1) + ', ' + QuotedStr(pName) +', ' + QuotedStr(pSurname) + ',' + QuotedStr(pPassword) + ')');
        qryClientInformation.ExecSQL;
      end;
    end;
  end
  else
      ShowMessage('Passwords don''t match');
end;

{ TPayment }

procedure TPayment.ResetShop;
begin
  Delete(arrItem,0,length(arrItem));
  Delete(arrAmount,0,length(arrAmount));
  Delete(arrItemAmount,0,length(arrItemAmount));

  SetLength(arrItem,1);
  SetLength(arrAmount,1);
  SetLength(arrItemAmount,1);
end;

procedure TPayment.UpdateAuditTrail;
begin
  dmData.tblClientInformation.RecNo := iUserRecordNumber;

  AssignFile(tAuditTrail, 'AuditTrail.txt');

  Reset(tAuditTrail);
  Append(tAuditTrail);
  Writeln(tAuditTrail,'C,' + dmData.tblClientInformation['Name'] + ',' + dmData.tblClientInformation['Surname']);

  CloseFile(tAuditTrail);
end;

procedure TPayment.UpdateDatabase;
begin
  with dmData do
  begin
    for var I := 0 to Length(arrItem)-1 do
    begin
      tblProductInformation.First;
      while not tblProductInformation.Eof do
      begin
        if tblProductInformation['Product name'] = arrItem[I] then
        begin
          tblProductInformation.Edit;
          tblProductInformation['Stock Available'] := tblProductInformation['Stock Available'] - arrAmount[I];
          tblProductInformation.Post;
          Break;
        end;
        tblProductInformation.Next;
      end;
    end;
  end;
end;

{ TAdmin }

procedure TAdmin.ChangeProductInfo(pChangeProductName, pChangeStock, pPrice, pCostPrice: string);
begin
  with dmData do
  begin
    if (pChangeProductName = tblProductInformation['Product name']) and (pChangeStock = IntToStr(tblProductInformation['Stock Available'])) and (pPrice = FloatToStr(tblProductInformation['Price'])) and (pCostPrice = FloatToStr(tblProductInformation['Cost price'])) then
      ShowMessage('No changes were made')
    else
    begin
      qryProductInformation.Close;
      qryProductInformation.SQL.Clear;
      qryProductInformation.SQL.Add('UPDATE tblProductInformation SET [Product name] = ' + QuotedStr(pChangeProductName) + ', [Stock Available] = ' + pChangeStock + ', Price = ' + pPrice + ', [Cost price] = ' + pCostPrice + ' where [Product name] = ' + QuotedStr(pChangeProductName));
      qryProductInformation.ExecSQL;
      ShowMessage('Product information changed');
    end;
  end;
end;

procedure TAdmin.NewProduct(pNewProductName, pStock, pPrice, pCostPrice: string);
begin
  with dmData do
  begin
    qryProductInformation.Close;
    qryProductInformation.SQL.Clear;
    qryProductInformation.SQL.Add('INSERT INTO tblProductInformation (ProductID, [Product name], [Stock available], Price, [Cost price]) VALUES (' + IntToStr(tblProductInformation.RecordCount + 1) + ', ' + QuotedStr(pNewProductName) + ', ' + pStock + ', ' + pPrice + ', ' + pCostPrice + ')');
    qryProductInformation.ExecSQL;
    ShowMessage('Product ''''' + pNewProductName + ''''' added');
  end;
end;

procedure TAdmin.RemoveUser(pName, pSurname: string);
var
  bFound: Boolean;
begin
  with dmData do
  begin
    tblClientInformation.First;
    while not tblClientInformation.Eof do
    begin
      if (pName = tblClientInformation['Name']) and (pSurname = tblClientInformation['Surname']) then
      begin
        bFound := True;
        qryClientInformation.Close;
        qryClientInformation.SQL.Clear;
        qryClientInformation.SQL.Add('DELETE FROM tblClientInformation WHERE Name = ' + QuotedStr(pName) + ' AND Surname = ' + QuotedStr(pSurname));
        qryClientInformation.ExecSQL;
        ShowMessage('User ' + pName + ' ' + pSurname + '''s record was removed');
        Break;
      end;
      tblClientInformation.Next;
    end;
    if bFound = False then
      ShowMessage('User ' + pName + ' ' + pSurname + '''s was not found');
  end;
end;

initialization
begin
  SetLength(arrItem,1);
  SetLength(arrAmount,1);
  SetLength(arrItemAmount,1);
end;

end.
