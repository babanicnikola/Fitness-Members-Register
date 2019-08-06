unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Shape1: TShape;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Unit1, Unit4;

procedure TForm3.Button1Click(Sender: TObject);
var
  datIsteka:TDate;

begin
  with Form1.ADOTable1 do
  begin
    Edit;
    datIsteka:=Form1.ADOTable1.FieldByName('Datum_isteka').AsDateTime;
    IF (RadioGroup1.ItemIndex=-1) THEN
      ShowMessage('Odaberi paket')
    ELSE
    Begin
    if (RadioGroup1.ItemIndex=0) then
      begin
        FieldByName('Paket').AsString:='3x7';
        FieldByName('Dolasci').AsString:='0';
        Form1.ADOTable1.FieldByName('Datum_uplate').AsString:=DateToStr(datum);
        if (Form1.ADOTable1.FieldByName('Status').AsString='Aktivan')then
          Form1.ADOTable1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datIsteka))
        else
          begin
            Form1.ADOTable1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datum));
            Form1.ADOTable1.FieldByName('Status').AsString:='Aktivan';
          end;
      end;
    if(RadioGroup1.ItemIndex=1) then
      begin
        Form1.ADOTable1.FieldByName('Paket').AsString:= '7x7';
        FieldByName('Dolasci').AsString:='0';
        Form1.ADOTable1.FieldByName('Datum_uplate').AsString:=DateToStr(datum);
        if (Form1.ADOTable1.FieldByName('Status').AsString='Aktivan')then
          Form1.ADOTable1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datIsteka))
        else
          begin
            Form1.ADOTable1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datum));
            Form1.ADOTable1.FieldByName('Status').AsString:='Aktivan';
          end;
      end;
    if(RadioGroup1.ItemIndex=2) then
      begin
        Form1.ADOTable1.FieldByName('Paket').AsString:= 'Student7x7';
        FieldByName('Dolasci').AsString:='0';
        Form1.ADOTable1.FieldByName('Datum_uplate').AsString:=DateToStr(datum);
        if (Form1.ADOTable1.FieldByName('Status').AsString='Aktivan')then
          Form1.ADOTable1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datIsteka))
        else
          begin
            Form1.ADOTable1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datum));
            Form1.ADOTable1.FieldByName('Status').AsString:='Aktivan';
          end;
      end;
    if(RadioGroup1.ItemIndex=3) then
      begin
        Form1.ADOTable1.FieldByName('Paket').AsString:= 'Godisnja';
        FieldByName('Dolasci').AsString:='0';
        Form1.ADOTable1.FieldByName('Datum_uplate').AsString:=DateToStr(datum);
        if (Form1.ADOTable1.FieldByName('Status').AsString='Aktivan')then
          Form1.ADOTable1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datIsteka,12))
        else
          begin
            Form1.ADOTable1.FieldByName('Datum_isteka').AsString:=DateToStr(IncMonth(datum,12));
            Form1.ADOTable1.FieldByName('Status').AsString:='Aktivan';
          end;
      end;

    Post;
    RadioGroup1.ItemIndex:=-1;
    Form4.ADOTable1.Open;
    Form4.ADOTable1.Append;
    Form4.ADOTable1.FieldValues['Broj_karte']:=Form1.ADOTable1.FieldValues['Broj_karte'];
    Form4.ADOTable1.FieldValues['Ime_prezime']:=Form1.ADOTable1.FieldValues['Ime_prezime'];
    Form4.ADOTable1.FieldValues['Akcija']:='Upl. '+Form1.ADOTable1.FieldValues['Paket'];
    Form4.ADOTable1.FieldValues['Datum_akcije']:=Form1.ADOTable1.FieldValues['Datum_uplate'];
    Form4.ADOTable1.Post;
    Form1.Label7.Caption:=IntToStr(StrToInt(Form1.Label7.Caption)+1);
    Form3.Visible:=False;
    End;
  end;
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
  Edit1.Text:=Form1.ADOTable1.FieldByName('Broj_karte').AsString;
  Edit2.Text:=Form1.ADOTable1.FieldByName('Ime_prezime').AsString;
  RadioGroup1.ItemIndex:=-1;
end;

end.
