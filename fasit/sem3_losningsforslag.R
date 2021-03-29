#################################
### SEMINAR 3 LØSNiNGSFORSLAG ###
#################################

# Laster først inn pakker jeg skal bruke
library(gapminder)
library(tidyverse)

# Oppgave 1 ----
# Her er det flere alternativer
# Alt 1:
data <- gapminder

# Alt 2 (må tilpasses mappestrukturen din og datanavn):
load("data/gapminder.Rdata")


# Oppgave 2 ----
# Også dette kan gjøres på flere måter
# Alternativ 1 med ifelse:
data$continent2 <- ifelse(data$continent == "Asia", 1, 
                                ifelse(data$continent == "Americas", 2, 
                                       ifelse(data$continent == "Oceania", 3,
                                              ifelse(data$continent == "Europe", 4,
                                                     ifelse(data$continent == "Africa", 5, NA)))))

table(data$continent, data$continent2, useNA = "always")

# Alternativ 2 med mutate og recode
data <- data %>% 
  mutate(continent3 = recode(continent, 
                             Asia = 1, 
                             Americas = 2, 
                             Oceania = 3, 
                             Europe = 4, 
                             Africa = 5))

table(data$continent, data$continent3, useNA = "always")


# Oppgave 3 ----
data$lifeExp_1000 <- data$lifeExp * 1000

summary(data$lifeExp)
summary(data$lifeExp_1000)

table((data$lifeExp_1000 / 1000) == data$lifeExp)


# Oppgave 4 ----
data_2 <- data %>% 
  filter(year == 1977) %>%
  select(pop, country, lifeExp) 


# Oppgave 5 ----
data_3 <- data %>% 
  filter(continent == "Europe",
         lifeExp >= 75) # Her sier jeg at verdien skal være større (>) eller den samme (=) som 75. 


# Oppgave 6 ----

ggplot(data, aes(x=year)) + 
  geom_bar()


# Oppgave 7 ----

ggplot(data, aes(x=gdpPercap)) + 
  geom_histogram()


# Oppgave 8 ----

ggplot(data, aes(x = gdpPercap)) + 
  geom_density(size = 2.0, color = "red")


# Oppgave 9 ----

ggplot(data, aes(x=lifeExp, y=pop)) + 
  geom_point()


# Oppgave 10 ----

ggplot(data, aes(x = lifeExp, y = pop, color = continent)) + 
  geom_point()


# Oppgave 11 ----

ggplot(data, aes(x = lifeExp, y = pop)) + 
  geom_point() + 
  facet_wrap(vars(continent))


# Oppgave 12 ----  

ggplot(data, aes(x = year, y = lifeExp)) + 
  geom_smooth()


# Oppgave 13 ----

ggplot(data, aes(x = year, y = lifeExp, col = continent)) + 
  geom_smooth()


# Oppgave 14 -----

ggplot(data, 
       aes(x = year, y = lifeExp, color = continent)) + 
  geom_smooth() + 
  labs(x = "Year", 
       y = "Life expectancy", 
       title = "Changes in life expectancy in the period 1952-2007")

#Oppretter objekt
lifeexp_plot <- ggplot(data, 
                       aes(x = year, y = lifeExp, color = continent)) + 
  geom_smooth() + 
  labs(x="Year", 
       y="Life expectancy", 
       title= "Changes in life expectancy in the period 1952-2007")

#Lagrer som png
ggsave("levealderplott.png", plot = lifeexp_plot)

#Lagrer som pdf
ggsave("levealderplott.pdf", plot = lifeexp_plot)


# Ekstraoppgave ----
data_africa1952 <- data %>% 
  filter(year == 1952,
         continent == "Africa") %>%
  filter(lifeExp > mean(lifeExp))
