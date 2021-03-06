# Validation de l'effet de la temp�rature sur la croissance d'une pousse
# Ici nous avons cherch� � tester les effets de la temp�rature sur notre mod�le
# que �a soit en faisant co�tre 2 UCs similaires � des temp�ratures tr�s diff�rentes
# ou bien en faisant cro�tre plusieurs UCs selon une gaussienne pour voir les effets de la variation de temp�rature
# Section 5.2 "Croissance d'une UC et d'une inflorescence" et 7.1 "Probl�mes ouverts" du rapport


setwd("C:/Users/Anne-Sarah/Desktop/stage/mangosim/src/vplants/mangosim/shoot_growth/data/simulation_results/temperature_effects")

# Fonction de mise en forme des donn�es issues de la simulation
MEF=function(fichier){
data=read.csv(fichier,header=TRUE,sep=",",dec=".")
# Mise en forme des donn�es issues de la simulation
data$Date=strptime(as.character(data$Date), "%Y-%m-%d %H:%M")
data$CodeUC=as.character(data$CodeUC)
return( data)
}

# Fonction permettant l'affichage de la courbe de croisance d'une UC avec une couleur diff�rente pour chaque stade ph�no
affich_pheno=function(UCsim){
	points(UCsim$Date,UCsim$Length,type='l',col=2,lwd=2)
	points(UCsim$Date[UCsim$Pheno_stage>0],UCsim$Length[UCsim$Pheno_stage>0],type='l',col=3,lwd=2)
	points(UCsim$Date[UCsim$Pheno_stage>1],UCsim$Length[UCsim$Pheno_stage>1],type='l',col=4,lwd=2)
	points(UCsim$Date[UCsim$Pheno_stage>2],UCsim$Length[UCsim$Pheno_stage>2],type='l',col=5,lwd=2)
	points(UCsim$Date[UCsim$Pheno_stage>3],UCsim$Length[UCsim$Pheno_stage>3],type='l',col=6,lwd=2)
}

#####################################
# UCs v�g�tatives
######


###### R�cup�ration des donn�es simul�es
UC20=MEF("croissUC_20.csv")
UC30=MEF("croissUC_30.csv")
UC30to20=MEF("croissUC_30to20.csv")
UC20to30=MEF("croissUC_20to30.csv")


###### Repr�sentation des courbes de croissance (avec stades ph�nos)
# comparaison de la croissance � 20�C et 30�C
plot(UC20$Date,UC20$Length,type='l',xlab="Date",ylab="Longueur",cex.lab = 1.5, cex.axis = 1.2) 
affich_pheno(UC20)
affich_pheno(UC30)
points(c(UC30$Date[UC30$Pheno_stage==4],UC20$Date[UC20$Date==max(UC20$Date)]),rep(max(UC20$Length),2), col = 6, type='l', lwd = 4)
legend("bottomright",cex=1.2,title="stades ph�nologiques",c("D","E","F","G","H"),col=c(2,3,4,5,6),lty=1,lwd=4)


# changement de la temp�rature en cours de croissance : 20�C -> 30 �C
plot(UC20$Date,UC20$Length,type='l',xlab="Date",ylab="Longueur",cex.lab = 1.5, cex.axis = 1.2)
affich_pheno(UC20to30)
points(c(UC30$Date[UC30$Pheno_stage==4],UC20$Date[UC20$Date==max(UC20$Date)]),rep(max(UC20$Length),2), col = 6, type='l', lwd = 4)
legend("bottomright",cex=1.2,title="stades ph�nologiques",c("D","E","F","G","H"),col=c(2,3,4,5,6),lty=1,lwd=4)

# changement de la temp�rature en cours de croissance : 30�C -> 20 �C
plot(UC30$Date,UC30$Length,type='l',xlab="Date",ylab="Longueur",cex.lab = 1.5, cex.axis = 1.2)
affich_pheno(UC30to20)
points(c(UC30$Date[UC30$Pheno_stage==4],UC20$Date[UC20$Date==max(UC20$Date)]),rep(max(UC20$Length),2), col = 6, type='l', lwd = 4)
legend("bottomright",cex=1.2,title="stades ph�nologiques",c("D","E","F","G","H"),col=c(2,3,4,5,6),lty=1,lwd=4)


#####################################
# Inflorescences
######


###### R�cup�ration des donn�es simul�es
Inflo20=MEF("croissInflo_20.csv")
Inflo30=MEF("croissInflo_30.csv")
Inflo30to20=MEF("croissInflo_30to20.csv")
Inflo20to30=MEF("croissInflo_20to30.csv")


