unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.Menus, Vcl.ExtCtrls, Unit2, Unit3, Unit4,
  Vcl.Buttons;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    MainMenu1: TMainMenu;
    Noviclan1: TMenuItem;
    Uplata1: TMenuItem;
    Izvestaj1: TMenuItem;
    SearchBox1: TSearchBox;
    SearchBox2: TSearchBox;
    Panel1: TPanel;
    Label1: TLabel;
    Button1: TButton;
    Panel2: TPanel;
    Label2: TLabel;
    Button2: TButton;
    Panel3: TPanel;
    Label3: TLabel;
    Edit1: TEdit;
    Button3: TButton;
    ADOTable1: TADOTable;
    Panel4: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    N1: TMenuItem;
    RezervaBaze1: TMenuItem;
    Napravirezernukopiju1: TMenuItem;
    echSupport1: TMenuItem;
    Administrator1: TMenuItem;
    N2: TMenuItem;
    ADMINISTRATORAKTIVIRAN1: TMenuItem;
    procedure SearchBox1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SearchBox2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Noviclan1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Uplata1Click(Sender: TObject);
    procedure Izvestaj1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure Napravirezernukopiju1Click(Sender: TObject);
    procedure Administrator1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);

  private
    { Private declarations }
  public
      { Public declarations }
  end;
  
var
  Form1: TForm1;
  buttonSelected : integer;
  datum : TDateTime;
  admin : boolean;

implementation

{$R *.dfm}

uses Unit5;


procedure TForm1.Administrator1Click(Sender: TObject);
begin
  Form5.Visible:=True;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  buttonSelected := messageDlg('Da li ste sigurni?',mtCustom,[mbYes,mbNo], 0);
  if buttonSelected = mrYes then
    begin
      Form4.ADOTable1.Append;
      Form4.ADOTable1.FieldValues['Broj_karte']:=ADOTable1.FieldValues['Broj_karte'];
      Form4.ADOTable1.FieldValues['Ime_prezime']:=ADOTable1.FieldValues['Ime_prezime'];
      Form4.ADOTable1.FieldValues['Akcija']:='Obrisan';
      Form4.ADOTable1.FieldValues['Datum_akcije']:=datum;
      Form4.ADOTable1.Post;
      ADOTable1.Locate('Ime_prezime','Broj_karte', [loPartialKey]);
      ADOTable1.Delete;
      Label6.Caption:=IntToStr(StrToInt(Label6.Caption)-1);
      DBGrid1.SetFocus;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  If (ADOTable1.FieldByName('Paket').AsString='3x7')Then
    Begin
      ADOTable1.Edit;
      ADOTable1.FieldByName('Dolasci').AsInteger:=StrToInt(ADOTable1.FieldByName('Dolasci').AsString) + 1;
      if(ADOTable1.FieldByName('Dolasci').AsInteger > 11)then
        ADOTable1.FieldByName('Status').AsString := 'Neaktivan';
      ADOTable1.Post;

      Form4.ADOTable1.Append;
      Form4.ADOTable1.FieldValues['Broj_karte']:=ADOTable1.FieldValues['Broj_karte'];
      Form4.ADOTable1.FieldValues['Ime_prezime']:=ADOTable1.FieldValues['Ime_prezime'];
      Form4.ADOTable1.FieldValues['Akcija']:='Dolazak Evid.';
      Form4.ADOTable1.FieldValues['Datum_akcije']:=datum;
      Form4.ADOTable1.FieldValues['Opis']:=ADOTable1.FieldByName('Dolasci').AsString;
      Form4.ADOTable1.Post;
      DBGrid1.SetFocus;
    End
  Else
    ShowMessage('Nemoguce evidentirati ovaj paket');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ADOTable1.Edit;
  ADOTable1.FieldByName('Napomena').AsString:= Edit1.Text;
  ADOTable1.Post;
  Form4.ADOTable1.Append;
  Form4.ADOTable1.FieldValues['Broj_karte']:=ADOTable1.FieldValues['Broj_karte'];
  Form4.ADOTable1.FieldValues['Ime_prezime']:=ADOTable1.FieldValues['Ime_prezime'];
  Form4.ADOTable1.FieldValues['Akcija']:='Napomena';
  Form4.ADOTable1.FieldValues['Datum_akcije']:=datum;
  Form4.ADOTable1.FieldValues['Opis']:=ADOTable1.FieldByName('Napomena').AsString;
  Form4.ADOTable1.Post;
  Edit1.Text:='';
  DBGrid1.SetFocus;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
  Edit1.Text:=ADOTable1.FieldByName('Napomena').AsString;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  if admin=true then
    begin
      DBGrid1.Options:=DBGrid1.Options - [dgRowSelect];
      DBGrid1.Options:=DBGrid1.Options + [dgEditing];
    end
  else
    begin
      DBGrid1.Options:=DBGrid1.Options - [dgEditing];
      DBGrid1.Options:=DBGrid1.Options + [dgRowSelect];
    end;
