:: Install choco .exe and add choco to PATH
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

:: Install all the packages
:::: Browsers
choco install googlechrome -y
#choco install firefox -y
#choco install brave -y

:: Drive
choco install googledrive -y

:: Office
# choco install officeproplus2013 -y
choco install office365proplus -y

:::: Dev tools
choco install wireshark -y
choco install python -y

:: Git
choco install git -y
# choco install sourcetree -y

:: VM
# choco install vmware-workstation-player -y
choco install vmwareworkstation -y

:::: Text editors / IDEs / Readers
choco install adobereader -y
# choco install pdfcreator -y
# choco install sublimetext3 -y
# choco install intellijidea-ultimate -y
choco install visualstudiocode -y
# choco install visualstudio2019community -y
choco install pycharm-community -y
choco install mobaxterm -y


:::: Media
choco install vlc -y
choco install stremio -y

:::: Utilities + other
choco install zoom -y
choco install discord -y
choco install 7zip -y
choco install termius -y
choco install putty -y
choco install notepadplusplus.install -y
choco install filezilla -y
choco install tailscale -y
choco install greenshot -y
#choco install jdk8 -y

::: Python
pip3 install pytest

::: Config git global
git config --global user.name "FainiDenis"
git config --gloabal user.email "dtf8841@rit.edu"

::: Microsoft Activation Scripts (MAS):
@powershell irm https://massgrave.dev/get | iex
