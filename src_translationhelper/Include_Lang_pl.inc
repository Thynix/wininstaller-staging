;
; Translation file - Polish (pl) - by Arkadiusz B�asiak (ares1112 that-a-thingy gmail that-dot-thingy com)
;

LoadLanguage_pl()
{
; Translation credit string. Remember to change language and name to your own in the translated string (not in the english one). Don't add personal comments or website links here - add those to the header of this file instead if you want.
Trans_Add("English localization by: Christian Funder Sommerlund (Zero3)", "Polskie t�umaczenie przez: Arkadiusz B�asiak (Ares)")

; Shared strings (Installer, Uninstaller)
Trans_Add("was not able to unpack necessary files to:", "nie m�g� wypakowa� potrzebnych plik�w do:")
Trans_Add("Please make sure that this program has full access to the system's temporary files folder.", "Prosz� upewni� si�, �e ten program ma pe�ny dost�p do plik�w tymczasowych.")

; Shared strings (Installer, Uninstaller, Service starter, Service stopper)
Trans_Add("requires administrator privileges to manage the Freenet service. Please make sure that your user account has administrative access to the system, and this program is executed with access to use these privileges.", "wymagane uprawnienia administratora, aby zarz�dza� us�ug� Freenet. Prosz� si� upewni� czy twoje konto u�ytkownika posiada dost�p administracyjny do systemu i program jest uruchomiony z tymi uprawnieniami.")

; Installer - Common
Trans_Add("Freenet Installer error", "B��d instalatora Freenet")
Trans_Add("Freenet Installer", "Instalator Freenet")
Trans_Add("Welcome to the Freenet Installer!", "Witaj w instalatorze programy Freenet!")
Trans_Add("Installation Problem", "B��d podczas instalacji")
Trans_Add("E&xit", "&Wyj�cie")

; Installer - Unsupported Windows version
Trans_Add("Freenet only supports the following versions of the Windows operating system:", "Freenet obs�uguje wy��cznie nast�puj�ce wersje systemu Windows:")
Trans_Add("Please install one of these versions if you want to use Freenet on Windows.", "Prosz� zainstalowa� jedn� z tych wersji, je�eli chcesz u�ywa� Freenet w systemie Windows.")

; Installer - Java missing
Trans_Add("Freenet requires the Java Runtime Environment, but your system does not appear to have an up-to-date version installed. You can install Java by using the included online installer, which will download and install the necessary files from the Java website automatically:", "Freenet wymaga pakiet Java Runtime Environment, jednak tw�j system nie posiada aktualnej wersji. Mo�esz zainstalowa� Jav� poprzez zawarty instalator online, kt�ry pobierze i zainstaluje wymagane pliki automatycznie ze strony Javy:")
Trans_Add("&Install Java", "&Zainstaluj Jav�")
Trans_Add("The installation will continue once Java version", "Instalacja b�dzie kontynuowana, gdy wersja Javy")
Trans_Add("or later has been installed.", "lub p�niejszej zako�czy si�.")

; Installer - Old installation detected
Trans_Add("has detected that you already have Freenet installed. Your current installation was installed using an older, unsupported installer. To continue, you must first uninstall your current version of Freenet using the previously created uninstaller:", "wykry�, �e Freenet jest ju� zainstalowany. Obecna instalacja by�a zainstalowana przez starszy, niewspierany instalator. Aby kontynuowa�, nale�y usun�� aktualn� wersj� Freenet poprzez uprzedni deinstalator:")
Trans_Add("&Uninstall", "&Usu�")
Trans_Add("The installation will continue once the old installation has been removed.", "Instalacja b�dzie kontynuowana, gdy starsza instalacja zostanie usuni�ta.")

; Installer - Main GUI - Header
Trans_Add("Please check the following default settings before continuing with the installation of Freenet.", "Prosz� sprawdzi� nast�puj�ce domy�lne ustawienia przed kontunuowaniem instalacji Freenet.")

; Installer - Main GUI - Install folder
Trans_Add("Installation directory", "�cie�ka instalacji")
Trans_Add("&Browse", "&Przegl�daj")
Trans_Add("De&fault", "Do&my�lne")
Trans_Add("Freenet requires the installation drive to have at least", "Freenet wymaga, aby dysk mia� przynajmniej")
Trans_Add("MB free disk space. The actual amount of space reserved to Freenet will be configured after the installation.", "MB wolnej przestrzeni. Aktualna warto�� przestrzeni zarezerwowanej dla Freenet b�dzie skonfigurowana po instalacji.")
Trans_Add("Status:", "Status:")
Trans_Add("If you do not choose a folder containing 'Freenet' in the path, a folder will be created for you automatically.", "Je�li folder o nazwie zawieraj�cej s�owo 'Freenet' nie b�dzie wybrany, zostanie utworzony automatycznie.")
Trans_Add("Invalid install path!", "Niew�a�ciwa �cie�ka instalacji!")
Trans_Add("(Too long for file system to handle)", "(Zbyt d�ugie dla systemu plik�w)")
Trans_Add("Not enough free space on installation drive!", "Brak wystarczaj�cej ilo�ci wolnego miejsca na dysku!")
Trans_Add("Freenet already installed! Please uninstall first or choose another directory!", "Freenet jest ju� zainstalowany! Prosz� go usun�� lub wybra� inn� �cie�k�!")
Trans_Add("Installation directory OK!", "�cie�ka instalacji OK!")

; Installer - Main GUI - System service
Trans_Add("System service", "Us�uga systemowa")
Trans_Add("Freenet will automatically start in the background as a system service. This is required to be a part of the Freenet network, and will use a small amount of system resources. The amount of resources used can be adjusted after installation.", "Freenet uruchomi si� automatycznie w tle jako us�uga systemowa. Jest to wymagane, aby by� cz�ci� sieci Freenet i zu�ywa niewielkie ilo�ci zasob�w systemu. Ilo�� u�ywanych zasob�w mo�e by� zmieniona po instalacji.")

; Installer - Main GUI - Additional settings
Trans_Add("Additional settings", "Dodatkowe ustawienia")
Trans_Add("Start Freenet &Tray Manager on Windows startup", "Uruchom mened�er &tray'a Freenet podczas uruchamiania Windows")
Trans_Add("(Recommended)", "(Zalecane)")
Trans_Add("Install &start menu shortcuts", "Zainstaluj skr�ty w menu &start")
Trans_Add("(Optional)", "(Opcjonalne)")
Trans_Add("Install &desktop shortcut", "Zainstaluj skr�t na pu&lpicie")
Trans_Add("Launch Freenet &after the installation", "Uruchom Freenet po &instalacji")

; Installer - Main GUI - Footer
Trans_Add("Version ", "Wersja")
Trans_Add(" - Build ", " - Kompilacja")
Trans_Add("&Install", "I&nstaluj")

; Installer - Actual installation
Trans_Add("Opens Freenet Tray Manager in the notification area", "Otwiera mened�er tray'a Freenet w obszarze powiadomie�")
Trans_Add("Opens the Freenet proxy homepage in a web browser", "Otwiera stron� domow� Freenet proxy w przegl�darce")
Trans_Add("Start Freenet", "Uruchom Freenet")
Trans_Add("Stop Freenet", "Zatrzymaj Freenet")
Trans_Add("Installation finished successfully!", "Instalacja uko�czona pomy�lnie!")
Trans_Add("Freenet Installer by:", "Instalator Freenet przez:")

; Installer - Error messageboxes
Trans_Add("was not able to find a free port on your system in the range", "nie m�g� znale�� wolnego portu na twoim systemie w zakresie")
Trans_Add("Please free a system port in this range to install Freenet.", "Prosz� zwolni� port w tym zakresie, aby zainstalowa� Freenet.")
Trans_Add("was not able to create a Winsock 2.0 socket for port availability testing.", "nie m�g� stworzy� Winsock 2.0 socket dla testu dost�pno�ci port�w.")
Trans_Add("was not able to write to the selected installation directory. Please select one to which you have write access.", "nie m�g� zapisa� do wybranej �cie�ki instalacji. Prosz� wybra� taki, do kt�rego masz dost�p zapisu.")
Trans_Add("Error: ", "B��d: ")

; Shared strings (Uninstaller, Service starter, Service stopper)
Trans_Add("was unable to control the Freenet system service.", "nie m�g� kontrolowa� us�ugi systemowej Freenet")
Trans_Add("Reason:", "Pow�d:")
Trans_Add("Timeout while managing the service.", "Timeout podczas zarz�dzania us�ug�.")
Trans_Add("Could not access the service.", "Brak dost�pu do us�ugi.")
Trans_Add("Service did not respond to signal.", "Us�uga nie odpowiedzia�a na sygna�.")

; Uninstaller
Trans_Add("Freenet uninstaller", "Deinstalator Freenet")
Trans_Add("was unable to recognize your Freenet installation at:", "nie m�g� rozpozna� instalacji Freenet w:")
Trans_Add("Please run this program from the 'bin' folder of a Freenet installation.", "Prosz� uruchomi� ten program z folderu 'bin' instalacji Freenet.")
Trans_Add("Do you really want to uninstall Freenet?", "Czy na pewno chcesz usun�� Freenet?")
Trans_Add("Stopping system service...", "Zatrzymywanie us�ugi systemowej...")
Trans_Add("Shutting down tray managers...", "Wy��czanie mened�er�w tray'a")
Trans_Add("Removing system service...", "Usuwanie us�ugi systemowej...")
Trans_Add("Removing files...", "Usuwanie plik�w...")
Trans_Add("Freenet uninstaller error", "B��d deinstalatora Freenet")
Trans_Add("was unable to delete the Freenet files located at:", "nie m�g� usun�� plik�w programu Freenet w:")
Trans_Add("Please close all applications with open files inside this directory.", "Prosz� zamkn�� wszystkie aplikacje, kt�re maj� otwarte pliki w tej �cie�ce.")
Trans_Add("The uninstallation was aborted.", "Proces deinstalacji zosta� przerwany.")
Trans_Add("Please manually remove the rest of your Freenet installation.", "Prosz� r�cznie usun�� reszt� pozosta�ych plik�w instalacji Freenet.")
Trans_Add("Removing registry modifications...", "Usuwanie modyfikacji rejestru...")
Trans_Add("Freenet has been uninstalled!", "Freenet zosta� pomy�lnie usuni�ty!")

; Shared strings (Launcher, Tray manager)
Trans_Add("was unable to find the following file:", "nie m�g� odnale�� nast�puj�cego pliku:")
Trans_Add("Make sure that you are running", "Upewnij si�, �e jest uruchomiony")
Trans_Add("from a Freenet installation directory.", "z �cie�ki instalacyjnej Freenet.")

; Shared Strings (Launcher, Service starter, Service stopper, Tray manager)
Trans_Add("If the problem keeps occurring, try reinstalling Freenet or report this error message to the developers.", "Je�li problem nadal wyst�puje, prosz� zainstalowa� Freenet ponownie lub zg�osi� ten komunikat deweloperom.")

; Launcher
Trans_Add("Freenet Launcher", "Freenet Launcher")
Trans_Add("Freenet Launcher error", "B��d Freenet Launcher")
Trans_Add("was unable to read the 'fproxy.port' value from the 'freenet.ini' configuration file.", "nie m�g� odczyta� warto�ci 'fproxy.port' z pliku konfiguracyjnego 'freenet.ini'.")

; Shared strings (Service starter, Service stopper)
Trans_Add("Command line options (only use one):", "Opcje wiersza polece� (u�ywaj tylko jednej):")
Trans_Add("Hide info messages", "Ukryj powiadomienia")
Trans_Add("Hide info and status messages", "Ukryj powiadomienia i informacje o statusie")
Trans_Add("Return codes:", "Kody zwrotne:")
Trans_Add("Success", "Sukces")
Trans_Add("Error occurred", "Wyst�pi� b��d")
Trans_Add("(no action)", "(brak akcji)")

; Service starter
Trans_Add("(service started)", "(us�uga uruchomiona)")
Trans_Add("Service was already running", "Us�uga ju� dzia�a")
Trans_Add("Freenet Starter", "Starter Freenet")
Trans_Add("The Freenet service is starting...", "Us�uga Freenet jest uruchamiana...")
Trans_Add("The Freenet service has been started!", "Us�uga Freenet zosta�a uruchomiona!")
Trans_Add("The Freenet service is already running!", "Us�uga Freenet jest ju� uruchomiona!")
Trans_Add("Freenet Starter error", "B��d Startera Freenet")

; Service stopper
Trans_Add("(service stopped)", "(us�uga zatrzymana)")
Trans_Add("Service was not running", "Us�uga nie by�a uruchomiona")
Trans_Add("Freenet Stopper", "Stopper Freenet")
Trans_Add("The Freenet service is stopping...", "Us�uga Freenet jest zatrzymywana...")
Trans_Add("The Freenet service has been stopped!", "Us�uga Freenet zosta�a zatrzymana!")
Trans_Add("The Freenet service is already stopped!", "Us�uga Freenet jest ju� zatrzymana!")
Trans_Add("Freenet Stopper error", "B��d Stoppera Freenet")

; Tray manager
Trans_Add("Freenet Tray", "Freenet Tray")
Trans_Add("Launch Freenet", "Uruchom Freenet")
Trans_Add("Start Freenet service", "Uruchom us�ug� Freenet")
Trans_Add("Stop Freenet service", "Zatrzymaj us�ug� Freenet")
Trans_Add("Manual update check", "R�czne sprawdzenie aktualizacji")
Trans_Add("View logfile", "Poka� logfile")
Trans_Add("About", "O...")
Trans_Add("Exit", "Wyj�cie")
Trans_Add("You can browse, start and stop Freenet along with other useful things from this tray icon.", "Mo�esz przegl�da�, startowa� i zatrzymywa� Freenet wraz z innymi przydatnymi rzeczami z tej ikony tray'a.")
Trans_Add("Left-click: Start/Browse Freenet", "Lewe klikni�cie: Start/Przegl�daj Freenet")
Trans_Add("Right-click: Advanced menu", "Prawe klikni�cie: Menu zaawansowane")
Trans_Add("Warning: Using the manual update check will update Freenet and its helper tools from the official Freenet website.", "Ostrze�enie: U�ycie r�cznej aktualizacji zaktualizuje Freenet i jego narz�dzia pomocy z oficjalnej strony Freenet.")
Trans_Add("Freenet already has a secure built-in autoupdate feature that will keep itself up-to-date automatically.", "Freenet posiada bezpieczne, wbudowane narz�dzie do automatycznej aktualizacji, kt�re b�dzie na bie��co aktualizowa�o program.")
Trans_Add("You should only use this manual update check if your installation is broken or you need updated versions of the helper tools.", "Powiniene� u�ywa� to r�czne narz�dzie sprawdzania aktualizacji, je�li instalacja jest zepsuta, b�d� potrzebujesz zaktualizowane wersje narz�dzi pomocy.")
Trans_Add("Freenet Windows Tray Manager", "Mened�er Tray'a Freenet")
}