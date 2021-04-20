#### R-Prøve - Løsningsforslag ####

library(tidyverse)

### Oppgave 1 ###

# Bruker load() for å laste inn fil i .Rdata-format
load("../../wages.Rdata")


### Oppgave 2 ###

# Inntekt 

# Raskeste måten 
summary(data$wages)
sd(data$wages, na.rm = TRUE) # sd() finner standardavviket

# ELLER 
mean(data$wages, na.rm = TRUE)
min(data$wages, na.rm = TRUE)
max(data$wages, na.rm = TRUE)
sd(data$wages, na.rm = TRUE)
sum(is.na(data$wages))

# gjennomsnitt = 15.6, minimumsverdi = 2.3, maxverdi = 49.9, 
# standardavvik = 7.9, og antall NA = 3278

# Utdanning

# Raskeste måten
summary(data$education)
sd(data$education, na.rm = TRUE)

# ELLER 
mean(data$education, na.rm = TRUE)
min(data$education, na.rm = TRUE)
max(data$education, na.rm = TRUE)
sd(data$education, na.rm = TRUE)
sum(is.na(data$education))

# gjennomsnitt = 12.5, minimumsverdi = 0, maxverdi = 20, 
# standardavvik = 3.4, og antall NA = 249

### Oppgave 3 ###

# Lager histogram
ggplot(data, aes(wages)) + geom_histogram()

# Histogrammet viser en høyreskjev fordeling, hvor de fleste observasjonene 
# har relativt lave inntekter. 


### Oppgave 4 ### 

# Lager spredningsplott
ggplot(data, aes(education, wages)) + geom_point()

# Spredningsplottet viser at det ser ut som at det er en positiv sammenheng 
# mellom utdanning og inntekt. Altså med økende utdanning, øker også inntekt.

### Oppgave 5 ##

# Krysstabell mellom kjønn og utdanning
table(data$sex, data$education)


### Oppgave 6 ### 

# Omkoder kjønn

data$sex_new <- ifelse(data$sex == "Female", 0, 1) 
# Her får kvinner får verdien 0 og menn 1. 

# Sjekker at det er gjort riktig med en krysstabell
table(data$sex, data$sex_new)

# Omkoder utdanning
data$education_new <- ifelse(data$education > mean(data$education, na.rm = TRUE), 1, 0)
# Husk å bruke na.rm her også, ellers vil det ikke fungere. 

# Sjekker at det er gjort riktig med en krysstabell
table(data$education, data$education_new)


### Oppgave 7 ### 

# Oppretter nytt datasett med select()
data_new <- data %>% select(wages, education, sex, sex_new, education_new)


### Oppgave 8 ### 

# Estimerer regresjonsmodell 
mod <- lm(formula = wages ~ education, data = data)

# Sammendrag av resultater 
summary(mod)

# Koeffisienten til utdanning er positiv og signifikant (p<0). Når 
# utdanningsnivået øker med en enhet (et år), øker gjennomsnittlig inntekt med 
# 0.8 (dvs. 800 pund ettersom inntekt er målt i pr 1000). 


### Oppgave 9 ### 

# Estimerer regresjonsmodell og legger til kjønn i modellen
mod2 <- lm(formula = wages ~ education + sex, data = data)

# Sammendrag av resultater 
summary(mod2)

# Begge koeffisientene er positive og signifikante (p<0). Dersom alt annet 
# holdes likt (i dette tilfellet utdanning), er gjennomsnittlig inntekt 3.5 
# (dvs. 3500 pund) høyere for menn enn for kvinner (hvis du har satt kvinner 
# som 0, og menn som 1). 