###### Repr�sentation des courbes de croissance (avec stades ph�nos)
# comparaison de la croissance � 20�C et 30�C
plot(Inflo20$Date,Inflo20$Length,type='l',xlab="Date",ylab="Longueur",cex.lab = 1.5, cex.axis = 1.2) 
affich_pheno(Inflo20)
affich_pheno(Inflo30)
legend("bottomright",cex=1.2,title="stades ph�nologiques",c("D","E","F","G"),col=c(2,3,4,5,6),lty=1,lwd=4)

# changement de la temp�rature en cours de croissance : 20�C -> 30 �C
plot(Inflo20$Date,Inflo20$Length,type='l',xlab="Date",ylab="Longueur",cex.lab = 1.5, cex.axis = 1.2)
affich_pheno(Inflo20to30)
legend("bottomright",cex=1.2,title="stades ph�nologiques",c("D","E","F","G"),col=c(2,3,4,5,6),lty=1,lwd=4)


# changement de la temp�rature en cours de croissance : 30�C -> 20 �C
plot(Inflo30$Date,Inflo30$Length,type='l',xlab="Date",ylab="Longueur",cex.lab = 1.5, cex.axis = 1.2)
affich_pheno(Inflo30to20)
legend("bottomright",cex=1.2,title="stades ph�nologiques",c("D","E","F","G"),col=c(2,3,4,5,6),lty=1,lwd=4)





#####################################
# Etude variations temp�rature 
######


###### R�cup�ration des donn�es simul�es
UC1=MEF("croissUC_test1.csv")
UC2=MEF("croissUC_test2.csv")
UC3=MEF("croissUC_test3.csv")
UC4=MEF("croissUC_test4.csv")

UC11=MEF("croissUC_test11.csv")
UC21=MEF("croissUC_test21.csv")
UC31=MEF("croissUC_test31.csv")
UC41=MEF("croissUC_test41.csv")

Inflo1=MEF("croissInflo_test1.csv")
Inflo2=MEF("croissInflo_test2.csv")
Inflo3=MEF("croissInflo_test3.csv")
Inflo4=MEF("croissInflo_test4.csv")

Inflo11=MEF("croissInflo_test11.csv")
Inflo21=MEF("croissInflo_test21.csv")
Inflo31=MEF("croissInflo_test31.csv")
Inflo41=MEF("croissInflo_test41.csv")

# On trace les diff�rentes courbes supperpos�es
#UCs
plot(UC1$Date,UC1$Length,type='l',xlab="Date",ylab="Longueur",cex.lab = 1.5, cex.axis = 1.2) 
affich_pheno(UC1)
affich_pheno(UC2)
affich_pheno(UC3)
affich_pheno(UC4)
legend("bottomright","Temp�rature ~ N(22,4)",cex=1.5)
#legend("bottomright",cex=1.2,title="stades ph�nologiques",c("D","E","F","G","H"),col=c(2,3,4,5,6),lty=1,lwd=4)

plot(UC11$Date,UC11$Length,type='l',xlab="Date",ylab="Longueur",cex.lab = 1.5, cex.axis = 1.2) 
affich_pheno(UC11)
affich_pheno(UC21)
affich_pheno(UC31)
affich_pheno(UC41)
legend("bottomright","Temp�rature ~ N(22,1)",cex=1.5)
#legend("bottomright",cex=1.2,title="stades ph�nologiques",c("D","E","F","G","H"),col=c(2,3,4,5,6),lty=1,lwd=4)


# Inflorescences
plot(Inflo1$Date,Inflo1$Length,type='l',xlab="Date",ylab="Longueur",cex.lab = 1.5, cex.axis = 1.2) 
affich_pheno(Inflo1)
affich_pheno(Inflo2)
affich_pheno(Inflo3)
affich_pheno(Inflo4)
legend("bottomright","Temp�rature ~ N(22,4)",cex=1.5)
#legend("bottomright",cex=1.2,title="stades ph�nologiques",c("D","E","F","G"),col=c(2,3,4,5),lty=1,lwd=4)

plot(Inflo11$Date,Inflo11$Length,type='l',xlab="Date",ylab="Longueur",cex.lab = 1.5, cex.axis = 1.2) 
affich_pheno(Inflo11)
affich_pheno(Inflo21)
affich_pheno(Inflo31)
affich_pheno(Inflo41)
legend("bottomright","Temp�rature ~ N(22,1)",cex=1.5)
#legend("bottomright",cex=1.2,title="stades ph�nologiques",c("D","E","F","G"),col=c(2,3,4,5),lty=1,lwd=4)
