<#      
NOM DU SCRIPT: InstallConfigClientWin.ps1			
*================================================================*
DESCRIPTION:

 Le script va nous permettre de ::

 1 :Installer le client Windows de BackupPC
 2 :Configurer la règle de firewall pour Rsync(873)
 3 :Enregistre dans un fichier le nom netbios du poste
 4 :Enregistre des informations sur le réseau		
*================================================================*
AUTEUR: Daniel DOS SANTOS < daniel.massy91@gmail.com >			
*================================================================*
DATE DE CREATION: 24/04/2019	
*================================================================*  
USAGE: PS C:\Users> powershell ./InstallConfigClientWin.ps1		
*================================================================*
NOTES: 
    
*================================================================*
POWERSHELL VERSION: 5.1  
*================================================================*
    RESTE A FAIRE
    ----------------

    1* 
#>

####   fonctions    ###
############################################
function message 
{
  Write-Host " " 
  Write-Host "$1"
  Write-Host "---------------------------" -f green -b black
  Write-Host " "
}

##### Début du script #####
## message d'accueil  ##
write-host ""
write-host "-----------------------------------------"
write-host "*                                       *"
write-host "*             BIENVENUE                 *"
write-host "*                                       *"
write-host "* SCRIPT << BackupPC client install >> *"
write-host "*                                       *"
write-host "-----------------------------------------" 
write-host ""
Start-Sleep 2

# Activation de l'exécution de scripts sur l'ordinateur
message "Activation de l'éxécution de scripts"
$auth = get-executionpolicy

#si = restricted, allsigned, remotesigned alors configurer l'autorisation
#si = Unrestricted ne rien faire c'est ok
if ($auth -eq "Unrestricted") {
  Write-Host "Authorisation acceptée"
}
else {
  Write-Host "Modification de l'authorisation à Unrestricted"
  set-executionpolicy -executionpolicy unrestricted -Force
}

message "Téléchargement du client Windows pour BackupPC"
Invoke-WebRequest -Uri https://www.logicbox.fr/download/DesktopClient_LogicBackup_1.0.0.1_installer.exe -OutFile "C:\"

# "/S" pour une installation non graphique
message "Installation du client"
Start-Process 'C:\DesktopClient_LogicBackup_1.0.0.1_installer.exe' "/S"

# Configuration du firewall de Windows
message "Ouverture dur port TCP 873 en trafic entrant"
new-netfirewallrule -name "LogicBackup" -displayname "LogicBackup port 873" -profile domain,public,private -enabled true -protocol TCP -localport 873 -Action allow

# Informations sur le poste client
message "Récupération des informations utiles concernant le poste client"
get-wmiobject Win32_computersystem >> poste_$env:userdomain.txt

message "Nom Netbios"
$env:userdomain >> poste_$env:userdomain.txt

message "Configuration Réseau"
Get-NetIPConfiguration >> poste_$env:userdomain.txt