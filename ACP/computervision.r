library(pixmap)
library(FactoMineR)

#
#	LECTURE DES IMAGES
#
#	les images considérées sont celles du dossier 'att_referenceFaceData'
#
# chaque image (112x92) est représentée sur une matrice ligne (1x10304)
# l'ensemble des 10 images est concaténé dans la matrice IMG (10x10304)
#

IMG <- matrix()
for (i in 101:110){
	img <- read.pnm(paste("att_referenceFaceData/",".pgm",sep=toString(i)),cellres=1)@grey[0:112,0:92]

	if(i == 101){
		IMG = matrix(img, nrow=1, byrow=TRUE)
	}
	else{
		IMG <- rbind(IMG, matrix(img, nrow=1, byrow=TRUE))
	}
}
for (i in 111:115){
	img <- read.pnm(paste("att_testFaceData/",".pgm",sep=toString(i)),cellres=1)@grey[0:112,0:92]
		IMG <- rbind(IMG, matrix(img, nrow=1, byrow=TRUE))
}


#
#	ACP
#

result<-PCA(IMG,scale.unit=TRUE, graph = FALSE, ind.sup=c(11:15))

#
#	Choix des axes factorielles
#

eigenvalues <- result$eig

## Graphe des éboulies
barplot(eigenvalues[, 2], names.arg=1:nrow(eigenvalues),
       main = "Variances",
       xlab = "Principal Components",
       ylab = "Percentage of variances",
       col ="steelblue")
lines(x = 1:nrow(eigenvalues), eigenvalues[, 2],
      type="b", pch=19, col = "red")

## Moyenne des inerties
mean(eigenvalues[,1])

## On choisit les 4 premiers axes, car avec les critéres du coude et de Kaisier on
# obtient le même résultat.
# l'inertie cumuluée est de 74,64%
U <- result$var$coord
test <- read.pnm(paste("att_testFaceData/111.pgm"),cellres=1)@grey[0:112,0:92]
test <- matrix(test, nrow=1, byrow=TRUE)
test %*% U
