library(topicmodels)
library(tm)
library(NLP)
library(tidytext)
library(ggplot2)
library(dplyr)
library(cluster)
library(wordcloud)
library(slam)
cname <- file.path("~", "Desktop", "TEXT_CC")
docs<-Corpus(DirSource(cname))
dir(cname)
summary(docs)
 

docs <- tm_map(docs,content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs,content_transformer(tolower))
toSpace <- content_transformer(function(x, pattern) { return (gsub(pattern, "", x))})
docs <- tm_map(docs, toSpace, "-")
docs <- tm_map(docs, toSpace, ":")
docs <- tm_map(docs, removePunctuation)


docs <- tm_map(docs, content_transformer(gsub), pattern = "organiz", replacement = "organ")
docs <- tm_map(docs, content_transformer(gsub), pattern = "organis", replacement = "organ")
docs <- tm_map(docs, content_transformer(gsub), pattern = "andgovern", replacement = "govern")
docs <- tm_map(docs, content_transformer(gsub), pattern = "inenterpris", replacement = "enterpris")
docs <- tm_map(docs, content_transformer(gsub), pattern = "team-", replacement = "team")
docs <- tm_map(docs, content_transformer(gsub), pattern = "utiliz", replacement = "use")
myStopwords <- c("and","can", "using", "type","levels","high","system","against", "used","new","data","applications","results","reference","people","patients","clinical","systems", "realtime","based","two","products","detection","time", "technology","detection","vol","days","health","performance","say", "one","way", "use", "is", "are", "patent", "research", "also","howev","tell","will",
                 "much","need", "take", "tend", "even", "like", "particular", "rather", "said", "get", "well", "make", "ask","come","end","function", "study", "research", "method", "function",

                 "get", "well", "make", "ask","come","end","function", "study", "research", "method", "function"
                 
                 )
docs <- tm_map(docs, removeWords, myStopwords)

docs <- tm_map(docs, stripWhitespace)
dtm <- DocumentTermMatrix(docs)
inspect(dtm)

tdm <- TermDocumentMatrix(docs)

inspect(tdm)
#doc.length = colSums( as.matrix(tdm) > 0 )[!empty.docs]


freq <- colSums(as.matrix(dtm))
length(freq)
ord <- order(freq)
m <- as.matrix(dtm)
dim(m)
write.csv(m,file="dtm.csv")
#-------------------------------
 dtms <- removeSparseTerms(dtm, 0.85)






  
  
  
  # calculate tf-idf
  tfidf <- tapply(dtms$v/row_sums(dtms)[dtms$i], dtms$j, mean) *
    log2(nDocs(dtms)/col_sums(dtms > 0))
  
  # remove terms with low tf-idf
  dtms <- dtms[,tfidf >= 0.005]    
  
  # remove documents 
  rmdoci <- row_sums(dtms) > 0
  dtm <- dtms[rmdoci > 0,]
  corp <- Corpus(DirSource(cname))
  corp <- corp[rmdoci > 0]
  
  



inspect(dtm)

freq[head(ord)]
freq[tail(ord)]
head(table(freq), 20)
tail(table(freq), 20)
freq <- colSums(as.matrix(dtm))




#-------------------------------visualization
#Add some color and plot words occurring at least 20 times.
#set.seed(142)   
#wordcloud(names(freq), freq, min.freq=20, scale=c(5, .1), colors=brewer.pal(6, "Dark2")) 

#Plot the 100 most frequently occurring words.

#set.seed(142)   
#dark2 <- brewer.pal(6, "Dark2")   
#wordcloud(names(freq), freq, max.words=500, rot.per=0.2, colors=dark2)   


ap_lda <- LDA(dtm, k =3, control = list(seed = 123))

a<-get_terms(ap_lda,5)

viz <- topicmodels_vis(ap_lda,corp,dtm) 
serVis(viz)    

#ap_topics <- tidy(ap_lda, matrix = "beta")
#ap_topics


#ap_top_terms <- ap_topics %>%
#  group_by(topic) %>%
#  top_n(10, beta) %>%
 # ungroup() %>%
#  arrange(topic, -beta)


#ap_top_terms %>%
#  mutate(term = reorder(term, beta)) %>%
 # ggplot(aes(term, beta, fill = factor(topic))) +
 # geom_col(show.legend = FALSE) +
#  facet_wrap(~ topic, scales = "free") +
#  coord_flip()
