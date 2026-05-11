# 1ACC0216-TB1-2026-1: Hotel Booking Demand EDA

Este proyecto desarrolla un **Análisis Exploratorio de Datos (EDA)** exhaustivo sobre el dataset *Hotel Booking Demand* utilizando el lenguaje **R**. Se abordan procesos críticos de limpieza de datos con ruido, pre-procesamiento estadístico y la generación de visualizaciones estratégicas para optimizar la toma de decisiones en el sector hotelero.

## Autores
- **Francesco Andre Meza Dagnino**
- **Alejandro Jhoshua García Hernández**
- **Ian Landauro La Rosa**

---

## Estructura del Proyecto (Documentation)
Para cumplir con los estándares de la evaluación, el repositorio se organiza de la siguiente manera:

* **`data/`**: 
    * `hotel_bookings.csv`: Dataset original con ruido (NAs y Outliers).
    * `hotel_bookings_cleaned.csv`: Dataset final procesado tras la limpieza.
* **`code/`**: 
    * `upc-nrogrupo-tb1.R`: Script principal de procesamiento y visualización.
    * `upc-nrogrupo-validation.R`: Script de control de calidad para validar la limpieza.
* **`README.md`**: Guía del proyecto y hallazgos principales.

---

## Tech Stack
* **Software:** RStudio.
* **Librerías:**
    * `ggplot2`: Creación de gráficos avanzados (barras apiladas, jitter plots, boxplots).
    * `stats`: Aplicación de medidas de tendencia central y técnicas de Winsorización.

---

## Hallazgos Clave y Lecciones Aprendidas

### Ingeniería de Datos y Limpieza
* **Tratamiento de NAs:** Se identificaron valores nulos en la variable `children`, los cuales fueron imputados mediante la mediana para evitar sesgos en el conteo de huéspedes.
* **Gestión de Outliers:** Se aplicó la técnica de **Winsorización** al percentil 95 en la variable `adr` (tarifa diaria), eliminando el ruido extremo (como el valor erróneo de 5,400) y estabilizando la distribución de precios.
* **Eliminación de Duplicados:** Se detectaron y eliminaron **32,015 registros redundantes**, garantizando que cada observación represente una reserva única y real.

### Insights de Negocio
* **Segmentación de Mercado:** El **City Hotel** concentra el mayor volumen de reservas, pero presenta una tasa de cancelación significativamente más alta que el **Resort Hotel**, lo que sugiere la necesidad de políticas de reserva más estrictas en zonas urbanas.
* **Análisis de Estacionalidad:** Se confirmó un pico de demanda crítico en los meses de **julio y agosto**, alineado con el verano europeo, lo que permite recomendar estrategias de *Dynamic Pricing*.
* **Relación Lead Time vs. Cancelación:** Existe una correlación positiva donde las reservas realizadas con mayor antelación tienen una probabilidad de cancelación superior, validando la implementación de tarifas no reembolsables para reservas tempranas.

---
