library(ggplot2)


ggplot(data = airquality, aes(sample = Ozone)) +
  stat_qq(
    size = 2.5,
    shape = 21,
    fill = 'steelblue',
    col = 'dodgerblue4'
  ) +
  stat_qq_line(col = "red" , lwd = 1) +
  theme_minimal() +
  labs(
    x = 'Qantis teóricos (distribuição normal)',
    y = "Quantis da amostra",
    title = "Gráficos QQ no ggplot",
    caption = "Visualização: Denis de Oliveira Rodrigues
                Doutorando em Epidemiologia-ENSP/Fiocruz"
  )
