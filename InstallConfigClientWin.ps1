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

### Début du script ###

# Activation de l'exécution de scripts sur l'ordinateur
$auth = get-executionpolicy
#si = restricted, allsigned, remotesigned alors configurer l'autorisation
set-executionpolicy -executionpolicy unrestricted -Force
#si = Unrestricted ne rien faire c'est ok

# Téléchargement du client Windows pour BackupPC
Invoke-WebRequest -Uri https://www.logicbox.fr/download/DesktopClient_LogicBackup_1.0.0.1_installer.exe -OutFile C:"\"

Set-Location C:\

# Installation du client
# "/S" pour une installation non graphique
Start-Process 'C:\DesktopClient_LogicBackup_1.0.0.1_installer.exe' "/S"

# Configuration du firewall de Windows
# Ouverture dur port TCP 873 en trafic entrant
new-netfirewallrule -name "LogicBackup" -displayname "LogicBackup port 873" -profile domain,public,private -enabled true -protocol TCP -localport 873 -Action allow

# Récupération des informations utiles concernant le poste
# Informations générales
get-wmiobject Win32_computersystem

# Nom Netbios
$env:userdomain

# Configuration Réseau
Get-NetIPConfiguration

##############################################################################################################################
### AIDE MEMOIRE  ###
############################
$fin = 0

####   fonctions    ###
############################################
function appuyez
{
	Write-Host "`n°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°" -f Cyan
    write-Host "[Veuillez appuyer sur entrée pour poursuivre]`n"
    Read-Host
}

function erreur
{
	Write-Host "##########################" -f Red -b black
    Write-Host "##   Erreur de syntax   ##" -f Red -b black
    Write-Host "## Veuillez recommencer ##" -f Red -b black
    Write-Host "##########################" -f Red -b black
    sleep 3
}

function power
{
	clear-host
	$ban = @"
	______                          _          _ _ 
	| ___ \                        | |        | | |
	| |_/ /____      _____ _ __ ___| |__   ___| | |
	|  __/ _ \ \ /\ / / _ \ '__/ __| '_ \ / _ \ | |
	| | | (_) \ V  V /  __/ |  \__ \ | | |  __/ | |
	\_|  \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_|
												   
	"@
	return write-host $ban
}

function menu
{
	clear-host
	write-host "`nVeillez choisir une option:"
	write-host ""
	write-host "####################################" -f 'green'
	write-host "                                    " -b 'black'
	write-host "[1] Affichage répertoire courant    " -f 'gray' -b 'black'
	write-host "[2] Liste des fichiers du répertoire" -f 'gray' -b 'black'
	write-host "[3] Information sur un fichier      " -f 'gray' -b 'black'
	write-host "[4] Changement de répertoire        " -f 'gray' -b 'black'
	write-host "[5] n premières lignes d'un fichier " -f 'gray' -b 'black'
	write-host "[0] Fin                             " -f 'Magenta' -b 'black'
	write-host "                                    " -b 'black'
	write-host "####################################" -f 'green'
	write-host ""

	$choix = read-host "votre choix "

	write-host ""
}

### message d'accueil  ###
power	
write-host ""
write-host "-----------------------------------------"
write-host "*                                       *"
write-host "*             BIENVENUE                 *"
write-host "*                                       *"
write-host "* SCRIPT << DECOUVERTE DE POWERSHELL >> *"
write-host "*                                       *"
write-host "-----------------------------------------" 
write-host ""
sleep 3

### boucle
while ($fin -ne 1)
{
menu
switch ($choix)
{  
    1 { 
        #get-location
        (Get-Location).path
        appuyez
      }

    2 { 
        Get-ChildItem
        appuyez
      }

    3 { 
        write-host ""
        Write-Host "Choisissez votre fichier" -f Green
        write-host ""
        $fichier = read-host "Chemin complait " 
        get-itemproperty $fichier | format-list
        write-host ""
        appuyez
      }

    4 { 
        write-host ""
        Write-Host "Choisissez votre répertoire" -f Green
        write-host ""
        $dossier = read-host "Chemin complait "
        Set-Location $dossier
        appuyez
      }

    5 { 
        write-host ""
        Write-Host "Choisissez votre fichier" -f Green
        write-host ""
        $nfic = read-host "Chemin complait "
        write-host ""
        Write-Host "Premières lignes a afficher" -f Green
        write-host ""
        $nligne = read-host "Combient de lignes "
        Write-Host ""
        Get-Content $nfic -TotalCount $nligne
        appuyez
      }

    0 { 
		power
        Write-Host "######################" -f gray -b black
        Write-Host "##  " -f Gray -b Black -NoNewline;
        write-host "Fin du script" -f Red -b Black -NoNewline;
        write-host "   ##" -f gray -b black
        Write-Host "######################" -f gray -b black
        $fin = 1
      }

default
      { 
        erreur
      }
}
}


