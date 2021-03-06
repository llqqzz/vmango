# Section 4.4 "Donn�es pour les mod�les de temps thermique" du rapport
# Calcul de la temp�rature de base pour les stades ph�nologiques v�g�tatifs du manguier regroup�s par stade

setwd("D:/MesDonn�es/mes documents/manguier/mod�lisation ph�no/stage 2014/Anne-Sarah Briand/donn�es/fichiers de donn�es/temp�ratures de base (Ana�lle)/TB stades ph�no/")                # pour mon ordi

# Calcul de la temp�rature de base pour la croissance des UCs du manguier

# source("D:/Mes Donnees/These/Donn�es croissance-temperature/12-09 Manip croissance-temp�rature/Grosse manip/Resultats/Exploit/Mod�les de temps thermique/Approche deterministe/Development/Temp vs 1 sur n/creation base nTInflo dvlpt.r")           # original Ana�lle

#source("D:/MesDonn�es/mes documents/manguier/mod�lisation ph�no/stage 2014/Anne-Sarah Briand/donn�es/fichiers de donn�es/temp�ratures de base (Ana�lle)/TB stades ph�no/creation base nTInflo dvlpt2.r")       # pour mon ordi
#nTInflo[1:10,]

# chargement directement du fichier de donn�es:
nTUC <- read.csv( "base developpement veget.csv", sep=";", dec=".", header=T)
nTUC[1:10,]
summary(nTUC)


#Chargement des fonctions: 
#source("D:/Mes Donnees/These/Donn�es croissance-temperature/12-09 Manip croissance-temp�rature/Grosse manip/Resultats/Exploit/Mod�les de temps thermique/Approche deterministe/Development/Autres/fonctions/tempbasecor.r")
#source("D:/Mes Donnees/These/Donn�es croissance-temperature/12-09 Manip croissance-temp�rature/Grosse manip/Resultats/Exploit/Mod�les de temps thermique/Approche deterministe/Development/Autres/fonctions/tempbaseCVST.r")
#source("D:/Mes Donnees/These/Donn�es croissance-temperature/12-09 Manip croissance-temp�rature/Grosse manip/Resultats/Exploit/Mod�les de temps thermique/Approche deterministe/Development/Autres/fonctions/tempbasesdj.r")
#source("D:/Mes Donnees/These/Donn�es croissance-temperature/12-09 Manip croissance-temp�rature/Grosse manip/Resultats/Exploit/Mod�les de temps thermique/Approche deterministe/Development/Autres/fonctions/tempbasesdST.r")
#Les fonctions sont d�finies pour TMUC et nUC

# pour mon ordi
source("D:/MesDonn�es/mes documents/manguier/th�ses/Ana�lle/CD fin de th�se/Donn�es croissance-temperature/12-09 Manip croissance-temp�rature/Grosse manip/Resultats/Exploit/Mod�les de temps thermique/Approche deterministe/Croissance/Autres/fonctions/tempbasecor.r")
source("D:/MesDonn�es/mes documents/manguier/th�ses/Ana�lle/CD fin de th�se/Donn�es croissance-temperature/12-09 Manip croissance-temp�rature/Grosse manip/Resultats/Exploit/Mod�les de temps thermique/Approche deterministe/Croissance/Autres/fonctions/tempbaseCVST.r")
source("D:/MesDonn�es/mes documents/manguier/th�ses/Ana�lle/CD fin de th�se/Donn�es croissance-temperature/12-09 Manip croissance-temp�rature/Grosse manip/Resultats/Exploit/Mod�les de temps thermique/Approche deterministe/Croissance/Autres/fonctions/tempbasesdj.r")
source("D:/MesDonn�es/mes documents/manguier/th�ses/Ana�lle/CD fin de th�se/Donn�es croissance-temperature/12-09 Manip croissance-temp�rature/Grosse manip/Resultats/Exploit/Mod�les de temps thermique/Approche deterministe/Croissance/Autres/fonctions/tempbasesdST.r")


############ Cogshall############################################

######### Stade D
UCcog<-nTUC[nTUC$cultivar=="cog",] 
UCcog<-UCcog[!is.na(UCcog$n_D),] 
head(UCcog)
dim(UCcog)


