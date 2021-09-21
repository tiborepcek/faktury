#NoTrayIcon

#include <Array.au3>

$subor_dodavatelia = @ScriptDir & "\dodavatelia.ini"
$subor_odberatelia = @ScriptDir & "\odberatelia.ini"
$subor_polozky = @ScriptDir & "\polozky.ini"
$subor_faktury = @ScriptDir & "\faktury-plus.tsv"
$priecinok_faktury = @ScriptDir & "\faktury_html_pdf\"
$priecinok_faktury_plus = @ScriptDir & "\plus\"
$priecinok_stiahnute = @UserProfileDir & "\Downloads\"

DirRemove($priecinok_faktury, 1)

$subor_faktury_pole = FileReadToArray($subor_faktury)
$subor_faktury_pocet_riadkov = @extended

$subor_faktury_do_pdf_vytvorit = FileOpen($priecinok_faktury & "faktury_do_pdf.bat", 9)
FileWrite($subor_faktury_do_pdf_vytvorit, "chcp 65001" & @CRLF)

For $faktura = 0 To $subor_faktury_pocet_riadkov - 1 ; vytvorenie faktúr vo formáte HTML a zapísanie dávky na konvertovanie do formátu PDF
   $subor_faktury_text_riadok_cast = StringSplit($subor_faktury_pole[$faktura], Chr(9))

   $dodavatel = $subor_faktury_text_riadok_cast[1]
   $odberatel = $subor_faktury_text_riadok_cast[2]
   $datum_vystavenia = $subor_faktury_text_riadok_cast[3]
   $datum_dodania = $datum_vystavenia
   $datum_splatnosti = $subor_faktury_text_riadok_cast[4]
   $datum_uhrady = $subor_faktury_text_riadok_cast[10]
   $vs = $subor_faktury_text_riadok_cast[5] ;vs = variabilný symbol
   $polozka_firma = StringTrimRight($subor_faktury_text_riadok_cast[6], 2)
   $polozka_cislo = StringRight($subor_faktury_text_riadok_cast[6], 1)
   $mena = $subor_faktury_text_riadok_cast[7]
   $mj = $subor_faktury_text_riadok_cast[8] ;mj = merná jednotka
   $cena_za_mj = $subor_faktury_text_riadok_cast[9] ;mj = merná jednotka
   $suma_na_uhradu = $cena_za_mj * $mj  ;mj = merná jednotka

   $subor_faktura_vytvor = FileOpen($priecinok_faktury & "f-p-" & $vs & ".html", 9)
   FileWrite($subor_faktura_vytvor, "<html>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "	<head>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<meta charset=""UTF-8"">" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<style>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			html {background-color: #ffffff; font-size: 1.1em; font-family: ""Calibri""; line-height: 1.45}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			hr {border-style: solid; border-width: 1px}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			.centre {text-align: center}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			.right {text-align: right}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			.big {font-size: 1.6em}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			.small {font-size: 0.8em}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			.margin {margin-top: 50px; margin-bottom: 50px}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			.marginPBS {margin-top: 100px}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			.marginViacInfo {margin-top: 230px}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			.border {border: 2px solid black; border-radius: 5px;}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			.padding {padding: 10px}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			.dolezite {font-weight: bold}" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		</style>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<title>Faktúra " & $vs & "</title>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "	</head>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "	<body>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<h1 class=""centre"">Faktúra " & $vs & "</h1>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<table align=""center"" width=""880"" class=""margin"">" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			<tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td width=""440"">Dátum vystavenia: " & $datum_vystavenia & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>Dátum splatnosti: <b>" & $datum_splatnosti & "</b></td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			</tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			<tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>Dátum dodania: " & $datum_dodania & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>Variabilný symbol: <b>" & $vs & "</b></td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			</tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		</table>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<table align=""center"" width=""880"">" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			<tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td width=""440""><b>Dodávateľ:</b></td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td><b>Odberateľ:</b></td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			</tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			<tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & dodavatel($dodavatel, "firma") & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & odberatel($odberatel, "firma") & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			</tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			<tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & dodavatel($dodavatel, "ulica") & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & odberatel($odberatel, "ulica") & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			</tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			<tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & dodavatel($dodavatel, "psc") & " " & dodavatel($dodavatel, "mesto") & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & odberatel($odberatel, "psc") & " " & odberatel($odberatel, "mesto") & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			</tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			<tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>IČO: " & dodavatel($dodavatel, "ico") & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>IČO: " & odberatel($odberatel, "ico") & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			</tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		</table>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<table align=""center"" width=""880"" class=""margin border padding dolezite"">" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			<tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>IBAN:</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>Variabilný symbol:</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>Dátum splatnosti:</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>Suma na úhradu ("& $mena &"):</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			</tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			<tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & rozdeleny_iban(dodavatel($dodavatel, "iban")) & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & $vs & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & $datum_splatnosti & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & $suma_na_uhradu & " " & znak_meny($mena) & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			</tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		</table>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<p>Fakturujeme Vám:</p>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<table align=""center"" width=""880"">" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			<tr align=""left"">" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<th>Popis:</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<th>Počet MJ:</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<th>Cena za MJ ("& $mena &"):</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<th>Suma ("& $mena &"):</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			</tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			<tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & polozka($polozka_firma, $polozka_cislo) & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & $mj & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & $cena_za_mj & " " & znak_meny($mena) & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "				<td>" & $suma_na_uhradu & " " & znak_meny($mena) & "</td>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "			</tr>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		</table>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<p class=""centre marginPBS""><img src=""qr_" & $vs & ".png"" height=""300""></p>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "		<p class=""marginViacInfo small""><b>Viac informácií o dodávateľovi:</b><br>Kontaktná osoba: " & dodavatel($dodavatel, "kontakt") & " | " & dodavatel($dodavatel, "email") & " | " & dodavatel($dodavatel, "mobil") & "<br>" & dodavatel($dodavatel, "spisova_znacka") & " | IČO: " & dodavatel($dodavatel, "ico") & " | DIČ: " & dodavatel($dodavatel, "dic") & " | IČ DPH: " & dodavatel($dodavatel, "icdph") & " | " & dodavatel($dodavatel, "typ") & "<br>Banka: " & dodavatel($dodavatel, "banka") & " | Kód banky: " & dodavatel($dodavatel, "kod_banky") & " | Číslo účtu: " & dodavatel($dodavatel, "cislo_uctu") & " | IBAN: " & dodavatel($dodavatel, "iban") & " | SWIFT: " & dodavatel($dodavatel, "swift") & "</p>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "	</body>" & @CRLF)
   FileWrite($subor_faktura_vytvor, "</html>" & @CRLF)

   FileWrite($subor_faktury_do_pdf_vytvorit, 'java -jar payBySquareApp-1.0.2.jar "' & $suma_na_uhradu & ';' & $mena & ';' & $vs & ';;;;;' & dodavatel($dodavatel, "iban") & ';" %CD%\qr_' & $vs & '.png' & @CRLF) ; vytvorenie 
   FileWrite($subor_faktury_do_pdf_vytvorit, "wkhtmltopdf --enable-local-file-access f-p-" & $vs & ".html f-p-" & $vs & ".pdf" & @CRLF)
