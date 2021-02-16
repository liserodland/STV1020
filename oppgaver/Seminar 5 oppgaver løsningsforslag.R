#### LØSNINGSFORSLAG TIL OPPGAVER SEMINAR 5 ####
## Husk at det finnes flere måter å løse disse på. Dersom du har fått det til, 
## men ikke brukt akkurat samme kode som oss så kan du likevel ha gjort helt 
## riktig :) 


## Laster inn pakker
library(tidyverse)
library(stargazer)

## 1. Laster inn datasettet
load("data/ess_nor.RData")
# Leser i environment at datasettet inneholder 1406 obsrvasjoner og 7 variabler


## 2. Finner navn på variablene i datasettet
# Henter bare ut variabelnavn
names(ess_nor)

# Henter også ut mer informasjon
ess_nor


## 3. Opprettet nytt datasett 
ess2 <- ess_nor %>% 
  select(influence, happy, age)

# Sjekker klassen
ess2
# Alle er dbl = numeric


## 4. Fjerner enheter med missing 
ess2_nona <- ess2 %>% 
  filter(complete.cases(.))
# Antall observasjoner er nå 1349


## 5. Lager spredningsplot
ggplot(data = ess2_nona) + 
  geom_point(aes(x = influence, y = happy))


## 6. Kjører lineær model
model1 <- lm(happy ~ influence, data = ess2_nona)


## 7. Tolk koeffisienten
summary(model1)
# Når influence øker med en skalaenhet så øker happy med 0.18661 skalaenheter.
# Resultatet er statistisk signifikant på 1 prosentsnivå. 


## 8. Lager tabell med stargazer og lagrer lokalt
stargazer(model1, 
          type = "html",
          out = "output/oppg8_tabl.htm")


## 9. Lager plot med predikerte verdiene
# Lagrer predikerte verdier i data
ess2_nona <- ess2_nona %>% 
  mutate(fitted = fitted(model1))

# Plotter
ggplot(data = ess2_nona) +
  geom_line(aes(x = influence, y = fitted))

ggsave(filename = "output/opg9_plot.jpg")


## 10. Estimerer en multivariat regresjonsmodell
model2 <- lm(happy ~ influence + age, data = ess_nor)

summary(model2)
