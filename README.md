Automatisation de la configuration de BackupPC
==============================================
*./InstallConfigBackupPC:*

Objectif
--------
Création d’un script qui installe le client BackupPC sur un poste Windows et d’un autre script qui automatise la configuration du serveur BackupPC par rapport au poste client.

Le besoin
---------
##### Au niveau client
* Le script doit être en bat ou Powershell.
* Installation automatique du client BackupPC.
* Script compatible avec Windows 7, 8 et 10.
* Affichage à la fin de la procédure d’un fichier d'information pour faciliter la configuration du serveur.
* Affichage du nom netbios du poste.
* Configuration automatique des règles de pare-feu Windows.

Procédure niveau client
------------------------
1. Activation de l'exécution de scripts sur le poste client:
```powershell
set-executionpolicy -executionpolicy unrestricted -Force
```

Procédure niveau serveur
------------------------
1. 

Reste à faire
-------------
* Ouverture automatique du navigateur sur la page web de configuration de BackupPC pour finaliser la configuration si besoin.
