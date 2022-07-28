'----------------------------------------------------------
' Plugin for OCS Inventory NG 2.x
' Script : Retrieve plugins script informations
' Version : 1.04
' Date : 14/04/2018
' Author : Stephane PAUTREL (acb78.com)
'----------------------------------------------------------
' OS checked [X] on	32b	64b	(Professionnal edition)
'	Windows XP		[X]
'	Windows Vista	[X]	[X]
'	Windows 7		[X]	[X]
'	Windows 8.1		[X]	[X]	
'	Windows 10		[X]	[X]
'	Windows 2k8R2		[X]
'	Windows 2k12R2		[X]
'	Windows 2k16		[X]
' ---------------------------------------------------------
' NOTE : No checked on Windows 8
' ---------------------------------------------------------
On Error Resume Next

Const ForReading = 1

Dim objFSO, rep, fich, fileExt, objSourceFile, Ligne, i
Dim FileName, Description, Version, CreaDate, ModiDate, Author

Set objWMIService = GetObject("winmgmts:root\cimv2")
Set colItems = objWMIService.ExecQuery( "SELECT * FROM Win32_Processor", , 48 )

For Each objItem in colItems
	ArchiOS = objItem.AddressWidth
	If ArchiOS = "32" Then
		PluginDir = "C:\Program Files (x86)\OCS Inventory Agent\Plugins"
	ElseIf ArchiOS = "64" Then
		PluginDir = "C:\Program Files\OCS Inventory Agent\Plugins"
	End If
Next

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set rep = objFSO.getFolder(PluginDir)

For each fich in rep.files

	If Right(LCase(fich.name), 3) = LCase("vbs") Or Right(LCase(fich.name), 3) = LCase("ps1") Then ' Vérification de l'extension (vbs ou ps1)
	
		FileExt = Right(LCase(fich.name), 3)
		Set objSourceFile = objFSO.OpenTextFile(fich, ForReading)

		FileName = left(fich.name,len(fich.name)-4)
		ModiDate = cdate(fich.DateLastModified)
	
		Do Until objSourceFile.AtEndOfStream

			Ligne = objSourceFile.ReadLine

			If Left(Ligne, 11) = "' Script : " Or Left(Ligne, 11) = "' Script :	" Then ' Recherche du texte + espace ou tabulation
				Description = Mid(Ligne, 12)
			End If
	
			If Left(Ligne, 12) = "' Version : " Or Left(Ligne, 12) = "' Version :	" Then ' Recherche du texte + espace ou tabulation
				Version = Mid(Ligne, 13)
			End If

			If Left(Ligne, 9) = "' Date : " Or Left(Ligne, 9) = "' Date :	" Then ' Recherche du texte + espace ou tabulation
				CreaDate = Mid(Ligne, 10)
			End If

			If Left(Ligne, 11) = "' Author : " Or Left(Ligne, 11) = "' Author :	" Then ' Recherche du texte + espace ou tabulation
				Author = Mid(Ligne, 12)
			ElseIf Left(Ligne, 12) = "' Authors : " Or Left(Ligne, 12) = "' Authors :	" Then ' Recherche du texte + espace ou tabulation
				Author = Mid(Ligne, 13)
			End If

		Loop
	
		Wscript.Echo _
			"<PLUGINSLIST>" & VbCrLf &_
				"<SCRIPTNAME>" & FileName & "</SCRIPTNAME>" & VbCrLf &_
				"<LANGUAGE>" & FileExt & "</LANGUAGE>" & VbCrLf &_
				"<DESCRIPTION>" & replaceSpecialCar(Description) & "</DESCRIPTION>" & VbCrLf &_
				"<VERSION>"	& Version & "</VERSION>" & VbCrLf &_
				"<CREADATE>" & CreaDate & "</CREADATE>" & VbCrLf &_
				"<MODIDATE>" & ModiDate & "</MODIDATE>" & VbCrLf &_
				"<AUTHOR>"	& replaceSpecialCar(Author) & "</AUTHOR>" & VbCrLf &_
			"</PLUGINSLIST>" & VbCrLf
	
		FileName = ""
		Description = ""
		Version = ""
		CreaDate = ""
		ModiDate = ""
		Author = ""
	
		objSourceFile.Close
	End If
