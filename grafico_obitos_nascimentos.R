# Post no site:
# http://denis-or.com.br/post/obitos_nascimentos_brasil_2000_2021/
#
# Letra:
# https://fonts.google.com/specimen/Inconsolata?query=inco

# Importar ----------------------------------------------------------------



parte_final <- readRDS('man/bd_nasc_ob_2000_2021.rds')



# Visualizar --------------------------------------------------------------

parte_final |>
  ggplot2::ggplot() +
  ggplot2::geom_line(ggplot2::aes(mes_ano, nasc, group = 1),
                     color = "#BA5800",
                     size = .8) +
  ggplot2::geom_line(ggplot2::aes(mes_ano, ob, group = 1),
                     color = "black",
                     size = .8) +
  ggplot2::geom_segment(
    ggplot2::aes(
      x = mes_ano,
      xend = mes_ano,
      y = ob,
      yend = nasc
    ),
    size = .05,
    color = "#BA5800"
  ) +
  ggplot2::scale_y_continuous(labels = scales::comma) +
  ggplot2::scale_x_date(
    labels = c(lubridate::year(as.Date("2000-01-01")):lubridate::year(as.Date("2021-08-30"))),
    breaks = seq.Date(as.Date("2000-01-01"), as.Date("2021-08-30"), "year"),
    expand = c(0.01, 0),
    sec.axis = ggplot2::dup_axis()
  ) +
  ggplot2::labs(x = "YEAR",
                y = "NUMBER") +
  # ggplot2::labs(x = "\nANO",
  #               y = "Nº ABSOLUTO") +
  ggplot2::theme_classic() +
  ggplot2::theme(
    axis.line.x = ggplot2::element_blank(),
    axis.line.y = ggplot2::element_blank(),
    axis.text = ggplot2::element_text(size = 12, family = "Inconsolata"),
    axis.title.x = ggplot2::element_text(hjust = 0, family = "Inconsolata"),
    axis.ticks.length = grid::unit(.25, "cm"),
    plot.caption = ggplot2::element_text(hjust = 0, family = "Inconsolata"),
    plot.margin = grid::unit(c(0.2, 0, 0.2, 0.2), "cm"),#TRBL
    plot.title = ggplot2::element_text(
      family = "Times New Roman",
      face = "bold",
      size = 22,
      hjust = .4,
    ),
    plot.subtitle = ggplot2::element_text(
      family = "Times New Roman",
      size = 14,
      hjust = .4,
      face = "italic"
    ),
    plot.caption.position = "plot",
    axis.title.y = ggplot2::element_text(
      hjust = 1,
      family = "Inconsolata",

    ),

  ) +
  ggplot2::annotate(
    "text",
    x = as.Date("2000-01-01"),
    y = 300000,
    # label = "NASCIMENTOS",
    label = "LIVE BIRTHS",
    color = "#BA5800",
    hjust = 0,
    size = 5,
    family = "Inconsolata",
    fontface = "bold"
  ) +
  ggplot2::annotate(
    "text",
    x = as.Date("2000-01-01"),
    y = 60000,
    # label = "ÓBITOS",
    label = "DEATHS",
    color = "black",
    hjust = 0,
    size = 5,
    family = "Inconsolata",
    fontface = "bold"

  ) +
  ggplot2::annotate(
    "text",
    x = as.Date("2021-04-30"),
    y = 75000,
    # label = "ÓBITOS",
    label = "2020 and 2021:\nPreliminary data",
    color = "black",
    hjust = 1,
    size = 3,
    family = "Times New Roman",

  ) +
  ggplot2::annotate(
    geom = "curve", x = as.Date("2020-08-30"), y = 60000, xend = as.Date("2021-01-01"), yend = 50000,
    curvature = -.3, arrow = ggplot2::arrow(length = grid::unit(2, "mm"))
  ) +
  ggplot2::annotate(
    geom = "curve", x = as.Date("2020-05-01"), y = 60000, xend = as.Date("2020-01-01"), yend = 50000,
    curvature = .3, arrow = ggplot2::arrow(length = grid::unit(2, "mm"))
  ) +
  ggplot2::labs(
    title = "LIFE vs. DEATH - BRAZIL",
    # title = "Nascimentos X Óbitos",
    subtitle = "TIME SERIES FROM 2000 TO 2021",
    # subtitle = "SÉRIE TEMPORAL DE 2000 A 2021",
    caption = "Source:\n Sistema de Informação de Mortalidade (SIM)\n Sistema de Informação de Nascidos Vivos (SINASC)\n\nVisualization:\n Denis Rodrigues (denis-or.com.br)")
    # caption = "Fonte:\n Sistema de Informação de Mortalidade (SIM)\n Sistema de Informação de Nascidos VIvos (SINASC)\n\nVisualização: Denis Rodrigues (denis-or.com.br)")

