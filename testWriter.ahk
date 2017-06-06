; ���������� ������� ������� A_Now � ���������� ����������
; ���������� ������� ������



; �������� ������ ������ �������� � ������
SendMode Input
KeysCount := 0
Rec := 1 ; ���� ������
t_prev := A_Now						; ���������� �����
t_Time := A_Now						; ������� �����


global Macro2 := {}					; ������� ��� ���������� ������������������ ������
global Array := Object()


^LButton::
	InsertSymbols()

	; �������� ������� �� ������� ����������
	TimeRewrite()
	delta := (t_Time - t_prev) * 1000
	
	; ��������� ������ �������� ������������
	MouseGetPos, xpos, ypos, id, control
	WinGetActiveTitle, title
	Dict := {type : "button",  dest : "left", x : xpos, y : ypos, id : id, control : control, delta : delta, title : title}
	Array.Insert(Dict)


	KeysCount := 0 ; ���������� ������ (������) � �������
	return

^RButton::
	InsertSymbols()

	; �������� ������� �� ������� ����������
	TimeRewrite()
	delta := (t_Time - t_prev) * 1000
	
	; ��������� ������ �������� ������������
	MouseGetPos, xpos, ypos, id, control
	WinGetActiveTitle, title
	Dict := {type : "button",  dest : "right", x : xpos, y : ypos, id : id, control : control, delta : delta, title : title}
	Array.Insert(Dict)
return

F8::
for i in Array
{
	; Sleep, 250
	if % Array[i].type = "button"
	{
		Sleep, % Array[i].delta
		MouseClick, % Array[i].dest, % Array[i].x, % Array[i].y	
	}
	
	if % Array[i].type = "text"
	{
		Send % Array[i].text
	}
}
return



Add(Key) ; ����������� ������� �������
{
    global
    If Rec = 1
    {
        KeysCount += 1
        Macro2.Insert(KeysCount, Key)
		TimeRewrite()					; ������������ �����
    }
}

InsertSymbols()				; ������� ���������� ����� � ������
{
	n = 0					; �� ���������� ���������� ������� ������	
	global KeysCount
	symbols := 
	Loop %KeysCount%
	{
		n += 1
		; �������� � 1 ������ some
		element := Macro2[A_Index]
		symbols .= element
		
		;Dict := {type : "text",  text : symbols}			; ��������� �������	
	}


	if(n > 0)                                              ; ������ n, � �� %n%
		{
			Dict := {type : "text",  text : symbols}			; ��������� �������
		
			Array.Insert(Dict)	
			var := Macro2.MaxIndex()
			Loop, %var% 
			{
				;k := A_Index	
				Macro2.Remove(1)
			}
			KeysCount := 0
			symbols := 
		}
}

TimeRewrite()
; ������������ �����
{
	global 
	t_prev := t_Time
	t_Time := A_Now
}

F2::
; ���������� �������
FileSelectFile, SelectedFile, 8, ,������� ����, ��������� ����� (*.ahk) 					; ����� ����� � ���������
for i in Array
{
	if % Array[i].type = "button"
	{
		d := % Array[i].delta
		dest := % Array[i].dest
		xx := % Array[i].x
		yy := % Array[i].y
		tt := % Array[i].title
		
		; ������ ��������� ����
		FileAppend, IfWinExist`, %tt%`n, %SelectedFile%`.ahk
		FileAppend, WinActivate`n, %SelectedFile%`.ahk
		FileAppend, else`n, %SelectedFile%`.ahk
		FileAppend, WinActivate`, %tt%`n, %SelectedFile%`.ahk
		;FileAppend, return`n, %SelectedFile%`.ahk
		
		; ������ ��������
		FileAppend, Sleep`,%d%`n, %SelectedFile%`.ahk
		FileAppend, MouseClick`,%dest%`,%xx%`,%yy%`n, %SelectedFile%`.ahk
		 	
	}
	
	if % Array[i].type = "text"
	{
		t := % Array[i].text
		FileAppend, Send %t%`n, %SelectedFile%`.ahk
	}
}
return

IfWinExist, %tt%
    WinActivate ; ������������ ����, ��������� ����
else
    WinActivate, %tt%
return

F5:: Reload
F9:: 
Pause, On
Rec := 0 ; ���� ������
return

F10:: 
Pause, Off
Rec := 1 ; ���� ������
global t_Time := A_Now
return

F11:: ExitApp




;==========================================================
; �������� �� ������
~Home:: Add("{Home}")
~End:: Add("{End}")

~Up:: Add("{Up}")
~Down:: Add("{Down}")
~Left:: Add("{Left}")
~Right:: Add("{Right}")

~^Left:: Add("^{Left}")
~^Right:: Add("^{Right}")

; �����, ��������, ������� � �.�.
~BackSpace:: Add("{BackSpace}")
~Delete:: Add("{Delete}")
~Tab:: Add("{Tab}")
~Space:: Add("{Space}")
~Enter:: Add("{Enter}")

; ������ � �������
~^sc02D:: Add("^{sc02D}") ; Control + X
~^sc02E:: Add("^{sc02E}") ; Control + C
~^sc02F:: Add("^{sc02F}") ; Control + V

~^Insert:: Add("^{Insert}")
~+Insert:: Add("+{Insert}")
~+Delete:: Add("+{Delete}")

; ��������� ������
~+Left:: Add("+{Left}")
~+Right:: Add("+{Right}")
~^+Left:: Add("^+{Left}")
~^+Right:: Add("^+{Right}")
~+Home:: Add("+{Home}")
~+End:: Add("+{End}")

