#### R-Prøve - Løsningsforslag ####

library(tidyverse)

### Oppgave 1 ###

# Bruker load() for å laste inn fil i .Rdata-format
load("data/wages.Rdata")


### Oppgave 2 ###

# Inntekt 

# Raskeste måten 
summary(wages$wages)
sd(wages$wages, na.rm = TRUE) # sd() finner standardavviket

# ELLER 
mean(wages$wages, na.rm = TRUE)
min(wages$wages, na.rm = TRUE)
max(wages$wages, na.rm = TRUE)
sd(wages$wages, na.rm = TRUE)
sum(is.na(wages$wages))

# gjennomsnitt = 15.6, minimumsverdi = 2.3, maxverdi = 49.9, 
# standardavvik = 7.9, og antall NA = 3278

# Utdanning

# Raskeste måten
summary(wages$education)
sd(wages$education, na.rm = TRUE)

# ELLER 
mean(wages$education, na.rm = TRUE)
min(wages$education, na.rm = TRUE)
max(wages$education, na.rm = TRUE)
sd(wages$education, na.rm = TRUE)
sum(is.na(wages$education))

# gjennomsnitt = 12.5, minimumsverdi = 0, maxverdi = 20, 
# standardavvik = 3.4, og antall NA = 249

### Oppgave 3 ###

# Lager histogram
ggplot(wages, aes(wages)) + geom_histogram()

# Histogrammet viser en høyreskjev fordeling, hvor de fleste observasjonene 
# har relativt lave inntekter. 


### Oppgave 4 ### 

# Lager spredningsplott
ggplot(wages, aes(education, wages)) + geom_point()

# Spredningsplottet viser at det ser ut som at det er en positiv sammenheng 
# mellom utdanning og inntekt. Altså med økende utdanning, øker også inntekt.

### Oppgave 5 ##

# Krysstabell mellom kjønn og utdanning
table(wages$sex, wages$education)


### Oppgave 6 ### 

# Omkoder kjønn

wages$sex_new <- ifelse(wages$sex == "Female", 0, 1) 
# Her får kvinner får verdien 0 og menn 1. 

# Sjekker at det er gjort riktig med en krysstabell
table(wages$sex, wages$sex_new, useNA = "always")

# Omkoder utdanning
wages$education_new <- ifelse(wages$education > mean(wages$education, na.rm = TRUE), 1, 0)
# Husk å bruke na.rm her også, ellers vil det ikke fungere. 

# Sjekker at det er gjort riktig med en krysstabell
table(wages$education, wages$education_new, useNA = "always")


### Oppgave 7 ### 

# Oppretter nytt datasett med select()
data_new <- wages %>% select(wages, education, sex, sex_new, education_new)


### Oppgave 8 ### 

# Estimerer regresjonsmodell 
mod <- lm(formula = wages ~ education, data = wages)

# Sammendrag av resultater 
summary(mod)

# Koeffisienten til utdanning er positiv og signifikant (p<0). Når 
# utdanningsnivået øker med en enhet (et år), øker gjennomsnittlig inntekt med 
# 0.8 (dvs. 800 pund ettersom inntekt er målt i pr 1000). 


### Oppgave 9 ### 

# Estimerer regresjonsmodell og legger til kjønn i modellen
mod2 <- lm(formula = wages ~ education + sex, data = wages)

# Sammendrag av resultater 
summary(mod2)

# Begge koeffisientene er positive og signifikante (p<0). Dersom alt annet 
# holdes likt (i dette tilfellet utdanning), er gjennomsnittlig inntekt 3.5 
# (dvs. 3500 pund) høyere for menn enn for kvinner (hvis du har satt kvinner 
# som 0, og menn som 1). 
