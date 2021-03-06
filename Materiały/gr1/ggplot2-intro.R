library(ggplot2)
library(dplyr)

gd <- read.csv("../../data/grants_small.csv", stringsAsFactors = FALSE)
# edit(gd)
# summary(gd)

# scoping w R
stats::filter
dplyr::filter

# factor i character w R
x_c <- c("a", "b", "a")
x_f <- factor(x_c)

as.numeric(x_c)
as.numeric(x_f)

# manipulowanie danymi
gd[["budget"]]

gd$budget

toupper(budget) # brak takiej zmiennej
toupper(gd[["budget"]])
mutate(gd, budget_large = toupper(budget))
gd[["institution"]]
pull(gd, institution)

lapply(strsplit(gd[["institution"]], ", "), first)

lapply(strsplit(gd[["institution"]], ", "), function(i) i[1])

sapply(strsplit(gd[["institution"]], ", "), function(i) i[1])

mutate(gd, 
       budget_numeric = as.numeric(gsub(pattern = "[a-z: ]", "", 
                                            budget, 
                                            ignore.case = TRUE)),
       institution = sapply(strsplit(gd[["institution"]], ", "), 
                            function(i) i[1])) %>% 
  group_by(institution) %>% 
  summarise(mean_budget = mean(budget_numeric)) %>% 
  filter(institution %in% c("Politechnika Warszawska",
                            "Politechnika Łódzka",
                            "Akademia Górniczo-Hutnicza im. St.Staszica w Krakowie",
                            "Uniwersytet Wrocławski")) %>% 
  ggplot(aes(x = institution, y = mean_budget)) +
  geom_col() +
  coord_flip()



# notatki moje
toupper(budget) # error, nie ma takiej zmiennej
toupper(budget)
# ale to poniżej git
mutate(gd, budget_large = toupper(budget))

as.numeric(gsub(pattern = "[a-z: ]","", gd$budget, ignore.case = TRUE))

mutate(gd, budget_numeric = as.numeric(gsub(pattern = "[a-z: ]","", budget, ignore.case = TRUE)) )



pull(gd, institution) # wariant dla gd$institution

lapply(strsplit(gd[['institution']],", "), first)
# lapply(strsplit(gd[['institution']],", "), function(i) i[1]) - drugi sposób

mutate(gd, budget_numeric = as.numeric(gsub(pattern = "[a-z: ]","", budget, ignore.case = TRUE)),
       institution = sapply(strsplit(gd[['institution']],", "), function(i) i[1])) %>% 
  group_by(institution) %>% 
  summarise(mean_budget = mean(budget_numeric)) %>% 
  filter(institution %in% c("Politechnika Warszawska",
                            "Politechnika Łódzka",
                            "Akademia Górniczo-Hutnicza im. St.Staszica w Krakowie")) %>% 
  ggplot(aes(x= institution, y= mean_budget)) +
  geom_col() +
  coord_flip()

# %>% Wpisuje do funckcji argument z lewej jako pierwszy nienazwany argument

