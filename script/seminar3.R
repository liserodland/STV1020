## ----setup, include=FALSE---------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----installere_gapminder, eval = FALSE-------------------------------------------------------------------------------------
## install.packages("gapminder")
## library(gapminder)


## ----laste_inn_gapminder, include  = FALSE----------------------------------------------------------------------------------
library(gapminder)


## ----gapminder_data---------------------------------------------------------------------------------------------------------
data <- gapminder
# data(gapminder, package = "gapminder")


## ----lagre_gapminder, eval = FALSE------------------------------------------------------------------------------------------
## save(data, file = "gapminder.Rdata")


## ----fjerne_objekter, eval = FALSE------------------------------------------------------------------------------------------
## # Denne koden fjerner alt i environment
## rm(list=ls())
## 
## # Denne koden fjerner et objekt
## rm(objektnavn)
## 
## # Denne koden fjerner flere objekter
## rm(objektnavn1, objektnavn2)
## 


## ---- laste_Rdata-----------------------------------------------------------------------------------------------------------
rm(data)

load("../../data/gapminder.Rdata")


## ----oversikt_gapminder-----------------------------------------------------------------------------------------------------
show(variable.names(gapminder))
# fixme: `names(gapminder)` bedre?
head(gapminder)
summary(gapminder)


## ----endre_årstallvariabel--------------------------------------------------------------------------------------------------
# Sjekker summary for opprinnelige variabel
summary(data$year)
# spennet er 2007-1952, dvs. 55 år
2007-1952

# Legger til ny variabel i datasettet
data$year_1952 <- data$year - 1952

# Sjekker summary for ny variabel
summary(data$year_1952)



## ----sjekke_variabel_med_tabell---------------------------------------------------------------------------------------------
# Lager en tabell med opprinnelig og ny variabel:
table(data$year_1952, data$year, useNA = "always")

# Lager en tabell med en logisk test:
table((data$year_1952 + 1952) == data$year, useNA = "always")


## ----baklengs_år------------------------------------------------------------------------------------------------------------
# Endrer retning på variabelen:
data$year_2007 <- data$year_1952*(-1) + 55

# Sjekker at det ble riktig med table():
table(data$year_1952, data$year_2007, useNA = "always")



## ----ifelse_eksempel, eval=FALSE--------------------------------------------------------------------------------------------
## data$nyvar <- ifelse(test = my_data$my.variabel == "some logical condition",
##                      yes  = "what to return if 'some condition' is TRUE",
##                      no   = "what to return if 'some condition' is FALSE")


## ----ifelse_omkoding--------------------------------------------------------------------------------------------------------
data$lifeExp_2 <- ifelse(test = data$lifeExp > mean(data$lifeExp, na.rm = TRUE),
                         yes = 1,
                         no = 0)


## ----sjekke_variabel_med_tabell2--------------------------------------------------------------------------------------------
table(data$lifeExp_2, data$lifeExp > mean(data$lifeExp, na.rm = TRUE), useNA = "always")



## ----mutate_eksempel, eval = FALSE------------------------------------------------------------------------------------------
## mutate(nyvariabel = recode(gammelvariabel,
##                            verdi1 = nyverdi1,
##                            verdi2 = nyverdi2))
## 


## ----mutate_omkoding--------------------------------------------------------------------------------------------------------
library(tidyverse)

data <- data %>% 
  mutate(continent2 = recode(continent, 
                             Africa = 1, 
                             Americas = 2, 
                             Asia = 3, 
                             Europe = 4, 
                             Oceania = 5))


## ----sjekke_variabel_med_tabell3--------------------------------------------------------------------------------------------
table(data$continent, data$continent2, useNA = "always")


## ----laste_inn_tidyverse----------------------------------------------------------------------------------------------------
# install.packages("tidyverse")
library(tidyverse)


## ----velge_variabler--------------------------------------------------------------------------------------------------------
data_pop <- data %>% 
  select(pop)

data_sub <- data %>%
  select(pop, country, year)



## ----subsette_datasett------------------------------------------------------------------------------------------------------
data_1952 <- data %>%
  filter(year == 1952)

data_1952pop <- data %>% 
  filter(year == 1952, 
         pop > mean(pop))



## ----fjerne_obkekter2-------------------------------------------------------------------------------------------------------
rm(data_pop, data_sub, data_1952, data_1952pop)


## ----ggplot_fundament, eval = FALSE-----------------------------------------------------------------------------------------
ggplot(data = data)


## ----ggplot_aes, eval = FALSE-----------------------------------------------------------------------------------------------
ggplot(data = data, mapping = aes(x = continent))


## ----geom_bar, eval = FALSE-------------------------------------------------------------------------------------------------
ggplot(data = data, aes(x=continent)) + 
  geom_bar()


## ----oversikt_continent-----------------------------------------------------------------------------------------------------
summary(data$continent)


