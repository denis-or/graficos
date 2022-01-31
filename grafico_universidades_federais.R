# Pacotes -----------------------------------------------------------------
library(ggplot2)
library(sf)
library(geobr) # devtools::install_github("ipeaGIT/geobr", subdir = "r-package")
library(ggrepel) # devtools::install_github("slowkow/ggrepel")
library(ggtext) # remotes::install_github("wilkelab/ggtext")


# Importar ----------------------------------------------------------------

br <- geobr::read_state()
br_mun <- geobr::read_municipal_seat()

ies <-
  readr::read_delim(
    "SUP_IES_2019.CSV",
    delim = "|",
    escape_double = FALSE,
    locale = readr::locale(encoding = "ISO-8859-1"),
    trim_ws = TRUE
  )

# Arrumar -----------------------------------------------------------------

ies <- ies[, 1:12]

ies_map <- br_mun |>
  dplyr::left_join(ies, by = c("code_muni" = "CO_MUNICIPIO")) |>
  dplyr::filter(
    !is.na(NU_ANO_CENSO),
    TP_ORGANIZACAO_ACADEMICA == 1,
    TP_CATEGORIA_ADMINISTRATIVA == 1
  )

# Visualizar --------------------------------------------------------------

ggplot2::ggplot(data = ies_map) +
  ggplot2::geom_sf(
    data = br,
    ggplot2::aes(fill = name_region),
    color = "#BABABA",
    alpha = .4
  ) +
  ggplot2::geom_sf(size = .7) +
  ggrepel::geom_label_repel(
    ggplot2::aes(
      label = SG_IES,
      geometry = geom,
      color = name_region
    ),
    size = 3,
    stat = "sf_coordinates",
    box.padding = 0.3,
    max.overlaps = nrow(ies_map),
    show.legend = F
  ) +

  ggplot2::guides(fill = ggplot2::guide_legend(title = "Regiões")) +
  ggplot2::labs(title = "**Universidades federais brasileiras**",
                caption = "Visualização:<br>Denis de Oliveira Rodrigues<br>
                Github: denis-or<br>
                Fonte: Microdados Censo Educação Superior 2019") +
  ggplot2::theme_void() +
  ggplot2::theme(
    plot.title = ggtext::element_markdown(),
    plot.caption = ggtext::element_markdown()
  )






