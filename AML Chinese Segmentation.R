
install.packages("src/jiebaRD_0.1.zip", lib = ".", repos = NULL, verbose = TRUE)
install.packages("src/jiebaR_0.4.zip", lib = ".", repos = NULL, verbose = TRUE)
library(jiebaRD, lib.loc=".", verbose=TRUE)
library(jiebaR, lib.loc=".", verbose=TRUE)


inputDF = maml.mapInputPort(1) 


#inputDF = data.frame("江州市长江大桥参加了长江大桥的通车仪式")
words = inputDF[1,1]
#class(words)
#words
Encoding(words)  <- "UTF-8" #work around AML internal encoding problem with UTF - this is the tricky part
objSeg = worker()
wordOut<-segment(words,objSeg )#objSeg <= words
plot(length(wordOut))
wordOutString <- paste(wordOut, collapse=" ")
outputDF<- data.frame(wordOutString,stringsAsFactors=F)
#outputDF[1,1]
maml.mapOutputPort('outputDF')