Next

Function replaceSpecialCar(sText)
	If IsNull(sText) Then Exit Function
 
	Dim arrSpecCar(81,2)
	arrSpecCar(0,0) = "À"
		arrSpecCar(0,1) = "A"
	arrSpecCar(1,0) = "Á"
		arrSpecCar(1,1) = "A"
	arrSpecCar(2,0) = "Â"
		arrSpecCar(2,1) = "A"
	arrSpecCar(3,0) = "Ã"
		arrSpecCar(3,1) = "A"
	arrSpecCar(4,0) = "Ä"
		arrSpecCar(4,1) = "A"
	arrSpecCar(5,0) = "Å"
		arrSpecCar(5,1) = "A"
	arrSpecCar(6,0)= "à"
		arrSpecCar(6,1) = "a"
	arrSpecCar(7,0) = "á"
		arrSpecCar(7,1) = "a"
	arrSpecCar(8,0) = "â"
		arrSpecCar(8,1) = "a"
	arrSpecCar(9,0) = "ã"
		arrSpecCar(9,1) = "a"
	arrSpecCar(10,0)= "ä"
		arrSpecCar(10,1)= "a"
	arrSpecCar(11,0)= "å"
		arrSpecCar(11,1)= "a"
	arrSpecCar(12,0)= "Ò"
		arrSpecCar(12,1)= "O"
	arrSpecCar(13,0)= "Ó"
		arrSpecCar(13,1)= "O"
	arrSpecCar(14,0)= "Ô"
		arrSpecCar(14,1)= "O"
	arrSpecCar(15,0)= "Õ"
		arrSpecCar(15,1)= "O"
	arrSpecCar(16,0)= "Ö"
		arrSpecCar(16,1)= "O"
	arrSpecCar(17,0)= "Ø"
		arrSpecCar(17,1)= "O"
	arrSpecCar(18,0)= "ò"
		arrSpecCar(18,1)= "o"
	arrSpecCar(19,0)= "ó"
		arrSpecCar(19,1)= "o"
	arrSpecCar(20,0)= "ô"
		arrSpecCar(20,1)= "o"
	arrSpecCar(21,0)= "õ"
		arrSpecCar(21,1)= "o"
	arrSpecCar(22,0)= "ö"
		arrSpecCar(22,1)= "o"
	arrSpecCar(23,0)= "ø"
		arrSpecCar(23,1)= "o"
	arrSpecCar(24,0)= "È"
		arrSpecCar(24,1)= "E"
	arrSpecCar(25,0)= "É"
		arrSpecCar(25,1)= "E"
	arrSpecCar(26,0)= "Ê"
		arrSpecCar(26,1)= "E"
	arrSpecCar(27,0)= "Ë"
		arrSpecCar(27,1)= "E"
	arrSpecCar(28,0)= "è"
		arrSpecCar(28,1)= "e"
	arrSpecCar(29,0)= "é"
		arrSpecCar(29,1)= "e"
	arrSpecCar(30,0)= "ê"
		arrSpecCar(30,1)= "e"
	arrSpecCar(31,0)= "ë"
		arrSpecCar(31,1)= "e"
	arrSpecCar(32,0)= "Ç"
		arrSpecCar(32,1)= "C"
	arrSpecCar(33,0)= "ç"
		arrSpecCar(33,1)= "c"
	arrSpecCar(34,0)= "Ì"
		arrSpecCar(34,1)= "I"
	arrSpecCar(35,0)= "Í"
		arrSpecCar(35,1)= "I"
	arrSpecCar(36,0)= "Î"
		arrSpecCar(36,1)= "I"
	arrSpecCar(37,0)= "Ï"
		arrSpecCar(37,1)= "I"
	arrSpecCar(38,0)= "ì"
		arrSpecCar(38,1)= "i"
	arrSpecCar(39,0)= "í"
		arrSpecCar(39,1)= "i"
	arrSpecCar(40,0)= "î"
		arrSpecCar(40,1)= "i"
	arrSpecCar(41,0)= "ï"
		arrSpecCar(41,1)= "i"
	arrSpecCar(42,0)= "Ù"
		arrSpecCar(42,1)= "U"
	arrSpecCar(43,0)= "Ú"
		arrSpecCar(43,1)= "U"
	arrSpecCar(44,0)= "Û"
		arrSpecCar(44,1)= "U"
	arrSpecCar(45,0)= "Ü"
		arrSpecCar(45,1)= "U"
	arrSpecCar(46,0)= "ù"
		arrSpecCar(46,1)= "u"
	arrSpecCar(47,0)= "ú"
		arrSpecCar(47,1)= "u"
	arrSpecCar(48,0)= "û"
		arrSpecCar(48,1)= "u"
	arrSpecCar(49,0)= "ü"
		arrSpecCar(49,1)= "u"
	arrSpecCar(50,0)= "ÿ"
		arrSpecCar(50,1)= "y"
	arrSpecCar(51,0)= "Ñ"
		arrSpecCar(51,1)= "N"
	arrSpecCar(52,0)= "ñ"
		arrSpecCar(52,1)= "n"
	arrSpecCar(53,0)= "©"
		arrSpecCar(53,1)= "copyright"
	arrSpecCar(54,0)= "®"
		arrSpecCar(54,1)= "registered"
	arrSpecCar(55,0)= "ª"
		arrSpecCar(55,1)= "exp(a)"
	arrSpecCar(56,0)= "×"
		arrSpecCar(56,1)= "x"
	arrSpecCar(57,0)= "÷"
		arrSpecCar(57,1)= "/"
	arrSpecCar(58,0)= "±"
		arrSpecCar(58,1)= "+/-"
	arrSpecCar(59,0)= "²"
		arrSpecCar(59,1)= "exp(2)"
	arrSpecCar(60,0)= "³"
		arrSpecCar(60,1)= "exp(3)"
	arrSpecCar(61,0)= "¼"
		arrSpecCar(61,1)= "1/4"
	arrSpecCar(62,0)= "½"
		arrSpecCar(62,1)= "1/2"
	arrSpecCar(63,0)= "¾"
		arrSpecCar(63,1)= "3/4"
	arrSpecCar(64,0)= "µ"
		arrSpecCar(64,1)= "u"
	arrSpecCar(65,0)= "¿"
		arrSpecCar(65,1)= "?"
	arrSpecCar(66,0)= "·"
		arrSpecCar(66,1)= "."
	arrSpecCar(67,0)= "¸"
		arrSpecCar(67,1)= ","
	arrSpecCar(68,0)= "º"
		arrSpecCar(68,1)= "o"
	arrSpecCar(69,0)= "°"
		arrSpecCar(69,1)= "degre"
	arrSpecCar(70,0)= "¯"
		arrSpecCar(70,1)= "_"
	arrSpecCar(71,0)= "…"
		arrSpecCar(71,1)= "..."
	arrSpecCar(72,0)= "¤"
		arrSpecCar(72,1)= "¤"
	arrSpecCar(73,0)= "¦"
		arrSpecCar(73,1)= "pipe"
	arrSpecCar(74,0)= "‡"
		arrSpecCar(74,1)= "dagger"
	arrSpecCar(75,0)= "¬"
		arrSpecCar(75,1)= "-"
	arrSpecCar(76,0)= "ˆ"
		arrSpecCar(76,1)= " "
	arrSpecCar(77,0)= "¨"
		arrSpecCar(77,1)= " "
	arrSpecCar(78,0)= "‰"
		arrSpecCar(78,1)= "0/00"
	arrSpecCar(79,0)= "œ"
		arrSpecCar(79,1)= "oe"
	arrSpecCar(80,0)= "&"
		arrSpecCar(80,1)= "and"
 
	' pour chaque element du tableau
	For i=0 To UBound(arrSpecCar,1)
		' on remplace
		sText = Replace(sText, arrSpecCar(i,0), arrSpecCar(i,1))
	Next
	' puis on affecte le retour
	replaceSpecialCar = sText
End Function