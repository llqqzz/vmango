modpopulation <- function(x){
#fonction qui calcule la log-vraisemblance d'une population de fleurs
#avec le mod�le de floraison en fonction des 2 param�tres x[1]=seuil
#et x[2]=param�tre de variance de la floraison.

	data <- croisUC
	z <- -1 * sum(data$nbUC*log(pnorm((data$dateTh - x[1])/(x[2]*sqrt(data$dateTh ))) - pnorm((data$dateThMin1 - x[1])/(x[2]*sqrt(data$dateThMin1)))))
#	print(z)
	return(z)
}