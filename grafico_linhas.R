
#1ª parte eu defino a pasta onde a planilha está
setwd('/docs/Downloads/')

#2ª parte: chamo um pacote para ajudar a configurar. Caso não tenha estes pacotes,
# peça ao R para instalar: install.packages(c("tidyr","dplyr","ggplot2","readxl"))
library(tidyr)
library(dplyr)
library(ggplot2)
library(readxl)

#3ª parte: eu importo a planilha, definindo inclusive o intervalo de dados que a tabela está.
df <- read_excel('TMI_2009_2017.xlsx', sheet = 1, range = "E3:K12")

#4ª parte: eu altero algumas configurações pra ficar mais facil plotar o gráfico
df <- df %>% 
  mutate(Ano = as.character(Ano)) %>% 
  pivot_longer(cols = Branca:Total, values_to = "tx")

#5ª parte: ploto o gráfico
df %>% 
  ggplot(aes(x = Ano, y = tx, color = name, group = name))+
  geom_line()+
  geom_point(aes(shape = name, size = 3))+
  labs(x = "Ano do óbito",
       y = "TMI",
       color = "Cor",
       shape = "Cor")+
  guides(shape = guide_legend()) +
  theme(
    panel.border = element_rect(fill = NA, colour = "black"),
    panel.background = element_rect(fill = NA),
    panel.grid.minor = element_blank(), 
    panel.grid.major = element_blank()
  )


