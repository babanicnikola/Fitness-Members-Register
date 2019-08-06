unit Form_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, ExtCtrls, DBCtrls,
  OleServer, AccessXP, comobj, FMTBcd, SqlExpr, jpeg, ComCtrls, DateUtils,
  Menus;

type
  TFormMain = class(TForm)
    MainConnection: TADOConnection;
    Table1: TADOTable;
    Panel1: TPanel;
    Label4: TLabel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Panel5: TPanel;
    Label6: TLabel;
    Button4: TButton;
    Edit2: TEdit;
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Edit1: TEdit;
    RadioGroup3: TRadioGroup;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    hemes1: TMenuItem;
    Red1: TMenuItem;
    Green1: TMenuItem;
    Blue1: TMenuItem;
    White1: TMenuItem;
    Black1: TMenuItem;
    Label5: TLabel;
    Izvestaj1: TMenuItem;
    Table2: TADOTable;
    DataSource2: TDataSource;
    Panel4: TPanel;
    Label7: TLabel;
    Button3: TButton;
    Panel6: TPanel;
    Label8: TLabel;
    Edit4: TEdit;
    Button5: TButton;
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Creator1Click(Sender: TObject);
    procedure Owner1Click(Sender: TObject);
    procedure Blue1Click(Sender: TObject);
    procedure Red1Click(Sender: TObject);
    procedure Green1Click(Sender: TObject);
    procedure White1Click(Sender: TObject);
    procedure Black1Click(Sender: TObject);
    procedure Izvestaj1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;
  buttonSelected : integer;
  datum : TDateTime;
implementation

uses Unit1, Unit2, Unit3;

{$R *.dfm}

procedure TFormMain.Edit1Change(Sender: TObject);
begin
  IF Edit1.Text <> '' THEN
    Begin
        table1.Filter:= Format('Ime_prezime LIKE ''%s%%''',[Edit1.Text]);
        table1.Filtered:=true;
        edit1.SetFocus;
    End
  Else
    table1.Filtered:=false;
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
  buttonSelected := messagedlg('Da li ste sigurni?',mtCustom,
                              [mbYes,mbCancel], 0);
  table2.Open;
  table2.Append;
  table2.FieldValues['Broj_karte']:=table1.FieldValues['Broj_karte'];
  table2.FieldValues['Ime_prezime']:=table1.FieldValues['Ime_prezime'];
  table2.FieldValues['Paket']:='Obrisan';
  table2.FieldValues['Datum_uplate']:=table1.FieldValues['Datum_uplate'];
  table2.Post;
  // Show the button type selected
  if buttonSelected = mrYes then
    begin
      Table1.Locate('Ime_prezime','Broj_karte', [loPartialKey]);
      Table1.Delete;
    end;
end;

procedure TFormMain.Button1Click(Sender: TObject);
begin
  if (edit2.text='') then
    ShowMessage('Unesi ime i prezime!')
  else
  if (RadioGroup1.ItemIndex=-1) then
    ShowMessage('Odaberi paket!')
  else
  if (RadioGroup3.ItemIndex=-1) then
    ShowMessage('Odaberi pol!')
  else
    begin
      table1.Open;
      table1.Append;
      table1.FieldValues['Ime_prezime']:= edit2.Text;
      if (RadioGroup3.ItemIndex=0) then
          table1.FieldValues['Pol']:= 'muski'
        else
          table1.FieldValues['Pol']:= 'zenski';
      if (RadioGroup1.ItemIndex=0) then
          table1.FieldValues['Paket']:= '3x7'
        else if(RadioGroup1.ItemIndex=1) then
          table1.FieldValues['Paket']:= '7x7'
        else if(RadioGroup1.ItemIndex=2) then
          table1.FieldValues['Paket']:= 'Student7x7'
        else if(RadioGroup1.ItemIndex=3) then
          table1.FieldValues['Paket']:= 'Godisnja';
      table1.FieldValues['Datum_uplate']:=DateToStr(datum);
      if(RadioGroup1.ItemIndex=3) then
        table1.FieldValues['Datum_isteka']:=IncMonth((datum),12)
      else
        table1.FieldValues['Datum_isteka']:=IncMonth(datum);
      table1.FieldValues['Status']:='Aktivan';
      table1.FieldValues['Dolasci']:='0';
      table1.Post;
      edit2.text:='';
      RadioGroup1.ItemIndex:=-1;
      RadioGroup3.ItemIndex:=-1;
      table2.Open;
      table2.Append;
      table2.FieldValues['Broj_karte']:=table1.FieldValues['Broj_karte'];
      table2.FieldValues['Ime_prezime']:=table1.FieldValues['Ime_prezime'];
      table2.FieldValues['Paket']:=table1.FieldValues['Paket'];
      table2.FieldValues['Datum_uplate']:=table1.FieldValues['Datum_uplate'];
      table2.Post;
    end;
