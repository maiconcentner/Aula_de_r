#? Carregando as bibliotecas
library(dplyr)
library(lubridate)
library(stringr)
library(ggplot2)

#? Setando pasta de trabalho
setwd("D:\\Mestrado\\1Sem_23\\Ferramentas computacionais\\R_pokemon")

#? Carregando base de dados
dados <- read.csv("Pokemon_full.csv")

#? Refazendo a tarefa da aula passada
# Criar uma coluna com a transformação Z-score para a altura por type

df <- dados %>% 
  group_by(type) %>% 
  mutate(
    z_height = (height - mean(height)) / sd(height)
  )

dados %>% pull(type) %>% unique

#? Plotagem do gráfico
ggplot(df)+
  geom_density(aes(x = z_height, color = type))+
  theme_bw()
