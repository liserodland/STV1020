########################
### SEMINAR 2 SCRIPT ###
########################

# Bestemme working directory ----

# Først setter vi working directory til den mappen vi ønsker 
# å hente og lagre filer til (ikke nødvendig dersom du jobber 
# i prosjektfilen din):
setwd("~/Desktop/STV1020")


# Pakker ----

# Første gang man skal bruke en pakke må man installere den. 
# I dag skal vi installere to pakker:
install.packages("tidyverse", 
                 "haven") 

# Før vi kan bruke pakken må vi også laste den inn:
library(tidyverse,
        haven)


# Laste inn data ----

# Vi laste inn datasettet vårt og lagrer det som et objekt:
__ <- read_dta("__")


# Organisering av data ----

# Lager et nytt datasett med et subset av variablene og 
# endrer navn på noen variabler:
ess_subset <- ess %>% 
  select(nwspol, polintr, vote, yrbrn) %>% 
  rename(
    __ = nwspol,
    __ = polintr, 
    __ = yrbrn
  )

# Lager en ny variabel for alder
__$__ <- 2018 - __$__


# Klasser og målenivå ----

# vote er kategorisk, sjekker klassen i R:
class(__$__)
is.numeric(__$__)

# omkoder så klasse i R reflekterer målenivå:
__$__ <- as.factor(__$__)

# interest er ordinal, sjekker klassen i R:
class(__$__)
is.numeric(__$__)

# omkoder så klasse i R reflekterer målenivå:
__$__ <- as.factor(__$__)

# news er kontinuerlig, sjekker klassen i R:
class(__$__)
is.numeric(__$__)


# Utforske data ---- 

summary(__)
str(__)
head(__)
tail(__)


# Deskriptiv statistikk ----

# Kategoriske variabler:
table(__, useNA = "always")
prop.table(table(__))
prop.table(table(__, useNA = "always"))

# Kontinuerlige variabler:
# Finner minimumsverdi 
min(ess_subset$news, na.rm = TRUE) # na.rm = TRUE sier at missing skal droppes i beregningen
# Finner maksimumsveriden 
max(ess_subset$news, na.rm = TRUE)
# Finner gjennomsnitt
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


# Plotting --- 

# Kategoriske data: 
# Søylediagram
ggplot(data = __, aes(x = __)) + 
  geom_bar()

# Søylediagram uten missing  
ggplot(data = __ %>% 
         filter(!is.na(__)), 
       aes(x = __)) + 
  geom_bar()

# Søylediagram med to variabler
ggplot(data = __, 
       aes(x = __)) + 
  geom_bar(aes(fill=__),
           position = "dodge")

# Kakediagram (pie chart): 
ggplot(data = __, aes(x = "", y = __, fill = __)) + 
  geom_bar(stat = "identity", width = 1) + 
  coord_polar("y", start = 0) +
  theme_void() +
  scale_fill_grey()


# Kontinuerlige data
# Histogram med antall
# Med fem søyler:
ggplot(data = __, aes(x = __)) +
  geom_histogram(bins = 5) 

# Med klassebredde på 10:
ggplot(data = __, aes(x = __)) +
  geom_histogram(binwidth = 10) 

# Histogram med 
ggplot(data = ess_subset, aes(x = __, y = ..density..)) +
  geom_histogram(bins = 5) 

ggplot(data = ess_subset, aes(x = __, y = ..density..)) +
  geom_histogram(binwidth = 10) 

# Boksplot

ggplot(data = __, aes(x = __)) +
  geom_boxplot() +
  theme_minimal()

