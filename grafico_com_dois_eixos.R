# Pacotes -----------------------------------------------------------------
library(ggplot2)
library(data.table)

# Importar ----------------------------------------------------------------

wfd <- structure(list(Year = 1994:2016,
                      Kcalpd = c(86L, 91L, 98L, 107L,
                                 116L, 126L, 123L, 112L,
                                 103L, 102L, 103L, 92L,
                                 77L, 59L, 43L, 29L,
                                 19L, 14L, 13L, 12L,
                                 12L, 10L, 9L),
                      Thtonnes = c(728.364,757.467,
                                   780.423, 792.756,
                                   701.685, 720.71,
                                   677.292, 761.649,
                                   668.218, 679.042,
                                   974.355, 1005.035,
                                   1123.09, 1055.07,
                                   1092.498, 1100.654,
                                   899.767, 1018.462,
                                   1046.096, 1084.173,
                                   1158.217, 802.194,
                                   276.773)),
                 row.names = c(NA, -23L),
                 class = "data.frame",
                 .Names = c("Year","Kcalpd", "Thtonnes")
)

# Arrumar -----------------------------------------------------------------

wfd.m <- reshape2::melt(wfd, id.vars = 1)


# Visualizar --------------------------------------------------------------

ggplot2::ggplot(wfd.m, ggplot2::aes(Year, value, fill = variable)) +
  ggplot2::geom_col(position = "dodge") +
  ggplot2::scale_fill_manual(values = c("Thtonnes" = "#440154FF", "Kcalpd" = "#FDE725FF")) +
  ggplot2::facet_wrap(~ variable, ncol = 1, scales = "free_y") +
  ggplot2::theme(legend.position = "none") +
  ggplot2::ylab("your label here")


scaleFactor <- max(wfd$Thtonnes) / max(wfd$Kcalpd)

ggplot2::ggplot(wfd, ggplot2::aes(x = Year,  width = .4)) +
  ggplot2::geom_col(
    ggplot2::aes(y = Thtonnes),
    fill = "#440154FF",
    position = ggplot2::position_nudge(x = -.4)
  ) +
  ggplot2::geom_line(ggplot2::aes(y = Kcalpd * scaleFactor),
                     color = "#FDE725FF",
                     size = 2) +
  ggplot2::scale_y_continuous(
    name = "Thtonnes (Rice + Wheat)",
    sec.axis = ggplot2::sec_axis( ~ . / scaleFactor, name = "Kcal per day")
  ) +
  ggplot2::scale_x_continuous(breaks = seq(1994, 2016, 4)) +
  ggplot2::theme(
    axis.title.y.left = ggplot2::element_text(color = "#440154FF"),
    axis.text.y.left = ggplot2::element_text(color = "#440154FF"),
    axis.title.y.right = ggplot2::element_text(color = "#FDE725FF"),
    axis.text.y.right = ggplot2::element_text(color = "#FDE725FF")
  ) +
  ggplot2::labs(title = "Food Security in Venezuela, Cereals Production and Food Gap",
                x = ggplot2::element_blank()) +
  ggplot2::theme_get()








