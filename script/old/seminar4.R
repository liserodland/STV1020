########################
### SEMINAR 4 SCRIPT ###
########################

# Der det står __ så kommer vi til å fylle inn i seminar

# Bestemme working directory ----

# Først setter vi working directory til den 
# mappen vi ønsker å hente og lagre filer 
# til (ikke nødvendig dersom du jobber i 
# prosjektfilen din):
# setwd("~/Desktop/STV1020")


# Repetisjon: pakker ----
# Installerer nye pakker
# install.packages("tidyverse")
install.packages("stargazer")
install.packages("gmodels")
install.packages("ggthemes")
install.packages("scales")

# Laster inn pakker 
library(tidyverse)
library(stargazer)
library(gmodels)
library(ggthemes)
library(scales)


# Laste inn data ----
# For å laste inn .csv-filer
__ <- read_csv("__") 

# For å lagre .csv-filer
write_csv(__, file = "__")


# Bli kjent med data ----
View(__)
head(__)
tail(__)

# Hente ut oppsummerende statistikk
__(__)


# Missing/NA/Not available ----

# Teller antall missing i hele datasettet
sum(is.na(__))

# Teller antlal missing på variabelen 
# internett
sum(is.na(__))

# Finner ut hvor mange observasjoner
# vi har all informasjon om
sum(complete.cases(__)) 

# Fjerne alle observajoner med minst en
# missing  
data1 <- data %>% 
  drop_na() 

# Fjerne alle observasjoner med missing 
# på en variabel (eller fler) 
data2 <- data %>% 
  drop_na(internettbruk) # Du kan legge til flere variable med komma

# Vi skal ikke bruke data1 og data2 mer
# så jeg fjerner dem fra environment
rm(data1, data2)


# Statistiske mål ---- 

# Variabelens standardavvik
__(__, na.rm = TRUE)

# Variabelens varians
# Lagrer variansen i et eget objekt
varians <- var(__, na.rm = TRUE)

# Lage tabell med oppsummerende statistikk:
stargazer(__,
          type = "text")

# Eksporterer tabell med oppsummerende
# statistikk: 
stargazer(__,
          type = "html",
          out = "sem4_desktab.htm")


# Bivariat analyse ---- 

## Tabellanalyse ----

# Hypotese: Det er en sammenheng mellom
# kjønn og stemmegivning i amerikanske
# presidentvalg. 

# Laster inn datasettet ANES2016small fra Kellstedt og
# Whitten. Bytt ut det som står i hermetegn med 
# filbanen og filnavnet på din maskin:
load("")

# Lager nye variabler med mer intuitive verdier
# Merk at de opprinnelige tallverdiene står inni
# tegnene ``. 
ANES2016small <- ANES2016small %>% 
  mutate(vote = recode(V2Trump,
                       `1` = "Trump",
                       `0` = "Clinton"), 
         gender = recode(female, 
                         `0` = "Male", 
                         `1` = "Female"))

# Sjekker at omkodingen ble riktig:
table(ANES2016small$female, 
      ANES2016small$gender, useNA = "always")

# Sjekker at omkodingen ble riktig:
table(ANES2016small$V2Trump, 
      ANES2016small$vote, useNA = "always")

# Lager krysstabell med antall:
krysstabell <- table(ANES2016small$vote, 
                     ANES2016small$gender)

krysstabell

# Lager krysstabell med andel: 
prop.table(__, margin = 2)

# Kjikvadrattest: 
chisq.test(__)

# Alternativ fremgangsmåte fra pakken gmodels: 
CrossTable(__, __, chisq = T)

# Plotter absolutte tall:
__(ANES2016small, aes(x = __,
                          fill = __)) + 
  __(position = "dodge") +
  labs(x = element_blank(),
       y = "Antall") +
  theme(legend.title = element_blank()) +
  theme_bw()

# Plotter andeler:
__(ANES2016small, aes(x = __,
                          group = __)) + 
  __(aes(y = ..prop..),
           position = "dodge") +
  labs(x = element_blank(),
       y = element_blank(),
       title = "Stemmegivning og kjønn") +
  theme(legend.title = element_blank()) +
  scale_y_continuous(labels = scales::percent) +
  theme_bw() + 
  facet_wrap(~gender)

# Lagrer plottet: 
ggsave(__)


## Sammenligne gjennomsnitt med t-test ----

# Hypotese: det er en sammenheng mellom
# kjønn og antall år med utdanning
# Her bruker vi dataene fra ESS

# Lager box_plot
__(data, aes(x = __, fill = as.factor(__))) +
  geom_boxplot()

# T-test
t.test(__ ~ as.factor(__), 
       data = data, var.equal = TRUE)


## Korrelasjonskoeffisient ----

# Hypotese: Det er en positiv sammenheng
# mellom økonomisk vekst og stemmeandel
# til den sittende presidentens parti 
# i amerikanske presidentvalg

# Laster inn data FairFPSR3.RData fra
# Kellstedt og Whitten:
load("__")

# Korrelasjon mellom stemmeandel og vekst:
cor(x = __,
    y = __, 
    use = "pairwise.complete.obs")

# Tester om korelasjonen er statistisk
# signifikant:
cor.test(__, 
         __, 
         use = "pairwise.complete.obs")

# Lager en korrelasjonsmatrise: 
cor(__, use = "pairwise.complete.obs")

# Lager spredningsplot: 
__(FairFPSR3, aes(x=__, y=__)) +
  __(shape=1) +
  theme_bw() +
  labs(x = "Percentage Change in Real DGP Per Capita",
       y = "Incumbent Party Vote Percentage")

# Legger til prediksjonslinje: 
__(FairFPSR3, aes(x=__, y=__)) +
  __(shape=1) +
  theme_bw() +
  labs(x = "Percentage Change in Real DGP Per Capita",
       y = "Incumbent Party Vote Percentage") +
  geom_smooth(method = "lm", color = "black")
