## ----setup, include=FALSE---------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(tidy.opts=list(width.cutoff=60), tidy=TRUE)



## ----sette_workingdirectory, eval = FALSE-----------------------------------------------------------------------------------
## # Bestemmer working directory (om du ikke jobber i prosjekt). Bytt ut det som står mellom "" så det matcher din filbane:
## setwd("../STV1020/")


## ----laste_pakker_og_data, eval = TRUE, include=TRUE, echo=TRUE, message=FALSE----------------------------------------------

# Laster inn pakker
library(tidyverse)
library(stargazer)

# Laster inn datasettet
# Bytt ut det som står mellom "" til å passe din filbane:
load("../../data/FairFPSR3.RData")



## ----dataoversikt-----------------------------------------------------------------------------------------------------------
# Hent ut informasjon om variabelnavn, klasse m.m.
str(FairFPSR3)

# Et alternativ til str()
FairFPSR3

# Printer variabelnavnene
names(FairFPSR3)

# Henter ut oppsummerende statistikk:
summary(FairFPSR3)


## ----sjekke_missing_alle----------------------------------------------------------------------------------------------------
# Sjekker hvor mange observasjoner som vi har informasjon på alle variablene om:
table(complete.cases(FairFPSR3))


## ----sjekke_missing_variabel------------------------------------------------------------------------------------------------
# Sjekker hvor mange observasjoner som har missing på variabelen inflation
table(is.na(FairFPSR3$inflation))



## ----lage_ant_missing_variabler---------------------------------------------------------------------------------------------
FairFPSR3 <- FairFPSR3 %>% 
  mutate(complete = complete.cases(.),
         inf_na = is.na(inflation))


## ----dikotomisering---------------------------------------------------------------------------------------------------------
# Oppretter den nye variabelen og endrer referansekategori
FairFPSR3 <- FairFPSR3 %>% 
  mutate(growth_dich = ifelse(growth > 0, "Growth", "No growth"),
         growth_dich = factor(growth_dich, levels = c("No growth", "Growth")))


## ----sjekke_ny_variabel-----------------------------------------------------------------------------------------------------
# Sjekker at det ser ok ut: 
class(FairFPSR3$growth_dich)
table(FairFPSR3$growth_dich, useNA = "always")


## ----plotte_ny_variabel, eval = FALSE---------------------------------------------------------------------------------------
## ggplot(data = FairFPSR3) +
##   geom_bar(aes(x=growth, fill = growth_dich),
##                binwidth = 1) +
##   theme_bw() +
##   theme(legend.title=element_blank()) +
##   labs(x = "Growth rate",
##        y = "No. of observations")
## 


## ----lagre_plot1, include = FALSE-------------------------------------------------------------------------------------------
ggplot(data = FairFPSR3) +
  geom_bar(aes(x=growth, fill = growth_dich),
               binwidth = 1) +
  theme_bw() +
  theme(legend.title=element_blank()) +
  labs(x = "Growth rate",
       y = "No. of observations")

ggsave("../../output/sem5fgi1.png")



## ----point_growth_stemme, eval = FALSE--------------------------------------------------------------------------------------
## ggplot(data = FairFPSR3) +
##   geom_point(aes(x = growth, y = inc_vote)) +
##   theme_bw() +
##   labs(y = "Incumbent-Party Vote Percentage",
##        x = "Percentage change in Real GDP Per Capita")


## ----lagre_plot2, include = FALSE-------------------------------------------------------------------------------------------
ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_bw() +
  labs(y = "Incumbent-Party Vote Percentage",
       x = "Percentage change in Real GDP Per Capita")

ggsave("../../output/sem5_fig2.png")


## ----ols_eksempel, eval = FALSE---------------------------------------------------------------------------------------------
## lm(avhengig_variabel ~ uavhengig_variabel, data = mitt_datasett)
## # På mac får du ~ med alt + k + space


## ----bivariat_ols-----------------------------------------------------------------------------------------------------------
model <- lm(inc_vote ~ growth, 
            data = FairFPSR3,
            na.action = "na.exclude")


## ----printe_ols_resultat----------------------------------------------------------------------------------------------------
summary(model)


## ----lage_tabell_ols--------------------------------------------------------------------------------------------------------
stargazer(model, 
          type = "text")


## ----lagre_tabell_ols, message=FALSE, eval=FALSE----------------------------------------------------------------------------
## stargazer(model,
##           type = "html",
##           out = "model1_tab.htm")


## ----point_growth_stemme2, eval = FALSE-------------------------------------------------------------------------------------
## ggplot(data = FairFPSR3) +
##   geom_point(aes(x = growth, y = inc_vote)) +
##   theme_bw() +
##   labs(y = "Incumbent-Party Vote Percentage",
##        x = "Percentage change in Real GDP Per Capita")


