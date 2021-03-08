#################################
### SEMINAR 1 LØSNiNGSFORSLAG ###
#################################

# Oppgave 1 ---------------------------
navn <- c("Aisha", "Marcus", "Jenny", "Thea")
alder <- c(20, 23, 25, 20)
hjemby <- c("Spydeberg", "Grimstad", "Oslo", "Bodø")
favfilm <- c("Ringenes herre", "Hamilton", "Parasitt", "Sjel")

data <- data.frame(navn, alder, favfilm, hjemby)

# Oppgave 2 ---------------------------
# Gjennomsnitt
mean(data$alder)

# Standardavvik
sd(data$alder)

# Median
median(data$alder)

# Oppgave 3 ---------------------------
# Dette kan gjøres på flere måter. Her vises noen eksempler.
# Variabelen kan legges rett inn i datasettet ved hjelp av 
# indeksering:
data[, "avstand"] <- c(46, 275, 0, 1189)
data$avstand <- c(46, 275, 0, 1189)

# Variabelen kan legges inn ved å gå frem på samme måte 
# som i oppgave 1:
avstand <- c(46, 275, 0, 1189)
data <- data.frame(data, avstand)

# Oppgave 4 ---------------------------
table(data$navn, data$avstand)
# Thea er lengst hjemmefra

# Oppgave 5 ---------------------------
# For å plotte så bruker vi pakken ggplot2. Denne er integrert i 
# tidyverse-pakken så det første vi gjør er å laste inn den:
library(tidyverse)

# Dersom du ikke har brukt tidyverse-pakken før så må du aller
# først installere den:
# install.packages("tidyverse")

# Deretter bruker vi ggplot. Her er noen eksempler på plot: 
ggplot(data = data, 
       aes(x = alder)) +
  geom_bar()

ggplot(data = data, 
       aes(x = alder)) +
  geom_histogram()

ggplot(data = data, 
       aes(x = alder)) +
  geom_area(stat = "bin")

ggplot(data = data, 
       aes(x = alder)) +
  geom_dotplot()

# Dette skal vi se mer på i seminar fremover. 
