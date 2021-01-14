unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.Buttons,
  PapagoAPI;

type
  TfrmMain = class(TForm)
    btnTranslate: TButton;
    eTarget: TMemo;
    eSource: TMemo;
    cbSource: TComboBox;
    cbTarget: TComboBox;
    sbSwitch: TSpeedButton;
    cbCopyToClipboard: TCheckBox;
    lbSource: TLabel;
    lbTarget: TLabel;

    procedure btnTranslateClick(Sender: TObject);
    procedure sbSwitchClick(Sender: TObject);
  private
    FPapago: TPapago;

    procedure LoadConfig;
    procedure SaveConfig;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  System.IniFiles,
  Vcl.ClipBrd;

{$R *.dfm}

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;

  FPapago := TPapago.Create;
  FPapago.FillItem(cbSource.Items);
  FPapago.FillItem(cbTarget.Items);

  LoadConfig;
end;

destructor TfrmMain.Destroy;
begin
  SaveConfig;

  FPapago.Free;

  inherited;
end;

procedure TfrmMain.btnTranslateClick(Sender: TObject);
var
  LSource: string;
  LTarget: string;
begin
  if (FPapago.ClientID = '') or (FPapago.ClientSecret = '') then
  begin
    Application.MessageBox('ClientID 또는 Client Secret Key가 없습니다', '확인', MB_ICONERROR + MB_OK);
    Exit;
  end;

  LSource := FPapago.GetCode(cbSource.ItemIndex);
  LTarget := FPapago.GetCode(cbTarget.ItemIndex);
  eTarget.Text := FPapago.Execute(LSource, LTarget, eSource.Text);

  if cbCopyToClipboard.Checked then
    Clipboard.AsText := eTarget.Text;
end;

procedure TfrmMain.LoadConfig;
begin
  with TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini')) do
  begin
    // API Key
    FPapago.ClientID := ReadString('KEY', 'ID', '');
    FPapago.ClientSecret := ReadString('KEY', 'SECRET', '');

    // 번역 옵션
    cbSource.ItemIndex := ReadInteger('OPTION', 'SOURCE', 0);
    cbTarget.ItemIndex := ReadInteger('OPTION', 'TARGET', 1);
    cbCopyToClipboard.Checked := ReadBool('OPTION', 'AUTOCOPY', True);

    // 화면 위치
    Left := ReadInteger('POSITION', 'LEFT', 0);
    Top := ReadInteger('POSITION', 'TOP', 0);

    Free;
  end;
end;

procedure TfrmMain.SaveConfig;
begin
  with TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini')) do
  begin
    // 번역 옵션
    WriteInteger('OPTION', 'SOURCE', cbSource.ItemIndex);
    WriteInteger('OPTION', 'TARGET', cbTarget.ItemIndex);
    WriteBool('OPTION', 'AUTOCOPY', cbCopyToClipboard.Checked);

    // 화면 위치
    WriteInteger('POSITION', 'LEFT', Left);
    WriteInteger('POSITION', 'TOP', Top);

    Free;
  end;
end;

procedure TfrmMain.sbSwitchClick(Sender: TObject);
var
  LIndex: Integer;
begin
  LIndex := cbSource.ItemIndex;
  cbSource.ItemIndex := cbTarget.ItemIndex;
  cbTarget.ItemIndex := LIndex;
end;

end.