#Ajustement  lin�aire
y<- 1/(UCcog$n_D)
x<- UCcog$T_D
plot(x,y)
sum<-summary(lm( y ~ x))
-sum[[4]][1]/sum[[4]][2]	#12.48544 �C

UCcog$nUC<-UCcog$n_D
UCcog$TMUC<-UCcog$T_D

# minimisation de l'�cart type des sommes de temp�rature
nlm(tempb.sdST, 15, dat=UCcog)            # 18.07423�C

# minimisation du coefficient de variation des sommes de temp�rature
nlm(tempb.CVST, 15, dat=UCcog)            # 12.12116 �C

# minimisation de l'�cart type des sommes de temp�rature en jours
nlm(tempb.sdj, 15, dat=UCcog)            # 12.64494�C

# minimisation du coef de corr�lation entre les sommes de temp�ratures et les temp�ratures moyennes
nlm(tempb.cor, 15, dat=UCcog)            #  12.3691 �C

#TB moy : 
(12.48544+12.12116+12.64494 +12.3691)/4			#12.40516 �C

# calcul de la somme de temp�rature moyenne pour le stade D de l'UC de Cogshall avec TB = 12.40516�C
STUCcog <- UCcog$n_D*(UCcog$T_D - 12.40516)
mean(STUCcog)                     # 41.84308 �C.j
sd(STUCcog)                       # 9.727154 �C.j




######### Stade EF

UCcog<-nTUC[nTUC$cultivar=="cog",] 
UCcog<-UCcog[!is.na(UCcog$n_E),] 
UCcog<-UCcog[!is.na(UCcog$n_F),] 
head(UCcog)
dim(UCcog)

# calcul de la dur�e totale du stade EF = E + F
UCcog$n_EF <- UCcog$n_E + UCcog$n_F

# calcul de la temp�rature moyenne pendant ce stade (� partir des temp�ratures moyennes de chaque sous-stade et de leur dur�e
UCcog$T_EF <- ((UCcog$T_E * UCcog$n_E) + (UCcog$T_F * UCcog$n_F))/ UCcog$n_EF

  
#Ajustement lin�aire
y<- 1/(UCcog$n_EF)
x<- UCcog$T_EF
plot(x,y)
sum<-summary(lm( y ~ x))
-sum[[4]][1]/sum[[4]][2]	# 13.91176�C

UCcog$nUC<-UCcog$n_EF
UCcog$TMUC<-UCcog$T_EF

# minimisation de l'�cart type des sommes de temp�rature
nlm(tempb.sdST, 10, dat=UCcog)            # 18.59694 �C

# minimisation du coefficient de variation des sommes de temp�rature
nlm(tempb.CVST, 10, dat=UCcog)            #   13.21842�C

# minimisation de l'�cart type des sommes de temp�rature en jours
nlm(tempb.sdj, 10, dat=UCcog)            #  13.53931�C

# minimisation du coef de corr�lation entre les sommes de temp�ratures et les temp�ratures moyennes
nlm(tempb.cor, 10, dat=UCcog)            #  13.64722 �C

#TB moy : 
mean(c(13.91176,13.21842,13.53931,13.64722))		#13.57918

# calcul de la somme de temp�rature moyenne pour le stade EF de l'UC de Cogshall avec TB = 13.57918�C
STUCcog <- UCcog$n_EF*(UCcog$T_EF - 13.57918)
mean(STUCcog)                     #  93.33751�C.j
sd(STUCcog)                       # 16.08143 �C.j

# calcul de la somme de temp�rature pour passer au stade F avec cette temp�rature de base
STUCcog <- UCcog$n_E*(UCcog$T_E - 13.57918)
mean(STUCcog)                     #  il faut 46.78448�C.j depuis le d�but du stade EF pour atteindre le stade F
sd(STUCcog)                       # 14.05229�C.j
 


######### Stade DEF

UCcog<-nTUC[nTUC$cultivar=="cog",] 
UCcog<-UCcog[!is.na(UCcog$n_D),] 
UCcog<-UCcog[!is.na(UCcog$n_E),] 
UCcog<-UCcog[!is.na(UCcog$n_F),] 
head(UCcog)
dim(UCcog)

# calcul de la dur�e totale du stade DEF = D + E + F
UCcog$n_DEF <- UCcog$n_D + UCcog$n_E + UCcog$n_F

