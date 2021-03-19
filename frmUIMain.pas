unit frmUIMain;

interface

uses
  midaslib
, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient;

type
  TForm1 = class(TForm)
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure OnCalcFields(aDataSet: TDataSet);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  lFieldDef: TFieldDef;
begin
  lFieldDef := ClientDataSet1.FieldDefs.AddFieldDef;
  lFieldDef.Name := 'FirstName';
  lFieldDef.DataType := ftString;
  lFieldDef.CreateField(ClientDataSet1).FieldKind := fkData;

  lFieldDef := ClientDataSet1.FieldDefs.AddFieldDef;
  lFieldDef.Name := 'LastName';
  lFieldDef.DataType := ftString;
  lFieldDef.CreateField(ClientDataSet1).FieldKind := fkData;

  lFieldDef := ClientDataSet1.FieldDefs.AddFieldDef;
  lFieldDef.Name := 'ACalculatedField';
  lFieldDef.DataType := ftString;
  lFieldDef.CreateField(ClientDataSet1).FieldKind := fkCalculated;

  ClientDataSet1.OnCalcFields := OnCalcFields;
  ClientDataSet1.CreateDataSet;
  ClientDataSet1.Active := True;

  ClientDataSet1.Insert;
  ClientDataSet1.FieldByName('FirstName').AsString := 'John';
  ClientDataSet1.FieldByName('LastName').AsString := 'Smith';
  ClientDataSet1.Post;
  ClientDataSet1.Insert;
  ClientDataSet1.FieldByName('FirstName').AsString := 'Jane';
  ClientDataSet1.FieldByName('LastName').AsString := 'Doe';
  ClientDataSet1.Post;
end;

procedure TForm1.OnCalcFields(aDataSet: TDataSet);
begin
  if ClientDataSet1.FieldByName('FirstName').AsString = 'Jane' then
    ClientDataSet1.FieldByName('ACalculatedField').AsString := 'Hi Jane'
  else
    ClientDataSet1.FieldByName('ACalculatedField').AsString := 'Not Jane!';
end;

end.
