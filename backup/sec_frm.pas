unit sec_frm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls;

type

  { Tsec_form }

  Tsec_form = class(TForm)
    DBMemo1: TDBMemo;
    Label1: TLabel;
  private

  public

  end;

var
  sec_form: Tsec_form;

implementation

{$R *.lfm}

end.

