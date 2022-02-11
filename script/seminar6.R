## ----setup, include=FALSE---------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(tidy.opts=list(width.cutoff=80), tidy=TRUE)



## ----laste_pakker-----------------------------------------------------------------------------------------------------------
library(tidyverse)
library(stargazer)


## ----lese_data--------------------------------------------------------------------------------------------------------------
# Bytt ut det som står i "" med din egen filbane:
ANES1996small <- read.csv("../../data/ANES1996small.csv")



## ----variabelnavn-----------------------------------------------------------------------------------------------------------
names(ANES1996small)


## ----se_på_data, eval = FALSE-----------------------------------------------------------------------------------------------
## View(ANES1996small)


## ----dataoversikt-----------------------------------------------------------------------------------------------------------
head(ANES1996small)


## ----variabeltabell---------------------------------------------------------------------------------------------------------
table(ANES1996small$v960066, useNA = "always")


## ----nytt_navn_til_variabler------------------------------------------------------------------------------------------------
ANES1996small <- ANES1996small %>% 
  rename(hillary_thermo = v960281,
         income = v960701,
         womenmvmt_thermo = v961039,
         gender = v960066,
         age = v960605)


## ----variabelnavn2----------------------------------------------------------------------------------------------------------
names(ANES1996small)


## ----velge_variabler, eval = FALSE------------------------------------------------------------------------------------------
## nydata <- data %>%
##   select(var1, var2)


## ----fjerne_variabler, eval = FALSE-----------------------------------------------------------------------------------------
## nydata <- data %>%
##   select(-var2)


## ----velge_variabler2-------------------------------------------------------------------------------------------------------
ANES1996small2 <- ANES1996small %>% 
  select(hillary_thermo,
         income,
         womenmvmt_thermo,
         gender,
         age)


## ----omkode_kjønn-----------------------------------------------------------------------------------------------------------
ANES1996small2 <- ANES1996small2 %>%
  mutate(female = ifelse(gender == 1, 0, 1))


## ----sjekke_ny_variabel-----------------------------------------------------------------------------------------------------
table(ANES1996small2$female, ANES1996small2$gender, useNA = "always")


## ----summerende_stat_variabel-----------------------------------------------------------------------------------------------
summary(ANES1996small$hillary_thermo)


## ----histogram_variabel, eval = FALSE---------------------------------------------------------------------------------------
ggplot(data = ANES1996small) +
  geom_histogram(aes(x = hillary_thermo),
                 binwidth = 10) +
  theme_bw()



## ----multivariat_ols_eksempel, eval = FALSE---------------------------------------------------------------------------------
## model <- lm(av ~ uv1 + uv2, data = data, na.action = "na.exclude")


## ----multivariat_ols--------------------------------------------------------------------------------------------------------
model1 <- lm(hillary_thermo ~ income + female, 
             data = ANES1996small2, na.action = "na.exclude")


## ----se_på_modell-----------------------------------------------------------------------------------------------------------
summary(model1)


## ----lage_modelltabell------------------------------------------------------------------------------------------------------
stargazer(model1, type = "text")


## ----bivariat_ols-----------------------------------------------------------------------------------------------------------
model0 <- lm(hillary_thermo ~ income, 
             data = ANES1996small2, na.action = "na.exclude")


## ----tabell_med_to_modell---------------------------------------------------------------------------------------------------
stargazer(model0, model1, 
          type = "text")


## ----tweek_tabell-----------------------------------------------------------------------------------------------------------
stargazer(model0, model1, 
          type = "text",
          title = c("Results from regression analysis"),
          covariate.labels = c("Income",
                               "Female",
                               "Intercept"),
          dep.var.labels = "Hillary Clinton Thermometer score")


## ----legge_inn_pred_resid---------------------------------------------------------------------------------------------------
ANES1996small2 <- ANES1996small2 %>% 
  mutate(mod1fitted = fitted(model1),
         mod1resid = resid(model1))


## ----enda_en_modell---------------------------------------------------------------------------------------------------------
model2additiv <- lm(hillary_thermo ~ female + womenmvmt_thermo, 
                    data = ANES1996small2, na.action = "na.exclude")



## ----samspillsmodell--------------------------------------------------------------------------------------------------------
model2samspill <- lm(hillary_thermo ~ female*womenmvmt_thermo, 
                     data = ANES1996small2, na.action = "na.exclude")

summary(model2additiv)
summary(model2samspill)



## ----enda_en_modelltabell---------------------------------------------------------------------------------------------------
stargazer(model2additiv, model2samspill, type = "text",
          title = c("Tabell fra Kellstedt og Whitten s. 257"),
          covariate.labels = c("Female",
                               "Women's Movement Thermometer",
                               "Women's Movement Thermometer x Female",
                               "Intercept"),
          dep.var.labels = "Hillary Clinton Thermometer score")


## ----html_tabell, eval = FALSE----------------------------------------------------------------------------------------------
## stargazer(model2additiv, model2samspill, type = "html",
##           title = c("Tabell fra Kellstedt og Whitten s. 257"),
##           covariate.labels = c("Female",
##                                "Women's Movement Thermometer",
##                                "Women's Movement Thermometer x Female",
##                                "Intercept"),
##           dep.var.labels = "Hillary Clinton Thermometer score",
##           out = "mod2_tabell.htm")


## ----plot_residualer, eval = FALSE------------------------------------------------------------------------------------------
ggplot(data = ANES1996small2, aes(x = mod1resid)) +
  geom_histogram() +
  theme_bw()



## ----resid_vs_fitted, eval = FALSE------------------------------------------------------------------------------------------
ggplot(data = ANES1996small2 ,
       aes(x = mod1fitted, y = mod1resid)) +
  geom_point() + 
  geom_smooth() + 
  theme_bw()


## ----innebygd_plot_modell, eval = FALSE-------------------------------------------------------------------------------------
## plot(model1)


## ----generere_script, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------
## knitr::purl("./doc/seminar6/seminar6.Rmd",
##             output = "./script/seminar6.R",
##             documentation = 1)

