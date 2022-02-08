########################
### SEMINAR 6 SCRIPT ###
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
read.csv("__")


# Bli kjent med data ----
# Dette er gått gjennom tidligere så 
# vi bruker ikke tid på det i seminar


# Forberede data for analyse ---- 
# Endrer navn på variablene:
ANES1996small <- ANES1996small %>% 
  rename(hillary_thermo = v960281,
         income = v960701,
         womenmvmt_thermo = v961039,
         gender = v960066,
         age = v960605)

# Sjekker at det ser greit ut:
names()

# Lager et subset med variablene vi 
# skal bruke: 
ANES1996small2 <- ANES1996small %>% 
  select(hillary_thermo,
         income,
         womenmvmt_thermo,
         gender,
         age)

# Lager en dummyvariabel for kvinne:
ANES1996small2 = ANES1996small2 %>%
  mutate(female = ifelse(__ == 1, 0, 1))

# Sjekker at det ble riktig: 
table(ANES1996small2$__, ANES1996small2$__, useNA = "always")

# Blir litt bedre kjent med avhengig
# variabel: 
summary(__)


# Multippel regresjonsanalyse ----
# Hypoteser fra KW: 
# Hypotese1: Alt annet likt, så vil rikere 
# individer gi Hillary Clinton lavere
# score.
# Hypotese2: Alt annet likt, så vil kvinner 
# gi Hillary Clinton en høyere score.

# Kjører modellen med to uv:
__ <- __(__ ~ __ + __, 
             data = __, na.action = "na.exclude")

# ser på resultatene
summary(__)
stargazer(__, type = "text")

# Kjører en modell med bare income som
# uavhengig variabel for sammenligning: 
__ <- lm(__ ~ __, 
             data = __, na.action = "na.exclude")

# Sammenligner resultatene:
stargazer(__, __, 
          type = "text")

# Lager en peneter tabell:
stargazer(model0, model1, 
          type = "text",
          title = c("Results from regression analysis"),
          covariate.labels = c("Income",
                               "Female",
                               "Intercept"),
          dep.var.labels = "Hillary Clinton Thermometer score")


# Multippel regresjon med samspill ----
# Hypotese fra KW: Effekten av hvordan 
# en respondent føler om kvinnebevegelsen 
# på hvordan de føler om  Hillary Clinton 
# vil være sterkere for kvinner enn for menn. 

# Kjører først en additiv modell med female
# og termometerscore til kvinnebevegelsen
# som uavhengige variable
model2additiv <- lm(hillary_thermo ~ female + womenmvmt_thermo, 
                    data = ANES1996small2, na.action = "na.exclude")

# Legger til samspill ved hjelp av * 
model2samspill <- lm(hillary_thermo ~ female__womenmvmt_thermo, 
                     data = ANES1996small2, na.action = "na.exclude")

# Undersøker resultatene:
summary(model2additiv)
summary(model2samspill)

# Sammenligner de to modellene: 
stargazer(model2additiv, model2samspill, type = "text",
          title = c("Tabell fra Kellstedt og Whitten s. 257"),
          covariate.labels = c("Female",
                               "Women's Movement Thermometer",
                               "Women's Movement Thermometer x Female",
                               "Intercept"),
          dep.var.labels = "Hillary Clinton Thermometer score")


# Modelldiagnostikk ----
# Dette går vi ikke gjennom på seminar