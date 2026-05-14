

rm(list=ls())

df <- read.csv("hotel_bookings.csv", header = TRUE, stringsAsFactors = FALSE)

head(df)

#---------------------------

str(df)

summary(df)

sum(duplicated(df))

#--------------------------

df <- unique(df)

df$hotel <- as.factor(df$hotel)
df$arrival_date_month <- as.factor(df$arrival_date_month)
df$meal <- as.factor(df$meal)
df$is_canceled <- as.factor(df$is_canceled)

df$reservation_status_date <- as.Date(df$reservation_status_date)

str(df)

#--------------------------

colSums(is.na(df))

df$children[is.na(df$children)] <- median(df$children, na.rm = TRUE)

#---------------------------

boxplot(df$adr, main="Detección de Outliers en ADR", col="orange")

limite_superior <- quantile(df$adr, 0.95, na.rm = TRUE)
df$adr[df$adr > limite_superior] <- limite_superior

boxplot(df$adr, main="ADR después de Winsorización", col="lightgreen")

#---------------------------
install.packages("ggplot2")
library(ggplot2)

ggplot(df, aes(x = hotel, fill = hotel)) +
  geom_bar() +
  labs(title = "Cantidad de Reservas por Tipo de Hotel", x = "Hotel", y = "Total")


ggplot(df, aes(x = arrival_date_month, group = arrival_date_year, color = as.factor(arrival_date_year))) +
  geom_line(stat = "count") +
  labs(title = "Tendencia de Reservas por Mes y Año", x = "Mes", y = "Cantidad")


ggplot(df, aes(x = arrival_date_month)) +
  geom_bar(fill = "steelblue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Distribución de Reservas por Mes", x = "Mes", y = "Total")


ggplot(df, aes(x = stays_in_weekend_nights, y = stays_in_week_nights)) +
  geom_jitter(alpha = 0.1, color = "darkgreen") +
  labs(title = "Relación de Noches de Fin de Semana vs Semana")


df$tiene_ninos <- ifelse(df$children > 0 | df$babies > 0, "Con Niños", "Solo Adultos")
ggplot(df, aes(x = tiene_ninos, fill = tiene_ninos)) +
  geom_bar() +
  labs(title = "Proporción de Reservas con Menores")


ggplot(df, aes(x = as.factor(required_car_parking_spaces))) +
  geom_bar(fill = "purple") +
  labs(title = "Demanda de Estacionamientos", x = "Espacios", y = "Frecuencia")


ggplot(df, aes(x = hotel, fill = is_canceled)) +
  geom_bar(position = "fill") +
  labs(title = "Proporción de Cancelaciones por Hotel", y = "Proporción")


ggplot(df, aes(x = is_canceled, y = lead_time, fill = is_canceled)) +
  geom_boxplot() +
  labs(title = "Antelación de Reserva vs Cancelación", x = "¿Cancelado?", y = "Días de Antelación")
