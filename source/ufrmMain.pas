unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.IOUtils, System.UITypes;

type
  TfrmMain = class(TForm)
    edStateSaveFile: TEdit;
    fodStateSaveFile: TFileOpenDialog;
    btnStateSaveFile: TButton;
    rgRomSize: TRadioGroup;
    lblStateSaveFile: TLabel;
    btnExtract: TButton;
    btnExit: TButton;
    lblStartAddress: TLabel;
    stStartAddress: TStaticText;
    btnSearch: TButton;
    procedure btnExitClick(Sender: TObject);
    procedure btnExtractClick(Sender: TObject);
    procedure btnStateSaveFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
  private
    { Private éŒ¾ }
    procedure Extract(SearchOnly: Boolean);
    procedure InitStartAddress;
    function GetROMSize: Integer;
    function GetStateSaveFile: string;
    property ROMSize: Integer read GetROMSize;
    property StateSaveFile: string read GetStateSaveFile;
  public
    { Public éŒ¾ }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function TfrmMain.GetROMSize: Integer;
begin
  result := 16 shl (rgRomSize.ItemIndex + 10);
end;

function TfrmMain.GetStateSaveFile: string;
begin
  result := Trim(edStateSaveFile.Text);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  OnShow := nil;
  InitStartAddress;
end;

procedure TfrmMain.btnExtractClick(Sender: TObject);
begin
  Extract(False);
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
begin
  Extract(True);
end;

procedure TfrmMain.btnStateSaveFileClick(Sender: TObject);
begin
  if fodStateSaveFile.Execute then
  begin
    edStateSaveFile.Text := fodStateSaveFile.FileName;
    InitStartAddress;
  end;
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.Extract(SearchOnly: Boolean);
var
  FR, FW: file of byte;
  Header: array [0..15] of byte;
begin
  InitStartAddress;

  if not TFIle.Exists(StateSaveFile) then
  begin
    MessageDlg('File not found.', mtError, [mbOK], -1);
    edStateSaveFile.SetFocus;
    Exit;
  end;

  var WriteFlg := False;
  var InHeader := False;
  var PB: byte;
  var CB: byte := 0;
  var StartAddress := 0;
  var NumOfWrite := 0;
  var HeaderIdx := 0;
  AssignFile(FR, StateSaveFile);
  Reset(FR);
  if not SearchOnly then
  begin
    AssignFile(FW, ChangeFileExt(StateSaveFile, '.ROM'));
    Rewrite(FW);
  end;
  while not Eof(FR) do
  begin
    PB := CB;
    Read(FR, CB);
    if WriteFlg then
    begin
      Write(FW, CB);
      Inc(NumOfWrite);
      if NumOfWrite >= ROMSize then
        break;
    end
    else
    begin
      Inc(StartAddress);
      if InHeader then
      begin
        Header[HeaderIdx] := CB;
        Inc(HeaderIdx);
        if (HeaderIdx in [11..16]) and (CB <> $00) then
        begin
          InHeader := False;
          HeaderIdx := 0;
          Continue;
        end;
        if HeaderIdx = 16 then
        begin
          InHeader := False;
          WriteFlg := True;
          stStartAddress.Caption := Format('%.8x', [StartAddress - 16]);
          Application.ProcessMessages;
          if SearchOnly then
            break;
          for var i:=0 to 15 do
            Write(FW, Header[i]);
          Inc(NumOfWrite, 16);
        end;
      end
      else if (PB = Ord('A')) and (CB = Ord('B')) then
      begin
        InHeader := True;
        Header[0] := PB;
        Header[1] := CB;
        HeaderIdx := 2;
      end;
    end;
  end;
  if not SearchOnly then
    CloseFile(FW);
  CloseFile(FR);
  ShowMessage('Done.');
end;

procedure TfrmMain.InitStartAddress;
begin
  stStartAddress.Caption := '< none >';
end;

end.
