## ----installere_pakker, eval = FALSE----------------------------------------------------------------------------------------
## # Installerer nye pakker
## install.packages("stargazer")
## install.packages("gmodels")
## install.packages("scales")


## ----laste_inn_pakker-------------------------------------------------------------------------------------------------------
# Laster inn pakker 
library(tidyverse)
library(stargazer)
library(gmodels)
library(scales)


## ----laste_inn_csv----------------------------------------------------------------------------------------------------------
# For å laste inn .csv-filer
data <- read.csv("../../data/internett.csv")


## ----skrive_csv, eval = FALSE-----------------------------------------------------------------------------------------------
## # For å lagre .csv-filer
## write.csv(data, file = "../../data/internett_ed.csv", row.names = FALSE)
## 


## ----se_på_data, eval = FALSE-----------------------------------------------------------------------------------------------
## View(data)


## ----head_tail--------------------------------------------------------------------------------------------------------------
head(data)
tail(data)


## ----oversikt_data----------------------------------------------------------------------------------------------------------
summary(data) 


## ----finne_missing----------------------------------------------------------------------------------------------------------
is.na(data %>% 
        slice_head(n = 6))


## ----sum_av_vektor----------------------------------------------------------------------------------------------------------
sum(2,2,6)


## ----sum_na-----------------------------------------------------------------------------------------------------------------
# Finner ut om de seks første observasjonene har missing på variabelen tilitt
is.na(data %>% 
        slice_head(n = 6) %>%  # Beholder bare de seks første observasjonene
        select(tillit))        # Beholder bare variabelen tillit


# Teller antall missing blant de seks første observasjonene
sum(is.na(data %>% 
            slice_head(n = 6) %>% 
            select(tillit)))


## ----sum_na2----------------------------------------------------------------------------------------------------------------
sum(is.na(data)) 


## ----sum_na_variabel--------------------------------------------------------------------------------------------------------
sum(is.na(data$internettbruk)) # Viser hvor mange missing det er på en variabel


## ----fullstendige_enheter---------------------------------------------------------------------------------------------------
complete.cases(data %>% 
                 slice_head(n = 6)) # Henter ut informasjon om de seks første observasjonene


## ----sum_fullstendige_enheter-----------------------------------------------------------------------------------------------
sum(complete.cases(data)) 


## ----oversikt_enkeltvariabel------------------------------------------------------------------------------------------------
# For alle variabler i datasettet
summary(data)

# For variabelen internettbrukt
summary(data$internettbruk)



## ----fjerne_na--------------------------------------------------------------------------------------------------------------
# Fjerne alle observajoner med minst en missing  
data1 <- data %>% 
  drop_na() 

# Fjerne alle observasjoner med missing på en variabel (eller fler) 
data2 <- data %>% 
  drop_na(internettbruk) # Du kan legge til flere variable med komma

# Vi skal ikke bruke data1 og data2 mer så jeg fjerner dem fra environment
rm(data1, data2)



## ----standardavvik, eval = FALSE--------------------------------------------------------------------------------------------
## sd(data$variabel, na.rm = TRUE)


## ----standardavvik2---------------------------------------------------------------------------------------------------------
sd(data$internettbruk, na.rm = TRUE)


## ----varians----------------------------------------------------------------------------------------------------------------
# Lagrer variansen i et eget objekt
varians <- var(data$internettbruk, na.rm = TRUE)

varians


## ----lagre_standardavvik----------------------------------------------------------------------------------------------------
# Lagrer først standardavviket i et objekt: 
stdavvik <- sd(data$internettbruk, na.rm = TRUE)

# Bruker logisk test for å spørre R om standardavviket er det samme som kvadrat-
# roten (sqrt) av variansen
stdavvik == sqrt(varians)



## ----fjerne_objekter1-------------------------------------------------------------------------------------------------------
rm(stdavvik, varians)


## ----lagre_tabell-----------------------------------------------------------------------------------------------------------
stargazer(data,
          type = "text")


## ----lagre_deskriptiv_tabell, eval = FALSE----------------------------------------------------------------------------------
## stargazer(data,
##           type = "html",
##           out = "sem4_desktab.htm")


## ----laste_inn_rdata--------------------------------------------------------------------------------------------------------
# Bytt ut det som står i hermetegn med filbanen og filnavnet på din maskin:
load("../../data/ANES2016small.RData")


## ----bivariat_tabell--------------------------------------------------------------------------------------------------------
ANES2016small <- ANES2016small %>% 
  mutate(vote = recode(V2Trump,
                           `1` = "Trump",
                           `0` = "Clinton"), 
         gender = recode(female, 
                         `0` = "Male", 
                         `1` = "Female"))

# Sjekker at omkodingen ble riktig:
table(ANES2016small$female, ANES2016small$gender, useNA = "always")

# Sjekker at omkodingen ble riktig:
table(ANES2016small$V2Trump, ANES2016small$vote, useNA = "always")