end;

procedure TFormMain.FormActivate(Sender: TObject);
var
  istek:TDate;
begin
  datum:=Date;
  Table1.Open;
  while not Table1.Eof do
    begin
      istek:=Table1.FieldByName('Datum_isteka').AsDateTime;
      If (datum > istek) then
        begin
          Table1.Edit;
          Table1.FieldByName('Status').AsString := 'Neaktivan';
          table1.Post;
        end
      Else
        begin
          Table1.Edit;
          if(Table1.FieldByName('Dolasci').AsInteger > 11)then
            Table1.FieldByName('Status').AsString := 'Neaktivan'
          else
            Table1.FieldByName('Status').AsString := 'Aktivan';
          table1.Post;
        end;
      Table1.Next;
    end;
    table1.Refresh;
    Table1.First;
end;


procedure TFormMain.Button4Click(Sender: TObject);
var
  datIsteka:TDate;
begin
  with Table1 do
  begin
    Locate('ime_prezime', 'broj_karte', [loPartialKey]);
    Edit;
    datIsteka:=table1.FieldByName('Datum_isteka').AsDateTime;
    if (RadioGroup2.ItemIndex=-1) then
      ShowMessage('Odaberi paket')
    else
    if (RadioGroup2.ItemIndex=0) then
      begin
        FieldByName('Paket').AsString:='3x7';
        FieldByName('Dolasci').AsString:='0';
        table1.FieldByName('Datum_uplate').AsString:=DateToStr(datum);
        if (table1.FieldByName('Status').AsString='Aktivan')then
          table1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datIsteka))
        else
          begin
            table1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datum));
            table1.FieldByName('Status').AsString:='Aktivan';
          end;
      end;
    if(RadioGroup2.ItemIndex=1) then
      begin
        table1.FieldByName('Paket').AsString:= '7x7';
        FieldByName('Dolasci').AsString:='0';
        table1.FieldByName('Datum_uplate').AsString:=DateToStr(datum);
        if (table1.FieldByName('Status').AsString='Aktivan')then
          table1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datIsteka))
        else
          begin
            table1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datum));
            table1.FieldByName('Status').AsString:='Aktivan';
          end;
      end;
    if(RadioGroup2.ItemIndex=2) then
      begin
        table1.FieldByName('Paket').AsString:= 'Student7x7';
        FieldByName('Dolasci').AsString:='0';
        table1.FieldByName('Datum_uplate').AsString:=DateToStr(datum);
        if (table1.FieldByName('Status').AsString='Aktivan')then
          table1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datIsteka))
        else
          begin
            table1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datum));
            table1.FieldByName('Status').AsString:='Aktivan';
          end;
      end;
    if(RadioGroup2.ItemIndex=3) then
      begin
        table1.FieldByName('Paket').AsString:= 'Godisnja';
        FieldByName('Dolasci').AsString:='0';
        table1.FieldByName('Datum_uplate').AsString:=DateToStr(datum);
        if (table1.FieldByName('Status').AsString='Aktivan')then
          table1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datIsteka,12))
        else
          begin
            table1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datum,12));
            table1.FieldByName('Status').AsString:='Aktivan';
          end;
      end;
    Post;
    RadioGroup2.ItemIndex:=-1;
    end;
    table2.Open;
    table2.Append;
    table2.FieldValues['Broj_karte']:=table1.FieldValues['Broj_karte'];
    table2.FieldValues['Ime_prezime']:=table1.FieldValues['Ime_prezime'];
    table2.FieldValues['Paket']:=table1.FieldValues['Paket'];
    table2.FieldValues['Datum_uplate']:=table1.FieldValues['Datum_uplate'];
    table2.Post;
