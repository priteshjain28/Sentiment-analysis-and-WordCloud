##### Sentiment Analysis #####

#Install the required packages
install.packages("syuzhet")
install.packages("lubridate")
install.packages("ggplot2")
install.packages("scales")
install.packages("reshape2")
install.packages("dplyr")
install.packages("tm")
install.packages("SnowballC")
install.packages("topicmodels")
install.packages("data.table")
install.packages("qdap")
install.packages("gridExtra")
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)
library(tm)
library(devtools)
library(tm)
library(wordcloud)
library(NLP)
library(RColorBrewer)
library(SnowballC)
library(topicmodels)
library(data.table)
library(stringi)
library(syuzhet)
library(qdap)
library(dplyr)
library(plyr)
library(gridExtra)

#Read File
tweets <- read.csv(file.choose(), header=T)
head(tweets)

# Create document corpus with desciption variable
tweetsCorpus<- Corpus(VectorSource(tweets$SentimentText))

inspect(tweetsCorpus[10])

#convert corpus to Lowercase  
tweetsCorpus <- tm_map(tweetsCorpus, content_transformer(stri_trans_tolower))

#Remove special characters and space  
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)   
tweetsCorpus <- tm_map(tweetsCorpus, content_transformer(removeNumPunct))

#Remove stopwords
tweetsCorpus <- tm_map(tweetsCorpus, removeWords,stopwords("english"))

#Remove whitespace
tweetsCorpus <- tm_map(tweetsCorpus ,stripWhitespace)

#Remove single words
removeSingle <- function(x) gsub(" . ", " ", x)   
tweetsCorpus <- tm_map(tweetsCorpus, content_transformer(removeSingle))

#Stem words in the corpus 
tweetsCorpus<-tm_map(tweetsCorpus, stemDocument)

#Obtain Sentiment Scores
sentimentscores <- get_nrc_sentiment(tweetsCorpus$content)

head(sentimentscores)

#Barplot
barplot(colSums(sentimentscores), las = 2, 
        col = rainbow(10), ylab = 'Count', 
        main = 'Barplot of Sentiments')
