#!/bin/bash
BASE_DIR=$(dirname "$(realpath "$0")")

# Usa explícitamente el intérprete de Python del entorno virtual
source "$BASE_DIR/../mlx-examples/env/bin/activate"

echo $VIRTUAL_ENV

# Leer configuraciones del archivo YAML
MODEL=$(yq e '.model' experiment_config.yaml)
BASE_MODEL=$(yq e '.base_model' experiment_config.yaml)
DATA=$(yq e '.data' experiment_config.yaml)
ADAPTER=$(yq e '.adapter-path' experiment_config.yaml)

# Construir la ruta al directorio de datos que está al mismo nivel que el directorio del script
DATA_DIR=$(realpath "$BASE_DIR/../data/$DATA")

# Cambiar al directorio del experimento
EXPERIMENT_DIR="$BASE_DIR/output/${MODEL}/${DATA}/"
mkdir -p "$EXPERIMENT_DIR"
cd "$EXPERIMENT_DIR" || exit 1

CMD="python -m mlx_lm.lora \
  --model $MODEL \
  --test \
  --base_model $BASE_MODEL \
  --data $DATA_DIR \
  --adapter-path $ADAPTER"

# Ejecutar el comando de experimento
echo "Running command: $CMD"
eval $CMD

