<#      
NOM DU SCRIPT: script_admin.ps1			
*================================================================*
DESCRIPTION:

 Le script va nous permettre de ::

 1 :Afficher le répertoire courant
 2 :Lister les fichiers du répertoire courant
 3 :Afficher les informations consernant un fichier
 4 :Changer de répertoire
 5 :Afficher les n premiéres lignes d'un fichiers donnée		
*================================================================*
AUTEUR: Daniel DOS SANTOS < daniel.massy91@gmail.com >			
*================================================================*
DATE DE CREATION: 02/03/2018	
*================================================================*
VERSION INITIALE: V.1.0
*================================================================*   
USAGE: PS C:\Users> powershell ./script_admin.ps1		
*================================================================*
NOTES: 

L'utilisateur doit valider par le touche entrée se qui lui
permet d'avoir le temps de visualiser le résultat pour note ou ..     
*================================================================*
POWERSHELL VERSION: 5.1  
*================================================================*
VERSIONS:

09/03/218 --->  
*================================================================*
    RESTE A FAIRE
    ----------------

    1* vérifier l'orthographe
    2* ajouter des commentaires partout
    3* améliorer l'indentation
    4* faire vérifier le script par un debuguer
    5* write-host ne pas permettre d'écrire juste de taper entrée
    6* faire des fonctions pour la partie [veuillez appuyer sur entrée]
    7* mettre en place un controle de caractères
    8* mettre en place [1] ou [un] ou [I].....
    9* faire un manuel d'utilisation
    10* possibilité de script non intéractif ( cmd -a xxx -b xxx -c xxx )
	11* ne pas permetre les champ vides
	12* refaire les indentations
	13* afficher la version courante du script dans le script
#>

### Variables globales   ###
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
	return write-hos $ban
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
