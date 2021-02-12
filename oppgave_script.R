install.packages("essurvey")
library(essurvey)

set_email("liserodland@gmail.com")

show_countries()
show_country_rounds("Norway")

ess_nor <- import_country(country = "Norway",
                          rounds = c(1:9)) 

select(idno, 
       influence_pol = psppipla,
       vote, 
       polintr, 
       age = agea,
       gender = gndr)


library(haven)
library(tidyverse)
library(stargazer)
ess_nor <- read_stata("ESS/ESS9NO.dta") %>% 
  select(idno, 
         influence = psppipla,
         vote, 
         polintr, 
         happy,
         age = agea,
         gender = gndr) %>% 
  filter(complete.cases(.))

save(ess_nor, file = "ess_nor.RData")

ess_nor$happy
ess_nor$influence_pol

model_ess <- lm(happy ~ influence, 
                data = ess_nor,
                na.action = "na.exclude")
stargazer(model_ess, 
          type = "html",
          out = "output/ess_table.htm")


ess_nor <- ess_nor %>%
  mutate(fitted = fitted(model_ess))

ggplot(data = ess_nor) +
  geom_line(aes(x = influence, y = fitted)) +
  geom_point(aes(x = influence, y = happy), position = "dodge")

ggsave(filename = "output/ess_nor_fig.jpg")

load("ess_nor.RData")
