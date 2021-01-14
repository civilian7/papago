unit uClipBrd;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.ClipBrd,
  Vcl.Forms;

type
	TClipboardMonitor = class
	private
    FHandle: THandle;

		FOnChange: TNotifyEvent;
	protected
		WndNext: THandle;

		procedure WndProc(var Msg : TMessage);
	public
		constructor Create;
		destructor Destroy; override;

    property Handle: THandle read FHandle;

		property OnChange : TNotifyEvent read FOnChange write FOnChange;
	end;

implementation

constructor TClipboardMonitor.Create;
begin
  FHandle := System.Classes.AllocateHWnd(WndProc);
	WndNext := SetClipboardViewer(FHandle);
end;

destructor TClipboardMonitor.Destroy;
begin
  ChangeClipboardChain(FHandle, WndNext);
	System.Classes.DeAllocateHWnd(FHandle);

	inherited;
end;

procedure TClipboardMonitor.WndProc(var Msg: TMessage);
begin
	with Msg do
	begin
		if (Msg = WM_CHANGECBCHAIN) then
		begin
			if HWND(WParam) = WndNext then
        WndNext := LParam
			else
        SendMessage(WndNext, Msg, WParam, LParam);
		end
		else
    if (Msg = WM_DRAWCLIPBOARD) then
		begin
			if Assigned(FOnChange) and ClipBoard.HasFormat(CF_TEXT) then
        FOnChange(Self);

			SendMessage(WndNext, Msg, WParam, LParam);
		end
		else
      Result := DefWindowProc(FHandle, Msg, wParam, lParam);
	end;
end;

end.
