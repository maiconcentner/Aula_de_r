#? Carregando as bibliotecas
library(dplyr)
library(lubridate)
library(stringr)
library(ggplot2)

#? Setando pasta de trabalho
setwd("D:\\Mestrado\\1Sem_23\\Ferramentas computacionais\\R_pokemon\\AulaR_imdb")

#? Pacote TIDYR
library(tidyr)

#? Carregando base

dados <- readr::read_rds("imdb.rds")

head(dados)
names(dados)

#? Carregando parte específicas da base

df <- dados %>% 
  select(titulo, orcamento, receita, receita_eua)

#? grafico com 10 primeiro filmes
#? barras
#? cada barra vem de uma coluna e aparece com uma cor diferente

#? pivot_longer

df_long <- df %>% 
  slice(1:10) %>% #seleciona os 10 primeiros
  tidyr::pivot_longer(2:4, values_to = "Valor", names_to = "Tipo de valor")

#? Gerando o gráfico

ggplot()+
  geom_col(data = df_long, aes(x = titulo, y = Valor, fill = `Tipo de valor`),
           position = position_dodge2())+
  theme_bw()+
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1.0)
  )
  

#? pivot_winder

df_winder <- df_long %>% 
  tidyr::pivot_wider(names_from = `Tipo de valor`, values_from = "Valor")

#? calculo correlação
library(reshape2)

correlacao <- df_winder %>% 
  select(orcamento, receita, receita_eua) %>% 
  cor()

correlacao
