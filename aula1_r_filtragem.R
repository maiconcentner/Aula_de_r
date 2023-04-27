#? Comentários com "?" são comentários normais
#! Comentários com "!" são códigos errados
#* Comentários com "*" são para correções
# Apenas "#" são códigos comentados (ignorados)
#TODO é algo para fazermos juntos

#? Vamos adicionar a biblioteca dplyr 
library(dplyr)

#? E outras bibliotecas que serão úteis
library(lubridate)
library(stringr)

#? setando diretório de trabalho
setwd("d:\\Mestrado\\1Sem_23\\Ferramentas computacionais\\R_pokemon")

#? Vamos começar com os dados de pokemon
#? https://www.kaggle.com/datasets/igorcoelho24/pokemon-all-generations/versions/1?resource=download
dados <- read.csv("Pokemon_full.csv")
head(dados) #? vê as primeiras linhas de dados


#? A biblioteca dplyr possui o operador "pipe"
#? dado por  %>%
#? Ele "pega" tudo que está à esquerda dele e coloca como primeiro elemento
#? da função à direita.
#? Também é possível usar o operador "."
#? para especificar onde ele deve substituir.


#? Exemplo: contar o número de linhas de dados

dados 
nrow(dados) 
dados %>% nrow()
dados %>% nrow(.)

#? Algumas funções da biblioteca dplyr

#? A função filter seleciona linhas com base em um teste
filter(dados, type == "grass")

#? podemos usar o seguinte comando também
#dados %>% filter(type == "grass")
dados %>% filter(type == "grass")

#Filtrar tipo fogo ou água
df_fogo_ou_agua <- dados %>% filter(type == "fire"|type =="water")

#dados %>% filter(type == "grass")
#TODO Vamos filtrar todos os pokemons do tipo fogo ou água
dados %>% filter(grepl("water",type) | grepl("fire"))

#TODO Vamos filtrar todos os pokemons que tem  "fly"
dados %>% filter(grepl("fly", name))
#TODO Vamos filtrar todos os pokemons que tem  "bee" ou "saur"
dados %>% filter(grepl("bee", name) | grepl("saur", name))

#? A função pull devolve um vetor
dados %>% 
  filter(type == "fire") %>% 
  pull(secundary.type) %>% 
  unique

#? A função select retorna uma coluna e não um vetor
dados %>% select(type) %>% unique

#? Selecionando duas colunas com o select
dados %>%  select(type, secundary.type) %>% unique



