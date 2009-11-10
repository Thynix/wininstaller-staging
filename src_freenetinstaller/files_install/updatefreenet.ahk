;
; Windows Freenet start script by Zero3 (zero3 that-a-thingy zero3 that-dot-thingy dk) - http://freenetproject.org/
;
; Extra credits:
; - Service state function: heresy (http://www.autohotkey.com/forum/topic34984.html)
;

;
; Don't-touch-unless-you-know-what-you-are-doing settings
;
#NoEnv									; Recommended for performance and compatibility with future AutoHotkey releases
#NoTrayIcon								; We won't need this...
#SingleInstance	ignore							; Only allow one instance at any given time

;#Include ..\src_translationhelper\Include_TranslationHelper.ahk		; Include translation helper

SendMode, Input								; Recommended for new scripts due to its superior speed and reliability
StringCaseSense, Off							; Treat A-Z as equal to a-z when comparing strings. Useful when dealing with folders, as Windows treat them as equals.

;_WorkingDir := RegExReplace(A_ScriptDir, "i)\\bin$", "")		; If we are located in the \bin folder, go back a step
;SetWorkingDir, %_WorkingDir%						; Look for other files relative to install root

_SplashCreated := 0							; Initial value
_Silent := 0								; Initial value

;
; Customizable settings
;
_ServiceTimeout := 120							; Maximum number of seconds we wait before "timing out" and throwing an error when managing the system service
_SplashFormat = A B2 T FS8						; How our splash should look.

;
; General init stuff
;
;InitTranslations()

;
; Check if we should be silent or not (error messages are always displayed though)
;
_Arg1 = %1%
If (_Arg1 == "/?")
{
	PopupInfoMessage("Command line options (only use one):`n/silent - Hide info messages`n/verysilent - Hide info and status messages`n`nReturn codes:`n0 - Success (service started)`n1 - Error occurred`n2 - Service was already running (no action)")
	ExitApp, 0
}
Else If (_Arg1 == "/silent")
{
	_Silent := 1
}
Else If (_Arg1 == "/verysilent")
{
	_Silent := 2
}

;
; Check for administrator privileges.
;
If not (A_IsAdmin)
{
	PopupErrorMessage("Freenet start script requires administrator privileges to start the Freenet service. Please make sure that your user account has administrative access to the system, and the start script is executed with access to use these privileges.")
	ExitApp, 1
}

;
; Check node status
;
;IfNotExist, installid.dat
;{
;	PopupErrorMessage("Freenet start script was unable to find the installid.dat ID file.`n`nMake sure that you are running Freenet start ;script from the 'bin' folder of a Freenet installation directory. If you are already doing so, please report this error message to the ;developers.")
;	ExitApp, 1
;}


MsgBox ,289,Update non-anonymously over HTTP?,Connect to the Freenetproject.org website and check for updates?
IfMsgBox Ok
    goto continue
else
    MsgBox Update Cancelled.
	ExitApp , 0
	
	
continue:

; Gui, +Resize
; Gui, Add, Button, default, &Load New Image
; Gui, Add, Radio, ym+5 x+10 vRadio checked, Load &actual size
; Gui, Add, Radio, ym+5 x+10, Load to &fit screen
; Gui, Add, Pic, xm vPic
; Gui, Show
; return

; ButtonLoadNewImage:
; FileSelectFile, file,,, Select an image:, Images (*.gif; *.jpg; *.bmp; *.png; *.tif; *.ico; *.cur; *.ani; *.exe; *.dll)
; if file =
    ; return
; Gui, Submit, NoHide ; Save the values of the radio buttons.
; if Radio = 1  ; Display image at its actual size.
; {
    ; Width = 0
    ; Height = 0
; }
; else ; Second radio is selected: Resize the image to fit the screen.
; {
    ; Width := A_ScreenWidth - 28  ; Minus 28 to allow room for borders and margins inside.
    ; Height = -1  ; "Keep aspect ratio" seems best.
; }
; GuiControl,, Pic, *w%width% *h%height% %file%  ; Load the image.
; Gui, Show, xCenter y0 AutoSize, %file%  ; Resize the window to match the picture size.
; return

; GuiClose:
; ExitApp

next:
Gui, Font, S12 CDefault, Verdana
Gui, Add, Text, w280 h30 , Please select release:
Gui, Add, Radio, w320 h40 vRELEASE Checked, Stable  (recommended)
Gui, Add, Radio, w170 h40 , Testing
Gui, Add, Button,w130 h40 Default, Next
;;Generated using SmartGUI Creator 4.0
Gui, Show, Autosize Center, Select Freenet Release
return
ButtonNext:
Gui, Submit ; Save the values of the radio buttons.
if RELEASE = 1
	{
	RELEASE = stable
	}
	else
	{
	RELEASE = testing
	}
MsgBox You selected %RELEASE%.
run update.cmd %RELEASE% guilaunch

ExitApp


; :: TODO:
; :: Fixme: what to do with changing away from custom freenet user account?

; :: CHANGELOG:
; :: 3.5 - Script will handle all the binaries as soon as the website is ready
; :: 3.4 - Made script more failsafe.
; :: 3.3 - Refactored script to be more organized and prepare for updating Windows binaries
; :: 3.2 - Use the .sha1 url to check for updates to freenet-ext.jar.  Saves ~4mb per run.
; :: 3.1 - Fix permissions by fixing invalid cacls arguments
; :: 3.0 - Handle binary start/stop.exe exit conditions and use it to set restart flag.
; :: 2.9 - Check for file permissions
; :: 2.8 - Add detecting of Vista\Seven, use the appropriate version of cacls.
; :: 2.7 - Better error handling
; :: 2.6 - Prepare for new binary start and stop.exe's
; :: ---   Many various changes
; :: 2.4 - Test downloaded jar after making sure it is not empty.  Copy over freenet.jar after testing for integrity.
; :: 2.3 - Reduce retries to 5.  Turn on file resuming.  Clarify text.
; :: 2.2 - Reduce retry delay and time between retries.
; :: 2.1 - Title, comments, hide "Please ignore, it is a side effect of a work-around" echo unless its needed.
; :: 2.0 - Warn user not to abort script.
; :: 1.9 - Cosmetic fixes (Spacing, typos)
; :: 1.8 - Loop stop script until Node is stopped.
; :: 1.7 - Retry downloads on timeout.

; ::Initialize some stuff
; set MAGICSTRING=INDO
; set CAFILE=startssl.pem
; set RESTART=0
; set MAINJARUPDATED=0
; set EXTJARUPDATED=0
; set WRAPPEREXEUPDATED=0
; set WRAPPERDLLUPDATED=0
; set STARTEXEUPDATED=0
; set STOPEXEUPDATED=0
; set TRAYUTILITYUPDATED=0
; set LAUNCHERUPDATED=0
; set SEEDUPDATED=0
; set PATH=%SYSTEMROOT%\System32\;%PATH%
; set RELEASE=stable
; if "%1"=="testing" set RELEASE=testing
; if "%1"=="-testing" set RELEASE=testing
; if "%1"=="/testing" set RELEASE=testing

; echo - Release selected is: %RELEASE%
; echo -----

; ::Check if we are on Vista/Seven if so we need to use icacls instead of cacls
; set VISTA=0
; ::Treat server 2k3/XP64 as vista as they need icacls
; VER | findstr /l "5.2." > nul
; IF %ERRORLEVEL% EQU 0 set VISTA=1
; ::Vista?
; VER | findstr /l "6.0." > nul
; IF %ERRORLEVEL% EQU 0 set VISTA=1
; ::Seven?
; VER | findstr /l "6.1." > nul
; IF %ERRORLEVEL% EQU 0 set VISTA=1

; ::Go to our location
; for %%I in (%0) do set LOCATION=%%~dpI
; cd /D "%LOCATION%"

; ::Check if its valid, or at least looks like it
; if not exist freenet.ini goto error2
; if not exist bin\wget.exe goto error2

; ::Simple test to see if we have enough privileges to modify files.
; echo - Checking file permissions
; if exist writetest del writetest > NUL
; if exist writetest goto writefail
; echo test > writetest
; if not exist writetest goto writefail
; del writetest > NUL
; if exist writetest goto writefail

; :: Maybe fix bug #2556
; echo - Changing file permissions
; if %VISTA%==0 echo Y| cacls . /E /T /C /G freenet:f > NUL
; if %VISTA%==1 echo y| icacls . /grant freenet:(OI)(CI)F /T /C > NUL

; ::Get the filename and skip straight to the Freenet update if this is a new updater
; for %%I in (%0) do set FILENAME=%%~nxI
; if %FILENAME%==update.new.cmd goto updaterok

; ::New folder for keeping our temp files for this updater.
; if not exist update_temp mkdir update_temp

; ::Download latest updater and verify it
; if exist update_temp\update.new.cmd del update_temp\update.new.cmd
; echo - Checking for newer version of this update script...
; bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/update/update-new.cmd -O update_temp\update.new.cmd
; Title Freenet Update Over HTTP Script

; if not exist update_temp\update.new.cmd goto error1
; find "FREENET W%MAGICSTRING%WS UPDATE SCRIPT" update_temp\update.new.cmd > NUL
; if errorlevel 1 goto error1

; ::Check if updater has been updated
; fc update.cmd update_temp\update.new.cmd > NUL
; if not errorlevel 1 goto updaterok

; ::It has! Run new version and end self
; echo - New update script found, restarting update script...
; echo -----
; copy /Y update_temp\update.new.cmd update.new.cmd > NUL
; start update.new.cmd %RELEASE%
; goto veryend

; ::Updater is up to date, check Freenet
; :updaterok
; echo    - Update script is current.
; echo -----

; find "freenet.jar" wrapper.conf > NUL
; if errorlevel 1 goto error5

; find "freenet.jar.new" wrapper.conf > NUL
; if not errorlevel 1 goto error5

; :: fix #1527
; find "freenet-ext.jar.new" wrapper.conf > NUL
; if errorlevel 1 goto skipit
; if not exist freenet-ext.jar.new goto skipit
; if exist freenet-ext.jar del /F freenet-ext.jar > NUL
; copy freenet-ext.jar.new freenet-ext.jar > NUL
; :: Try to delete the file.  If the node is running, it will likely fail.
; if exist freenet-ext.jar.new del /F freenet-ext.jar.new > NUL
; :: Fix the wrapper.conf
; goto error5
; :skipit

; echo - Freenet installation found at %LOCATION%
; echo -----
; echo - Checking for Freenet JAR updates...
; echo -----

; ::Check for sha1test and download if needed.
; if not exist lib mkdir lib
; if not exist lib\sha1test.jar bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10  https://downloads.freenetproject.org/alpha/installer/sha1test.jar -O lib\sha1test.jar
; if not errorlevel 0 goto error3
; if not exist lib\sha1test.jar goto error3

; ::New folder for keeping our temp files for this updater.
; if not exist update_temp mkdir update_temp
; ::We will work out of the temp folder for most of the rest of this script.
; cd update_temp\
; ::Let's clean up any files currently in the Freenet folder
; if exist ..\freenet-*.url move /Y ..\freenet-*.url . > NUL
; if exist ..\freenet-*.sha1 move /Y ..\freenet-*.sha1 . > NUL
; if exist ..\freenet-stable* del ..\freenet-stable*
; if exist ..\freenet-testing* del ..\freenet-testing*

; ::Check for a new main jar
; echo - Checking main jar
; if exist freenet-%RELEASE%-latest.jar.url.bak del freenet-%RELEASE%-latest.jar.url.bak
; if exist freenet-%RELEASE%-latest.jar.url copy freenet-%RELEASE%-latest.jar.url freenet-%RELEASE%-latest.jar.url.bak > NUL
; if exist freenet-%RELEASE%-latest.jar.new.url del freenet-%RELEASE%-latest.jar.new.url
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/freenet-%RELEASE%-latest.jar.url -O freenet-%RELEASE%-latest.jar.new.url
; Title Freenet Update Over HTTP Script

; if not exist freenet-%RELEASE%-latest.jar.new.url goto error3
; FOR %%I IN ("freenet-%RELEASE%-latest.jar.new.url") DO if %%~zI==0 goto error3

; ::Do we have something old to compare with? If not, update right away
; if not exist freenet-%RELEASE%-latest.jar.url goto mainyes

; ::Compare with current copy
; fc freenet-%RELEASE%-latest.jar.url freenet-%RELEASE%-latest.jar.new.url > NUL
; if errorlevel 1 goto mainyes
; echo    - Main jar is current.
; goto maincheckend

; :mainyes
; echo    - New main jar found!
; set MAINJARUPDATED=1
; :maincheckend

; ::Check for a new freenet-ext.jar.
; echo - Checking ext jar
; if exist freenet-ext.jar.sha1.bak del freenet-ext.jar.sha1.bak
; if exist freenet-ext.jar.sha1 copy freenet-ext.jar.sha1 freenet-ext.jar.sha1.bak > NUL
; if exist freenet-ext.jar.sha1.new del freenet-ext.jar.sha1.new
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/freenet-ext.jar.sha1 -O freenet-ext.jar.sha1.new
; Title Freenet Update Over HTTP Script

; if not exist freenet-ext.jar.sha1.new goto error3
; FOR %%I IN ("freenet-ext.jar.sha1.new") DO if %%~zI==0 goto error3

; ::Do we have something old to compare with? If not, update right away
; if not exist freenet-ext.jar.sha1 goto extyes
; fc freenet-ext.jar.sha1 freenet-ext.jar.sha1.new > NUL
; if errorlevel 1 goto extyes
; echo    - ext jar is current.
; goto extcheckend

; :extyes
; echo    - New ext jar found!
; set EXTJARUPDATED=1
; :extcheckend


; ::Check wrapper .exe
; if not exist ..\bin\wrapper-windows-x86-32.exe goto wrapperexecheckend
; echo - Checking wrapper .exe
; if exist wrapper-windows-x86-32.exe.sha1.bak del wrapper-windows-x86-32.exe.sha1.bak
; if exist wrapper-windows-x86-32.exe.sha1 copy wrapper-windows-x86-32.exe.sha1 wrapper-windows-x86-32.exe.sha1.bak > NUL
; if exist wrapper-windows-x86-32.exe.sha1.new del wrapper-windows-x86-32.exe.sha1.new
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/installer/wrapper-windows-x86-32.exe.sha1 -O wrapper-windows-x86-32.exe.sha1.new
; Title Freenet Update Over HTTP Script

; if not exist wrapper-windows-x86-32.exe.sha1.new goto error3
; FOR %%I IN ("wrapper-windows-x86-32.exe.sha1.new") DO if %%~zI==0 goto error3

; ::Do we have something old to compare with? If not, update right away
; if not exist wrapper-windows-x86-32.exe.sha1 goto wrapperexeyes

; fc wrapper-windows-x86-32.exe.sha1 wrapper-windows-x86-32.exe.sha1.new > NUL
; if errorlevel 1 goto wrapperexeyes
; echo    - wrapper .exe is current.
; goto wrapperexecheckend

; :wrapperexeyes
; echo    - New wrapper .exe found!
; set WRAPPEREXEUPDATED=1
; :wrapperexecheckend


; ::Check wrapper .dll
; if not exist ..\lib\wrapper-windows-x86-32.dll goto wrapperdllcheckend
; echo - Checking wrapper .dll
; if exist wrapper-windows-x86-32.dll.sha1.bak del wrapper-windows-x86-32.dll.sha1.bak
; if exist wrapper-windows-x86-32.dll.sha1 copy wrapper-windows-x86-32.dll.sha1 wrapper-windows-x86-32.dll.sha1.bak > NUL
; if exist wrapper-windows-x86-32.dll.sha1.new del wrapper-windows-x86-32.dll.sha1.new
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/installer/wrapper-windows-x86-32.dll.sha1 -O wrapper-windows-x86-32.dll.sha1.new
; Title Freenet Update Over HTTP Script

; if not exist wrapper-windows-x86-32.dll.sha1.new goto error3
; FOR %%I IN ("wrapper-windows-x86-32.dll.sha1.new") DO if %%~zI==0 goto error3

; ::Do we have something old to compare with? If not, update right away
; if not exist wrapper-windows-x86-32.dll.sha1 goto wrapperdllyes

; fc wrapper-windows-x86-32.dll.sha1 wrapper-windows-x86-32.dll.sha1.new > NUL
; if errorlevel 1 goto wrapperdllyes
; echo    - wrapper .dll is current.
; goto wrapperdllcheckend

; :wrapperdllyes
; :: Handle loop if there is no old URL to compare to.
; echo    - New wrapper .dll found!
; set WRAPPERDLLUPDATED=1
; :wrapperdllcheckend


; ::Check start.exe if present
; if not exist ..\bin\start.exe goto startexecheckend
; echo - Checking start.exe
; if exist start.exe.sha1.bak del start.exe.sha1.bak
; if exist start.exe.sha1 copy start.exe.sha1 start.exe.sha1.bak > NUL
; if exist start.exe.sha1.new del start.exe.sha1.new
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/installer/start.exe.sha1 -O start.exe.sha1.new
; Title Freenet Update Over HTTP Script

; if not exist start.exe.sha1.new goto error3
; FOR %%I IN ("start.exe.sha1.new") DO if %%~zI==0 goto error3

; ::Do we have something old to compare with? If not, update right away
; if not exist start.exe.sha1 goto startexeyes

; fc start.exe.sha1 start.exe.sha1.new > NUL
; if errorlevel 1 goto startexeyes
; echo    - start.exe is current.
; goto startexecheckend

; :startexeyes
; echo    - New start.exe found!
; set STARTEXEUPDATED=1
; :startexecheckend


; ::Check stop.exe if present
; if not exist ..\bin\stop.exe goto stopexecheckend
; echo - Checking stop.exe
; if exist stop.exe.sha1.bak del stop.exe.sha1.bak
; if exist stop.exe.sha1 copy stop.exe.sha1 stop.exe.sha1.bak > NUL
; if exist stop.exe.sha1.new del stop.exe.sha1.new
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/installer/stop.exe.sha1 -O stop.exe.sha1.new
; Title Freenet Update Over HTTP Script

; if not exist stop.exe.sha1.new goto error3
; FOR %%I IN ("stop.exe.sha1.new") DO if %%~zI==0 goto error3

; ::Do we have something old to compare with? If not, update right away
; if not exist stop.exe.sha1 goto stopexeyes

; fc stop.exe.sha1 stop.exe.sha1.new > NUL
; if errorlevel 1 goto stopexeyes
; echo    - stop.exe is current.
; goto stopexecheckend

; :stopexeyes
; echo    - New stop.exe found!
; set STOPEXEUPDATED=1
; :stopexecheckend

; ::bypass this entire section so it won't run until the tray utility is ready.
; goto traycheckend
; ::Check tray utility if present
; ::If the required start.exe and stop.exe and installid.dat are present we will offer to install the tray for them
; if not exist ..\bin\start.exe goto traycheckend
; if not exist ..\bin\stop.exe goto traycheckend
; if not exist ..\installid.dat goto traycheckend
; if exist ..\bin\freenettray.exe goto traycheck

; ::Get the tray utility and put it in the \bin directory
; ::We don't need to exit the program because it's not running since it's not even installed.
; echo - Downloading freenettray.exe
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/installer/freenettray.exe -O freenettray.exe
; Title Freenet Update Over HTTP Script

; if not exist freenettray.exe goto error3
; FOR %%I IN ("freenettray.exe") DO if %%~zI==0 goto error3

; java -cp ..\lib\sha1test.jar Sha1Test freenettray.exe . ..\%CAFILE% > NUL
; if %ERRORLEVEL% NEQ 0 goto error4
; Title Freenet Update Over HTTP Script

; ::Copy it to the /bin folder
; copy /Y freenettray.exe ..\bin\freenettray.exe > NUL
; if not exist ..\bin\freenettray.exe goto unknownerror

; ::Offer to install freenettray.exe in the all users>start folder
; echo *******************************************************************
; echo * It appears you are not using the Freenet tray utility.  
; echo * This is likely because you have an older installation that
; echo * was before the tray program was created.  
; echo * We have downloaded the tray utility to your \bin directory.
; echo *******************************************************************
; echo -
; echo - We can also install it in your startup folder so it launches when you login.  
; :promptloop
; ::Set ANSWER to a different variable so it won't bug out when we loop
; set ANSWER==X
; echo - 
; set /P ANSWER=- Would you like to install it for "A"ll users, just "Y"ou or "N"one? 
; if /i %ANSWER%==A goto allusers
; if /i %ANSWER%==Y goto justyou
; if /i %ANSWER%==N goto traycheckend
; ::User hit a wrong key or <enter> without selecting, go around again.
; goto promptloop
; :allusers
; copy /Y freenettray.exe "%ALLUSERSPROFILE%\Start Menu\Programs\Startup\" > NUL
; if not errorlevel 0 goto writefail
; echo freenettray.exe copied to %ALLUSERSPROFILE%\Start Menu\Programs\Startup\
; goto traycheck
; :justyou
; copy /Y freenettray.exe "%USERPROFILE%\Start Menu\Programs\Startup\" > NUL
; if not errorlevel 0 goto writefail
; echo freenettray.exe copied to %USERPROFILE%\Start Menu\Programs\Startup\

; :traycheck
; echo - Checking freenettray.exe
; if exist freenettray.exe.sha1.bak del freenettray.exe.sha1.bak
; if exist freenettray.exe.sha1 copy freenettray.exe.sha1 freenettray.exe.sha1.bak > NUL
; if exist freenettray.exe.sha1.new del freenettray.exe.sha1.new
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/installer/freenettray.exe.sha1 -O freenettray.exe.sha1.new
; Title Freenet Update Over HTTP Script

; if not exist freenettray.exe.sha1.new goto error3
; FOR %%I IN ("freenettray.exe.sha1.new") DO if %%~zI==0 goto error3

; ::Do we have something old to compare with? If not, update right away
; if not exist freenettray.exe.sha1 goto trayyes

; fc freenettray.exe.sha1 freenettray.exe.sha1.new > NUL
; if errorlevel 1 goto trayyes
; echo    - freenettray.exe is current.
; goto traycheckend

; :trayyes
; echo    - New freenettray.exe found!
; set TRAYUTILITYUPDATED=1
; ::We can only hope the tray gets shutdown in time, let's give it all the time we can by starting now
; if not exist ..\tray_die.dat type "" >> ..\tray_die.dat
; :traycheckend


; ::Check launcher utility if present
; if not exist ..\freenetlauncher.exe goto launchercheckend
; echo - Checking freenetlauncher.exe
; if exist freenetlauncher.exe.sha1.bak del freenetlauncher.exe.sha1.bak
; if exist freenetlauncher.exe.sha1 copy freenetlauncher.exe.sha1 freenetlauncher.exe.sha1.bak > NUL
; if exist freenetlauncher.exe.sha1.new del freenetlauncher.exe.sha1.new
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/installer/freenetlauncher.exe.sha1 -O freenetlauncher.exe.sha1.new
; Title Freenet Update Over HTTP Script

; if not exist freenetlauncher.exe.sha1.new goto error3
; FOR %%I IN ("freenetlauncher.exe.sha1.new") DO if %%~zI==0 goto error3

; ::Do we have something old to compare with? If not, update right away
; if not exist freenetlauncher.exe.sha1 goto launcheryes

; fc freenetlauncher.exe.sha1 freenetlauncher.exe.sha1.new > NUL
; if errorlevel 1 goto launcheryes
; echo    - freenetlauncher.exe is current.
; goto launchercheckend

; :launcheryes
; echo    - New freenetlauncher.exe found!
; set LAUNCHERUPDATED=1
; :launchercheckend

; ::Check for an updated seednodes.fref
; if exist seednodes.fref.sha1.bak del seednodes.fref.sha1.bak
; if exist seednodes.fref.sha1 copy seednodes.fref.sha1 seednodes.fref.sha1.bak > NUL
; if exist seednodes.fref.sha1.new del seednodes.fref.sha1.new
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/opennet/seednodes.fref.sha1 -O seednodes.fref.sha1.new
; Title Freenet Update Over HTTP Script

; if not exist seednodes.fref.sha1.new goto error3
; FOR %%I IN ("seednodes.fref.sha1.new") DO if %%~zI==0 goto error3

; ::Do we have something old to compare with? If not, update right away
; if not exist seednodes.fref.sha1 goto seedyes

; fc seednodes.fref.sha1 seednodes.fref.sha1.new > NUL
; if errorlevel 1 goto seedyes
; goto seedcheckend

; :seedyes
; set SEEDUPDATED=1
; :seedcheckend


; ::Check if we have flagged any of the files as updated
; if %MAINJARUPDATED%==1 goto updatebegin
; if %EXTJARUPDATED%==1 goto updatebegin
; if %WRAPPEREXEUPDATED%==1 goto updatebegin
; if %WRAPPERDLLUPDATED%==1 goto updatebegin
; if %STARTEXEUPDATED%==1 goto updatebegin
; if %STOPEXEUPDATED%==1 goto updatebegin
; if %TRAYUTILITYUPDATED%==1 goto updatebegin
; if %LAUNCHERUPDATED%==1 goto updatebegin
; goto noupdate

; ::New version found, check if the node is currently running
; :updatebegin
; echo -----
; echo - New Freenet version found!  Installing now...
; echo -----

; echo - Downloading new files...

; ::Download new main jar file
; if %MAINJARUPDATED%==0 goto mainjardownloadend
; if exist freenet-%RELEASE%-latest.jar del freenet-%RELEASE%-latest.jar
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 -i freenet-%RELEASE%-latest.jar.new.url -O freenet-%RELEASE%-latest.jar
; Title Freenet Update Over HTTP Script
; :: Make sure it got downloaded successfully
; if not exist freenet-%RELEASE%-latest.jar goto error4
; FOR %%I IN ("freenet-%RELEASE%-latest.jar") DO if %%~zI==0 goto error4
; ::Test the new file for integrity.
; java -cp ..\lib\sha1test.jar Sha1Test freenet-%RELEASE%-latest.jar . ..\%CAFILE% > NUL
; if %ERRORLEVEL% NEQ 0 goto error4
; echo    - Freenet-%RELEASE%-snapshot.jar downloaded and verified
; :mainjardownloadend

; ::Download new ext jar file
; if %EXTJARUPDATED%==0 goto extjardownloadend
; if exist freenet-ext.jar.sha1 del freenet-ext.jar.sha1
; if exist freenet-ext.jar del freenet-ext.jar
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 https://checksums.freenetproject.org/cc/freenet-ext.jar -O freenet-ext.jar
; Title Freenet Update Over HTTP Script
; if not exist freenet-ext.jar goto error4
; FOR %%I IN ("freenet-ext.jar") DO if %%~zI==0 goto error4
; ::Test the new file for integrity.
; java -cp ..\lib\sha1test.jar Sha1Test freenet-ext.jar . ..\%CAFILE% > NUL
; if %ERRORLEVEL% NEQ 0 goto error4
; echo    - Freenet-ext.jar downloaded and verified
; :extjardownloadend

; ::Download new wrapper.exe file
; if %WRAPPEREXEUPDATED%==0 goto wrapperexedownloadend
; if exist wrapper-windows-x86-32.exe.sha1 del wrapper-windows-x86-32.exe.sha1
; if exist wrapper-windows-x86-32.exe del wrapper-windows-x86-32.exe
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 https://checksums.freenetproject.org/cc/wrapper-windows-x86-32.exe -O wrapper-windows-x86-32.exe
; Title Freenet Update Over HTTP Script
; if not exist wrapper-windows-x86-32.exe goto error4
; FOR %%I IN ("wrapper-windows-x86-32.exe") DO if %%~zI==0 goto error4
; ::Test the new file for integrity.
; java -cp ..\lib\sha1test.jar Sha1Test wrapper-windows-x86-32.exe . ..\%CAFILE% > NUL
; if %ERRORLEVEL% NEQ 0 goto error4
; echo    - wrapper .exe downloaded and verified
; :wrapperexedownloadend

; ::Download new wrapper.dll file
; if %WRAPPERDLLUPDATED%==0 goto wrapperdlldownloadend
; if exist wrapper-windows-x86-32.dll.sha1 del wrapper-windows-x86-32.dll.sha1
; if exist wrapper-windows-x86-32.dll del wrapper-windows-x86-32.dll
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 https://checksums.freenetproject.org/cc/wrapper-windows-x86-32.dll -O wrapper-windows-x86-32.dll
; Title Freenet Update Over HTTP Script
; if not exist wrapper-windows-x86-32.dll goto error4
; FOR %%I IN ("wrapper-windows-x86-32.dll") DO if %%~zI==0 goto error4
; ::Test the new file for integrity.
; java -cp ..\lib\sha1test.jar Sha1Test wrapper-windows-x86-32.dll . ..\%CAFILE% > NUL
; if %ERRORLEVEL% NEQ 0 goto error4
; echo    - wrapper .dll downloaded and verified
; :wrapperdlldownloadend

; ::Download new start.exe file
; if %STARTEXEUPDATED%==0 goto startexedownloadend
; if exist start.exe.sha1 del start.exe.sha1
; if exist start.exe del start.exe
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 https://checksums.freenetproject.org/cc/start.exe -O start.exe
; Title Freenet Update Over HTTP Script
; if not exist start.exe goto error4
; FOR %%I IN ("start.exe") DO if %%~zI==0 goto error4
; ::Test the new file for integrity.
; java -cp ..\lib\sha1test.jar Sha1Test start.exe . ..\%CAFILE% > NUL
; if %ERRORLEVEL% NEQ 0 goto error4
; echo    - start.exe downloaded and verified
; :startexedownloadend

; ::Download new stop.exe file
; if %STOPEXEUPDATED%==0 goto stopexedownloadend
; if exist stop.exe.sha1 del stop.exe.sha1
; if exist stop.exe del stop.exe
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 https://checksums.freenetproject.org/cc/stop.exe -O stop.exe
; Title Freenet Update Over HTTP Script
; if not exist stop.exe goto error4
; FOR %%I IN ("stop.exe") DO if %%~zI==0 goto error4
; ::Test the new file for integrity.
; java -cp ..\lib\sha1test.jar Sha1Test stop.exe . ..\%CAFILE% > NUL
; if %ERRORLEVEL% NEQ 0 goto error4
; echo    - stop.exe downloaded and verified
; :stopexedownloadend

; ::Download new freenettray.exe file
; if %TRAYUTILITYUPDATED%==0 goto traydownloadend
; if exist freenettray.exe.sha1 del freenettray.exe.sha1
; if exist freenettray.exe del freenettray.exe
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 https://checksums.freenetproject.org/cc/freenettray.exe -O freenettray.exe
; Title Freenet Update Over HTTP Script
; if not exist freenettray.exe goto error4
; FOR %%I IN ("freenettray.exe") DO if %%~zI==0 goto error4
; ::Test the new file for integrity.
; java -cp ..\lib\sha1test.jar Sha1Test freenettray.exe . ..\%CAFILE% > NUL
; if %ERRORLEVEL% NEQ 0 goto error4
; echo    - freenettray.exe downloaded and verified
; :traydownloadend

; ::Download new freenetlauncher.exe file
; if %LAUNCHERUPDATED%==0 goto stoplauncherdownloadend
; if exist freenetlauncher.exe.sha1 del freenetlauncher.exe.sha1
; if exist freenetlauncher.exe del freenetlauncher.exe
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 https://checksums.freenetproject.org/cc/freenetlauncher.exe -O freenetlauncher.exe
; Title Freenet Update Over HTTP Script
; if not exist freenetlauncher.exe goto error4
; FOR %%I IN ("freenetlauncher.exe") DO if %%~zI==0 goto error4
; ::Test the new file for integrity.
; java -cp ..\lib\sha1test.jar Sha1Test freenetlauncher.exe . ..\%CAFILE% > NUL
; if %ERRORLEVEL% NEQ 0 goto error4
; echo    - freenetlauncher.exe downloaded and verified
; :stoplauncherdownloadend

; ::Download an updated seednodes.fref.  We will only do this if at least one of the main files above were updated and the .sha1 of the file has changed.
; ::We are stingy because we don't want people to run this script *just* to get the latest seednodes file.
; if %SEEDUPDATED%==0 goto seeddownloadend
; if exist seednodes.fref.sha1 del seednodes.fref.sha1
; if exist seednodes.fref del seednodes.fref
; ..\bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/opennet/seednodes.fref -O seednodes.fref
; Title Freenet Update Over HTTP Script
; if not exist seednodes.fref goto error4
; FOR %%I IN ("seednodes.fref") DO if %%~zI==0 goto error4
; ::Test the new file for integrity.
; java -cp ..\lib\sha1test.jar Sha1Test seednodes.fref . ..\%CAFILE% > NUL
; if %ERRORLEVEL% NEQ 0 goto error4
; echo    - seednodes.fref downloaded and verified
; :seeddownloadend

; Title Freenet Update Over HTTP Script


; ::Time to stop the node and if needed freenettray.exe
; if %TRAYUTILITYUPDATED%==0 goto nodestop
; ::We can only hope the tray gets shutdown in time
; if not exist ..\tray_die.dat type "" >> ..\tray_die.dat


; :nodestop
; ::See if we are using the new binary stop.exe
; if not exist ..\bin\stop.exe goto oldstopper
; :newstoppper
; call ..\bin\stop.exe /silent
; if errorlevel 0 set RESTART=1
; if errorlevel 1 goto unknownerror
; goto beginfilecopy

; :oldstopper
; net start | find "Freenet 0.7 darknet" > NUL
; if errorlevel 1 goto beginfilecopy > NUL
; set RESTART=1
; ::Tell the user not to abort script, it gets very messy.
; echo -----
; echo - Shutting down Freenet...   (This may take a moment, please don't abort)
; echo -----
; call ..\bin\stop.cmd > NUL
; net start | find "Freenet 0.7 darknet" > NUL
; if errorlevel 1 goto beginfilecopy
; :: Uh oh, this may take a few tries.  Better tell the user not to panic.
; echo -
; echo - If you see an error message about:
; echo - "The service could not be controlled in its present state."
; echo - Please ignore, it is a side effect of a work-around
; echo - to make sure the node is stopped before we copy files.
; echo -
; ::Keep trying until service is stopped for sure.
; :safetycheck
; net start | find "Freenet 0.7 darknet" > NUL
; if errorlevel 1 goto beginfilecopy
; call ..\bin\stop.cmd > NUL
; goto safetycheck

; ::Ok Freenet is stopped, it is safe to copy files.
; :beginfilecopy
; ::Everything looks good, lets install it
; echo - Backing up files...
; echo -----
; ::Backup last version of Freenet.jar file, user may want to go back if something is broken in new build
; if exist freenet.jar.bak del freenet.jar.bak
; if exist ..\freenet.jar copy ..\freenet.jar freenet.jar.bak > NUL
; ::Backup last version of wrapper.exe file, user may want to go back if something is broken in new build
; if exist wrapper-windows-x86-32.exe.bak del wrapper-windows-x86-32.exe.bak
; if exist ..\bin\wrapper-windows-x86-32.exe copy ..\bin\wrapper-windows-x86-32.exe wrapper-windows-x86-32.exe.bak > NUL
; ::Backup last version of wrapper.dll file, user may want to go back if something is broken in new build
; if exist wrapper-windows-x86-32.dll.bak del wrapper-windows-x86-32.dll.bak
; if exist ..\lib\wrapper-windows-x86-32.dll copy ..\lib\wrapper-windows-x86-32.dll wrapper-windows-x86-32.dll.bak > NUL
; ::Backup last version of start.exe file, user may want to go back if something is broken in new build
; if exist start.exe.bak del start.exe.bak
; if exist ..\bin\start.exe copy ..\bin\start.exe start.exe.bak > NUL
; ::Backup last version of stop.exe file, user may want to go back if something is broken in new build
; if exist stop.exe.bak del stop.exe.bak
; if exist ..\bin\stop.exe copy ..\bin\stop.exe stop.exe.bak > NUL
; ::Backup last version of freenettray.exe file, user may want to go back if something is broken in new build
; if exist freenettray.exe.bak del freenettray.exe.bak
; if exist ..\bin\freenettray.exe copy ..\bin\freenettray.exe freenettray.exe.bak > NUL
; ::Backup last version of freenetlauncher.exe file, user may want to go back if something is broken in new build
; if exist freenetlauncher.exe.bak del freenetlauncher.exe.bak
; if exist ..\freenetlauncher.exe copy ..\freenetlauncher.exe freenetlauncher.exe.bak > NUL
; ::Backup last version of seednodes.fref file, user may want to go back if something is broken in new build
; if exist seednodes.fref.bak del seednodes.fref.bak
; if exist ..\seednodes.fref copy ..\seednodes.fref seednodes.fref.bak > NUL

; echo - Installing new files...
; ::Main jar
; if %MAINJARUPDATED%==0 goto maincopyend
; copy /Y freenet-%RELEASE%-latest.jar ..\freenet.jar > NUL
; ::Prepare shortcut file for next run.
; if exist freenet-%RELEASE%-latest.jar.url del freenet-%RELEASE%-latest.jar.url
; ren freenet-%RELEASE%-latest.jar.new.url freenet-%RELEASE%-latest.jar.url
; echo    - Freenet-%RELEASE%-snapshot.jar copied to freenet.jar
; :maincopyend

; ::Ext jar
; if %EXTJARUPDATED%==0 goto extcopyend
; copy /Y freenet-ext.jar ..\freenet-ext.jar > NUL
; ::Prepare .sha1 file for next run.
; if exist freenet-ext.jar.sha1 del freenet-ext.jar.sha1
; if exist freenet-ext.jar.sha1.new ren freenet-ext.jar.sha1.new freenet-ext.jar.sha1
; echo    - Copied updated freenet-ext.jar
; :extcopyend

; ::wrapper .exe
; if %WRAPPEREXEUPDATED%==0 goto wrapperexecopyend
; copy /Y wrapper-windows-x86-32.exe ..\bin\wrapper-windows-x86-32.exe > NUL
; ::Prepare .sha1 file for next run.
; if exist wrapper-windows-x86-32.exe.sha1 del wrapper-windows-x86-32.exe.sha1
; if exist wrapper-windows-x86-32.exe.sha1.new ren wrapper-windows-x86-32.exe.sha1.new wrapper-windows-x86-32.exe.sha1
; echo    - Copied updated wrapper .exe
; :wrapperexecopyend

; ::Wrapper .dll
; if %WRAPPERDLLUPDATED%==0 goto wrapperdllcopyend
; copy /Y wrapper-windows-x86-32.dll ..\lib\wrapper-windows-x86-32.dll > NUL
; ::Prepare .sha1 file for next run.
; if exist wrapper-windows-x86-32.dll.sha1 del wrapper-windows-x86-32.dll.sha1
; if exist wrapper-windows-x86-32.dll.sha1.new ren wrapper-windows-x86-32.dll.sha1.new wrapper-windows-x86-32.dll.sha1
; echo    - Copied updated wrapper dll
; :wrapperdllcopyend

; ::Start.exe
; if %STARTEXEUPDATED%==0 goto startexecopyend
; copy /Y start.exe ..\bin\start.exe > NUL
; ::Prepare .sha1 file for next run.
; if exist start.exe.sha1 del start.exe.sha1
; if exist start.exe.sha1.new ren start.exe.sha1.new start.exe.sha1
; echo    - Copied updated start.exe
; :startexecopyend

; ::Stop.exe
; if %STOPEXEUPDATED%==0 goto stopexecopyend
; copy /Y stop.exe ..\bin\stop.exe > NUL
; ::Prepare .sha1 file for next run.
; if exist stop.exe.sha1 del stop.exe.sha1
; if exist stop.exe.sha1.new ren stop.exe.sha1.new stop.exe.sha1
; echo    - Copied updated stop.exe
; :stopexecopyend

; ::freenetlauncher.exe
; if %LAUNCHERUPDATED%==0 goto launchercopyend
; copy /Y freenetlauncher.exe ..\freenetlauncher.exe > NUL
; ::Prepare .sha1 file for next run.
; if exist freenetlauncher.exe.sha1 del freenetlauncher.exe.sha1
; if exist freenetlauncher.exe.sha1.new ren freenetlauncher.exe.sha1.new freenetlauncher.exe.sha1
; echo    - Copied updated freenetlauncher.exe
; :launchercopyend

; ::freenettray.exe
; if %TRAYUTILITYUPDATED%==0 goto traycopyend
; :trayloop
; copy /Y freenettray.exe ..\bin\freenettray.exe > NUL
; if not errorlevel 0 goto trayloop
; ::Update the startup folder also
; if exist "%ALLUSERSPROFILE%\Start Menu\Programs\Startup\freenettray.exe" copy /y freenettray.exe "%ALLUSERSPROFILE%\Start Menu\Programs\Startup\" > NUL
; if exist "%USERPROFILE%\Start Menu\Programs\Startup\freenettray.exe" copy /y freenettray.exe "%USERPROFILE%\Start Menu\Programs\Startup\" > NUL
; ::Prepare .sha1 file for next run.
; if exist freenettray.exe.sha1 del freenettray.exe.sha1
; if exist freenettray.exe.sha1.new ren freenettray.exe.sha1.new freenettray.exe.sha1
; echo    - Copied updated freenettray.exe
; :traycopyend

; ::seednodes.fref
; if %SEEDUPDATED%==0 goto seedcopyend
; copy /Y seednodes.fref ..\seednodes.fref > NUL
; ::Prepare .sha1 file for next run.
; if exist seednodes.fref.sha1 del seednodes.fref.sha1
; if exist seednodes.fref.sha1.new ren seednodes.fref.sha1.new seednodes.fref.sha1
; echo    - Copied updated seednodes.fref
; :seedcopyend

; goto end

; ::No update needed
; :noupdate
; echo -----
; echo - Freenet is already up to date.
; goto end

; ::Server gave us a damaged version of the update script, tell user to try again later.
; :error1
; echo - Error! Downloaded update script is invalid. Try again later.
; goto end

; ::Can't find Freenet installation
; :error2
; echo - Error! Please run this script from a working Freenet installation.
; echo -----
; pause
; goto veryend

; ::Server may be down.
; :error3
; echo - Error! Could not download latest Freenet update information. Try again later.
; goto end

; ::Corrupt file was downloaded, restore comparison URL's from backup.
; :error4
; echo - Error! Freenet update failed, one or more files didn't download correctly...
; ::Restore the old .sha1 files so we can check them again next run.
; ::Main jar
; if exist freenet-%RELEASE%-latest.jar.url del freenet-%RELEASE%-latest.jar.url
; if exist freenet-%RELEASE%-latest.jar.url.bak ren freenet-%RELEASE%-latest.jar.url.bak freenet-%RELEASE%-latest.jar.url
; ::Ext jar
; if exist freenet-ext.jar.sha1 del freenet-ext.jar.sha1
; if exist freenet-ext.jar.sha1.bak ren freenet-ext.jar.sha1.bak freenet-ext.jar.sha1
; ::Wrapper .exe
; if exist wrapper-windows-x86-32.exe.sha1 del wrapper-windows-x86-32.exe.sha1
; if exist wrapper-windows-x86-32.exe.sha1.bak ren wrapper-windows-x86-32.exe.sha1.bak wrapper-windows-x86-32.exe.sha1
; ::Wrapper .dll
; if exist wrapper-windows-x86-32.dll.sha1 del wrapper-windows-x86-32.dll.sha1
; if exist wrapper-windows-x86-32.dll.sha1.bak ren wrapper-windows-x86-32.dll.sha1.bak wrapper-windows-x86-32.dll.sha1
; ::Start.exe
; if exist start.exe.sha1 del start.exe.sha1
; if exist start.exe.sha1.bak ren start.exe.sha1.bak start.exe.sha1
; ::Stop.exe
; if exist stop.exe.sha1 del stop.exe.sha1
; if exist stop.exe.sha1.bak ren stop.exe.sha1.bak stop.exe.sha1
; ::Tray utility
; if exist freenettray.exe.sha1 del freenettray.exe.sha1
; if exist freenettray.exe.sha1.bak ren freenettray.exe.sha1.bak freenettray.exe.jar.sha1
; ::Launcher.exe
; if exist freenetlauncher.exe.sha1 del freenetlauncher.exe.sha1
; if exist freenetlauncher.exe.sha1.bak ren freenetlauncher.exe.sha1.bak freenetlauncher.exe.sha1
; ::seednodes.fref
; if exist seednodes.fref.sha1 del seednodes.fref.sha1
; if exist seednodes.fref.sha1.bak ren seednodes.fref.sha1.bak seednodes.fref.sha1

; goto end

; ::Wrapper.conf is old, downloading new version and restarting update script
; :error5
; echo - Your wrapper.conf needs to be updated .... updating it; please restart the script when done.
; :: Let's try falling back to the old version of the wrapper so we can keep our memory settings.  If it doesn't work we'll get a new one next time around.
; if not exist wrapper.conf.bak goto newwrapper
; if exist wrapper.conf del wrapper.conf
; ren wrapper.conf.bak wrapper.conf
; start update.cmd
; goto veryend

; :newwrapper
; if exist wrapper.conf ren wrapper.conf wrapper.conf.bak
; :: This will set the memory settings back to default, but it can't be helped.
; bin\wget.exe -o NUL -c --timeout=5 --tries=5 --waitretry=10 http://downloads.freenetproject.org/alpha/update/wrapper.conf -O wrapper.conf
; if not exist wrapper.conf goto wrappererror
; if exist wrapper.password type wrapper.password >> wrapper.conf
; start update.cmd
; goto veryend

; :wrappererror
; if exist wrapper.conf.bak ren wrapper.conf.bak wrapper.conf
; goto error3

; ::Cleanup and restart if needed.
; :end
; echo -----
; echo - Cleaning up...

; :: Maybe fix bug #2556
; cd ..
; echo - Changing file permissions
; if %VISTA%==0 echo Y| cacls . /E /T /C /G freenet:F > NUL
; if %VISTA%==1 echo y| icacls . /grant freenet:(OI)(CI)F /T /C > NUL

; ::Try to restart the tray if it was flagged as updated
; if %TRAYUTILITYUPDATED%==0 goto restart
; if exist tray_die.dat del tray_die.dat
; start bin\freenettray.exe
; :restart
; if %RESTART%==0 goto cleanup2
; echo - Restarting Freenet...
; ::See if we are using the new binary start.exe
; if not exist bin\start.exe goto oldstarter
; call bin\start.exe /silent
; if errorlevel 0 goto cleanup2
; cd update_temp
; goto unknownerror

; :oldstarter
; call bin\start.cmd > NUL

; :cleanup2
; if %FILENAME%==update.new.cmd goto newend
; if exist update_temp\update.new.cmd del update_temp\update.new.cmd
; echo -----
; goto veryend

; ::If this session was launched by an old updater, replace it now (and force exit, or we will leave a command prompt open)
; :newend
; copy /Y update.new.cmd update.cmd > NUL
; echo -----
; exit

 ; ::We don't have enough privileges!
; :writefail
; echo - File permissions error!  Please launch this script with administrator privileges.
; pause
; goto veryend

; :unknownerror
; echo - An unknown error has occurred.
; echo - Please scroll up and look for clues and contact support@freenetproject.org
; ::Restore the old .sha1 files so we can check them again next run.
; ::Main jar
; if exist freenet-%RELEASE%-latest.jar.url del freenet-%RELEASE%-latest.jar.url
; if exist freenet-%RELEASE%-latest.jar.url.bak ren freenet-%RELEASE%-latest.jar.url.bak freenet-%RELEASE%-latest.jar.url
; ::Ext jar
; if exist freenet-ext.jar.sha1 del freenet-ext.jar.sha1
; if exist freenet-ext.jar.sha1.bak ren freenet-ext.jar.sha1.bak freenet-ext.jar.sha1
; ::Wrapper .exe
; if exist wrapper-windows-x86-32.exe.sha1 del wrapper-windows-x86-32.exe.sha1
; if exist wrapper-windows-x86-32.exe.sha1.bak ren wrapper-windows-x86-32.exe.sha1.bak wrapper-windows-x86-32.exe.sha1
; ::Wrapper .dll
; if exist wrapper-windows-x86-32.dll.sha1 del wrapper-windows-x86-32.dll.sha1
; if exist wrapper-windows-x86-32.dll.sha1.bak ren wrapper-windows-x86-32.dll.sha1.bak wrapper-windows-x86-32.dll.sha1
; ::Start.exe
; if exist start.exe.sha1 del start.exe.sha1
; if exist start.exe.sha1.bak ren start.exe.sha1.bak start.exe.sha1
; ::Stop.exe
; if exist stop.exe.sha1 del stop.exe.sha1
; if exist stop.exe.sha1.bak ren stop.exe.sha1.bak stop.exe.sha1
; ::Tray utility
; if exist freenettray.exe.sha1 del freenettray.exe.sha1
; if exist freenettray.exe.sha1.bak ren freenettray.exe.sha1.bak freenettray.exe.jar.sha1
; ::Launcher.exe
; if exist freenetlauncher.exe.sha1 del freenetlauncher.exe.sha1
; if exist freenetlauncher.exe.sha1.bak ren freenetlauncher.exe.sha1.bak freenetlauncher.exe.sha1
; ::seednodes.fref
; if exist seednodes.fref.sha1 del seednodes.fref.sha1
; if exist seednodes.fref.sha1.bak ren seednodes.fref.sha1.bak seednodes.fref.sha1

; pause

; :veryend
; ::FREENET WINDOWS UPDATE SCRIPT


;
; Helper functions
;
PopupErrorMessage(_ErrorMessage)
{
	MsgBox, 16, % "Freenet start script error", %_ErrorMessage%		; 16 = Icon Hand (stop/error)
}

PopupInfoMessage(_InfoMessage)
{
	global

	If (_Silent < 1)
	{
		MsgBox, 64, % "Freenet start script", %_InfoMessage%		; 64 = Icon Asterisk (info)
	}
}

