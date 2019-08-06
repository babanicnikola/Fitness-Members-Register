unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, RpDefine, RpRender,
  RpRenderPDF, OleServer, OutlookXP, RpCon, RpConDS, RpRave;

type
  TForm3 = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    RvProject1: TRvProject;
    RvRenderPDF1: TRvRenderPDF;
    RvDataSetConnection1: TRvDataSetConnection;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    procedure Edit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Form_Main;

{$R *.dfm}

procedure TForm3.Edit1Change(Sender: TObject);
begin
  IF Edit1.Text <> '' THEN
    Begin
        FormMain.Table2.Filter:= Format('Datum_uplate LIKE ''%s%%''',[Edit1.Text]);
        FormMain.Table2.Filtered:=true;
        edit1.SetFocus;
    End
  Else
    FormMain.Table2.Filtered:=false;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Form3.RvProject1.Execute;
end;

procedure TForm3.Edit2Change(Sender: TObject);
begin
IF Edit2.Text <> '' THEN
    Begin
        formmain.table2.Filter:= Format('Ime_prezime LIKE ''%s%%''',[Edit2.Text]);
        formmain.table2.Filtered:=true;
        edit2.SetFocus;
    End
  Else
    formmain.table2.Filtered:=false;
end;

procedure TForm3.Edit3Change(Sender: TObject);
begin
IF Edit3.Text <> '' THEN
    Begin
        formmain.Table2.Filter:='Broj_karte = ' + Edit3.Text;
        formmain.Table2.Filtered:=true;
        Edit3.SetFocus
    End
  Else
    formmain.Table2.Filtered:=false;
end;

end.
