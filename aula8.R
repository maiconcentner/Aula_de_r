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

#criando uma função

f <- function(x){
    if (x <= 15){
      return("Executei essa ação")
    }else{
      return("Executei aquela ação")
    }
}

x1 <- 20

f(x1)

#! O codigo abaixo nao funciona
dados %>% 
  mutate(
    nova_var = f(height)
  ) %>% 
    select(height, nova_var) %>% head(30)

#* O código abaixo funciona
dados %>% 
  rowwise() %>% 
    mutate(
      nova_var = f(height)
    ) %>% 
        select(height, nova_var) %>% head(30)

#? Uma outra função para aceitar vetor
f2 <- function(y){
    resposta <- c()
    
    for(i in 1:length(y)){
      if (y[i] <= 15) {
        resposta[i] <- "baixinhho"
        
      }else{
        resposta[i] <- "altão"
      }
    }
    return(resposta)
}

x2 <- c(10,14,15,16,20)

f2(x2)

#? Aplicando na base de dados

dados %>% 
  mutate(
    tamanho = f2(height)
  ) %>% head

#? Join

df_means <- dados %>% 
  group_by(type) %>% 
  summarise(
    media_h = mean(height),
    media_w = mean(weight)
  )

df_means

#? Excluindo os grupos que começam com "g"

df_means <- df_means %>%
  filter(!grepl("^g",type))

#? Criando um grupo que não existe

novo_grupo <- data.frame(
  type = "Vozes da minha cabeça",
  media_H = 1000,
  media_w = 400.82
)

#? Adicionar o grupo

df_means <- rbind(df_means, novo_grupo)

#? full join

df <- full_join(dados, df_means, by="type")
View(df)

#? inner join

df <- inner_join(dados, df_means, by="type")
View(df)

#? left

df <- left_join(dados, df_means, by="type")
View(df)

#? right

df <- right_join(dados, df_means, by="type")
View(df)










