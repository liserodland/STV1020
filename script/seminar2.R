## ----setup, include=FALSE---------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(tidy.opts=list(width.cutoff=60), tidy=TRUE)



## ----sette_workingdirectory, eval=FALSE-------------------------------------------------------------------------------------
## setwd("~/Dokumenter/STV1020")


## ----installere_pakker, eval=FALSE------------------------------------------------------------------------------------------
## install.packages("tidyverse")


## ----laste_inn_pakker-------------------------------------------------------------------------------------------------------
library(tidyverse)


## ----sjekke_workingdirectory------------------------------------------------------------------------------------------------
getwd()
list.files()


## ----lese_filer_til_objekt, eval = FALSE------------------------------------------------------------------------------------
## # Laster inn og lagrer datasettet som et objekt:
## datasett <- read_filtype("filbane/filnavn.filtype")


## ----haven, eval = FALSE----------------------------------------------------------------------------------------------------
## install.packages("haven")


## ----lese_stata-------------------------------------------------------------------------------------------------------------
library(haven)

ess <- read_dta("../../data/ESS9NO.dta", encoding = "UTF-8")


## ----lese_csv, eval = FALSE-------------------------------------------------------------------------------------------------
## # For csv-format:
## datanavn <- read_csv("data/filnavn.csv")
## 
## # For filer i Rdata-format:
## load("data/filnavn.Rdata")


## ----lese_excel, eval = FALSE-----------------------------------------------------------------------------------------------
## install.packages("readxl")
## 
## library(readxl)
## 
## datanavn <- read_excel("data/filnavn.xlsx")


## ----velge_og_navngi_variabler----------------------------------------------------------------------------------------------
ess_subset <- ess %>% 
  select(nwspol, polintr, vote, yrbrn) %>% 
  rename(
    	news = nwspol,
    	interest = polintr, 
    	year_born = yrbrn
  )



## ----velge_og_navngi_variabler2---------------------------------------------------------------------------------------------
ess_subset <- ess %>% 
  select(
    vote,
    news = nwspol,
    interest = polintr, 
    year_born = yrbrn
    )


## ----konstruere_alder-------------------------------------------------------------------------------------------------------
ess_subset$age <- 2018 - ess_subset$year_born 


## ----sjekke_klasse----------------------------------------------------------------------------------------------------------
class(ess_subset$vote)


## ----variabeltabell---------------------------------------------------------------------------------------------------------
table(ess_subset$vote)


## ----konvertere_til_faktor--------------------------------------------------------------------------------------------------
# Lager en ny variabel i datasettet som heter vote_factor
ess_subset$vote_factor <- as_factor(ess_subset$vote)


## ----lese_nivåer_faktor-----------------------------------------------------------------------------------------------------
# Sjekker faktornivåene:
levels(ess_subset$vote_factor)

# Sjekker klasse:
class(ess_subset$vote_factor)


## ----sjekke_klasse2---------------------------------------------------------------------------------------------------------
class(ess_subset$interest)



## ----konvertere_til_faktor2-------------------------------------------------------------------------------------------------
ess_subset$interest_factor <- as_factor(ess_subset$interest)


## ----sjekke_nivåer_faktor2--------------------------------------------------------------------------------------------------
# Sjekker faktornivåene:
levels(ess_subset$interest_factor)

# Sjekker klasse:
class(ess_subset$interest_factor)


## ----sjekke_klasse3---------------------------------------------------------------------------------------------------------
class(ess_subset$news)

is.numeric(ess_subset$news)


## ----datasettoversikt-------------------------------------------------------------------------------------------------------
summary(ess_subset)
str(ess_subset)


## ----datasettoversikt2------------------------------------------------------------------------------------------------------
head(ess_subset)
tail(ess_subset)


## ----variabeltabell_og_proporsjontabell-------------------------------------------------------------------------------------
table(ess_subset$vote, useNA = "always")
prop.table(table(ess_subset$vote))
prop.table(table(ess_subset$vote, useNA = "always"))


## ----sentraltendens_spredning_etc-------------------------------------------------------------------------------------------
# Finner minimumsverdi (det laveste antall minutter brukt på nyheter)
min(ess_subset$news, na.rm = TRUE) # na.rm = TRUE sier at missing skal droppes i beregningen
# Finner maksimumsveriden (den høyeste antall minutter brukt på nyheter)
max(ess_subset$news, na.rm = TRUE)
# Finner gjennomsnittlig antall minutter
mean(ess_subset$news, na.rm = TRUE)
# Finner median
median(ess_subset$news, na.rm = TRUE)
# Finner standardavviket
sd(ess_subset$news, na.rm = TRUE)
# Finner varians
var(ess_subset$news, na.rm = TRUE)
# Finner kvantilverdiene
quantile(ess_subset$news, na.rm = TRUE)
# Finner forskjellig deskriptiv statistikk for en variabel
summary(ess_subset$news)


## ----lage_figur, eval = FALSE-----------------------------------------------------------------------------------------------
ggplot(data = ess_subset, aes(x = interest_factor)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))


## ----fjerne_NA_figur, eval = FALSE------------------------------------------------------------------------------------------
ggplot(data = ess_subset %>% 
         filter(!is.na(interest_factor)), 
       aes(x = interest_factor)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))


## ----kakefigur, eval = FALSE------------------------------------------------------------------------------------------------
ggplot(ess_subset, aes(x = "", y = interest_factor, fill = interest_factor)) + 
  geom_bar(stat = "identity", width = 1) + 
  coord_polar("y", start = 0) +
  theme_void() +
  scale_fill_grey()


## ----søylediagram, eval = FALSE---------------------------------------------------------------------------------------------
ggplot(data = ess_subset, 
       aes(x = interest_factor)) + 
  geom_bar(aes(fill=vote_factor),
           position = "dodge") +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))


## ----histogram, eval = FALSE------------------------------------------------------------------------------------------------
ggplot(data = ess_subset, aes(x = news)) +
 	  geom_histogram(bins = 5) +
  ggtitle("Histogram med fem søyler (bins) og frekvens")


## ----endre_bins_histogram, eval = FALSE-------------------------------------------------------------------------------------
ggplot(data = ess_subset, aes(x = news)) +
  geom_histogram(binwidth = 10) +
  ggtitle("Histogram med søylebredde (binwidth) på 10 og frekvens")



## ----lage_histogram_density, eval = FALSE-----------------------------------------------------------------------------------
ggplot(data = ess_subset, aes(x = news, y = ..density..)) +
 	  geom_histogram(bins = 5) +
  ggtitle("Histogram med fem søyler (bins) og density")


## ----endre_bins_histogram_density, eval = FALSE-----------------------------------------------------------------------------
ggplot(data = ess_subset, aes(x = news, y = ..density..)) +
  geom_histogram(binwidth = 10) +
  ggtitle("Histogram med søylebredde (binwidth) 10 og density")


## ----lage_boxplot, eval = FALSE---------------------------------------------------------------------------------------------
ggplot(data = ess_subset, aes(x = news)) +
  geom_boxplot() +
  theme_minimal()



## ----generere_script, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------
## knitr::purl("./doc/seminar2/seminar2.Rmd",
##             output = "./script/seminar2.R",
##             documentation = 1)

