unit dmData_U;

interface

uses
  System.SysUtils, System.Classes, ADODB, DB, Windows; //Add ADODB and DB

type
  TdmData = class(TDataModule)
    procedure DataModuleSetup(Sender: TObject);
  public
    conData: TADOConnection; //Connect to the database
    tblClientInformation, tblProductInformation: TADOTable; //Connect to the tables in the database
    qryClientInformation, qryProductInformation: TADOQuery; //Connect to the query in the database
    dscClientInformation, dscProductInformation, dscqryClientInformation, dscqryProductInformation: TDataSource; //Connect to any other components
    procedure RestoreDataBase; //A procedure to reset the database
  end;

var
  dmData: TdmData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmData.DataModuleSetup(Sender: TObject);
begin
//Instatiate the objects
  conData := TADOConnection.Create(dmData);
  tblClientInformation := TADOTable.Create(dmData);
  tblProductInformation := TADOTable.Create(dmData);
  qryClientInformation := TADOQuery.Create(dmData);
  qryProductInformation := TADOQuery.Create(dmData);
  dscClientInformation := TDataSource.Create(dmData);
  dscProductInformation := TDataSource.Create(dmData);
  dscqryClientInformation := TDataSource.Create(dmData);
  dscqryProductInformation := TDataSource.Create(dmData);

//Setup our connection
  conData.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=PATData.mdb;Mode=ReadWrite;Persist Security Info=False';
  conData.LoginPrompt := False;
  conData.Open;

//Setup our tables and query
  tblClientInformation.Connection := conData;
  tblProductInformation.Connection := conData;
  tblClientInformation.TableName := 'tblClientInformation';
  tblProductInformation.TableName := 'tblProductInformation';

  qryClientInformation.Connection := conData;
  qryProductInformation.Connection := conData;

//Setup the datasource
  dscClientInformation.DataSet := tblClientInformation;
  dscProductInformation.DataSet := tblProductInformation;
  dscqryClientInformation.DataSet := qryClientInformation;
  dscqryProductInformation.DataSet := qryProductInformation;

//Open the tables
  tblClientInformation.Open;
  tblProductInformation.Open;
end;

procedure TdmData.RestoreDataBase;
begin
//Restore the database to its original state
  conData.Close;

  tblClientInformation.Destroy;
  tblProductInformation.Destroy;

  DeleteFile('PATData.mdb');
  CopyFile('PATDataBackup.mdb', 'PATData.mdb', False);

  DataModuleSetup(dmData);
end;

end.


