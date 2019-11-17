Automatisation de la configuration de BackupPC
==============================================
*./InstallConfigBackupPC:*

Objectif
--------
Création d’un script qui installe le client BackupPC sur un poste Windows.

Le besoin
---------
#### Au niveau client
* Le script doit être en bat ou Powershell.
* Installation automatique du client BackupPC.
* Script compatible avec Windows 7, 8 et 10.
* Affichage à la fin de la procédure d’un fichier d'information pour faciliter la configuration du serveur.
* Affichage du nom netbios du poste.
* Configuration automatique des règles de pare-feu Windows.

Procédure niveau client
------------------------
1. Coller le script dans:
```powershell
C:\WINDOWS\system32
```
2. Executer Powershell en tant qu'administrateur.
3. Activation de l'autorisation d'exécuter des scripts sur le poste client:
```powershell
set-executionpolicy -executionpolicy unrestricted -Force
```
4. Executer le script:
```powershell
.\InstallConfigClientWin.ps1
```
5. Copier et coller le fichier d'information client dans une clé USB.
6. Restreindre l'autorisation d'exécuter des scripts sur le poste client:
```powershell
set-executionpolicy -executionpolicy restricted -Force
```
Reste à faire
-------------
#### Au niveau client
* Ouverture automatique du navigateur sur la page web de configuration de BackupPC pour finaliser la configuration si besoin.
* Faire un test si le fichier Atout existe ou pas.
* Faire un test si la règle de firewall existe déjà.
