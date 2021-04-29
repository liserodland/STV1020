#### LØSNINGSFORSLAG TIL OPPGAVER SEMINAR 6 ####
## Husk at det finnes flere måter å løse disse på. Dersom du har fått det til, 
## men ikke brukt akkurat samme kode som oss så kan du likevel ha gjort helt 
## riktig :) 

# Laster inn nødvendige pakker
library(tidyverse)
library(stargazer)
library(foreign) 
# OBS! har du ikke installert foreign fra
# før så må du installere den først. 
# Du kan også bruke haven-pakken om foreign
# ikke virker. Da må du bruke en litt annen
# funksjon for å laste inn datasettet. 
# Sjekk dokumentet på Canvas. Husk å installere
# og laste inn pakken med funksjonen før du
# bruker den. 


## 1. Laster inn datasett 
# Laster inn datasettet og lagrer det som et objekt ved navn "dta". 
dta <- read.dta("ESS9NO.dta")


## 2. Lager et oversiktelig datasett
# Gjør alt i en operasjon:
dta2 <- dta %>%
  select(gndr, agea, eduyrs, grspnum) %>%
  rename(alder = agea, utdanning = eduyrs, inntekt = grspnum) %>%
  mutate(kjonn = if_else(gndr == "Male", 0, 1)) # Har du brukt haven pakken til å laste inn data så må du bytte ut "Male" med 1 her

# Oppretter et nytt objekt ved navn "dta2".
# Vi binder sammen funksjoner med dette tegnet %>%
# Relevante variabler inkluderes ved hjelp av "select" funksjonen.
# Variabelnavn endres ved hjelp av "rename" funksjonen. 
# Variabelen "gndr" omkodes ved hjelp av "mutate" og "if_else" funksjonen.

# Sjekker at omkodingen ble riktig:
table(dta2$gndr, dta2$kjonn, useNA = "always")


## 3. Fjerner enheter som har missing. 
# Fra datasett vi har laget:
dta2 <- na.omit(dta2)

# Fra opprinnelig datasett:
dta_nona <- na.omit(dta)

# Når vi fjerner enheter med missing fra det opprinnelige 
# datasettet (dta) står vi igjen med 0 observasjoner, 
# fordi alle enhetene mangler observasjoner på en eller flere 
# variabler.  

# Når vi subsetter først har vi 838 observasjoner igjen. 


## 4. Multippel regresjon
mod1 <- lm(inntekt ~ utdanning +
             alder+
             kjonn,
           data = dta2)

# Presenterer resultatene i en fin tabell ved hjelp av stargazer
stargazer(mod1, 
          type = "text", # Indikerer at vi ønsker outputet i tekst-format. 
          digits = 2, # Spesifiserer antall desimaler
          title = "OLS regresjon", # Tittel
          dep.var.labels = "Inntekt", # Navn på AV
          covariate.labels = c("Utdanning","Alder", "Kjønn")) # Navn på UV

# Eksempel på tolkning: 
# Sammenhengen mellom alder og inntekt er statistisk signifikant (p<0.01) 
# og positiv. Det vil si at for hver skalaenhets økning i alder, vil inntekt 
# øke med 6195 kroner, gitt at de andre variablene holdes konstant.   


## 5. Plotter regresjonslinjen
# Plotter regresjonslinjen til utdannings-koeffisienten.
ggplot(dta2, # Spesifiserer datasetet vi jobber i.
       aes(x = utdanning, # Den uavhengige variablenen vi er interessert i.
           y = inntekt)) + # Avhengig variabel.
  # ylim(0, 3000000)+ # Man kan definere den øvre og nedre grensen til AV hvis man ønsker.
  geom_point() +  # Enhetene som punkter
  stat_smooth(method = "lm", col = "red") # En lineær regresjonslinje.

# Plottet illustrerer at flertallet av respondentene tjener mellom 0 og 2.5 million.
# Imidlertid er det et par uteliggere med svært stor residual, noe som potensielt
# kan påvirke styrken og/eller retningen på parameterestimatene.


## 6. Plotter residualene

# Legger residual-variabelen til dta2. 
dta2$resid1 <- mod1$residuals

# Residual-fordelingen: Tetthetsplot
ggplot(dta2,
       aes(x = resid1)) +
  geom_density() + theme_classic()

# Residual-fordelingen er høyreskjev, og noe spissere enn normalfordelingen. 

# Alternativt: Histogram
ggplot(dta2, aes(x = resid1)) + 
  geom_histogram(binwidth = 10000, 
                 color = "blue")