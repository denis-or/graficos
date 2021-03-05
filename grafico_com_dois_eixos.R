library(ggplot2)
library(data.table)

wfd <- structure(list(Year = 1994:2016, Kcalpd = c(86L, 91L, 98L, 107L, 
                                                   116L, 126L, 123L, 112L, 103L, 102L, 103L, 92L, 77L, 59L, 43L, 
                                                   29L, 19L, 14L, 13L, 12L, 12L, 10L, 9L), Thtonnes = c(728.364, 
                                                                                                        757.467, 780.423, 792.756, 701.685, 720.71, 677.292, 761.649, 
                                                                                                        668.218, 679.042, 974.355, 1005.035, 1123.09, 1055.07, 1092.498, 
                                                                                                        1100.654, 899.767, 1018.462, 1046.096, 1084.173, 1158.217, 802.194, 
                                                                                                        276.773)), row.names = c(NA, -23L), class = "data.frame", .Names = c("Year", 
                                                                                                                                                                             "Kcalpd", "Thtonnes"))



wfd.m <- melt(wfd, id.vars = 1)

ggplot(wfd.m, aes(Year, value, fill = variable)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("Thtonnes" = "blue", "Kcalpd" = "red")) +
  facet_wrap(~variable, ncol = 1, scales = "free_y") +
  theme(legend.position = "none") +
  ylab("your label here")




scaleFactor <- max(wfd$Thtonnes) / max(wfd$Kcalpd)

ggplot(wfd, aes(x=Year,  width=.4)) +
  geom_col(aes(y=Thtonnes), fill="blue", position = position_nudge(x = -.4)) +
  geom_col(aes(y=Kcalpd * scaleFactor), fill="red") +
  scale_y_continuous(name="Thtonnes (Rice + Wheat)", sec.axis=sec_axis(~./scaleFactor, name="Kcal per day")) +
  scale_x_continuous(breaks = seq(1994, 2016, 4)) +
  theme(
    axis.title.y.left=element_text(color="blue"),
    axis.text.y.left=element_text(color="blue"),
    axis.title.y.right=element_text(color="red"),
    axis.text.y.right=element_text(color="red")
  ) +
  labs(title = "Food Security in Venezuela, Cereals Production and Food Gap", x = element_blank())