## ----geom_bar_fill, eval = FALSE--------------------------------------------------------------------------------------------
ggplot(data = data, aes(x = continent, fill = continent)) + 
  geom_bar()


## ----legge_til_n------------------------------------------------------------------------------------------------------------
data <- data %>% 
  add_count(continent)


## ----geom_hline, eval = FALSE-----------------------------------------------------------------------------------------------
ggplot(data = data, aes(x = continent, fill = continent)) + 
  geom_bar() +
  geom_hline(aes(yintercept = mean(n)))



## ----pynte_figur, eval = FALSE----------------------------------------------------------------------------------------------
ggplot(data, aes(x = continent, fill = continent)) + 
  geom_bar() +
  geom_hline(aes(yintercept = mean(n))) +
  labs(x = "", 
       y = "Antall land-år-observasjoner", 
       title = "Antall observasjoner per kontinent",
       caption = "Gjennomsnittlig antall observasjoner er gitt ved den horisontale linjen") +
  theme_bw() +
  theme(legend.position = "none") 



## ----plot_til_objekt--------------------------------------------------------------------------------------------------------
plot_le <- ggplot(data, aes(x = lifeExp))


## ----geom_histogram, eval = FALSE-------------------------------------------------------------------------------------------
plot_le +
  geom_histogram()



## ----endre_binwidth, eval = FALSE-------------------------------------------------------------------------------------------
plot_le +
  geom_histogram(binwidth = 1)



## ----endre_tema, eval = FALSE-----------------------------------------------------------------------------------------------
plot_le +
  geom_histogram(aes(fill=continent),
                 binwidth = 1, 
                 alpha = 0.5) +
  theme_bw()


## ----geom_boxplot, eval = FALSE---------------------------------------------------------------------------------------------
plot_le + 
  geom_boxplot(aes(y = continent))


## ----pynte_boxplot, eval = FALSE--------------------------------------------------------------------------------------------
plot_le +
  geom_boxplot(aes(y = continent)) +
  theme_bw() +
  labs(title = "Boxplot for forventet levealder per kontinent",
       x = "Forventet levealder",
       y = "") +
  theme(legend.position = "none")


## ----geom_density, eval = FALSE---------------------------------------------------------------------------------------------
plot_le + 
  geom_density()



## ----size_fill_alpha, eval = FALSE------------------------------------------------------------------------------------------
plot_le + 
  geom_density(size=1.5, fill="pink", alpha=0.3)


## ----tweeks_boxplot, eval = FALSE-------------------------------------------------------------------------------------------
plot_le + 
  geom_density(size=0.5, fill="pink", alpha=1)



## ----facet_wrap, eval = FALSE-----------------------------------------------------------------------------------------------
plot_le + 
  geom_density(size=0.5, fill="pink", alpha=1) + 
  facet_wrap(vars(continent)) +
  theme_bw()




## ----geom_point, eval = FALSE-----------------------------------------------------------------------------------------------
ggplot(data, 
       aes(x=lifeExp, y=gdpPercap)) + 
  geom_point()



## ----geom_smooth, eval = FALSE----------------------------------------------------------------------------------------------
ggplot(data, aes(x=lifeExp, y=gdpPercap)) +
  geom_point() + 
  geom_smooth()


## ----farge_points_smooth, eval = FALSE--------------------------------------------------------------------------------------
ggplot(data, 
       aes(x=lifeExp, y=gdpPercap, col=continent)) +
  geom_point() + 
  geom_smooth()



## ----tweeks_smooth_figur, eval = FALSE--------------------------------------------------------------------------------------
ggplot(data, 
       aes(x = lifeExp, y = gdpPercap, col = continent)) +
  geom_point() + 
  geom_smooth(colour="black") + 
  facet_wrap(~continent) +
  theme_bw() +
  theme(legend.position = "none")



## ----endre_titler_figur, eval = FALSE---------------------------------------------------------------------------------------
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


## ----faktisk_lagre_figur_eksempel, eval = FALSE-----------------------------------------------------------------------------
## # For png-format:
## ggsave(filename = "gdplevealder.png")
## 
## # For pdf-format:
## ggsave(filename = "gdplevealder.pdf")
## 
## # For jpeg-format:
## ggsave(filename = "gdplevealder.jpeg")
## 
## 
## # Du trenger egentlig ikke skrive "filename" så lenge du bruker ggsave:
## ggsave("gdplevealder.png")


## ----lagre_figur_objekt, eval = FALSE---------------------------------------------------------------------------------------
## ggsave(“navnpåplott.filtype”, plot = objektnavn)
## 
## # For eksempel:
## ggsave("histogram_gapminder.png", plot = gm_h)
## 


## ----generere_script, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------
## knitr::purl("./doc/seminar3/seminar3.Rmd",
##             output = "./script/seminar3.R",
##             documentation = 1)

