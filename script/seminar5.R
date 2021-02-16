## ---- eval = TRUE, include=TRUE, echo=TRUE, message=FALSE----------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Bestemmer working directory
setwd("../../STV1020/")

# Laster inn pakker
library(tidyverse)
library(stargazer)

# Laster inn datasettet
load("data/FairFPSR3.RData")



## Undersøker data
# Hent ut informasjon om variabelnavn, klasse m.m.
str(FairFPSR3)

# Et alternativ til str()
FairFPSR3

# Printer variabelnavnene
names(FairFPSR3)

# Sjekker hvor mange observasjoner som har manglende informasjon/missing/NA
table(complete.cases(FairFPSR3))

# Sjekker hvor mange observasjoner som har missing på variabelen inflation
table(is.na(FairFPSR3$inflation))

FairFPSR3 <- FairFPSR3 %>% 
  mutate(complete = complete.cases(.),
         inf_na = is.na(inflation))


## Omkoding av variabler
# Oppretter den nye variabelen og endrer referansekategori
FairFPSR3 <- FairFPSR3 %>% 
  mutate(growth_dich = ifelse(growth > 0, "Growth", "No growth"),
         growth_dich = factor(growth_dich, levels = c("No growth", "Growth")))

# Sjekker at det ser ok ut: 
class(FairFPSR3$growth_dich)
table(FairFPSR3$growth_dich, useNA = "always")

# Eksempel på plott. Kan byttes ut med andre plott i f.eks. Healy 
# (har ikke fått boka enda så vet ikke hva de vektlegger der)
ggplot(data = FairFPSR3) +
  geom_histogram(aes(x=growth, fill = growth_dich),
               binwidth = 1) +
  theme_bw() +
  theme(legend.title=element_blank()) +
  xlab("Growth rate") +
  ylab("No. of observations")



## Litt plotting før regresjon
ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_classic() +
  theme(axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black", fill=NA, size=1)) +
  ylab("Incumbent-Party Vote Percentage") +
  xlab("Percentage change in Real GDP Per Capita") 


# Regresjon med numerisk uavhengig variabel 
model <- lm(inc_vote ~ growth, 
            data = FairFPSR3,
            na.action = "na.exclude")

ummary(model)
stargazer(model, 
          type = "text")

stargazer(model, 
          type = "html",
          out = "../output/model1_tab.htm")


ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_classic() +
  theme(axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black", fill=NA, size=1)) +
  ylab("Incumbent-Party Vote Percentage") +
  xlab("Percentage change in Real GDP Per Capita") 


FairFPSR3 <- FairFPSR3 %>% 
  mutate(fitted = fitted(model), 
         residuals = resid(model))

ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_classic() +
  theme(axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black", fill=NA, size=1)) +
  ylab("Incumbent-Party Vote Percentage") +
  xlab("Percentage change in Real GDP Per Capita") +
  geom_line(aes(x = growth, y = fitted))

ggplot(data = FairFPSR3) +
  geom_point(aes(x = growth, y = inc_vote)) +
  theme_classic() +
  theme(axis.line = element_line(colour = "black"),
        panel.border = element_rect(colour = "black", fill=NA, size=1)) +
  ylab("Incumbent-Party Vote Percentage") +
  xlab("Percentage change in Real GDP Per Capita") +
  geom_line(aes(x = growth, y = fitted)) +
  geom_hline(yintercept=mean(FairFPSR3$inc_vote), linetype = "dashed") +
  geom_vline(xintercept=mean(FairFPSR3$growth), linetype = "dashed")


confint(model)

## Regresjon med dikotom uavhengig variabel
model_dich <- lm(inc_vote ~ growth_dich, data = FairFPSR3)
stargazer(model_dich, 
          type = "text")

