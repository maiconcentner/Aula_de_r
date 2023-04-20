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

nrow(dados)
dados %>% nrow()
dados %>% nrow(.)

#? Algumas funções da biblioteca dplyr

#? A função filter seleciona linhas com base em um teste
filter(dados, type == "grass")

#? podemos usar o seguinte comando também
#dados %>% filter(type == "grass")


#Filtrar tipo fogo ou água
filter(dados, type == "fire"|type =="water")

#dados %>% filter(type == "grass")
#TODO Vamos filtrar todos os pokemons do tipo fogo ou água

#TODO Vamos filtrar todos os pokemons que tem  "fly"
filter(dados,secundary.type == "flying")
#TODO Vamos filtrar todos os pokemons que tem  "bee" ou "saur"
filter(dados,names == "bee"|names=="saur")
texto_filtrado <- dados[str_detect(dados$name, "bee|saur"),]

# Imprimir o resultado
texto_filtrado

