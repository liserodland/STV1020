## ----setup, include=FALSE---------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(tidy.opts=list(width.cutoff=80), tidy=TRUE)



## ----chunk_eksempel---------------------------------------------------------------------------------------------------------
# Dette er kode.  


## ----kommentar_eksempel-----------------------------------------------------------------------------------------------------
# Dette er en kommentar. 
# Nå skal vi gjøre et lite forsøk med noe enkel matte! 
# For å kjøre koden setter dere musepekeren ved siden av, og trykker ctrl+enter (cmd+return på Mac). 
100/2+4


## ----mean_funksjonen, eval=FALSE--------------------------------------------------------------------------------------------
## #La oss prøve dette med "mean()" funksjonen, som logisk nok finner gjennomsnitt:
## ?mean


## ----hjeplefil_eksempel-----------------------------------------------------------------------------------------------------
?vif



## ----lage_objekter----------------------------------------------------------------------------------------------------------

To <- 2

2 + To


## ----lage_objekter2---------------------------------------------------------------------------------------------------------
en_til_hundre <- 1:100
tall <- c(1,4,56,8,4,2,4)

tall


## ----funksjon_eksempel------------------------------------------------------------------------------------------------------
mean(en_til_hundre)
mean(tall)


## ----indeksering_eksempel---------------------------------------------------------------------------------------------------
tall[5]


## ----indeksering_eksempel2--------------------------------------------------------------------------------------------------
tall[3:6]
tall[c(3,5,3,6)]


## ----funksjon_indeksering---------------------------------------------------------------------------------------------------
mean(tall[c(3,5,3,6)])


## ----nytt_objekt_indeksering------------------------------------------------------------------------------------------------
Ny_Vektor <- tall[c(3,5,3,6)]


## ----sjekke_numeric---------------------------------------------------------------------------------------------------------
is.numeric(en_til_hundre)
# Her ser vi at vi får opp "TRUE" som betyr at en_til_hundre er et numerisk objekt


## ----sjekke_klasse----------------------------------------------------------------------------------------------------------
class(en_til_hundre)


## ----klasse_tekst_eksempel--------------------------------------------------------------------------------------------------
Tekst <- "Hei, jeg elsker R! <3"
# Denne klassen kan inneholde tekst, men vil f.eks. ikke kunne brukes til matte. 
mean(Tekst)


## ----bytte_klasse-----------------------------------------------------------------------------------------------------------
tall_ch <- as.character(tall)
mean(tall_ch)


## ----faktor_eksempel--------------------------------------------------------------------------------------------------------
# Lager en faktorvariabel uten å sette nivåer
skolenivaer <- factor(c("Barneskole", 
                        "Ungdomskole", 
                        "Videregaende", 
                        "Videregaende", 
                        "Universitet",
                        "Ungdomskole",
                        "Universitet"))

# Printer alle verdiene
skolenivaer 

# Printer alle nivåene
levels(skolenivaer)
# Er det noe som skurrer her?


## ----endre_faktornivå-------------------------------------------------------------------------------------------------------
# Endrer faktornivåene
skolenivaer <- factor(skolenivaer,
                      levels = c("Barneskole",
                                 "Ungdomskole",
                                 "Videregaende",
                                 "Universitet"))
skolenivaer
levels(skolenivaer)


## ----blande_klasser_eksempel------------------------------------------------------------------------------------------------
teksttall <- c(1,4,0,4, "Bamse", "R", "R Seminarer er de BESTE seminarer", 42, "the answer")

class(teksttall)
mean(teksttall[1:4])


## ----eksempel_vektorer------------------------------------------------------------------------------------------------------
navn <- c("Mohammed", "Jakob", "Olav", "Martin", 
          "Maja", "Sofia", "Iben", "Therese")

antall <- c(94, 76, 68, NA, 65, 64, 60, NA)

per_tusen <- c(19, 16, 14, NA, 14, 14, 13, NA)

kjonn <- c("Gutt", "Gutt", "Gutt", "Gutt", 
           "Jente", "Jente", "Jente", "Jente")

by <- c("Oslo")



## ----lengde_vektor----------------------------------------------------------------------------------------------------------

length(navn)
length(by)



## ----datasett_eksempel------------------------------------------------------------------------------------------------------
navnestat <- data.frame(navn, antall, per_tusen, kjonn, by)


## ----vise_datasett_spss_style-----------------------------------------------------------------------------------------------
View(navnestat)


## ----indeksering_datasett---------------------------------------------------------------------------------------------------
# Med klammeparanteser kan vi velge rad og kolonne. Rad kommer først, og så kolonnen:
# `datasett[rader, kolonner]`
navnestat[2,1] 

# Skriver vi en tom får vi alle kollonene/radene 
navnestat[,2] 
navnestat[2,]



## ----trekke_ut_variabler----------------------------------------------------------------------------------------------------
#Her skriver jeg først navnet på dataframen, og så variabelen: 
navnestat$antall 

#La oss prøve å få ut gjennomsnittlet til antall 
mean(navnestat$antall)


## ----gjennomsnitt_datasettvariabel------------------------------------------------------------------------------------------
mean(navnestat$antall, na.rm = TRUE) 
median(navnestat$antall, na.rm = TRUE)


## ----summerende_statistikk--------------------------------------------------------------------------------------------------
summary(navnestat$antall)

summary(navnestat)


## ----installere_pakker, eval=FALSE------------------------------------------------------------------------------------------
## install.packages("tidyverse")


## ----laste_inn_pakker-------------------------------------------------------------------------------------------------------
library(tidyverse)


## ----ggplot_eksempel, warning=FALSE-----------------------------------------------------------------------------------------
# I første argument spesifiserer vi datasettet
# og hvilken variabel vi vil plotte
# Vi legger til en + på slutten av linjen for
# å fortelle R at vi vil legge til flere lag
# Etter + skrive vi hva slags plot vi vil ha. 

ggplot(data = navnestat, aes(x = per_tusen)) + 
  geom_bar(bins = 30) 
  


## ----set_up_for_tabell, echo = FALSE, message=FALSE-------------------------------------------------------------------------
"Atomic vector" <- c("numeric", "integer", "character", "factor", "logical")
"List" <- c("blanding", "", "", "", "")
tabell <- cbind(`Atomic vector`, List)



## ----klasser_i_datasett-----------------------------------------------------------------------------------------------------
class(navnestat$navn)
class(navnestat$antall)
class(navnestat$by)


## ----endre_klasse_i_datasett------------------------------------------------------------------------------------------------
# Her lager vi en ny variabel antall2 der vi ber R lagre alder som character
navnestat$antall2 <- as.character(navnestat$antall)


## ----logiske_operasjoner----------------------------------------------------------------------------------------------------
1 == 2                                # tester om 1 er lik 2
2 == 2                                # tester om 2 er lik 2
"Statsvitenskap" == "statsvitenskap"  # Logiske tester kan også brukes på tekst
"statsvitenskap" == "statsvitenskap"  # R er imidlertid sensitivt til store og små bokstaver
1 <= 2                                # Tester om 1 er mindre enn eller lik 2
1 >= 2                                # Tester om 1 er større enn eller lik 2
1 != 2                                # Tester om 1 er ulik 2
1 == 2 | 1 == 1                       # Tester om en av de to påstandene 1 er lik 2 eller 1 er lik 1 er sanne
1 == 2 & 1 == 1                       # Tester om begge de to påstandene 1 er lik 2 og 1 er lik 1 er sanne


## ----generere_script, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------
## knitr::purl("./doc/seminar1/seminar1.Rmd",
##             output = "./script/seminar1.R",
##             documentation = 1)

