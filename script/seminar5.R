########################
### SEMINAR 5 SCRIPT ###
########################

# Der det står __ så kommer vi til å fylle inn i seminar

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
str(__)

# Et alternativ til str()
__

# Printer variabelnavnene
names(__)

# Sjekker hvor mange observasjoner som 
# _ikke_ har manglende informasjon/missing/NA
table(complete.cases(__))

# Sjekker hvor mange observasjoner som 
# har missing på variabelen inflation
table(is.na(__))


## Omkoding av variabler ----
# Oppretter en  dummy-variabel og endrer
# referansekategori:

FairFPSR3 <- FairFPSR3 %>% 
  mutate(growth_dich = ifelse(__ > __, "Growth", "No growth"),
         growth_dich = factor(growth_dich, levels = c("No growth", "Growth")))

# Sjekker at det ser ok ut: 
class(__)
table(__, useNA = "always")

# Lager et plott for å se om omkodingen 
# ble riktig
ggplot(data = __) +
  geom_bar(aes(x=__, fill = __),
           binwidth = 1) +
  theme_bw() +
  theme(legend.title=element_blank()) +
  labs(x = "Growth rate",
       y = "No. of observations")


# Litt plotting før regresjon ----

# Lager et spredningsplot med avhengig
# og uavhengig variabel
ggplot(data = __) +
  geom_point(aes(x = __, y = __)) +
  theme_bw() +
  labs(y = "Incumbent-Party Vote Percentage",
       x = "Percentage change in Real GDP Per Capita") 


# Regresjon med numerisk uavhengig variabel ----

# Kjører modellen med inc_vote som av
# og growth som uv. Vi lagrer resultatene
# i objektet model:
model <- lm(__ ~ __, 
            data = __,
            na.action = "na.exclude")

# Vi undersøker resultatene nærmere
summary(__)

# Vi undersøker resultatene ved hjelp
# av stargazer:
stargazer(__, 
          type = "__")


# Vi lagrer resultatene i en tabell på
# PC-en ved hjelp av stargazer:
stargazer(__, 
          type = "__",
          out = "__")


# Plotter regresjonslinjen:
ggplot(data = __) +
  geom_point(aes(x = __, y = __)) +
  theme_bw() +
  labs(y = "Incumbent-Party Vote Percentage",
       x = "Percentage change in Real GDP Per Capita") +
  geom_smooth(aes(x = __, y = __),
              method = "lm", color = "goldenrod3")

# Legger til predikerte verdier og 
# residualer i datasettet:
FairFPSR3 <- FairFPSR3 %>% 
  mutate(fitted = fitted(__), 
         residuals = resid(__))

# Legger til horisontale og vertikale
# linjer for gjennomsnitt i plottet:
ggplot(data = __) +
  geom_point(aes(x = __, y = __)) +
  theme_bw() +
  labs(y = "Incumbent-Party Vote Percentage",
       x = "Percentage change in Real GDP Per Capita") +
  geom_smooth(aes(x = __, y = __),
              method = "lm", color = "black") +
  geom_hline(yintercept=__, linetype = "dashed") +
  geom_vline(xintercept=__, linetype = "dashed")

# Henter ut konfidensintervallene
confint(model)

# Regresjon med dikotom uavhengig variabel ---- 
model_dich <- lm(__ ~ __, 
                 data = FairFPSR3,
                 na.action = "na.exclude")

stargazer(__, 
          type = "text")

