library(pixmap)

#
#	LECTURE DES IMAGES
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
