# Post no site:
# http://denis-or.com.br/post/
#
#
# Importar ----------------------------------------------------------------

sim <- readRDS('man/bd_nasc_ob_2000_2021.rds') |>
  dplyr::mutate(mes = factor(lubridate::month(mes_ano, abbr = T, label = T)))

# Arrumar -----------------------------------------------------------------

banco <- dplyr::filter(sim, mes_ano < as.Date("2020-01-01")) |>
  dplyr::mutate(mes = forcats::fct_rev(mes))
  

banco_2020 <- dplyr::filter(sim, dplyr::between(mes_ano,
                                                as.Date("2020-01-01"),
                                                as.Date("2020-12-31"))) |>
  dplyr::mutate(mes = forcats::fct_rev(mes))

banco_2021 <- dplyr::filter(sim, dplyr::between(mes_ano,
                                                as.Date("2021-01-01"),
                                                as.Date("2021-08-30"))) |>
  dplyr::mutate(mes = forcats::fct_rev(mes))


media_geral <- mean(banco$ob)

media_mes <- banco |>
  dplyr::group_by(mes) |>
  dplyr::summarise(media_mes = mean(ob))

# Visualizar --------------------------------------------------------------


ggplot2::ggplot() +
  ggplot2::geom_jitter(
    data = banco,
    ggplot2::aes(ob, mes, color = ob),
    alpha = .4,
    size = 3,
    height = .1,
    # show.legend = T

  ) +
  ggplot2::geom_point(
    data = banco_2020,
    ggplot2::aes(ob, mes, fill = "A"),
    colour = "transparent",
    shape = 21,
    size = 5
  ) +
  ggplot2::geom_point(
    data = banco_2021,
    ggplot2::aes(ob, mes, fill = "B"),
    colour = "transparent",
    shape = 21,
    size = 5
  ) +
  ggplot2::geom_point(
    data = media_mes,
    ggplot2::aes(media_mes, mes, fill = "C"),
    colour = "transparent",
    shape = 21,
    size = 5
  ) +
  ggplot2::scale_color_continuous(
    type = "viridis",
    name = "Deaths\n\n2000 and 2019",
    limits = c(min(banco$ob), max(banco$ob)),
    breaks = seq(75e3, 125e3, 15e3), 
    labels = scales::label_number(scale = 1 / 1000, suffix = "k"),
    guide = ggplot2::guide_colourbar(
      order = 1,
      direction = "horizontal",
      barwidth = 8,
      barheight = .5,
      title.position = "top",
      draw.ulim = FALSE,
      draw.llim = FALSE
      )
  ) +
  ggplot2::scale_fill_manual(
    name = "",
    values = c("A" = "orange", "B" = "red", "C" = "black"),
    labels = c(
      "2020 (Preliminary)",
      "2021 (Preliminary)",
      "Monthly average\n 2000 to 2019"
    )
  ) +
  ggplot2::scale_x_continuous(labels = scales::label_number(scale = 1 / 1000, suffix = "k")) +
  ggplot2::scale_y_discrete(labels = rev(month.name)) +

  ggplot2::theme_bw() +
  ggplot2::theme(
    legend.text = ggplot2::element_text(size = 12, family = "Cambria"),
    legend.title = ggplot2::element_text(size = 12, family = "Cambria"),
    axis.title = ggplot2::element_text(size = 15, family = "Cambria"),
    axis.text = ggplot2::element_text(size = 15, family = "Cambria"),
    plot.title = ggplot2::element_text(
      family = "Cambria",
      face = "bold",
      size = 22,
      hjust = .4
    ),
    plot.caption.position = "plot",
    plot.caption = ggplot2::element_text(size = 12, family = "Cambria"),
  ) +
  ggplot2::labs(
    title = "DEATHS - BRAZIL",
    x = "Total number of deaths",
    y = "Month of death",
    caption = "Source:\n Sistema de Informação de Mortalidade (SIM)\n\nVisualization:\n Denis Rodrigues (denis-or.com.br)") +
  
  ggplot2::geom_vline(
    ggplot2::aes(
      xintercept = media_geral, 
      linetype = "Overall average\n2000 to 2019"
    ),
  size = .8) +
  ggplot2::scale_linetype_manual(name = "",values = 2) +
  ggplot2::annotate(
    "text",
    x = 125e3,
    y = 12,
    family = "Cambria",
    size = 4,
    color = "gray20",
    lineheight = .9,
    label = glue::glue("Overall average:\n{round(media_geral, 0)} deaths")
  )+
  ggplot2::geom_curve(
    ggplot2::aes(
    x = 125e3,
    y = 11.6, 
    xend = 95e3, 
    yend = 11.7),
    arrow = ggplot2::arrow(length = ggplot2::unit(0.1, "inch")), size = 0.4,
    color = "gray20",
    curvature = -0.2
  ) +
  ggplot2::annotate(
    "text",
    x = 18e4,
    y = 11,
    family = "Cambria",
    size = 4,
    color = "gray20",
    lineheight = .9,
    label = glue::glue("Maximum value:\n{max(banco_2021$ob)} deaths")
  )+
  ggplot2::geom_curve(
    ggplot2::aes(
    x = 19e4,
    y = 11, 
    xend = 208e3, 
    yend = 10.3),
    arrow = ggplot2::arrow(length = ggplot2::unit(0.1, "inch")), size = 0.4,
    color = "gray20",
    curvature = -0.3
  )