# calcul de la temp�rature moyenne pendant ce stade (� partir des temp�ratures moyennes de chaque sous-stade et de leur dur�e
UCcog$T_DEF <- ((UCcog$T_D * UCcog$n_D) + (UCcog$T_E * UCcog$n_E) + (UCcog$T_F * UCcog$n_F))/ UCcog$n_DEF

 
 #Ajustement lin�aire
y<- 1/(UCcog$n_DEF)
x<- UCcog$T_DEF
plot(x,y)
sum<-summary(lm( y ~ x))
-sum[[4]][1]/sum[[4]][2]			# 13.66972�C

UCcog$nUC<-UCcog$n_DEF
UCcog$TMUC<-UCcog$T_DEF

# minimisation de l'�cart type des sommes de temp�rature
nlm(tempb.sdST, 10, dat=UCcog)            # 15.76597 �C

# minimisation du coefficient de variation des sommes de temp�rature
nlm(tempb.CVST, 10, dat=UCcog)            # 13.14455�C

# minimisation de l'�cart type des sommes de temp�rature en jours
nlm(tempb.sdj, 10, dat=UCcog)            #   13.27166�C

# minimisation du coef de corr�lation entre les sommes de temp�ratures et les temp�ratures moyennes
nlm(tempb.cor, 10, dat=UCcog)            #   13.42472�C

#TB moy : 
mean(c(13.66972, 13.14455, 13.27166, 13.42472))			# 13.37766

# calcul de la somme de temp�rature moyenne pour la dur�e des stades DEF de Cogshall avec TB =  13.37766�C
STUCcog <- UCcog$n_DEF*(UCcog$T_DEF -  13.37766)
mean(STUCcog)                     # 133.5086�C.j
sd(STUCcog)                       # 14.79044 �C.j


# calcul de la somme de temp�rature pour passer au stade D avec cette temp�rature de base

STUCcog <- UCcog$n_D*(UCcog$T_D - 13.37766)
mean(STUCcog)                     #  il faut 38.50587 �C.j depuis le d�but du stade DEF pour du stade D au stade E (soit la dur�e moyenne du stade D)
sd(STUCcog)                       # 9.009979�C.j


# calcul de la somme de temp�rature pour passer au stade F avec cette temp�rature de base
# calcul de la dur�e totale du stade DE = D + E
UCcog$n_DE <- UCcog$n_D + UCcog$n_E

# calcul de la temp�rature moyenne pendant ce stade (� partir des temp�ratures moyennes de chaque sous-stade et de leur dur�e
UCcog$T_DE <- ((UCcog$T_D * UCcog$n_D) + (UCcog$T_E * UCcog$n_E))/ UCcog$n_DE

STUCcog <- UCcog$n_DE*(UCcog$T_DE - 13.37766)
mean(STUCcog)                     #  il faut 86.11976 �C.j depuis le d�but du stade DEF pour atteindre le stade F. C'est donc la dur�e des stades D+E, et la dur�e moyenne du stade E est donc 86.11976 - 38.50587 = 47.61389 �C.j
sd(STUCcog)                       # 13.15483�C.j

# La dur�e moyenne du stade F est alors 133.5086 - 86.11976 = 47.38884 �C.f (la m�me que cette du stade E).


######### Stade G

UCcog<-nTUC[nTUC$cultivar=="cog",] 
UCcog$dataset <- paste(UCcog$verger,UCcog$saison, sep="")
ind <- which(UCcog$dataset=="BP4" & UCcog$n_G<18)
UCcog <- UCcog[-ind,]           # retrait de 12 points correspondant � la saison 4 � Bassin-Plat pour lesquels il y a des soucis de donn�es  (dur�e stade G tr�s courte (10 � 14 j)

UCcog<-UCcog[!is.na(UCcog$n_G),] 
head(UCcog)
dim(UCcog)



 #Ajustement lin�aire
y<- 1/(UCcog$n_G)
x<- UCcog$T_G
plot(x,y)
sum<-summary(lm( y ~ x))
-sum[[4]][1]/sum[[4]][2]			# 8.442356�C

UCcog$nUC<-UCcog$n_G
UCcog$TMUC<-UCcog$T_G

# minimisation de l'�cart type des sommes de temp�rature
nlm(tempb.sdST, 10, dat=UCcog)            # 17.69696 �C