end;

procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
Edit1.Text:=ADOTable1.FieldByName('Napomena').AsString;
end;

procedure TForm1.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
Edit1.Text:=ADOTable1.FieldByName('Napomena').AsString;
end;

procedure TForm1.DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
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

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
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

procedure TForm1.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  DBGrid1.Top:=10;
  IF (WindowState = wsMaximized) then
    Begin
      DBGrid1.Width:= NewWidth - 20;
      DBGrid1.Height:=NewHeight - 180;
      Panel1.Left:= NewWidth - 126;
      Panel1.Top:= 380 + NewHeight - 535;
      Panel2.Top:= 380 + NewHeight - 535;
      Panel3.Top:= 380 + NewHeight - 535;
      Panel4.Top:= 380 + NewHeight - 535;
      SearchBox1.Top:= 380 + NewHeight - 535;
      SearchBox2.Top:= 410 + NewHeight - 535;
    End
    Else
    Begin
      DBGrid1.Width:= NewWidth - 20;
      DBGrid1.Height:=NewHeight - 140;
      Panel1.Left:= NewWidth - 126;
      Panel1.Top:= 380 + NewHeight - 500;
      Panel2.Top:= 380 + NewHeight - 500;
      Panel3.Top:= 380 + NewHeight - 500;
      Panel4.Top:= 380 + NewHeight - 500;
      SearchBox1.Top:= 380 + NewHeight - 500;
      SearchBox2.Top:= 410 + NewHeight - 500;
    End
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  istek:TDate;
  ukClanova, ukAktivnih: longint;
begin
  admin:=false;
  datum:=Date;
  ukClanova:=0;
  ukAktivnih:=0;
  ADOTable1.Open;
  while not ADOTable1.Eof do
    begin
      ukClanova:=ukClanova+1;
      istek:=ADOTable1.FieldByName('Datum_isteka').AsDateTime;
      If (datum > istek) then
        begin
          ADOTable1.Edit;
          ADOTable1.FieldByName('Status').AsString := 'Neaktivan';
          ADOTable1.Post;
        end
      Else
        begin
          ADOTable1.Edit;
          if(ADOTable1.FieldByName('Dolasci').AsInteger > 11)then
            ADOTable1.FieldByName('Status').AsString := 'Neaktivan'
          else
            begin
              ADOTable1.FieldByName('Status').AsString := 'Aktivan';
              ukAktivnih:=ukAktivnih+1;
            end;
          ADOTable1.Post;
        end;
      ADOTable1.Next;
    end;
    ADOTable1.Refresh;
    ADOTable1.First;
    Label6.Caption:=IntToStr(ukClanova);
    Label7.Caption:=IntToStr(ukAktivnih);
end;

procedure TForm1.Izvestaj1Click(Sender: TObject);
begin
  Form4.Visible:=True;
end;

procedure TForm1.Napravirezernukopiju1Click(Sender: TObject);
begin
  CopyFile('C:\Fitness_Prog\db.mdb', 'C:\Fitness_Prog\backup\1.mdb', False);
  if RenameFile('C:\Fitness_Prog\backup\1.mdb', 'C:\Fitness_Prog\backup\'+DateToStr(date)+'.mdb')
  then ShowMessage('Uspesno napravljena kopija baze podataka!')
  else
    ShowMessage('Neuspesna obrada zahteva!');
end;

procedure TForm1.Noviclan1Click(Sender: TObject);
begin
  Form2.Visible:=True;
end;

procedure TForm1.SearchBox1Change(Sender: TObject);
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

procedure TForm1.SearchBox2Change(Sender: TObject);
begin
  IF SearchBox2.Text <> '' THEN
    Begin
        //ADOTable1.Filter:= Format('Broj_karte LIKE ''%s%%''',[SearchBox2.Text]);
        //ADOTable1.Locate('Broj_karte', SearchBox2.Text, [loCaseInsensitive, loPartialKey]);
        ADOTable1.Filter:='Broj_karte = ' + QuotedStr(SearchBox2.Text);
        ADOTable1.Filtered:=True;
        SearchBox2.SetFocus;
    End
  Else
    ADOTable1.Filtered:=False;
end;

procedure TForm1.Uplata1Click(Sender: TObject);
begin
  Form3.Visible:=True;
end;

end.
