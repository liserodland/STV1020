library(tidyverse)
library(foreign)
# Her kan du evnt. bruke pakken haven dersom foreign ikke lar seg installere

## OPPGAVE 1
ess <- read.dta("data/ESS9NO.dta")

## OPPGAVE 2
ess <- ess %>% 
  rename(trust_pol = trstplt,
         gender = gndr,
         birth_year = yrbrn)

## Oppgave 3
ess$age <- 2018 - ess$birth_year

## Oppgave 4
ess_sub <- ess %>% 
  select(trust_pol, gender, age, birth_year, vote)

## Oppgave 5
class(ess_sub$trust_pol)
# Faktor 
# Bonus: ordinalt målenivå

class(ess_sub$gender)
# Faktor
# Bonus: kategorisk målenivå

## Oppgave 6
levels(ess_sub$trust_pol)
# 14 ulike verdier 
# Eller 11 verdier pluss 3 kategorier for missing

table(ess_sub$trust_pol)
# 8 har svart complete trust

## Oppgave 7
ggplot(data = ess_sub, 
       aes(x = trust_pol)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 60,
                                   hjust = 1))
# Flere har svart fem eller høyere enn mindre enn fem. 


## Oppgave 8
# Et forslag til plot:
ggplot(data = ess_sub, 
       aes(x = vote, fill = gender)) +
  geom_bar(position = "dodge")

## Oppgave 9
ggplot(data = ess_sub, 
       aes(x = age, fill = vote)) +
  geom_boxplot(position = "dodge",
                 bins = 10)
