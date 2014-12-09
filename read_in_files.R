
workingdir<-paste("C:\\Users", Sys.getenv("USERNAME"), "Documents\\GitHub\\YACensusData", sep = "\\")
setwd(workingdir)

listofzipfiles <- list.files(pattern=".zip")

for (i in listofzipfiles) {
    zipdir <- tempfile()
    dir.create(zipdir)
    unzip(i, exdir = zipdir)
    b<-strsplit(i, "\\.")
    b<-b[[1]][1]
    k<-0
    for (j in list.files(path = zipdir, pattern=".csv")){
        k<-k+1
        filestr = paste(b, as.character(k), sep="_")
        assign(filestr,read.csv(paste(zipdir,j, sep="\\")))
    }
}