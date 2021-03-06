setwd("C:/Users/Anne-Sarah/Desktop/stage/mangosim/src/vplants/mangosim/shoot_growth")

#### Relations allom�triques :
#             - Base allometries :
#                             - Feuilles : longueur / surface
#                             - Feuilles : largeur / surface
#                             - Feuilles : longueur / largeur
#             - Base MA05 :
#                             - UCs : diam�tre / longueur
#                             - UCs : diam�tre / nombre de feuilles

# Ce script nous sert � d�terminer de nombreuses relations allom�triques n�cessaires � la simulation des organes du manguiers
# Il permet notamment de d�duire la longueur d'une feuille de sa surface, ce qui nous est n�cessaire pour la mod�lisation
# Section 4.3 "Donn�es relatives � la morphologie des UCs" du rapport

# On charge les donn�es de la base allom�trie
base=read.table("data/size_data/base_allometriesR.csv",header=TRUE,sep=";",dec=",")

# On ne garde que Cogshall, car c'est la vari�t� � laquelle on s'int�resse
basecog=base[base$variete=="cogshall",]
attach(basecog)
surface=aire


##############################################
#### Relations allom�triques sur les feuilles
##########

#### surface / longueur 
fit_long=lsfit(sqrt(surface),longueur)
#Intercept         X 
#0.1748717 2.3288180 

summary(lm(longueur ~ sqrt(surface)))   # L'intercepte n'est pas significatif, R2=0.98
summary(lm(longueur~-1+sqrt(surface)))  # R2=0.99

# On trace la longueur en fonction de la surface et de la racine de la surface
par(mfrow=c(1,2))
plot(surface,longueur,main="Longueur fonction de la surface")
plot(sqrt(surface),longueur,main="Longueur fonction de sqrt(surface)")
abline(fit_long,col=2)


#### surface / largeur


fit_larg=lsfit(sqrt(surface),largeur)
# Intercept          X 
#0.06559624 0.56410552

summary(lm(sqrt(surface)~largeur))      # L'intercepte n'est pas significatif, R2=0.97
summary(lm(sqrt(surface)~largeur-1))    # R2=0.99

# On trace la largeur en fonction de la surface et de la racine de la surface
plot(surface,largeur,main="Largeur fonction de l'surface")
plot(sqrt(surface),largeur,main="Longueur fonction de sqrt(surface)")


#### Longueur / Largeur 

fitlong_larg=lsfit(longueur,largeur)
# Intercept          X 
#0.1080185 0.2349332 
cor.test(longueur,largeur)

summary(lm(largeur~longueur))            # L'intercepte n'est pas significatif, R2=0.93
summary(lm(largeur~-1+longueur))         # R2=0.99

# On trace la largeur en fonction de la longueur
plot(longueur,largeur)   
points(longueur,longueur*0.24,col=2,type='l')
#plot(largeur - (0.11+longueur*0.24),col=2 )



#########################################
#### Relation sur le diam�tre des UCs
##########

# On d�croche les donn�es de la base allometries et on charge celles de la base MA05
detach(basecog)
MA=read.table("data/size_data/MA05.csv",header=TRUE,sep=";",dec=",")
attach(MA)

####  diam�tre / longueur  

fitdiam_longUC=lsfit(MA$Long,diametre)
# Intercept          X 
# 2.911564  0.182806 
cor.test(diametre,MA$Long)

summary(lm(diametre~MA$Long))

# On trace le diam�tre en fonction de la longueur de l'UC
plot(MA$Long,diametre,main="Diam�tre fonction de la longueur")
abline(lsfit(MA$Long,diametre),col=2)
hist(diametre/(2*pi))


# Diff�renciation apicale / lat�rale
plot(MA[position=="A",]$Long,MA[position=="A",]$diametre,main="Diam�tre fonction de la longueur")
abline(lsfit(MA[position=="A",]$Long,MA[position=="A",]$diametre),col=2)
hist(MA[position=="A",]$diametre/(2*pi))
summary(lm(MA[position=="A",]$diametre~MA[position=="A",]$Long))

plot(MA[position=="L",]$Long,MA[position=="L",]$diametre,main="Diam�tre fonction de la longueur")
abline(lsfit(MA[position=="L",]$Long,MA[position=="L",]$diametre),col=2)
hist(MA[position=="L",]$diametre/(2*pi))
summary(lm(MA[position=="L",]$diametre~MA[position=="L",]$Long))

# Diam�tre en fonction de la longueur de l'UC pour les UCs en position apicale et lat�rale
par(mfrow=c(1,2))
plot(MA[position=="A",]$Long,MA[position=="A",]$diametre,main="UCs en position apicale",xlim=c(0,30),ylim=c(2,10),xlab="Longueur ",ylab="Diam�tre")
abline(lsfit(MA[position=="A",]$Long,MA[position=="A",]$diametre),col=2)
plot(MA[position=="L",]$Long,MA[position=="L",]$diametre,main="UCs en position lat�rale",xlim=c(0,30),ylim=c(2,10),xlab="Longueur ",ylab="Diam�tre")
abline(lsfit(MA[position=="L",]$Long,MA[position=="L",]$diametre),col=2)
#title("Diam�tre fonction de la longueur ",outer=TRUE,line=-1)

summary(MA[position=="A",]$diametre/2)
summary(MA[position=="L",]$diametre/2)

#Analyse de covariance
summary(lm(MA$diametre ~ position*MA$Long))
summary(lm(MA$diametre ~ position*MA$Long-1))



######## Diam�tre / nombre de feuilles 
plot(MA$NbFeu,MA$diametre)
lm.diam_nbfeu=lm(MA$diametre~MA$NbFeu)
summary(lm.diam_nbfeu)

# UCs en position apicale
plot(MA[position=="A",]$NbFeu,MA[position=="A",]$diametre)
lm.diam_nbfeu=lm(MA[position=="A",]$diametre~MA[position=="A",]$NbFeu)
summary(lm.diam_nbfeu)


# UCs en position lat�rale
plot(MA[position=="L",]$NbFeu,MA[position=="L",]$diametre)
lm.diam_nbfeu=lm(MA[position=="L",]$diametre~MA[position=="L",]$NbFeu)
summary(lm.diam_nbfeu)









