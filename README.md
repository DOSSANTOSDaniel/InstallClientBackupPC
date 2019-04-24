# InstallConfigBackupPC
Plusieurs cripts permettant la configuration d'un client Windows, MacOSX ou GNU/Linux et d'un serveur sous GNU/Linux

Automatisation de la mise en place de BackupPC

Objectif
Création d’un script qui installe le client BackupPC sur un poste Windows et d’un autre script qui automatise la configuration du serveur BackupPC.
Le besoin
Le script doit être en bat et Powershell.
Le script doit être exécutable avec tous les droits.
Installation automatique du client BackupPC.
Script compatible avec toutes les versions de Windows.
Configuration automatique du client BackupPC.
Affichage à la fin de la procédure d’un fichier de logs.
Affichage du nom netbios du poste.
Configuration automatique des règles de pare-feu Windows.
Ouverture automatique du navigateur sur la page web de configuration de BackupPC pour finaliser la configuration si besoin.

Faisabilité et solutions

Action
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