end;
procedure TFormMain.Edit3Change(Sender: TObject);
begin
  IF Edit3.Text <> '' THEN
    Begin
        table1.Filter:='Broj_karte = ' + Edit3.Text;
        table1.Filtered:=true;
        edit3.SetFocus
    End
  Else
    table1.Filtered:=false;
end;

procedure TFormMain.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
      // #8 is Backspace
  if not (Key in [#8, '0'..'9']) then begin
    ShowMessage('Neispravan karakter');
    // Discard the key
    Key := #0;
  end;
end;

procedure TFormMain.DBGrid1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
 pt: TGridcoord;
begin
 pt:= DBGrid1.MouseCoord(x, y);
 if pt.y=0 then
 DBGrid1.Cursor:=crHandPoint
 else
 DBGrid1.Cursor:=crDefault;
end;

procedure TFormMain.DBGrid1TitleClick(Column: TColumn);
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
 if ((Pos(Column.Field.FieldName, Table1.Sort) = 1) and (Pos(' DESC', Table1.Sort)= 0)) then
    with TCustomADODataSet(DBGrid1.DataSource.DataSet) do
      Table1.Sort := Column.Field.FieldName + ' DESC'
    else
    with TCustomADODataSet(DBGrid1.DataSource.DataSet) do
      Table1.Sort := Column.Field.FieldName + ' ASC';
 end;
end;

procedure TFormMain.Creator1Click(Sender: TObject);
begin
  Form1.Visible:=true;
end;

procedure TFormMain.Owner1Click(Sender: TObject);
begin
   Form2.Visible:=true;
end;

procedure TFormMain.Blue1Click(Sender: TObject);
begin
  FormMain.Color:=clTeal;
  DBGrid1.Color:=clTeal;
  DBGrid1.Font.Color:=clWindow;
  Panel1.Color:=clTeal;
  Panel2.Color:=clTeal;
  Panel4.Color:=clTeal;
  Panel5.Color:=clTeal;
  Panel6.Color:=clTeal;
  RadioGroup1.Color:=clTeal;
  RadioGroup2.Color:=clTeal;
  RadioGroup3.Color:=clTeal;
  Label1.Font.Color:=clWindowText;
  Label2.Font.Color:=clWindowText;
  Label3.Font.Color:=clWindowText;
  Label4.Font.Color:=clWindowText;
  Label5.Font.Color:=clWindowText;
  Label6.Font.Color:=clWindowText;
  Label7.Font.Color:=clWindowText;
  Label8.Font.Color:=clWindowText;
  RadioGroup1.Font.Color:=clWindowText;
  RadioGroup2.Font.Color:=clWindowText;
  RadioGroup3.Font.Color:=clWindowText;
end;

procedure TFormMain.Red1Click(Sender: TObject);
begin
  FormMain.Color:=clMaroon;
  DBGrid1.Color:=clMaroon;
  DBGrid1.Font.Color:=clWindow;
  Panel1.Color:=clMaroon;
  Panel2.Color:=clMaroon;
  Panel4.Color:=clMaroon;
  Panel5.Color:=clMaroon;
  Panel6.Color:=clMaroon;
  RadioGroup1.Color:=clMaroon;
  RadioGroup2.Color:=clMaroon;
  RadioGroup3.Color:=clMaroon;
  Label1.Font.Color:=clWindow;
  Label2.Font.Color:=clWindow;
  Label3.Font.Color:=clWindow;
  Label4.Font.Color:=clWindow;
  Label5.Font.Color:=clWindow;
  Label6.Font.Color:=clWindow;
  Label7.Font.Color:=clWindow;
  Label8.Font.Color:=clWindow;
  RadioGroup1.Font.Color:=clWindow;
  RadioGroup2.Font.Color:=clWindow;
  RadioGroup3.Font.Color:=clWindow;
end;

procedure TFormMain.Green1Click(Sender: TObject);
begin
  FormMain.Color:=clGreen;
  DBGrid1.Color:=clGreen;
  DBGrid1.Font.Color:=clWindow;
  Panel1.Color:=clGreen;
  Panel2.Color:=clGreen;
  Panel4.Color:=clGreen;
  Panel5.Color:=clGreen;
  Panel6.Color:=clGreen;
  RadioGroup1.Color:=clGreen;
  RadioGroup2.Color:=clGreen;
  RadioGroup3.Color:=clGreen;
  Label1.Font.Color:=clWindow;
  Label2.Font.Color:=clWindow;
  Label3.Font.Color:=clWindow;
  Label4.Font.Color:=clWindow;
  Label5.Font.Color:=clWindow;
  Label6.Font.Color:=clWindow;
  Label7.Font.Color:=clWindow;
  Label8.Font.Color:=clWindow;
  RadioGroup1.Font.Color:=clWindow;
  RadioGroup2.Font.Color:=clWindow;
  RadioGroup3.Font.Color:=clWindow;
end;

procedure TFormMain.White1Click(Sender: TObject);
begin
  FormMain.Color:=clWindow;
  DBGrid1.Color:=clGray;
  DBGrid1.Font.Color:=clWindowText;
  Panel1.Color:=clGray;
  Panel2.Color:=clGray;
  Panel4.Color:=clGray;
  Panel5.Color:=clGray;
  Panel6.Color:=clGray;
  RadioGroup1.Color:=clGray;
  RadioGroup2.Color:=clGray;
  RadioGroup3.Color:=clGray;
  Label1.Font.Color:=clWindowText;
  Label2.Font.Color:=clWindowText;
  Label3.Font.Color:=clWindowText;
  Label4.Font.Color:=clWindowText;
  Label5.Font.Color:=clWindowText;
  Label6.Font.Color:=clWindowText;
  Label7.Font.Color:=clWindowText;
  Label8.Font.Color:=clWindowText;
  RadioGroup1.Font.Color:=clWindowText;
  RadioGroup2.Font.Color:=clWindowText;
  RadioGroup3.Font.Color:=clWindowText;
end;

procedure TFormMain.Black1Click(Sender: TObject);
begin
  FormMain.Color:=clBlack;
  DBGrid1.Color:=clBlack;
  DBGrid1.Font.Color:=clWindow;
  Panel1.Color:=clBlack;
  Panel2.Color:=clBlack;
  Panel4.Color:=clBlack;
  Panel5.Color:=clBlack;
  Panel6.Color:=clBlack;
  RadioGroup1.Color:=clBlack;
  RadioGroup2.Color:=clBlack;
  RadioGroup3.Color:=clBlack;
  Label1.Font.Color:=clWindow;
  Label2.Font.Color:=clWindow;
  Label3.Font.Color:=clWindow;
  Label4.Font.Color:=clWindow;
  Label5.Font.Color:=clWindow;
  Label6.Font.Color:=clWindow;
  Label7.Font.Color:=clWindow;
  Label8.Font.Color:=clWindow;
  RadioGroup1.Font.Color:=clWindow;
  RadioGroup2.Font.Color:=clWindow;
  RadioGroup3.Font.Color:=clWindow;
end;

procedure TFormMain.Izvestaj1Click(Sender: TObject);
begin
  Form3.Visible:=True;
end;

procedure TFormMain.Button3Click(Sender: TObject);
begin
  Table1.Open;
  If (Table1.FieldByName('Paket').AsString='3x7')Then
    Begin
      Table1.Edit;
      Table1.FieldByName('Dolasci').AsInteger:=StrToInt(Table1.FieldByName('Dolasci').AsString) + 1;
      Table1.Post;
      table2.Open;
      table2.Append;
      table2.FieldValues['Broj_karte']:=table1.FieldValues['Broj_karte'];
      table2.FieldValues['Ime_prezime']:=table1.FieldValues['Ime_prezime'];
      table2.FieldValues['Paket']:='Dolazak Evid.';
      table2.FieldValues['Datum_uplate']:=datum;
      table2.FieldValues['Opis']:=Table1.FieldByName('Dolasci').AsString;
      table2.Post;
    End
   Else
      ShowMessage('Nemoguce evidentirati ovaj paket');
end;

procedure TFormMain.Button5Click(Sender: TObject);
begin
  Table1.Open;
  Table1.Edit;
  Table1.FieldByName('Napomena').AsString:=Edit4.Text;
  Table1.Post;
  table2.Open;
  table2.Append;
  table2.FieldValues['Broj_karte']:=table1.FieldValues['Broj_karte'];
  table2.FieldValues['Ime_prezime']:=table1.FieldValues['Ime_prezime'];
  table2.FieldValues['Paket']:='Napomena';
  table2.FieldValues['Datum_uplate']:=datum;
  table2.FieldValues['Opis']:=Table1.FieldByName('Napomena').AsString;
  table2.Post;
  Edit4.Text:='';
end;

end.

