;
; Translation helper
;
; This file contains functions used to translate the GUI.
;

;
; Include translations
;
#Include ..\include_translator\Include_Lang_de.inc								; Include German (de) translation
#Include ..\include_translator\Include_Lang_fr.inc								; Include French (fr) translation
#Include ..\include_translator\Include_Lang_it.inc								; Include Italian (it) translation
#Include ..\include_translator\Include_Lang_es.inc								; Include Spanish (es) translation
#Include ..\include_translator\Include_Lang_da.inc								; Include Danish (da) translation
#Include ..\include_translator\Include_Lang_fi.inc								; Include Finnish (fi) translation
#Include ..\include_translator\Include_Lang_ru.inc								; Include Russian (ru) translation
#Include ..\include_translator\Include_Lang_nl.inc								; Include Dutch (nl) translation
#Include ..\include_translator\Include_Lang_pt-br.inc								; Include Brazilian Portuguese (pt-br) translation
#Include ..\include_translator\Include_Lang_ja.inc								; Include Japanese (ja) translation

InitTranslations()
{
	global

	_LangArray := 1												; Set initial position for languages array

	; AddLanguage() arguments: <localized language name> <language load function name from language file> <windows language code(s) (see http://www.autohotkey.com/docs/misc/Languages.htm)>
	; Somewhat ordered by number of speakers. Hint: http://en.wikipedia.org/wiki/List_of_countries_by_population
	AddLanguage("English","","")										; Load English (en) translation (dummy)
	AddLanguage("Deutsch","LoadLanguage_de","0407+0807+0c07+1007+1407")					; Make default for all variations of German
	AddLanguage("Français","LoadLanguage_fr","040c+080c+0c0c+100c+140c+180c")				; Make default for all variations of French
	AddLanguage("Italiano","LoadLanguage_it","0410+0810")							; Make default for all variations of Italian
	AddLanguage("Español","LoadLanguage_es","040a+080a+0c0a+100a+140a+180a+1c0a+200a+240a+280a+2c0a+300a+340a+380a+3c0a+400a+440a+480a+4c0a+500a")	; Make default for all variations of Spanish
	AddLanguage("Dansk","LoadLanguage_da","0406")
	AddLanguage("suomi","LoadLanguage_fi","040b")
	AddLanguage("русский","LoadLanguage_ru","0419")
	AddLanguage("Nederlands","LoadLanguage_nl","0413+0813+0013")						; Netherlands Dutch, Belgian Dutch, and generic Dutch
	AddLanguage("Português brasileiro", "LoadLanguage_pt_br", "0416")					; Brazilian Portuguese, FIXME CHECK THE LOCALISED NAME!

	LoadLanguage(LanguageCodeToID(A_Language))								; Load language matching OS language (will fall back to English if no match)
}

AddLanguage(_Name, _LoadFunction, _LanguageCode)
{
	global

	_LanguageNames%_LangArray% := _Name
	_LanguageLoadFunctions%_LangArray% := _LoadFunction
	_LanguageCodes%_LangArray% := _LanguageCode

	_LangArray++
}

LoadLanguage(_LoadNum)
{
	global

	_LangNum := _LoadNum
	_TransArray := 1
	_LoadFunction := _LanguageLoadFunctions%_LoadNum%

	If (_LoadFunction <> "")
	{
		%_LoadFunction%()
	}
}

LanguageCodeToID(_LanguageCode)
{
	global

	Loop % _LangArray-1
	{
		IfInString, _LanguageCodes%A_Index%, %_LanguageCode%
		{
			return A_Index
		}
	}

	return 1												; Language 1 should always be the default language, so use that if no match above
}

Trans_Add(_OriginalText, _TranslatedText)
{
	global

	If (StrLen(_TranslatedText) <> 0)									; Skip zero-length adds
	{
		_OriginalTextArray%_TransArray% := _OriginalText
		_TranslatedTextArray%_TransArray% := _TranslatedText

		_TransArray++
	}
}

Trans(_OriginalText)
{
	global

	Loop % _TransArray-1
	{
		If (_OriginalText = _OriginalTextArray%A_Index%)
		{
			return UTF82Ansi(_TranslatedTextArray%A_Index%)
		}
	}

	return _OriginalText
}

UTF82Ansi(zString)
{
	Ansi2Unicode(zString, wString, 65001)
	Unicode2Ansi(wString, sString, 0)
	Return sString
}

Ansi2Unicode(ByRef sString, ByRef wString, CP = 0)
{
     nSize := DllCall("MultiByteToWideChar"
      , "Uint", CP
      , "Uint", 0
      , "Uint", &sString
      , "int",  -1
      , "Uint", 0
      , "int",  0)

   VarSetCapacity(wString, nSize * 2)

   DllCall("MultiByteToWideChar"
      , "Uint", CP
      , "Uint", 0
      , "Uint", &sString
      , "int",  -1
      , "Uint", &wString
      , "int",  nSize)
}

Unicode2Ansi(ByRef wString, ByRef sString, CP = 0)
{
     nSize := DllCall("WideCharToMultiByte"
      , "Uint", CP
      , "Uint", 0
      , "Uint", &wString
      , "int",  -1
      , "Uint", 0
      , "int",  0
      , "Uint", 0
      , "Uint", 0)

   VarSetCapacity(sString, nSize)

   DllCall("WideCharToMultiByte"
      , "Uint", CP
      , "Uint", 0
      , "Uint", &wString
      , "int",  -1
      , "str",  sString
      , "int",  nSize
      , "Uint", 0
      , "Uint", 0)
}