Next

;FileWrite($subor_faktury_do_pdf_vytvorit, "pause") ; ak sa má spustená dávka na konci zastaviť (okno príkazového riadku sa nezavrie)

FileClose($subor_faktury_do_pdf_vytvorit)
FileClose($subor_faktura_vytvor)

;FileCopy("wkhtmltopdf.exe", $priecinok_faktury) ; ak súbor wkhtmltopdf.exe nie je v PATH
FileCopy("payBySquareApp-1.0.2.jar", $priecinok_faktury) ; súbor payBySquareApp*.jar musí byť v priečinku spolu s týmto skriptom

ShellExecuteWait($priecinok_faktury & "faktury_do_pdf.bat", "", $priecinok_faktury) ; spustenie dávky na konvertovanie HTML súborov do formátu PDF

For $faktura = 0 To $subor_faktury_pocet_riadkov - 1 ; kopírovanie vytvorených PDF súborov do iných priečinkov
	$subor_faktury_text_riadok_cast = StringSplit($subor_faktury_pole[$faktura], Chr(9))
	$odberatel = $subor_faktury_text_riadok_cast[2]
	$vs = $subor_faktury_text_riadok_cast[5] ;vs = variabilný symbol
	FileCopy($priecinok_faktury & "f-p-" & $vs & ".pdf", $priecinok_stiahnute & $vs & "-" & $odberatel & ".pdf", 1)
	FileCopy($priecinok_faktury & "f-p-" & $vs & ".pdf", $priecinok_faktury_plus & "f-p-" & $vs & ".pdf", 1)
Next

;ShellExecute($priecinok_stiahnute & $vs & ".pdf", "", $priecinok_stiahnute) ; ak sa má vytvorený PDF súbor zobraziť

;DirRemove($priecinok_faktury, 1) ; ak sa má priečinok s HTML a PDF súbormi vymazať

Func dodavatel($dodavatel_skratka, $dodavatel_polozka)
   Return IniRead($subor_dodavatelia, $dodavatel_skratka, $dodavatel_polozka, "N/A")
EndFunc

Func odberatel($odberatel_skratka, $odberatel_polozka)
   Return IniRead($subor_odberatelia, $odberatel_skratka, $odberatel_polozka, "N/A")
EndFunc

Func polozka($firma_skratka, $poradove_cislo)
   Return IniRead($subor_polozky, $firma_skratka, $poradove_cislo, "N/A")
EndFunc

Func znak_meny($mena)
   If $mena = "EUR" Then Return "€"
EndFunc

Func rozdeleny_iban($iban)
	$iban_1 = StringMid($iban, 1, 4)
	$iban_2 = StringMid($iban, 5, 4)
	$iban_3 = StringMid($iban, 9, 4)
	$iban_4 = StringMid($iban, 13, 4)
	$iban_5 = StringMid($iban, 17, 4)
	$iban_6 = StringMid($iban, 21, 4)
	Return $iban_1 & " " & $iban_2 & " " & $iban_3 & " " & $iban_4 & " " & $iban_5 & " " & $iban_6
EndFunc