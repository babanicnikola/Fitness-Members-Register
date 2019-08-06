unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Data.Win.ADODB, Vcl.StdCtrls, frxClass, frxExportBaseDialog, frxExportPDF,
  frxDBSet, Vcl.WinXCtrls;

type
  TForm4 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    frxReport1: TfrxReport;
    Button1: TButton;
    frxDBDataset1: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    SearchBox1: TSearchBox;
    SearchBox2: TSearchBox;
    SearchBox3: TSearchBox;
    ADOTable1: TADOTable;
    procedure Button1Click(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
    procedure SearchBox2Change(Sender: TObject);
    procedure SearchBox3Change(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure SearchBox1Click(Sender: TObject);
    procedure SearchBox2Click(Sender: TObject);
    procedure SearchBox3Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  frxReport1.ShowReport();
end;

procedure TForm4.DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
 pt: TGridcoord;
begin
 pt:= DBGrid1.MouseCoord(x, y);
 if pt.y=0 then
 DBGrid1.Cursor:=crHandPoint
 else
 DBGrid1.Cursor:=crDefault;
end;

procedure TForm4.DBGrid1TitleClick(Column: TColumn);
{$J+}
  const PreviousColumnIndex : integer = 0;
{$J-}
begin

if DBGrid1.DataSource.DataSet is TCustomADODataSet then
  with DBGrid1.DataSource.DataSet do
    begin
      try
        DBGrid1.Columns[PreviousColumnIndex].title.Font.Style :=
        DBGrid1.Columns[PreviousColumnIndex].title.Font.Style - [fsBold];
      except
    end;
  Column.title.Font.Style := Column.title.Font.Style + [fsBold];
  PreviousColumnIndex := Column.Index;

  if (ADOTable1.Sort = Column.Field.FieldName + ' ASC') then
    with TCustomADODataSet(DBGrid1.DataSource.DataSet) do
      ADOTable1.Sort := Column.Field.FieldName + ' DESC'
    else
    with TCustomADODataSet(DBGrid1.DataSource.DataSet) do
      ADOTable1.Sort := Column.Field.FieldName + ' ASC';
 end;
end;

procedure TForm4.FormActivate(Sender: TObject);
begin
   SearchBox1.Text:='';
   SearchBox2.Text:='';
   SearchBox3.Text:='';
end;

procedure TForm4.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  DBGrid1.Top:=10;
  DBGrid1.Height:=NewHeight - 80;
  IF (WindowState = wsMaximized) then
    begin
      DBGrid1.Width:= NewWidth - 500;
      Button1.Left:= NewWidth - 300;
      SearchBox1.Left:= NewWidth - 300;
      SearchBox2.Left:= NewWidth - 300;
      SearchBox3.Left:= NewWidth - 300;
    end
  else
    begin
      DBGrid1.Width:= NewWidth - 200;
      Button1.Left:= NewWidth - 145;
      SearchBox1.Left:= NewWidth - 180;
      SearchBox2.Left:= NewWidth - 180;
      SearchBox3.Left:= NewWidth - 180;
    end;
end;

procedure TForm4.SearchBox1Change(Sender: TObject);
begin
  IF SearchBox1.Text <> '' THEN
    Begin
        ADOTable1.Filter:= Format('Ime_prezime LIKE ''%s%%''',[SearchBox1.Text]);
        ADOTable1.Filtered:=true;
        SearchBox1.SetFocus;
    End
  Else
    ADOTable1.Filtered:=false;
end;

procedure TForm4.SearchBox1Click(Sender: TObject);
begin
   SearchBox2.Text:='';
   SearchBox3.Text:='';
end;

procedure TForm4.SearchBox2Change(Sender: TObject);
begin
  IF SearchBox2.Text <> '' THEN
    Begin
        ADOTable1.Filter:='Broj_karte = ' + SearchBox2.Text;
        ADOTable1.Filtered:=True;
        SearchBox2.SetFocus;
    End
  Else
    ADOTable1.Filtered:=False;
end;

procedure TForm4.SearchBox2Click(Sender: TObject);
begin
  SearchBox1.Text:='';
  SearchBox3.Text:='';
end;

procedure TForm4.SearchBox3Change(Sender: TObject);
begin
   IF SearchBox3.Text <> '' THEN
    Begin
        ADOTable1.Filter:= Format('Datum_akcije LIKE ''%s%%''',[SearchBox3.Text]);
        ADOTable1.Filtered:=true;
        SearchBox3.SetFocus;
    End
  Else
    ADOTable1.Filtered:=false;
end;

procedure TForm4.SearchBox3Click(Sender: TObject);
begin
  SearchBox1.Text:='';
  SearchBox2.Text:='';
end;

end.
