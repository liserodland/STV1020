---
output:
  pdf_document: 
    keep_md: yes
  github_document: default
---

# Oppgaver til seminar 3

Legg gjerne til flere endringer på plottene i oppgavene enn det som står. Lek deg med ulike design ved å se hva som kommer opp når du taste `theme_` etterfulgt av tab, eller se på ulike farger. 

1.	Last inn datasettet gapminder.
2.	Opprett en ny variabel hvor landene i Asia får verdien 1, Amerika verdien 2, Oseania verdien 3, Europa verdien 4 og Afrika verdien 5. Undersøk om omkodingen er gjort riktig.
3.	Opprett en ny variabel hvor verdien på variablene `lifeExp` er ganget med 1000. Undersøk om du har omkodet riktig. 
4.	Velg ut tre variabler fra datasettet og opprett et nytt datasett bestående av disse. Inkluder kun observasjoner med verdien 1977 på variabelen year (Tips: Husk at R jobber sekvensielt så pass på hvilket argument som kommer først).
5.	Opprett et datasett bestående av europeiske land som har en forventet levealder på 75 år eller høyere. 
6.	Dataene i Gapminder er hentet inn hvert femte år. Vi er interessert i å vite om det er like mange observasjoner for hvert av årene. Lag et søylediagram (barplot) for å undersøke dette.
7.	Lag et histogram for variabelen GDP per capita (`gdpPercap`). 
8. Lag et density plot for variabelen GDP per capita (`gdpPercap`). Gjør linja rød, og sett tykkelsen til 2.0. *Hint: sjekk ut `color = ` og `size` argumentene i `geom_density`*. 
9. Lag et scatterplott over forventet levealder (`lifeExp`) og befolkningstall (`pop`).
10. Del opp observasjonene  i plottet fra oppgave 9 i ulike farger for hvert kontinent. 
11. Kan du bruke `facet_wrap()` for å gjøre plottet fra oppgave 9 mer oversiktig? 
12. Plott en graf (ei linje) over hvordan forventet levealder har endret seg over tid. 
13. Hvordan ser denne trenden i oppgave 12 ut på ulike kontinenter? Lag ei linje for hvert kontinent.
10.	Legg til en tittel på plottet fra forrige oppgave, samt nye labels til x- og y-aksen. Lagre plottet ditt som et objekt i environment, og lagre det deretter på pcen din, både som png- og pdf-fil. 


**Ekstraoppgave** 

Opprett et datasett hvor du kun inkluderer afrikanske land fra året 1952 som har en høyere forventet levealder en gjennomsnittet for alle afrikanske landene i 1952. (Datasettet skal bestå av 25 observasjoner. Får du flere eller mindre enheter har du gjort noe feil. Denne oppgaven er litt vanskelig, men prøv før du ser på fasiten) 



