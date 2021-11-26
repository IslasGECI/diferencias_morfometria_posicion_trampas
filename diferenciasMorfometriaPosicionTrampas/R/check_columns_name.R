library(tidyverse)
library(reshape2)

check_columns_name <- function(data) {
  table <- vector()
  n_col <- ncol(data)
  for (i in 1:n_col) {
    table[i] <- str_detect(
      names(data)[i],
      "^(0[1-9]|[1-2][0-9]|3[0-1])/(Ene|Feb|Mar|Abr|May|Jun|Jul|Ago|Sep|Oct|Nov|Dic)/(20[0-9]{2})|(ID)|(Coor-X)|(Coor-Y)|(Nombre_del_responsable)$"
    )
  }
  table <- cbind(melt(names(data)), melt(table))
  names(table) <- c("columna", "es_correcto")
  table <- tibble::as_tibble(table)
  table$columna <- as.character(table$columna)
  return(table)
}
