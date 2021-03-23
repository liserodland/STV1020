########################
### SEMINAR 3 SCRIPT ###
########################

# Der det står __ så kommer vi til å fylle inn i seminar

# Bestemme working directory ----

# Først setter vi working directory til den 
# mappen vi ønsker å hente og lagre filer 
# til (ikke nødvendig dersom du jobber i 
# prosjektfilen din):
setwd("~/Desktop/STV1020")

# Laste inn pakker ----
install.packages("gapminder")
library(gapminder)
library(tidyverse)


# Laste inn data ----
data <- gapminder

# Lagrer datasettet
save(data, file = "gapminder.Rdata")

# Fjerner opprinnelig data
rm(data)

# Laster inn data på nytt
# Bytt ut __ med navn på datasett og 
# evnt. filbane for å laste det inn:
load("__")


# Omkoding av variabler ----
# Vi undersøker datasettet litt nærmere
show(variable.names(gapminder))
head(gapminder)
summary(gapminder)


## Matematisk omkoding ---- 

# Sjekker summary for opprinnelige variabel
summary(data$year)

# spennet er 2007-1952, dvs. 55 år
2007-1952

# Legger til ny variabel i datasettet
__ <- data$year - 1952

# Sjekker summary for ny variabel
summary(__)

# Sjekker at kodingen gikk fint:
# Lager en tabell med opprinnelig og ny variabel:
table(__, data$year)

# Lager en tabell med en logisk test:
table((__ + 1952) == data$year)

# Endrer retning på variabelen:
__ <- __*(-1) + 55

# Sjekker at det ble riktig med table():
table(__, __)


## Omkoding med ifelse ----

data$lifeExp_2 <- ifelse(test = data$lifeExp > mean(data$lifeExp, na.rm = TRUE),
                         yes = 1,
                         no = 0)

# Sjekker at det blir riktig
table(data$lifeExp_2, 
      data$lifeExp > mean(data$lifeExp, na.rm = TRUE))


# Subsetting av datasett ----

# Dette gikk vi gjennom på seminar 2 så
# vi går ikke gjennom det på ny i tredje 
# seminar. Se gjennom det som står i 
# dokumentet som forklarer koden på
# egenhånd. 


# Intro til ggplot ----


## Steg 1: Fortell ggplot() hvor vi vil hente 
## data fra
ggplot(data = data)


## Steg 2: Fortell ggplot hvilken sammenheng 
## vi vil plotte
ggplot(data = data, mapping = aes(x = continent))


## Steg 3: Fortell ggplot hvordan du vil
## illustrere sammenhengen
ggplot(data = data, aes(x=continent)) + 
  geom_bar()

# Bruker summary til å kontrollere plottet
summary(data$continent)

# Legger til farger
ggplot(data = data, 
       aes(x = continent, fill = continent)) + 
  geom_bar()


## Steg 4: Legg til `geom_` etter behov 
# Lagger en ny variabel med informasjon
# om antall obs. per kontinent
data <- data %>% 
  add_count(continent)

# Legger til geom_hline():
ggplot(data = data, 
       aes(x = continent, fill = continent)) + 
  geom_bar() +
  geom_hline(aes(yintercept = mean(n)))


## Steg 5: Bruk funksjoner til å justere skala, etiketter, tittel o.l..
ggplot(data, aes(x = continent, fill = continent)) + 
  geom_bar() +
  geom_hline(aes(yintercept = mean(n))) +
  labs(x = "", 
       y = "Antall land-år-observasjoner", 
       title = "Antall observasjoner per kontinent",
       caption = "Gjennomsnittlig antall observasjoner er gitt ved den horisontale linjen") +
  theme_bw() +
  theme(legend.position = "none") 


# Uliker typer plot ----
# Jeg går ikke gjennom alle fra seminar-
# dokumentet her, men viser noen eksempler.

# Først lagrer vi informasjon om data og
# variabel i et eget objekt

plot_le <- ggplot(data, aes(x = lifeExp))


## Histogram ----
plot_le +
  geom_histogram()

plot_le +
  geom_histogram(aes(fill=continent),
                 binwidth = 1, 
                 alpha = 0.5) +
  theme_bw()


## Boxplot ----
plot_le + 
  geom_boxplot(aes(y = continent))

plot_le + 
  geom_boxplot(aes(y = continent)) +
  theme_bw() +
  labs(title = "Boxplot for forventet levealder per kontinent",
       x = "Forventet levealder",
       y = "") 


## Density plot ----
plot_le + 
  geom_density()

plot_le + 
  geom_density(size=1.5, fill="pink", alpha=0.3)

plot_le + 
  geom_density(size=0.5, fill="pink", alpha=1) + 
  facet_wrap(vars(continent)) +
  theme_bw()


## Spredningsplot ----
ggplot(data, 
       aes(x=lifeExp, y=gdpPercap)) + 
  geom_point()

ggplot(data, 
       aes(x=lifeExp, y=gdpPercap)) +
  geom_point() + 
  geom_smooth()

ggplot(data, 
       aes(x=lifeExp, y=gdpPercap, col=continent)) +
  geom_point() + 
  geom_smooth()

ggplot(data, 
       aes(x = lifeExp, y = gdpPercap, col = continent)) +
  geom_point() + 
  geom_smooth(colour="black") + 
  facet_wrap(vars(continent)) +
  labs(x = "Forventet levealder", 
       y = "GDP per capita", 
       title = "Et plot med Gapminderdata") +
  theme_bw() +
  theme(legend.position = "none")
