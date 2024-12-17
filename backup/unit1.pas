unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, mysql57conn, DB, Forms, Controls,
  Graphics, Dialogs, StdCtrls, DBGrids, DBCtrls, ZConnection, RichView;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    bible_cmb: TComboBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    DataSource6: TDataSource;
    search_edit: TEdit;
    MySQL57Connection1: TMySQL57Connection;
    SQLQuery3: TSQLQuery;
    SQLQuery4: TSQLQuery;
    SQLQuery5: TSQLQuery;
    SQLQuery6: TSQLQuery;
    SQLTransaction2: TSQLTransaction;
    verseBibleFrom_text: TEdit;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    chapterBible_text: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    verseBibleTo_text: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
  function hasMoreThanOneSpace(keyword:string):boolean;
  end;

var
  Form1: TForm1;
 verseFrom,verseTo,chapter,book:string;

implementation
 uses sec_frm,third_frm;
{$R *.lfm}

{ TForm1 }
function TForm1.hasMoreThanOneSpace(keyword:string):boolean;
var
  numberOfSpace,x:integer;
begin
  numberOfSpace:=0;
  for x:=1 to keyword.Length do
  begin
    if(copy(keyword,x-1,1) = ' ') then
    begin
      numberOfSpace:=numberOfSpace+1;
    end;
  end;
  if(numberOfSpace > 1)then begin
    showMessage('true'+numberOfSpace.ToString);
    result:= true;
  end;
  if(numberOfSpace = 1)then begin
    showMessage('false'+numberOfSpace.ToString);
    result:= false;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
     //Memo1.Lines.Clear;
     //Memo1.Text:='WrapText does a wordwrap at column MaxCol of the string in Line. It breaks the string only at characters which are in BreakChars (default whitespace and hyphen) and inserts then the string BreakStr (default the lineending character for the current OS).';
     //showMessage(Form1.Height.ToString);
     //showMessage(Form1.Width.ToString);
end;

procedure TForm1.FormResize(Sender: TObject);
var
    oneLineHeight:integer;
begin
    oneLineHeight:=100;
    Label1.Caption:=Form1.Height.ToString;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
    oneLineHeight,book_id,len,mem_length:integer;
    input,names,verse,book_ids:string;
begin

    names:= bible_cmb.Text;
    book:=bible_cmb.Text;
    chapter:=chapterBible_text.Text;
    verseFrom:= verseBibleFrom_text.Text;
    verseTo:=verseBibleTo_text.Text;
    if(verseBibleTo_text.Text = '')then begin
         verseTo:=verseFrom;
         showMessage('no verseTo');
    end;

    book_ids:=(bible_cmb.ItemIndex+1).ToString;
    book_id:=(bible_cmb.ItemIndex+1);

    SQLQuery1.Close;
    SQLQuery1.ParamByName('name').AsString:=names;
    SQLQuery1.ParamByName('chapter').AsString:=chapter;
    SQLQuery1.ParamByName('verseFrom').AsString:=verseFrom;
    SQLQuery1.ParamByName('verseTo').AsString:=verseTo;
    SQLQuery1.Open;


    len:=Length(SQLQuery1.Fields[3].AsString);
    ShowMessage(len.ToString);
    if(verseFrom <> verseTo)then begin
         third_form.Label1.Caption:=names+' '+chapter+':'+verseFrom+'-'+verseTo;
    end;
     if(verseFrom = verseTo)then begin
         third_form.Label1.Caption:=names+' '+chapter+':'+verseFrom;
    end;



    oneLineHeight:=300;
    if third_form.Memo1.Text = '' then begin
       showMessage('no entry');
    end;
    if third_form.Memo1.Text <> '' then begin
       showMessage('length: '+(Length(third_form.Memo1.Text)).toString);

       mem_length:=Round(len/2);
        if mem_length > 1 then begin
       third_form.Memo1.Font.Height:=160;

       end;
       if mem_length > 64 then begin
       third_form.Memo1.Font.Height:=150;
       end;
       if mem_length > 100 then begin
       third_form.Memo1.Font.Height:=130;
       end;
       if mem_length > 120 then begin
       third_form.Memo1.Font.Height:=120;
       end;
       if mem_length > 150 then begin
       third_form.Memo1.Font.Height:=120;
       end;
       if mem_length > 200 then begin
       third_form.Memo1.Font.Height:=120;
       end;
       if mem_length > 229 then begin
       third_form.Memo1.Font.Height:=120;
       end;
    end;


end;

procedure TForm1.Button2Click(Sender: TObject);
var
    oneLineHeight:integer;
begin
    third_form.Show;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
 book,chapter,verseFrom,verseTo,searchVerse:string;
