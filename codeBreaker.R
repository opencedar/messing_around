code <- readChar("annaCode.txt", file.info("annaCode.txt")$size)

code <- (gsub(" ", "", code, fixed = TRUE))
code <- (gsub("\n", "", code, fixed = TRUE))
code <- (gsub("[.$%\\^&\\*;:{}=_\\-`~()\\,'\\?\\’]", "", code))
code <- (gsub("-", "", code, fixed = TRUE))
code <- tolower(code)


codeVector <- vector()
for(i in 1:nchar(code)) {
  codeVector[i] <- substr(code,i,i)
}

codeVector <- factor(codeVector)
length(levels(codeVector))

freq <- table(codeVector)

freq <- freq[order(freq, decreasing = TRUE)]
freq <- data.frame(freq, stringsAsFactors = FALSE)
freq$codeVector <- as.character(freq$codeVector)

freqDictionary <- read.csv("letterFreq.csv", stringsAsFactors = FALSE)
freqDictionary <- freqDictionary[order(freqDictionary$frequency, decreasing = TRUE),]

known <- data.frame(codeVector = c("h", "2", "l", "4", "m", "6", "n", "1", "3", "s", "!",
                                   "b", "w", "c", "g", "p", "d", "5", "k", "r", "t", "#", "f"), 
                    replacement = c("h", "e", "l", "o", "m", "y", "n", "a", "i", "s", "a",
                                    "b", "w", "c", "g", "p", "d", "u", "k", "r", "t", "I", "y"), stringsAsFactors = FALSE)

freq <- freq[!freq$codeVector %in% known$codeVector,]
freqDictionary <- freqDictionary[!freqDictionary$letter %in% known$replacement,]


translations <- list()
for(i in 1:1000) {
  x <- (rnorm(nrow(freq), mean=100, sd=25))/100
  freqLoop <- freq
  freqLoop$Freq <- round(freqLoop$Freq * x)
  freqLoop <- freqLoop[order(freqLoop$Freq, decreasing = TRUE),]
  freqLoop <- cbind(freqLoop, replacement = freqDictionary$letter, stringsAsFactors = FALSE)
  freqLoop <- freqLoop[,c(1,3)]
  freqLoop <- rbind(freqLoop, known)
  translation <- vector()
  for(j in 1:nchar(code)) {
    replacement <- freqLoop$replacement[freqLoop$codeVector==substr(code,j,j)]
    translation[j] <- replacement
  }
  translationString <- paste0(translation, collapse = '')
  translations[i] <- translationString
  
}