## ----bivar_tabell_objekt----------------------------------------------------------------------------------------------------
krysstabell <- table(ANES2016small$vote, ANES2016small$gender)

krysstabell


## ----proporsjonstabell------------------------------------------------------------------------------------------------------
prop.table(krysstabell, margin = 2)


## ----kjikvadrattest---------------------------------------------------------------------------------------------------------
chisq.test(krysstabell)


## ----krysstabell------------------------------------------------------------------------------------------------------------
CrossTable(ANES2016small$vote, ANES2016small$gender, chisq = T)


## ----absoluttetall_plot, eval = FALSE---------------------------------------------------------------------------------------
ggplot(ANES2016small, aes(x = vote,
                          fill = gender)) + 
  geom_bar(position = "dodge") +
  labs(x = element_blank(),
       y = "Antall") +
  theme(legend.title = element_blank()) +
  theme_bw()


## ----andelsplot, eval = FALSE-----------------------------------------------------------------------------------------------
# Andeler:
ggplot(ANES2016small, aes(x = vote,
                          group = gender)) + 
  geom_bar(aes(y = ..prop..),
           position = "dodge") +
  labs(x = element_blank(),
       y = element_blank(),
       title = "Stemmegivning og kjønn") +
  theme(legend.title = element_blank()) +
  scale_y_continuous(labels = scales::percent) +
  theme_bw() + 
  facet_wrap(~gender)


## ----boxplot, eval = FALSE--------------------------------------------------------------------------------------------------
ggplot(data, aes(x = utdanning, fill = as.factor(kjonn))) +
  geom_boxplot()


## ----t_test-----------------------------------------------------------------------------------------------------------------
t.test(utdanning ~ as.factor(kjonn), data = data, var.equal = TRUE)


## ----t_test2----------------------------------------------------------------------------------------------------------------
# Enhalet test
# Tester om menn (verdi 1) har signifikant mindre utdanning enn kvinner:
t.test(utdanning ~ as.factor(kjonn), 
       data = data, 
       alternative = "less",
       var.equal = TRUE)

# Enhalet test
# Tester om menn (verdi 1) har signifikant mer utdanning enn kvinner:
t.test(utdanning ~ as.factor(kjonn), 
       data = data, 
       alternative = "greater",
       var.equal = TRUE)


# Tohalet test
# Tester om menn (verdi 1) har signifikant forskjellig utdanning fra kvinner:
t.test(utdanning ~ as.factor(kjonn), 
       data = data, 
       alternative = "two.sided",
       var.equal = TRUE)


## ----laste_inn_rdata2-------------------------------------------------------------------------------------------------------
load("../../data/FairFPSR3.RData")


## ----bivariat_korrelasjon---------------------------------------------------------------------------------------------------
cov(x = FairFPSR3$growth,
    y = FairFPSR3$inc_vote, 
    use = "pairwise.complete.obs")


## ----kovariansmatrise-------------------------------------------------------------------------------------------------------
cov(FairFPSR3,
    use = "pairwise.complete.obs")


## ----pairwise_missing_korrelasjon-------------------------------------------------------------------------------------------
# Korrelasjon mellom vekst og stemmeandel
cor(x = FairFPSR3$growth,
    y = FairFPSR3$inc_vote, 
    use = "pairwise.complete.obs")



## ----korrelasjon_sig_test---------------------------------------------------------------------------------------------------
# tester om korrelasojnen er statistisk signifikant
cor.test(FairFPSR3$inc_vote, 
         FairFPSR3$growth, 
         use = "pairwise.complete.obs")


## ----korrelasjonsmatrise----------------------------------------------------------------------------------------------------
cor(FairFPSR3, use = "pairwise.complete.obs")



## ----growth_stemmer_plot, eval = FALSE--------------------------------------------------------------------------------------
ggplot(data = FairFPSR3, 
       aes(x = growth, y = inc_vote)) +
  geom_point()


## ----endre_punktform, eval = FALSE------------------------------------------------------------------------------------------
ggplot(FairFPSR3, aes(x=growth, y=inc_vote)) +
  geom_point(shape=1) +
  theme_bw() +
  labs(x = "Percentage Change in Real DGP Per Capita",
       y = "Incumbent Party Vote Percentage")


## ----prediksjonslinje_plot, eval = FALSE------------------------------------------------------------------------------------
ggplot(FairFPSR3, aes(x=growth, y=inc_vote)) +
  geom_point(shape=1) +
  theme_bw() +
  labs(x = "Percentage Change in Real DGP Per Capita",
       y = "Incumbent Party Vote Percentage") +
  geom_smooth(method = "lm", color = "black")

ggsave("../../output/sem4_scatter3.png")



## ----generere_script, eval=FALSE, echo=FALSE--------------------------------------------------------------------------------
## knitr::purl("./doc/seminar4/seminar4.Rmd",
##             output = "./script/seminar4.R",
##             documentation = 1)

