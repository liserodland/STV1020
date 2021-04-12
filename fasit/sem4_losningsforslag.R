
# Laster inn pakker ---- 
library(tidyverse)

# Oppgave 1 ----
# Laster inn data
load("data/VALGDATA.Rdata")

# Oppgave 2 ----
# Finner navn på variabler:
# Dette kan gjøres på litt ulike måter:
names(valgdata)

summary(valgdata)

# Oppgave 3 ----
# Finner totalt antall missing:
sum(is.na(valgdata))

# 377 missingverdier i datasettet


# Oppgave 4 ----
# Finner missing på enkeltvariabler
summary(valgdata)

# NA's er antall missing per variabel
# Merk at valg ikke kommer opp med antall missing her. 
# Henter ut antall missing på valg ved hjelp av sum() og is.na()

sum(is.na(valgdata$valg))
# 323 missing på valgvariabelen

# Alternativ så kunne vi brukt table()
table(valgdata$valg, useNA = "always")


# Oppgave 5 ----
# Lager et nytt datasett uten missing på variabelen valg
valgdata2 <- valgdata %>% 
  drop_na(valg)


# Oppgave 6 ----
# Lager en ny variabel
valgdata$kjonn_2 <- ifelse(valgdata$kjonn == 1, "mann", "kvinne")
# Sjekker at det ble riktig
table(valgdata$kjonn, valgdata$kjonn_2, useNA = "always")

# Vi vet fra før at 1 = "Male" og 2 = "Female". Om vi ikke visste dette så kunne 
# vi sjekket opp i labels ved hjelp av attr(, "labels"): 
attr(valgdata$kjonn, "labels")

# Vi kan også bruke recode, men i og med at variabelens klasse er "haven_labelled"
# så må vi bruke as.numeric() rund variabelen først
valgdata <- valgdata %>% 
  mutate(kjonn_3 <- recode(as.numeric(kjonn),
                           `1` = "mann",
                           `2` = "kvinne"))

# Oppgave 7 ----
# Bruker table til å finne antall kvinner og menn:
table(valgdata$kjonn_2)


# Oppgave 8 ----
mean(valgdata$alder, na.rm = TRUE)
# Gjennomsnittsalderen er 47.10 år


# Oppgave 9 ----
# Dette kan løses på mange måter. Her er bare to eksempler

# Lager to nye datasett men hhv. bare kvinner og bare menn
valg_kvinner <- valgdata %>% 
  filter(kjonn_2 == "kvinne")

valg_menn <- valgdata %>% 
  filter(kjonn_2 == "mann")

# Regner gjennomsnitt for de ulike datasett
mean(valg_kvinner$alder, na.rm = TRUE)
mean(valg_menn$alder, na.rm = TRUE)

# Regner forskjellen: 
mean(valg_kvinner$alder, na.rm = TRUE) - mean(valg_menn$alder, na.rm = TRUE)

# BONUSLØSNING
# Dette har vi ikke vært gjennom i seminar og det forventes ikke at dere kan
# dette, men det er en smoothere måte å løse det på: 
kjonn_snitt <- valgdata %>% 
  group_by(kjonn_2) %>% 
  summarise(gjsnitt_alder = mean(alder, na.rm = TRUE))

kjonn_snitt

# Beregner differanse: 
46.4-47.7


# Oppgave 10 ----
ggplot(valgdata, aes(valg)) +
  geom_bar()


# Oppgave 11 ----
# Finner korrelasjonen
cor(valgdata$rik, valgdata$alder, use = "pairwise.complete.obs")

attr(valgdata$rik, "label")

# Oppgave 12 ----
ggplot(valgdata, aes(x = alder, y = rik)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Alder",
       y = "Viktighet av å være rik, ha penger å dyre ting",
       title = "Sammenheng mellom alder og vektlegging av rikdom")
