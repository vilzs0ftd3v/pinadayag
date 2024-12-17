unit third_frm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, RVStyle;

type

  { Tthird_form }

  Tthird_form = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  third_form: Tthird_form;

implementation

{$R *.lfm}

{ Tthird_form }

procedure Tthird_form.Button1Click(Sender: TObject);
begin
  Memo1.Font.Height:=Memo1.Font.Height+10;
end;

procedure Tthird_form.Button2Click(Sender: TObject);
begin
   Memo1.Font.Height:=Memo1.Font.Height-10;
end;

end.

