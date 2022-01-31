# Pacotes -----------------------------------------------------------------
library(readr, quietly = T, warn.conflicts = F)
library(dplyr, quietly = T, warn.conflicts = F)
library(magrittr, quietly = T, warn.conflicts = F)
library(ggplot2, quietly = T, warn.conflicts = F)

# Importar ----------------------------------------------------------------

bd <- data.frame(
  stringsAsFactors = FALSE,
  atividade = c("Trabalho rodoviário de carga, exceto produtos perigosos e \n mudanças, intermunicipal, interstadual e internacional","Condomínios prediais",
                "Comércio varejista de mercadorias em geral, com predominância \n de produtos alimentícios - supermercados",
                "Construção de edifícios","Limpeza em prédios e em domicílios",
                "Atividades de atendimento hospitalar, exceto pronto socorro e \n unidades para atendimento a urgências",
                "Administração pública em geral","Restaurantes e similares",
                "Atividades de vigilância e segurança privada",
                "Transporte rodoviário coletivo de passageiros, com itinerário \n fixo, municipal","Criação de bovinos para corte",
                "Fabricação de açúcar bruto",
                "Comércio varejista de combustíveis para veículos automotores",
                "Atividades de associações de defesa de direitos sociais",
                "Lanchonetes, casas de chá, sucos e similares"),
  ano2019 = c(1487,1388,1276,1222,
              1216,986,974,940,917,909,695,618,574,482,470),
  ano2020 = c(2166,1552,1548,1665,
              1479,1395,1228,1065,1388,1242,543,602,761,523,506),
  proporcao = c(0.456624075319435,
                0.118155619596542,0.213166144200627,0.362520458265139,
                0.216282894736842,0.414807302231237,0.260780287474333,
                0.132978723404255,0.19745143740,0.366336633663366,-0.218705035971223,
                -0.0258899676375405,0.325783972125436,
                0.0850622406639004,0.0765957446808511)
)


# Visualizar --------------------------------------------------------------

ggplot(data = bd %>% mutate(atividade = forcats::fct_reorder(atividade, ano2019))) +
  geom_segment(
    aes(
      x = ano2019,
      xend = ano2020,
      y = atividade,
      yend = atividade
    ),
    color = "gray",
    size = 3.2,
    alpha = .5
  ) +

  # 2019
  geom_point(aes(ano2019, atividade), color = "#F59300", size = 3.5) +
  geom_text(
    data = bd %>%
      filter(
        atividade != "Fabricação de açúcar bruto",
        atividade != "Criação de bovinos para corte"
      ),
    aes(x = ano2019, y = atividade, label = ano2019),
    hjust = 1.5,
    color = "#F59300",
    nudge_x = .1,
    size = 4,
    family = "Arial Narrow"
  ) +
  geom_text(
    data = bd %>% filter(
      atividade %in% c("Fabricação de açúcar bruto", "Criação de bovinos para corte")
    ),
    aes(x = ano2019, y = atividade, label = ano2019),
    color = "#F59300",
    hjust = -.5,
    size = 4,
    family = "Arial Narrow"
  ) +



  # 2020
  geom_point(aes(ano2020, atividade), color = "#974602", size = 3.5) +
  geom_text(
    data = bd %>% filter(
      atividade != "Fabricação de açúcar bruto",
      atividade != "Criação de bovinos para corte"
    ),
    aes(x = ano2020, y = atividade, label = ano2020),
    hjust = -.5,
    color = "#974602",
    nudge_x = .1,
    size = 4,
    family = "Arial Narrow"
  ) +
  geom_text(
    data = bd %>% filter(
      atividade %in% c("Fabricação de açúcar bruto", "Criação de bovinos para corte")
    ),
    aes(x = ano2020, y = atividade, label = ano2020),
    color = "#974602",
    hjust = 1.5,
    size = 4,
    family = "Arial Narrow"
  ) +

  annotate(
    "text",
    x = 1400,
    y = 15,
    vjust = -.5,
    label = "desligamentos por \n morte em 2019",
    color = "#F59300"
  ) +
  annotate(
    "text",
    x = 2100,
    y = 15,
    vjust = -.5,
    label = "desligamentos por\nmorte em 2020",
    color = "#974602"
  ) +

  #coluna da variação
  geom_text(
    aes(
      x = 2300,
      y = atividade,
      label = scales::percent(proporcao)
    ),
    hjust = 0,
    nudge_x = .1,
    size = 4,
    family = "Arial Narrow"
  ) +
  annotate(
    "text",
    x = 2340,
    y = 15,
    vjust = -.5,
    label = "Variação \n(%)"
  ) +

  theme_minimal() +
  theme(
    plot.title = element_text(
      size = 18,
      face = "bold",
      color = "#22568B",
      family = "Arial Narrow"
    ),
    plot.title.position = "plot",
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_line(linetype = 2, color = "gray85"),
    panel.grid.major.y = element_blank(),
    axis.text = element_text(size = 11, family = "Arial Narrow"),
    plot.margin = unit(c(0.35, 2, 0.3, 0.35), "cm")
  ) + #t, r, b, l
  scale_x_continuous(breaks = seq(400, 2200, 200)) +

  # definição da área para plotagem da coluna fora
  coord_cartesian(xlim = c(400, 2200),
                  ylim = c(1, 15),
                  clip = "off") +

  # Título e afins
  labs(
    x = "",
    y = "",
    title = "Os 15 setores com mais desligamentos por morte em 2019 e 2020",
    subtitle = "Transporte, serviços prediais, comércio e saúde tiveram fortes aumentos nas mortes de funcionários com emprego formal \n\n\n"
  )
