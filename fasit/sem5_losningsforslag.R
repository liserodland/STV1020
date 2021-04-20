#### LØSNINGSFORSLAG TIL OPPGAVER SEMINAR 5 ####
## Husk at det finnes flere måter å løse disse på. Dersom du har fått det til, 
## men ikke brukt akkurat samme kode som oss så kan du likevel ha gjort helt 
## riktig :) 


## Laster inn pakker
library(tidyverse)
library(stargazer)

## 1. Laster inn datasettet
data <- read.csv("data/wvs_us17.csv")
# Leser i environment at datasettet inneholder 2596 obsrvasjoner og 7 variabler


## 2. Finner navn på variablene i datasettet
# Henter bare ut variabelnavn
names(data)

# Henter også ut mer informasjon
data


## 3. Opprettet nytt datasett 
data2 <- data %>% 
  select(imp_democracy, age, income_group)

# Sjekker klassen 
str(data2)
# Alle er integer = numeric

# Alternativt kan en gjøre dette for hver variabel:
class(data2$imp_democracy)


## 4. Fjerner enheter med missing 
data3 <- data %>% 
  drop_na()
# Antall observasjoner er nå 2508


## 5. Lager spredningsplot
ggplot(data = data) + 
  geom_point(aes(x = age, y = imp_democracy))


## 6. Kjører lineær model
model1 <- lm(imp_democracy ~ age, 
             data = data3)


## 7. Tolk koeffisienten
# Printer resultatene for å kunne tolke:
summary(model1)
stargazer(model1, type = "text")

# Når age øker med en skalaenhet (dvs. ett år) 
# så øker imp_democracy med 0.037 skalaenheter.
# Resultatet er statistisk signifikant på 
# 1 prosentsnivå. 


## 8. Lager tabell med stargazer og lagrer lokalt
stargazer(model1, 
          type = "html",
          out = "oppg8_tabell.htm")


## 9. Lager plot med regresjonslinje:
ggplot(data = data,
       aes(x = age, y = imp_democracy)) + 
  geom_point() +
  geom_smooth(method = "lm") + 
  labs(y = "Viktighet av demokratisk styresett",
       x = "Alder",
       title = "Plott med regresjonslinje og observerte verdier")

# Lagrer
ggsave(filename = "oppg9_plot.png")


# 10. Lager variabelen gender2
## Alternativ 1: 
data$gender2 <- ifelse(data$gender == 1, "Mann", "Kvinne")

## Sjekker at det ble riktig
table(data$gender2, data$gender, useNA = "always")

## Alternativ 2:
data <- data %>% 
  mutate(gender3 = recode(gender, 
                          `1` = "Mann",
                          `2` = "Kvinne"))

## Sjekker at det ble riktig
table(data$gender3, data$gender, useNA = "always")


## 10. Estimerer en multivariat regresjonsmodell
model2 <- lm(imp_democracy ~ age + gender2, data = data)

# Ser på resultatene:
stargazer(model2,
          type = "text")
