#!/usr/bin/env bash

# Define el archivo donde se almacenará el contador de segundos
ARCHIVO_CONTADOR="$HOME/go/myfaceapp/time-of-use.org"

while true; do
  # Ejecuta el comando y captura su salida
  SALIDA=$(go run "$HOME/go/myfaceapp/main.go")

  # Cuenta cuántas veces aparece "roberto" en la salida
  CUENTA=$(echo "$SALIDA" | grep -c "roberto")

  # Duplica la cantidad de coincidencias
  SEGUNDOS=$((CUENTA * 2))

  # Escribe el número de segundos en el archivo, sobreescribiendo el contenido
  echo "$SEGUNDOS" > "$ARCHIVO_CONTADOR"

  # Muestra el resultado (opcional)
  echo "Número de coincidencias: $CUENTA"
  echo "Número de segundos registrados: $SEGUNDOS"

done
