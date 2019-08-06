unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit1, Unit4;

type
  TForm5 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
begin
  if Edit1.Text='fitnessadmin' then
  begin
     CheckBox1.Visible:=true;
     button2.Visible:=true;
  end;

end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  buttonSelected := messageDlg('Da li ste sigurni da zelite da obrisete istoriju izvestaja?',mtCustom,[mbYes,mbNo], 0);
  if buttonSelected = mrYes then
  begin
    Form4.ADOTable1.Open;
    while not Form4.ADOTable1.Eof do
      begin
        Form4.ADOTable1.Delete;
      end;
  end;
end;

procedure TForm5.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked=true then
  begin
    admin:=true;
    form1.MainMenu1.Items[6].Visible:=true;
  end else
    begin
      admin:=false;
      form1.MainMenu1.Items[6].Visible:=false;
    end;
end;

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CheckBox1.Visible:=false;
   Button2.Visible:=false;
   Edit1.Text:='';
end;

end.
