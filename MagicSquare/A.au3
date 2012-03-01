#region ---Au3Recorder generated code Start (v3.3.7.0)  ---

#region --- Internal functions Au3Recorder Start ---
Func _Au3RecordSetup()
Opt('WinWaitDelay',100)
Opt('WinDetectHiddenText',1)
Opt('MouseCoordMode',0)
EndFunc

Func _WinWaitActivate($title,$text,$timeout=0)
	WinWait($title,$text,$timeout)
	If Not WinActive($title,$text) Then WinActivate($title,$text)
	WinWaitActive($title,$text,$timeout)
EndFunc

_AU3RecordSetup()
#endregion --- Internal functions Au3Recorder End ---

; check if the AUT is B.exe
If $CMDLINE[1] <> "B.exe" Then
	MsgBox(0, "Error", "Program A.exe will run on your AUT. Be Aware.")
EndIf

; take a first parameter from command line as AUT
$sAUT = @WorkingDir & "\" & $CMDLINE[1]
MsgBox(0, "", "AUT is " & " " & $sAUT )
Sleep(2000)

; run AUT
Local $foo = Run($sAUT)

; wait until AUT is active
_WinWaitActivate($sAUT,"")

; user input start

; square dimension
$iSize = 2
Send($iSize)
Send("{ENTER}")

Global $vArray[$iSize][$iSize]
$vArray[0][0] = 1
$vArray[0][1] = 2
$vArray[1][0] = 2
$vArray[1][1] = 1

$sExpected = "yes"
;$sExpected = "no"

;creating an array list for bad result to show
$sNote = ""
For $iRow = 0 to ($iSize-1)
	For $iColumn  = 0 to ($iSize-1)
		$sNote = $sNote & $vArray[$iRow][$iColumn] & " "
		Next
	$sNote = $sNote & @CRLF
Next

; just make a program show user input slower
Sleep(1000)

;Send("2{ENTER}1{ENTER}2{ENTER}2{ENTER}1{ENTER}")
For $iRow = 0 to ($iSize-1)
	For $iColumn  = 0 to ($iSize-1)
		Send($vArray[$iRow][$iColumn])
		Send("{ENTER}")
	Next
	Sleep(1000)
Next
; user input end

; open file written by the AUT
$sFile = @WorkingDir & "\" & "result.txt"
Local $file = FileOpen($sFile, 0)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
EndIf

; Read in 3 characters at a time until the EOF is reached
While 1
    Local $sResult = FileRead($file, 3)
    If @error = -1 Then ExitLoop

	; check if actual result is equal to expected
	If $sResult = $sExpected Then
		$sTestResult = "ok"
	Else
		$sTestResult = "not ok:" & @CRLF& $sNote & @CRLF & "returned: " & $sResult & @CRLF & "expected: " & $sExpected
	EndIf

	; show test result
    MsgBox(0, "Test result", $sTestResult)
WEnd

FileClose($file)

#endregion --- Au3Recorder generated code End ---



