unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Data.Win.ADODB;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Edit1: TEdit;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  datum: TDateTime;
implementation

{$R *.dfm}

uses Unit1, Unit4;

procedure TForm2.Button1Click(Sender: TObject);
begin
datum:=Date;
if (edit1.text='') then
    ShowMessage('Unesi ime i prezime!')
  else
  if (RadioGroup1.ItemIndex=-1) then
    ShowMessage('Odaberi paket!')
  else
  if (RadioGroup2.ItemIndex=-1) then
    ShowMessage('Odaberi pol!')
  else
    begin
      Form1.ADOTable1.Open;
      Form1.ADOTable1.Append;
      Form1.ADOTable1.FieldValues['Ime_prezime']:= edit1.Text;
      if (RadioGroup2.ItemIndex=0) then
          Form1.ADOTable1.FieldValues['Pol']:= 'muski'
        else
          Form1.ADOTable1.FieldValues['Pol']:= 'zenski';
      if (RadioGroup1.ItemIndex=0) then
          Form1.ADOTable1.FieldValues['Paket']:= '3x7'
        else if(RadioGroup1.ItemIndex=1) then
          Form1.ADOTable1.FieldValues['Paket']:= '7x7'
        else if(RadioGroup1.ItemIndex=2) then
          Form1.ADOTable1.FieldValues['Paket']:= 'Student7x7'
        else if(RadioGroup1.ItemIndex=3) then
          Form1.ADOTable1.FieldValues['Paket']:= 'Godisnja';
      Form1.ADOTable1.FieldValues['Datum_uplate']:=DateToStr(datum);
      if(RadioGroup1.ItemIndex=3) then
        Form1.ADOTable1.FieldValues['Datum_isteka']:=IncMonth((datum),12)
      else
        Form1.ADOTable1.FieldValues['Datum_isteka']:=IncMonth(datum);
      Form1.ADOTable1.FieldValues['Status']:='Aktivan';
      Form1.ADOTable1.FieldValues['Dolasci']:='0';
      Form1.ADOTable1.Post;
      Edit1.text:='';
      RadioGroup1.ItemIndex:=-1;
      RadioGroup2.ItemIndex:=-1;
      Form4.ADOTable1.Open;
      Form4.ADOTable1.Append;
      Form4.ADOTable1.FieldValues['Broj_karte']:=Form1.ADOTable1.FieldValues['Broj_karte'];
      Form4.ADOTable1.FieldValues['Ime_prezime']:=Form1.ADOTable1.FieldValues['Ime_prezime'];
      Form4.ADOTable1.FieldValues['Akcija']:='Upl. '+ Form1.ADOTable1.FieldValues['Paket'];
      Form4.ADOTable1.FieldValues['Datum_akcije']:=Form1.ADOTable1.FieldValues['Datum_uplate'];
      Form4.ADOTable1.Post;
      Form1.Label6.Caption:=IntToStr(StrToInt(Form1.Label6.Caption)+1);
      Form1.Label7.Caption:=IntToStr(StrToInt(Form1.Label7.Caption)+1);
      Form2.Visible:=False;
    end;
end;



procedure TForm2.FormActivate(Sender: TObject);
begin
      Edit1.text:='';
      RadioGroup1.ItemIndex:=-1;
      RadioGroup2.ItemIndex:=-1;
      Edit1.SetFocus;
end;

end.
