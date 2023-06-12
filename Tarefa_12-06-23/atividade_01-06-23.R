# TAREFA DO DIA 01/06/2023

# CAREGANDO PACOTES
library(dplyr)
library(ggplot2)

# SETANDO PASTA DE TRABALHO
setwd("D:\\Mestrado\\1Sem_23\\Ferramentas computacionais\\R_pokemon")

# CAREGANDO BASE DE DADOS

dados <- read.csv("Pokemon_full.csv")

## LIÇAO DIA 01/06

df <- dados %>%
  group_by(type) %>% 
  summarise(
    media_h = mean(height),
    media_w = mean(weight)
  ) 

fator <- max(df$media_w)/max(df$media_h)
fator

df$media_h <- df$media_h*fator

df %>% 
  tidyr::pivot_longer(cols = c("media_h", "media_w"), names_to = "tipo", values_to = "media") %>% 
  ggplot() +
  geom_line(aes(x = type, y = media, color = tipo, group = tipo), size = 1.2) +
  geom_point(aes(x = type, y = media, color = tipo, group = tipo), size = 2) +  # Adiciona os pontos
  scale_y_continuous(
    name = "Peso",
    limits = c(0, 2500),
    sec.axis = sec_axis(~./fator, name = "Altura"),
    expand = c(0, 0)
  ) +
  scale_color_manual(values = c("black", "#377EB8"), labels = c("Altura média", "Peso médio")) +
  scale_fill_manual(values = c("black", "#377EB8"), labels = c("Altura média", "Peso médio")) +
  labs(x = "Tipo do Pokémon", title = "Média de Altura e Peso por Tipo de Pokémon") +  # Altera o nome do eixo x e adiciona título
  theme_classic() +
  theme(
    panel.background = element_rect(fill = "#F0F0F0", color = "black"),
    panel.grid.major = element_line(color = "#CCCCCC"),
    panel.grid.minor = element_blank(),
    plot.background = element_rect(fill = "#F0F0F0"),
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 14),
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_blank(),  # Remove o título da legenda
    legend.position = "bottom"  # Posiciona a legenda na parte inferior do gráfico
  )


# BONUS :)

df <- dados %>%
  group_by(type) %>% 
  summarise(
    media_h = mean(height),
    media_w = mean(weight)
  ) 

altura_plot <- df %>%
  arrange(desc(media_h)) %>%
  mutate(tipo = factor(type, levels = unique(type))) %>%
  ggplot() +
  geom_col(aes(x = tipo, y = media_h, fill = tipo), width = 0.5) +
  scale_fill_manual(values = rep("gray", n_distinct(df$type)), labels = c("Altura média"), guide = FALSE) +
  labs(x = "Tipo do Pokémon", y = "Altura", title = "Rank da Média de Altura por Tipo de Pokémon") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "none"
  )

peso_plot <- df %>%
  arrange(desc(media_w)) %>%
  mutate(tipo = factor(type, levels = unique(type))) %>%
  ggplot() +
  geom_col(aes(x = tipo, y = media_w, fill = tipo), width = 0.5) +
  scale_fill_manual(values = rep("black", n_distinct(df$type)), labels = c("Peso médio"), guide = FALSE) +
  labs(x = "Tipo do Pokémon", y = "Peso", title = "Rank da Média de Peso por Tipo de Pokémon") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "none"
  )

library(patchwork)
altura_plot / peso_plot + plot_layout(ncol = 1)