## ----lagre_plot3, include = FALSE-------------------------------------------------------------------------------------------
ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_bw() +
  labs(y = "Incumbent-Party Vote Percentage",
       x = "Percentage change in Real GDP Per Capita")

ggsave("../../output/sem5_fig3.png")



## ----regresjonslinje_plot, eval = FALSE-------------------------------------------------------------------------------------
## ggplot(data = FairFPSR3) +
##   geom_point(aes(x = growth, y = inc_vote)) +
##   theme_bw() +
##   labs(y = "Incumbent-Party Vote Percentage",
##        x = "Percentage change in Real GDP Per Capita") +
##   geom_smooth(aes(x = growth, y = inc_vote),
##               method = "lm", color = "goldenrod3")


## ----lagre_plot4, include = FALSE-------------------------------------------------------------------------------------------
ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_bw() +
  labs(y = "Incumbent-Party Vote Percentage",
       x = "Percentage change in Real GDP Per Capita") +
  geom_smooth(aes(x = growth, y = inc_vote),
              method = "lm", color = "goldenrod3")

ggsave("../../output/sem5_fig4.png")


## ----uv_snitt_linjer, eval = FALSE------------------------------------------------------------------------------------------
## ggplot(data = FairFPSR3) +
##   geom_point(aes(x = growth, y = inc_vote)) +
##   theme_bw() +
##   labs(y = "Incumbent-Party Vote Percentage",
##        x = "Percentage change in Real GDP Per Capita") +
##   geom_smooth(aes(x = growth, y = inc_vote),
##               method = "lm", color = "goldenrod3") +
##   geom_hline(yintercept=mean(FairFPSR3$inc_vote), linetype = "dashed") +
##   geom_vline(xintercept=mean(FairFPSR3$growth), linetype = "dashed")


## ----lagre_plot5, include = FALSE-------------------------------------------------------------------------------------------
ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_bw() +
  labs(y = "Incumbent-Party Vote Percentage",
       x = "Percentage change in Real GDP Per Capita") +
  geom_smooth(aes(x = growth, y = inc_vote),
              method = "lm", color = "goldenrod3") +
  geom_hline(yintercept=mean(FairFPSR3$inc_vote), linetype = "dashed") +
  geom_vline(xintercept=mean(FairFPSR3$growth), linetype = "dashed")

ggsave("../../output/sem5_fig5.png")


## ----lagre_pred_pg_resid----------------------------------------------------------------------------------------------------
FairFPSR3 <- FairFPSR3 %>% 
  mutate(fitted = fitted(model), 
         residuals = resid(model))


## ----pred_plot, eval = FALSE------------------------------------------------------------------------------------------------
## ggplot(data = FairFPSR3) +
##   geom_point(aes(x = growth, y = inc_vote)) +
##   theme_bw() +
##   labs(y = "Incumbent-Party Vote Percentage",
##        x = "Percentage change in Real GDP Per Capita") +
##   geom_line(aes(x = growth, y = fitted))


## ----lagre_plot6, include = FALSE-------------------------------------------------------------------------------------------
ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_bw() +
  labs(y = "Incumbent-Party Vote Percentage",
       x = "Percentage change in Real GDP Per Capita") +
  geom_line(aes(x = growth, y = fitted))

ggsave("../../output/sem5_fig6.png")


## ----snitt_plot2, eval = FALSE----------------------------------------------------------------------------------------------
## ggplot(data = FairFPSR3) +
##   geom_point(aes(x = growth, y = inc_vote)) +
##   theme_bw() +
##   labs(y = "Incumbent-Party Vote Percentage",
##        x = "Percentage change in Real GDP Per Capita") +
##   geom_line(aes(x = growth, y = fitted)) +
##   geom_hline(yintercept=mean(FairFPSR3$inc_vote), linetype = "dashed") +
##   geom_vline(xintercept=mean(FairFPSR3$growth), linetype = "dashed")
## 


## ----lagre_plot7, include = FALSE-------------------------------------------------------------------------------------------
ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_bw() +
  labs(y = "Incumbent-Party Vote Percentage",
       x = "Percentage change in Real GDP Per Capita") +
  geom_line(aes(x = growth, y = fitted)) +
  geom_hline(yintercept=mean(FairFPSR3$inc_vote), linetype = "dashed") +
  geom_vline(xintercept=mean(FairFPSR3$growth), linetype = "dashed")

ggsave("../../output/sem5_fig7.png")



## ----modellens_konfidensintervall-------------------------------------------------------------------------------------------
confint(model)


## ----dikotim_ols------------------------------------------------------------------------------------------------------------
# Lagrer modellen
model_dich <- lm(inc_vote ~ growth_dich, 
                 data = FairFPSR3,
                 na.action = "na.exclude")

# Undersøker resultatene
stargazer(model_dich, 
          type = "text")


## ----generere_script, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------
## knitr::purl("./doc/seminar5/seminar5.Rmd",
##             output = "./script/seminar5.R",
##             documentation = 1)

