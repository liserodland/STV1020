########################
### SEMINAR 1 SCRIPT ###
########################

# Der det står __ så kommer vi til å fylle inn i seminar


# Objekter ---------------------------

# Etter # skriver jeg kommentarer. 
# Alt som ikke kommer etter en # vil bli evaluert som kode
# Sett musepekeren på likningen under og trykk crl+enter
# (cmd+return på mac) for å kjøre den.
100/2+4

# Første skal vi lage et objekt:
# Skriv inn et passende objektnavn der det står __ og kjør
# koden. 
__ <- 2

# Når vi lager et objekt så skjer det ikke noe umiddelbart
# i console. Prøv å skriv inn navnet på objektet ditt,
# kjør koden og se hva som skjer i console:
__

# Nå har vi laget et objekt. Skriv inn objektnavnet ditt
# under, kjør koden og se hva resultatet blir i console. 
2 + __ 

# Dette var et veldig enkelt eksempel, men objekter kan
# inneholde mye informasjon! Nå skal vi lage to vektorer.
# Gi objektene et passende navn og kjør koden: 
__ <- 1:100
__ <- c(1,4,56,8,4,2,4)

# Skriv inn navnet her, kjør koden og se hva som kommer 
# opp i console:
__
__

# Hva gjorde 1:100? 

# Det er noen regler for objektnavn:
# - Navn bør bare inneholde små bokstaver, tall og _
# - Ikke bruk et tall som første tegn
# - Ikke bruk æ/ø/å
# - Ikke bruk mellomrom
# - Ikke bruk FALSE, TRUE, Inf, for, else, break, 
#   function, funksjonsnavn


# Funksjoner ---------------------------

# Vi kan nå bruke objektene våre til å prøve ut noen
# funksjoner. Finn gjennomsnittet på de to objektene
# vi lagde tidligere ved å sette inn objektnavnet i
# funksjonen og kjøre koden:
mean(__)
mean(__)


# Indeksering --------------------------- 

# Noen ganger vil vi være interessert i å hente ut 
# informasjon om enkeltobservasjoner i dataene våre. 
# Da kan vi bruke indeksering. 

# Sett inn navnet på et av objektene vi lagde
# tidligere og kjør koden: 
__[5] 

# Hva skjedde? 

# Vektorer inneholder strukturert informasjon. Dette
# gjør det mulig å hente ut informasjon. Sett inn navnet
# på vektorene her og kjør koden:

__[3:6]
__[c(3,5,3,6)]

# Vi kan også bruke indeksering inne i funksjoner:
# Erstatt første __ med funksjnen for å regne gjennomsnitt
# og erstatt den andre __ med objektnavnet ditt:
__(__[c(3,5,3,6)])

# Vi kan også bruke indeksering til å subsette
Ny_Vektor <- __[c(3,5,3,6)]


# Klasser --------------------------- 

# Hvilken klasse et objekt har avgjør hva vi kan gjøre 
# med det. For å sjekke hvilken klasse et objekt har så
# kan vi bruke ulike funksjoner:

# Sett inn objektnavnet ditt og kjør koden: 
class(__)

# Hva fikk du i konsoll? Hva betyr svaret? 

# R operer med flere klasser og vi kan også lagre tekst.
# Gi objektet et navn og skriv noen ord mellom 
# hermetegnene:
__ <- "__"

# Hva skjer om du prøver å ta gjennomsnittet av det nye 
# objektet ditt? 
__(__)

# Hvilken klasse har det nye objektet ditt? 
__(__)

# Vi kan kreve at et objekt skal ha en viss klasse. Det 
# gjør vi med funksjonen as."klassenavn"(). Prøv å lagre
# den numeriske vektoren fra tidligere som en character:

__ <- as.character(__)

__

mean(__)

# Hva skjedde nå? 

# Vi kan også lage objekter som inneholder både tekst 
# og tall. Gi objektet et navn og bytt ut __ med tall
# og ord: 

__ <- c(1,__,0,__, "__", "__", 42, "the answer")

# Hvilken klasse fikk objektet?
class(__)


# Datasett --------------------------- 

# Nå skal vi se på hvordan vi kan slå sammen flere
# vektorer til et datasett. Først lager vi en del ulike
# objekter. Kjør koden under

navn <- c("Mohammed", "Jakob", "Olav", "Martin", 
          "Maja", "Sofia", "Iben", "Therese")
antall <- c(94, 76, 68, NA, 65, 64, 60, NA)
per_tusen <- c(19, 16, 14, NA, 14, 14, 13, NA)
kjonn <- c("Mann", "Mann", "Mann", "Mann",
           "Kvinne", "Kvinne", "Kvinne" "Kvinne")
by <- c("Oslo")

# Vi har nå laget fem ulike vektorer med ulik informasjon
# om navnestatistikk. I environment så kan vi se hvor 
# mange observasjoner det er i hver vektor, men vi kan 
# også bruke funksjonen length(). 
# Sjekk lengden på en av vektorene: 

length(__)

# For å slå disse vektorene sammen til et datasett så
# kan vi bruke funksjonen data.frame. Gi datasettet et n
# navn og kjør koden: 

__ <- data.frame(navn, antall, per_tusen, kjonn, by)

# Når vi indekserte tidligere så skrev vi kun navnet på
# objektet samt et tall. Nå som vi har et datasett må vi
# R informasjon om hvilken rad (observajon) og 
# rekke (variabel) vi vil hente ut:

# Med klammeparanteser kan vi velge rad og kolonne. 
# Rad kommer først, og så kolonnen. 
__[2, 1]

# Hva skjer når vi lar plassen for rad eller kolonne være
# tom? Sett inn navnet på datasettet ditt og kjør koden:
_[, 2]  
_[2, ]

# En mer vanlig måte å hente ut kolonner på er med '$'.
# Her skrive vi først navnet på datasettet og så navnet
# på variabelen
__$navn 

# Denne formen er mye brukt i funksjoner. Finn 
# gjennomsnittet av variabelen per_tusen:
mean(__$per_tusen, na.rm = TRUE)

#Eller median for å finne median
median(__$per_tusen, na.rm = TRUE)

# Funksjonen summary() gir oss all denne informasjonen: 
summary(__$per_tusen)


# Syntaks feil --------------------------- 

feil1 <- c(1 2, 3, 4)

feil2 <- c1, 2, 3, 4)

feil3 < c(1, 2, 3, 4)

feil4 <- c(1, 2, 3, 4
           

# Pakker ---------------------------

# Til nå har vi bare brukt funksjoner som er innebygd i
# R, men nå skal vi installere og laste inn en pakke vi
# kommer til å bruke mye i seminar. Pakken heter
# tidyverse. Vi installerer den ved hjelp av funksjonen
# install.packages(): 

install.packages("tidyverse")

# Når vi installerer pakker må vi alltid sette pakkenavnet
# i hermetegn.  Etter at vi har installert den så må vi
# laste den inn med funksjonen library():
library(tidyverse)

# Vi trenger bare å installere en pakke en gang, men vi må 
# laste den inn med library() hver gang vi starter en ny
# R-sesjon.


# Plotting --------------------------- 

# Helt til slutt så skal vi bare se på et eksempel på
# hvordan vi kan lage et plot med funksjonen ggplot()

ggplot(data = __, aes(x = __)) + 
  geom_bar() 
