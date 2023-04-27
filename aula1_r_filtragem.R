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

#? Função mutate modifica ou cria uma coluna com base em outros
mutate(dados, height2 = 2*height)

dados %>% 
  mutate (
    height2 = 2*height,
    speed2 = 2*speed,
    bee = grepl("bee", name)
  )
dados %>% head

#?Função arrange (organiza o data frame com base em colunas)
#?head mostra o começo da tabela e tail mostra o final
dados %>% 
  arrange(name) %>% 
    head()

dados %>% 
  arrange(name) %>% 
    tail()

#? organizando em forma descrescente
dados %>% 
  arrange(desc(name)) %>% 
    head()

#? Realizando algumas análises

#? summarise resume os dados

dados %>% 
  summarise(
    media_altura = mean(height),
    media_peso = mean(weight)
  )

#realizando a análise para grupos
dados %>% 
  group_by(type) %>% 
    summarise(
      media_altura = mean(height),
      media_peso = mean(weight),
      N = n()
    ) %>% 
        arrange(media_altura, media_peso)

#Exercício: filtrar os pokemons que tem o peso acima da média da altura do seu type
#primeiramente vou agrupar os pokemons por tipo
dados %>%
  group_by(type) %>% 
  mutate(
    media_altura = mean(height)
  )
#mesmo comando com o filtros na altura e peso

dados %>% 
  group_by(type) %>% 
  mutate(
    media_altura = mean(height),
    media_peso = mean(weight)
  ) %>% 
  filter(height > media_altura, weight > media_peso) %>%
  select(-media_altura, -media_peso) %>% View 
#aqui estou excluindo a coluna criada media_altura
  
#a função rowaise realiza operação linha por linha

#LIÇÃO : CRIAR UMA COLUNA COM A TRANSFORMAÇÃO Z-score PARA a ALTURA por type 
#devemos subtrair a média da amostra do valor de cada observação e dividir
#pelo desvio padrão da amostra