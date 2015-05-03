## Environment setup
# Load packages.
packages <- c("gdata", "ggplot2")
packages <- lapply(packages, FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
        install.packages(x)
        library(x, character.only = TRUE)
    }
})

# Set working directory
workingdir<-paste("C:\\Users", Sys.getenv("USERNAME"), "Documents\\GitHub\\YACensusData", sep = "\\")
setwd(workingdir)

## Load and organize data
# Here's how you read files from inside zip files without having to save the unzipped values
listofzipfiles <- list.files(pattern=".zip")
patternfilestoread <- ".csv"
pb<-txtProgressBar(1, length(listofzipfiles), style=3)
pbi<-0
for (i in listofzipfiles) {
    pbi<-pbi+1
    setTxtProgressBar(pb, pbi)
    zipdir <- tempfile()
    dir.create(zipdir)
    unzip(i, exdir = zipdir)
    b<-strsplit(i, "\\.")
    b<-b[[1]][1]
    k<-0
    for (j in list.files(path = zipdir, pattern=patternfilestoread)){
        k<-k+1
        filestr = paste(b,j, sep="_")
        assign(filestr,read.csv(paste(zipdir,j, sep="\\")))
    }
}

# now, combine all like files - uses gdata to create source columns
YA_County_data<-combine(YA_County_CSV_YA_1980_050.csv, YA_County_CSV_YA_1990_050.csv, YA_County_CSV_YA_2000_050.csv, YA_County_CSV_YA_2009_2013_050.csv)
YA_Metro_data<-combine(YA_Metro_CSV_YA_1980_310.csv, YA_Metro_CSV_YA_1990_310.csv, YA_Metro_CSV_YA_2000_310.csv, YA_Metro_CSV_YA_2009_2013_310.csv)
YA_State_data<-combine(YA_State_CSV_YA_1980_040.csv, YA_State_CSV_YA_1990_040.csv, YA_State_CSV_YA_2000_040.csv, YA_State_CSV_YA_2009_2013_040.csv)
YA_Tract_data<-combine(YA_Tract_CSV_YA_1980_140.csv, YA_Tract_CSV_YA_1990_140.csv, YA_Tract_CSV_YA_2000_140.csv, YA_Tract_CSV_YA_2009_2013_140.csv)
YA_US_data<-combine(YA_US_CSV_YA_1980_010.csv, YA_US_CSV_YA_1990_010.csv, YA_US_CSV_YA_2000_010.csv, YA_US_CSV_YA_2009_2013_010.csv)


dt = YA_US_data
qplot(source, liveWithParent_p, data = dt)

dt = YA_Metro_data
qplot(source, liveWithParent_p, data = dt)

dt = YA_State_data
qplot(source, liveWithParent_p, data = dt)

dt = YA_County_data
qplot(source, liveWithParent_p, data = dt)

