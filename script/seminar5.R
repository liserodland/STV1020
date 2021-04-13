########################
### SEMINAR 5 SCRIPT ###
########################

# Setter working directory ----
# Først setter vi working directory til den 
# mappen vi ønsker å hente og lagre filer 
# til (ikke nødvendig dersom du jobber i 
# prosjektfilen din):
# setwd("~/Desktop/STV1020")


# Laster inn pakker ----
library(tidyverse)
library(stargazer)


# Laster inn datasettet ----
# Bytt ut det som står i "" med egen
# filbane
load("data/FairFPSR3.RData")


## Undersøker data ----
# Hent ut informasjon om variabelnavn, klasse m.m.
str(FairFPSR3)

# Et alternativ til str()
FairFPSR3

# Printer variabelnavnene
names(FairFPSR3)

# Sjekker hvor mange observasjoner som 
# _ikke_ har manglende informasjon/missing/NA
table(complete.cases(FairFPSR3))

# Sjekker hvor mange observasjoner som 
# har missing på variabelen inflation
table(is.na(FairFPSR3$inflation))


## Omkoding av variabler ----
# Oppretter en variabel og endrer
# referansekategori:

FairFPSR3 <- FairFPSR3 %>% 
  mutate(growth_dich = ifelse(growth > 0, "Growth", "No growth"),
         growth_dich = factor(growth_dich, levels = c("No growth", "Growth")))

# Sjekker at det ser ok ut: 
class(FairFPSR3$growth_dich)
table(FairFPSR3$growth_dich, useNA = "always")

#Lager et plott for å se om omkodingen 
# ble riktig
ggplot(data = FairFPSR3) +
  geom_bar(aes(x=growth, fill = growth_dich),
           binwidth = 1) +
  theme_bw() +
  theme(legend.title=element_blank()) +
  xlab("Growth rate") +
  ylab("No. of observations")


# Litt plotting før regresjon ----

# Lager et spredningsplot med avhengig
# og uavhengig variabel
ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_bw() +
  ylab("Incumbent-Party Vote Percentage") +
  xlab("Percentage change in Real GDP Per Capita") 

# Regresjon med numerisk uavhengig variabel ----
# Kjører modellen med inc_vote som av
# og growth som uv. Vi lagrer resultatene
# i objektet model:
model <- lm(inc_vote ~ growth, 
            data = FairFPSR3,
            na.action = "na.exclude")

# Vi undersøker resultatene nærmere
summary(model)

# Vi undersøker resultatene ved hjelp
# av stargazer:
stargazer(model, 
          type = "text")


# Vi lagrer resultatene i en tabell på
# PC-en ved hjelp av stargazer:
stargazer(model, 
          type = "html",
          out = "sem5_mod_tab.htm")


# Plotter regresjonslinjen:
ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_bw() +
  ylab("Incumbent-Party Vote Percentage") +
  xlab("Percentage change in Real GDP Per Capita") +
  geom_smooth(aes(x = growth, y = inc_vote),
              method = "lm", color = "goldenrod3")

# Legger til predikerte verdier og 
# residualer i datasettet:
FairFPSR3 <- FairFPSR3 %>% 
  mutate(fitted = fitted(model), 
         residuals = resid(model))

# Legger til horisontale og vertikale
# linjer for gjennomsnitt i plottet:
ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_bw() +
  ylab("Incumbent-Party Vote Percentage") +
  xlab("Percentage change in Real GDP Per Capita") +
  geom_smooth(aes(x = growth, y = inc_vote),
              method = "lm", color = "black") +
  geom_hline(yintercept=mean(FairFPSR3$inc_vote), linetype = "dashed") +
  geom_vline(xintercept=mean(FairFPSR3$growth), linetype = "dashed")

# Henter ut konfidensintervallene
confint(model)

## Regresjon med dikotom uavhengig variabel
model_dich <- lm(inc_vote ~ growth_dich, 
                 data = FairFPSR3,
                 na.action = "na.exclude")

stargazer(model_dich, 
          type = "text")

