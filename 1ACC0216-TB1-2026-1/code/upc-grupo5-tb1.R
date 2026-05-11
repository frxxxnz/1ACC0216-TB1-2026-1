

# ------------------------------------------------------------------------------
# 3.1 CARGAR DATOS [cite: 133, 168]
# ------------------------------------------------------------------------------
# Limpiar el entorno de trabajo [cite: 169, 170]
rm(list=ls())

# Cargar el dataset con parámetros requeridos [cite: 170]
df <- read.csv("hotel_bookings.csv", header = TRUE, stringsAsFactors = FALSE)

# ------------------------------------------------------------------------------
# 3.2 INSPECCIONAR DATOS [cite: 134, 171]
# ------------------------------------------------------------------------------
str(df)           # Estructura del dataset [cite: 172]
summary(df)       # Resumen estadístico inicial [cite: 172]
sum(duplicated(df)) # Identificación de duplicados [cite: 172]

# ------------------------------------------------------------------------------
# 3.3 AJUSTES Y TRANSFORMACIONES [cite: 135, 173]
# ------------------------------------------------------------------------------
# Eliminar registros duplicados [cite: 175]
df <- unique(df)

# Transformación de variables a Factores y Fechas [cite: 174, 175]
df$hotel <- as.factor(df$hotel)
df$arrival_date_month <- as.factor(df$arrival_date_month)
df$meal <- as.factor(df$meal)
df$is_canceled <- as.factor(df$is_canceled)
df$reservation_status_date <- as.Date(df$reservation_status_date)

# ------------------------------------------------------------------------------
# 3.4 PRE-PROCESAR DATOS [cite: 136, 176]
# ------------------------------------------------------------------------------

# 3.4.1 Identificación y Tratamiento de Datos Faltantes [cite: 137, 177]
colSums(is.na(df)) # Identificar NAs [cite: 178]

# Imputación de la mediana en la variable 'children' [cite: 178]
df$children[is.na(df$children)] <- median(df$children, na.rm = TRUE)

# 3.4.2 Detección y Tratamiento de Outliers (ADR) [cite: 138, 179]
# Boxplot inicial para detección [cite: 180]
boxplot(df$adr, main="Detección de Outliers en ADR", col="orange")

# Winsorización al percentil 95 [cite: 181]
limite_superior <- quantile(df$adr, 0.95, na.rm = TRUE)
df$adr[df$adr > limite_superior] <- limite_superior

# Boxplot después del tratamiento [cite: 181]
boxplot(df$adr, main="ADR después de Winsorización", col="lightgreen")

# ------------------------------------------------------------------------------
# 3.5 VISUALIZACIÓN DE DATOS [cite: 139, 182]
# ------------------------------------------------------------------------------
library(ggplot2)

# 1. Reservas por tipo de hotel [cite: 183, 184]
ggplot(df, aes(x = hotel, fill = hotel)) +
  geom_bar() +
  labs(title = "Cantidad de Reservas por Tipo de Hotel", x = "Hotel", y = "Total") [cite: 185]

# 2. Demanda de reservas en el tiempo [cite: 186, 187]
ggplot(df, aes(x = arrival_date_month, group = arrival_date_year, color = as.factor(arrival_date_year))) +
  geom_line(stat = "count") +
  labs(title = "Tendencia de Reservas por Mes y Año", x = "Mes", y = "Cantidad") [cite: 188]

# 3. Temporadas de reserva (Distribución por Mes) [cite: 189, 190]
ggplot(df, aes(x = arrival_date_month)) +
  geom_bar(fill = "steelblue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Distribución de Reservas por Mes", x = "Mes", y = "Total") [cite: 191]

# 4. Relación de noches (Fin de semana vs Semana) [cite: 192, 193]
ggplot(df, aes(x = stays_in_weekend_nights, y = stays_in_week_nights)) +
  geom_jitter(alpha = 0.1, color = "darkgreen") +
  labs(title = "Relación de Noches de Fin de Semana vs Semana") [cite: 194]

# 5. Reservas con niños y/o bebés [cite: 195, 196, 197]
df$tiene_ninos <- ifelse(df$children > 0 | df$babies > 0, "Con Niños", "Solo Adultos")
ggplot(df, aes(x = tiene_ninos, fill = tiene_ninos)) +
  geom_bar() +
  labs(title = "Proporción de Reservas con Menores") [cite: 198]

# 6. Espacios de estacionamiento requeridos [cite: 199, 200]
ggplot(df, aes(x = as.factor(required_car_parking_spaces))) +
  geom_bar(fill = "purple") +
  labs(title = "Demanda de Estacionamientos", x = "Espacios", y = "Frecuencia") [cite: 201]

# 7. Cancelaciones por tipo de hotel [cite: 202, 203]
ggplot(df, aes(x = hotel, fill = is_canceled)) +
  geom_bar(position = "fill") +
  labs(title = "Proporción de Cancelaciones por Hotel", y = "Proporción") [cite: 204]

# 8. PREGUNTA DEL EQUIPO: Lead Time vs Cancelaciones [cite: 205, 206, 207]
ggplot(df, aes(x = is_canceled, y = lead_time, fill = is_canceled)) +
  geom_boxplots() +
  labs(title = "Antelación de Reserva vs Cancelación", x = "¿Cancelado?", y = "Días de Antelación") [cite: 208]