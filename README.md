# Faktúry

Skript, ktorý vytvorí faktúry vo formáte HTML a následne ich konvertuje do formátu PDF (pomocou [wkhtmltopdf](https://wkhtmltopdf.org/)). Okrem textu sa do každej faktúry pridáva aj QR kód PayBySquare (pomocou [payBySquare4s Commandline app](https://github.com/softwavesk/payBySquare4s#commandline-app)).

Ide o jednoduchý fakturačný systém, ktorý používa tieto textové súbory:

1. `dodavatelia.ini` - moje firmy, v mene ktorých fakturujem
1. `odberatelia.ini` - kontaktné údaje ľudí a organizácií, ktorým posielam faktúry
1. `polozky.ini` - aktivity, za ktoré žiadam peniaze na faktúre
1. `faktury-plus.tsv` - faktúry, ktoré posielam ja na úhradu (ukladajú sa do priečinka s názvom `plus`)
1. `faktury-plus-archiv.tsv` - archív faktúr, ktoré posielam ja na úhradu (ich PDF súbory sú už uložené v priečinku s názvom plus)
1. `vytvor_faktury.au3` - skript napísaný v jazyku [AutoIt](https://www.autoitscript.com/), ktorý vytvorí HTML súbory a zapíše dávku na ich konvertovanie do formátu PDF (viac info v komentároch skriptu)

Názov PDF súboru pre faktúry plus (výnosy) je v tomto formáte: `f-p-RRRRXXX.pdf`.

Údaje na faktúre plus (zo súboru faktury-plus.tsv) sú oddelené tabulátorom (nie čiarkou) a nasledujú presne v tomto poradí:

Dodávateľ (zo súboru dodavatelia.ini), Odberateľ (zo súboru odberatelia.ini), Dátum vystavenia, Dátum dodania, Dátum splatnosti, Variabilný symbol, Položka (zo súboru polozky.ini), Mena, Počet merných jednotiek (MJ), Cena za MJ, Suma, Dátum úhrady

Vo Windowse pre potrebey nástroja `payBySquare4s Commandline app` netreba inštalovať Javu. Stačí iba stiahnuť a rozbaliť prenosnú verziu [OpenJDK JRE Portable 64-bit](https://portableapps.com/apps/utilities/OpenJDKJRE64) a pridať do PATH cestu k priečinku `OpenJDKJRE64\bin\`.
