# prep-env-test-edk2
preparation de l'environnement de test pour projets edk2 pour ubuntu 20.04

setup.sh va créer une partie de l'environement de développement.
il va installer codium et 2 scripts dans ~/bin:
* efitest.sh qui va démarer une vm kvm pour pouvoir tester une application efi
* prepare_edk2_project_files.sh qui va configurer codium, 
il ajoutera 3 tâches: 
* une "efitest" pour lancer l'emulateur kvm depuis l'ide (le répertoire ~/wrk/test sera vu comme un disque dur dans la vm)
* une "copy_efi_file_to_test.sh" qui va copier les applications efi générées avec le framework edk2 vers le repertoire ~/wrk/test pour le test
* une tâche "build" qui build