# minimisation du coefficient de variation des sommes de temp�rature
nlm(tempb.CVST, 10, dat=UCcog)            # 10.42945�C

# minimisation de l'�cart type des sommes de temp�rature en jours
nlm(tempb.sdj, 10, dat=UCcog)            #   10.63864�C

# minimisation du coef de corr�lation entre les sommes de temp�ratures et les temp�ratures moyennes
nlm(tempb.cor, 10, dat=UCcog)            #   9.627277�C

#TB moy : 
mean(c(8.442356, 10.42945, 10.63864, 9.627277))			# 9.784431

# calcul de la somme de temp�rature moyenne pour le stade ph�no G de l'UC de Cogshall avec TB =  9.784431�C
STUCcog <- UCcog$n_G*(UCcog$T_G -  9.784431)
mean(STUCcog)                     # 316.376�C.j
sd(STUCcog)                       # 40.4748 �C.j






## Pour suivi de la croissance en biomasse des UCs (Nirina)
## Hyp: croissance en biomasse jusqu'� la fin du stade G (ensuite: UC mature).
## D�termination temp�rature de base et somme de temp�rature du d�bourrement � fin stage G
######### dur�e de B2 � fin G
UCcog<-nTUC[nTUC$cultivar=="cog",]
UCcog<-UCcog[!is.na(UCcog$n_B2_Fin_G),]
UCcog$dataset <- paste(UCcog$verger,UCcog$saison, sep="")
ind <- which(UCcog$dataset=="BP4" & UCcog$n_G<18)
UCcog <- UCcog[-ind,]           # retrait de 12 points correspondant � la saison 4 � Bassin-Plat pour lesquels il y a des soucis de donn�es  (dur�e stade G tr�s courte (10 � 14 j)

head(UCcog)
dim(UCcog)


#Ajustement  lin�aire
y<- 1/(UCcog$n_B2_Fin_G)
x<- UCcog$T_B2_Fin_G
plot(x,y)
sum<-summary(lm( y ~ x))
-sum[[4]][1]/sum[[4]][2]	# 11.60913�C

UCcog$nUC<-UCcog$n_B2_Fin_G
UCcog$TMUC<-UCcog$T_B2_Fin_G

# minimisation de l'�cart type des sommes de temp�rature
nlm(tempb.sdST, 15, dat=UCcog)            # 14.79773�C

# minimisation du coefficient de variation des sommes de temp�rature
nlm(tempb.CVST, 15, dat=UCcog)            # 12.15358 �C

# minimisation de l'�cart type des sommes de temp�rature en jours
nlm(tempb.sdj, 15, dat=UCcog)            # 12.22857�C

# minimisation du coef de corr�lation entre les sommes de temp�ratures et les temp�ratures moyennes
nlm(tempb.cor, 15, dat=UCcog)            #  11.90532 �C

#TB moy :
(11.60913 + 12.15358 + 12.22857 + 11.90532)/4			# 11.97415 �C

# calcul de la somme de temp�rature moyenne pour le stade D de l'UC de Cogshall avec TB = 11.97415�C
STUCcog <- UCcog$n_B2_Fin_G*(UCcog$T_B2_Fin_G - 11.97415)
mean(STUCcog)                     # 423.3913 �C.j
sd(STUCcog)                       # 34.5013 �C.j


## Avec cette temp�rature de base, somme de temp�rature pour atteindre le stade F  (fin du stade E)
STUCcog <- UCcog$n_B2_Fin_E*(UCcog$T_B2_Fin_E - 11.97415)
mean(STUCcog)                     # d�but du stade F � 99.25174 �C.j
sd(STUCcog)                       # 12.28983 �C.j

## Avec cette temp�rature de base, somme de temp�rature pour atteindre le stade G  (fin du stade F)
STUCcog <- UCcog$n_B2_Fin_F*(UCcog$T_B2_Fin_F - 11.97415)
mean(STUCcog)                     # d�but du stade G � 151.0965 �C.j
sd(STUCcog)                       # 17.56348 �C.j

#  donc milieu du stade F � (151.0965 + 99.25174)/2 = 125.1741 �C.j
# et milieu du stade G � (151.0965 + 423.3913)/2 = 287.2439 �C.j