begin

  searchVerse:=search_edit.Text;

  if(searchVerse.IndexOf('.') <> -1)then begin
    book:=Copy(searchVerse,0,(searchVerse.IndexOf('.')));
    showMessage('BOOK:'+book);
    chapter:= Copy(searchVerse,(searchVerse.IndexOf(' ')+2),(searchVerse.IndexOf(':'))-(searchVerse.IndexOf(' ')+1));
    showMessage('CHAPTER:'+chapter);
    if(hasMoreThanOneSpace(searchVerse) = false)then begin
         if(searchVerse.IndexOf('-') <> -1)then begin
           verseFrom:=Copy(searchVerse,(searchVerse.IndexOf(':')+2),(searchVerse.IndexOf('-')-1)-(searchVerse.IndexOf(':')));
           verseTo:=Copy(searchVerse,(searchVerse.IndexOf('-')+2),(searchVerse.Length)-(searchVerse.IndexOf('-')));
           showMessage('FROM:'+verseFrom);
           showMessage('TO:'+verseTo);
         end;
    end;

    if(hasMoreThanOneSpace(searchVerse) = true) then begin
         if(searchVerse.IndexOf('-') <> -1)then begin
           verseFrom:=Copy(searchVerse,(searchVerse.IndexOf(':')+2),(searchVerse.IndexOf('-')-1)-(searchVerse.IndexOf(':')));
           verseTo:=Copy(searchVerse,(searchVerse.IndexOf('-')+2),(searchVerse.Length)-(searchVerse.IndexOf('-')));
           showMessage('FROM:'+verseFrom);
           showMessage('TO:'+verseTo);
         end;
    end;

  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
var
 dateToday:string;
begin
  dateToday:=FormatDateTime('yyyy-mm-dd, hh:nn:ss',now);
  if((book <> '') and (chapter <> '') and (verseFrom <> '')) then begin
    SQLQuery5.Clear;
    try
       try
         SQLQuery5.SQL.Text:='insert into Cebpinadayag_notes(book,chapter,verseFrom,verseTo,dateSaved) values(:book,:chapter,:verseFrom,:verseTo,:dateSaved)';
         SQLQuery5.Params.ParamByName('book').AsString:=book;
         SQLQuery5.Params.ParamByName('chapter').AsString:=chapter;
         SQLQuery5.Params.ParamByName('verseFrom').AsString:=verseFrom;
         SQLQuery5.Params.ParamByName('verseTo').AsString:=verseTo;
         SQLQuery5.Params.ParamByName('dateSaved').AsString:=dateToday;
         SQLQuery5.ExecSQL;
         SQLTransaction1.Commit;

       except on E : EDatabaseError do
         showMessage('DB ERROR:'+' '+ E.ClassName+' '+ E.Message);
       end;
    finally
       SQLQuery6.Close;
       SQLQuery6.Open;
    end;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  SQLQuery6.Close;
  SQLQuery6.Open;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
var
 len,mem_length:integer;
begin
  third_form.Memo1.Text:=DBGrid1.DataSource.DataSet.Fields[3].AsString;
  len:=Length(DBGrid1.DataSource.DataSet.Fields[3].AsString);

  if third_form.Memo1.Text <> '' then begin
       showMessage('length: '+(Length(third_form.Memo1.Text)).toString);
       mem_length:=Round(len/2);
        if mem_length > 1 then begin
       third_form.Memo1.Font.Height:=160;
       showMessage('160');
       end;
       if mem_length > 64 then begin
       third_form.Memo1.Font.Height:=150;
       showMessage('150');
       end;
       if mem_length > 100 then begin
       third_form.Memo1.Font.Height:=130;
       showMessage('130');
       end;
       if mem_length > 120 then begin
       third_form.Memo1.Font.Height:=120;
       showMessage('120');
       end;
       if mem_length > 150 then begin
       third_form.Memo1.Font.Height:=120;
       showMessage('100');
       end;
       if mem_length > 200 then begin
       third_form.Memo1.Font.Height:=120;
       showMessage('100');
       end;
       if mem_length > 229 then begin
       third_form.Memo1.Font.Height:=120;
       showMessage('100');
       end;
    end;
end;

procedure TForm1.DBGrid2CellClick(Column: TColumn);
begin
    book:=DBGrid2.DataSource.DataSet.Fields[0].AsString;
    chapter:=DBGrid2.DataSource.DataSet.Fields[1].AsString;
    verseFrom:=DBGrid2.DataSource.DataSet.Fields[2].AsString;
    verseTo:=DBGrid2.DataSource.DataSet.Fields[3].AsString;
    SQLQuery1.Close;
    SQLQuery1.ParamByName('name').AsString:='%'+book+'%';
    SQLQuery1.ParamByName('chapter').AsString:=chapter;
    SQLQuery1.ParamByName('verseFrom').AsString:=verseFrom;
    SQLQuery1.ParamByName('verseTo').AsString:=verseTo;
    SQLQuery1.Open;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    SQLite3Connection1.Connected:=true;
    if SQLite3Connection1.Connected = true then
    begin
      showMessage('connected!');
    end;

end;

end.

