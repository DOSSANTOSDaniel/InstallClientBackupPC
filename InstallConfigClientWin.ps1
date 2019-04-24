<#      
NOM DU SCRIPT: InstallConfigClientWin.ps1			
*================================================================*
DESCRIPTION:
 Le script va nous permettre de :

 1 :Installer le client Windows de BackupPC
 2 :Configurer la règle de firewall pour Rsync(873)
 3 :Enregistre dans un fichier le nom netbios du poste et 
 d'autres informations.
*================================================================*
AUTEUR: Daniel DOS SANTOS < daniel.massy91@gmail.com >			
*================================================================*
DATE DE CREATION: 24/04/2019	
*================================================================*  
USAGE: PS C:\Users> powershell ./InstallConfigClientWin.ps1		
*================================================================*
POWERSHELL VERSION: 5.1  
*================================================================*
#>

### Fonctions ###
function message ($1)
{
  Write-Host " " 
  Write-Host "$1"
  Write-Host "---------------------------------------------------------------------------------" -f green -b black
  Write-Host " "
}

### Début du code ###

# Message d'accueil
write-host ""
write-host "-----------------------------------------"
write-host "*                                       *"
write-host "*      Script client BackupPC           *"
write-host "*                                       *"
write-host "-----------------------------------------" 
write-host ""
Start-Sleep 2

# Dossier principale
mkdir $env:USERPROFILE\atout

message "Téléchargement du client Windows pour BackupPC en cours"
Invoke-WebRequest -Uri https://www.logicbox.fr/download/DesktopClient_LogicBackup_1.0.0.1_installer.exe -OutFile $env:USERPROFILE\atout\DesktopClient_LogicBackup_1.0.0.1_installer.exe
Clear-Host

# "/S" pour une installation non graphique
message "Installation du client en cours"
Start-Process $env:USERPROFILE\atout\DesktopClient_LogicBackup_1.0.0.1_installer.exe "/S"
Clear-Host

# Configuration du firewall de Windows
message "Ouverture dur port TCP 873 en trafic entrant en cours"
new-netfirewallrule -name "LogicBackup" -displayname "LogicBackup port 873" -profile domain,public,private -enabled true -protocol TCP -localport 873 -Action allow
Start-Sleep 6
Clear-Host

# Informations sur le poste client
$chemin="$env:USERPROFILE\atout\poste_$env:userdomain.txt"
message "Récupération des informations utiles concernant le poste client en cours"
message "Informations poste client $env:userdomain" *>> $chemin
get-wmiobject Win32_computersystem >> $chemin
message "Nom Netbios" *>> $chemin
$env:userdomain >> $chemin
message "Configuration Réseau" *>> $chemin
Get-NetIPConfiguration >> $chemin
Start-Sleep 3
Clear-Host

message "Les informations ont été enregistrées dans le fichier : $chemin"
write-host ""
write-host "-----------------------------------------"
write-host "*             Fin du script !           *"
write-host "-----------------------------------------" 
write-host ""