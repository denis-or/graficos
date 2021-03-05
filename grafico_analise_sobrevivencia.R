#apago o tem antes
rm(list = ls())



Paciente <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29)
tempos <-c(1,2,3,3,3,5,5,16,16,16,16,16,16,16,16,1,1,1,1,4,5,7,8,10,10,12,16,16,16)
censura <- c(0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1,1,0,0,0,0,0)
tratamento <- c ("Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide")

#crio o dataframe
Dados_Hepatite <- data.frame(Paciente, tempos, censura, tratamento)

#faço a inspeção visual primária
head(Dados_Hepatite)

library(tidyverse)
ggplot(Dados_Hepatite)+
  geom_hline(yintercept = 16, linetype="dashed", color = "red")+
  geom_linerange(aes(x = Paciente, ymin = 0, ymax = tempos))+
  geom_point(aes(x = Paciente, y = tempos),shape = if_else(censura==0,19,1))+
  scale_x_continuous(breaks = seq(min(Paciente), max(Paciente),1))+
  scale_y_continuous(breaks = c(0,5,10,15,16))+
  annotate("text", x = 31, y = 13.8,
           hjust = 0, color = "red",
           size = 3.7,
           label = "final do estudo") +
  coord_flip()+
  theme(panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank())+
  labs(x="Paciente",y="Tempo em semanas", title = "Estudo sobre ...")


ggplot(Dados_Hepatite)+
  geom_hline(yintercept = 16, linetype="dashed", color = "red")+
  geom_linerange(aes(x = Paciente, ymin = 0, ymax = tempos))+
  geom_point(aes(x = Paciente, y = tempos),shape = if_else(censura==0,19,1))+
  scale_x_continuous(breaks = seq(min(Paciente), max(Paciente),1))+
  scale_y_continuous(breaks = c(0,5,10,15,16))+
  coord_flip()+facet_wrap(~ censura)+
  theme(panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank())+
  labs(x="Paciente",y="Tempo em semanas", title = "Estudo sobre ...")
