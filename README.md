Automatisation de l'installation de l'agent BackupPC
==============================================
*./InstallConfigBackupPC:*

Objectif
--------
Création d’un script qui installe le client BackupPC sur un poste Windows.

Le besoin
---------
#### Au niveau client
* Installation automatique du client BackupPC.
* Script compatible avec Windows 7, 8 et 10.
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
5. Restreindre l'autorisation d'exécuter des scripts sur le poste client:
```powershell
set-executionpolicy -executionpolicy restricted -Force
```
Reste à faire
-------------
#### Au niveau client
* Ouverture automatique du navigateur sur la page web de configuration de BackupPC pour finaliser la configuration si besoin.
* Faire un test si la règle de firewall existe déjà.
