Paciente <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29)
tempos <-c(1,2,3,3,3,5,5,16,16,16,16,16,16,16,16,1,1,1,1,4,5,7,8,10,10,12,16,16,16)
censura <- c(0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1,1,0,0,0,0,0)
tratamento <- c ("Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Controle","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide","Esteroide")

#crio o dataframe
Dados_Hepatite <- data.frame(Paciente, tempos, censura, tratamento)

#faço a inspeção visual primária
head(Dados_Hepatite)



ggplot2::ggplot(Dados_Hepatite) +
  ggplot2::geom_hline(yintercept = 16,
                      linetype = "dashed",
                      color = "red") +
  ggplot2::geom_linerange(ggplot2::aes(x = Paciente, ymin = 0, ymax = tempos)) +
  ggplot2::geom_point(ggplot2::aes(x = Paciente, y = tempos),
                      shape = dplyr::if_else(censura == 0, 19, 1)) +
  ggplot2::scale_x_continuous(breaks = seq(min(Paciente), max(Paciente), 1)) +
  ggplot2::scale_y_continuous(breaks = c(0, 5, 10, 15, 16)) +
  ggplot2::annotate(
    "text",
    x = 31,
    y = 13.8,
    hjust = 0,
    color = "red",
    size = 3.7,
    label = "final do estudo"
  ) +
  ggplot2::coord_flip() +
  ggplot2::theme(
    panel.grid.minor.x = ggplot2::element_blank(),
    panel.grid.minor.y = ggplot2::element_blank()
  ) +
  ggplot2::labs(x = "Paciente",
                y = "Tempo em semanas",
                title = "Estudo sobre ...")


ggplot2::ggplot(Dados_Hepatite) +
  ggplot2::geom_hline(yintercept = 16,
                      linetype = "dashed",
                      color = "red") +
  ggplot2::geom_linerange(ggplot2::aes(x = Paciente, ymin = 0, ymax = tempos)) +
  ggplot2::geom_point(ggplot2::aes(x = Paciente, y = tempos),
                      shape = dplyr::if_else(censura == 0, 19, 1)) +
  ggplot2::scale_x_continuous(breaks = seq(min(Paciente), max(Paciente), 1)) +
  ggplot2::scale_y_continuous(breaks = c(0, 5, 10, 15, 16)) +
  ggplot2::coord_flip() +
  ggplot2::facet_wrap( ~ censura) +
  ggplot2::theme(
    panel.grid.minor.x = ggplot2::element_blank(),
    panel.grid.minor.y = ggplot2::element_blank()
  ) +
  ggplot2::labs(x = "Paciente",
                y = "Tempo em semanas",
                title = "Estudo sobre ...")