; �����
~sc029:: Add("{sc029}") ; `
~+sc029:: Add("+{sc029}")
~sc002:: Add("{sc002}") ; 1
~+sc002:: Add("+{sc002}")
~sc003:: Add("{sc003}") ; 2
~+sc003:: Add("+{sc003}")
~sc004:: Add("{sc004}") ; 3
~+sc004:: Add("+{sc004}")
~sc005:: Add("{sc005}") ; 4
~+sc005:: Add("+{sc005}")
~sc006:: Add("{sc006}") ; 5
~+sc006:: Add("+{sc006}")
~sc007:: Add("{sc007}") ; 6
~+sc007:: Add("+{sc007}")
~sc008:: Add("{sc008}") ; 7
~+sc008:: Add("+{sc008}")
~sc009:: Add("{sc009}") ; 8
~+sc009:: Add("+{sc009}")
~sc00A:: Add("{sc00A}") ; 9
~+sc00A:: Add("+{sc00A}")
~sc00B:: Add("{sc00B}") ; 0
~+sc00B:: Add("+{sc00B}")
~sc00C:: Add("{sc00C}") ; -
~+sc00C:: Add("+{sc00C}")
~sc00D:: Add("{sc00D}") ; =
~+sc00D:: Add("+{sc00D}")
~sc02B:: Add("{sc02B}") ; \
~+sc02B:: Add("+{sc02B}")

; �����
~sc010:: Add("{sc010}") ; Q
~+sc010:: Add("+{sc010}")
~sc011:: Add("{sc011}") ; W
~+sc011:: Add("+{sc011}")
~sc012:: Add("{sc012}") ; E
~+sc012:: Add("+{sc012}")
~sc013:: Add("{sc013}") ; R
~+sc013:: Add("+{sc013}")
~sc014:: Add("{sc014}") ; T
~+sc014:: Add("+{sc014}")
~sc015:: Add("{sc015}") ; Y
~+sc015:: Add("+{sc015}")
~sc016:: Add("{sc016}") ; U
~+sc016:: Add("+{sc016}")
~sc017:: Add("{sc017}") ; I
~+sc017:: Add("+{sc017}")
~sc018:: Add("{sc018}") ; O
~+sc018:: Add("+{sc018}")
~sc019:: Add("{sc019}") ; P
~+sc019:: Add("+{sc019}")
~sc01A:: Add("{sc01A}") ; {
~+sc01A:: Add("+{sc01A}")
~sc01B:: Add("{sc01B}") ; }
~+sc01B:: Add("+{sc01B}")

~sc01E:: Add("{sc01E}") ; A
~+sc01E:: Add("+{sc01E}")
~sc01F:: Add("{sc01F}") ; S
~+sc01F:: Add("+{sc01F}")
~sc020:: Add("{sc020}") ; D
~+sc020:: Add("+{sc020}")
~sc021:: Add("{sc021}") ; F
~+sc021:: Add("+{sc021}")
~sc022:: Add("{sc022}") ; G
~+sc022:: Add("+{sc022}")
~sc023:: Add("{sc023}") ; H
~+sc023:: Add("+{sc023}")
~sc024:: Add("{sc024}") ; J
~+sc024:: Add("+{sc024}")
~sc025:: Add("{sc025}") ; K
~+sc025:: Add("+{sc025}")
~sc026:: Add("{sc026}") ; L
~+sc026:: Add("+{sc026}")
~sc027:: Add("{sc027}") ; :
~+sc027:: Add("+{sc027}")
~sc028:: Add("{sc028}") ; "
~+sc028:: Add("+{sc028}")

~sc02C:: Add("{sc02C}") ; Z
~+sc02C:: Add("+{sc02C}")
~sc02D:: Add("{sc02D}") ; X
~+sc02D:: Add("+{sc02D}")
~sc02E:: Add("{sc02E}") ; C
~+sc02E:: Add("+{sc02E}")
~sc02F:: Add("{sc02F}") ; V
~+sc02F:: Add("+{sc02F}")
~sc030:: Add("{sc030}") ; B
~+sc030:: Add("+{sc030}")
~sc031:: Add("{sc031}") ; N
~+sc031:: Add("+{sc031}")
~sc032:: Add("{sc032}") ; M
~+sc032:: Add("+{sc032}")
~sc033:: Add("{sc033}") ; <
~+sc033:: Add("+{sc033}")
~sc034:: Add("{sc034}") ; >
~+sc034:: Add("+{sc034}")
~sc035:: Add("{sc035}") ; ?
~+sc035:: Add("+{sc035}")

; NumPad
~sc052:: Add("{Numpad0}") ; Num0
~sc04F:: Add("{Numpad1}") ; Num1
~sc050:: Add("{Numpad2}") ; Num2
~sc051:: Add("{Numpad3}") ; Num3
~sc04B:: Add("{Numpad4}") ; Num4
~sc04C:: Add("{Numpad5}") ; Num5
~sc04D:: Add("{Numpad6}") ; Num6
~sc047:: Add("{Numpad7}") ; Num7
~sc048:: Add("{Numpad8}") ; Num8
~sc049:: Add("{Numpad9}") ; Num9
~sc053:: Add("{NumpadDot}") ; Num Dot
~sc135:: Add("{NumpadDiv}") ; Num /
~sc037:: Add("{NumpadMult}") ; Num *
~sc04A:: Add("{NumpadSub}") ; Num -
~sc04E:: Add("{NumpadAdd}") ; Num +
~sc11C:: Add("{NumpadEnter}") ; Num Enter












