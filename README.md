# cours_ynov
TP3 :

J'ai terminé la partie du code Ansible où il faut récupérer le code HTML de notre repository et l'afficher.
Je n'ai malheuresement pas réussi à faire la partie de la création d'une lambda.
 
Pour accéder au serveur web NGINX, il faut faire un terraform apply, modifier le fichier hosts avec la nouvelle IP qui s'affiche en sortie puis faire la commande :
ansible-playbook --private-key=../tp_dev_ynov.pem -i hosts nginx_install.yml (dans le dossier Ansible).
Le fichier hosts se trouve dans le dossier Ansible, dans Terraform.

