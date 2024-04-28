#!/bin/bash

# Determina el directorio donde se encuentra run.sh
BASE_DIR=$(dirname "$(realpath "$0")")

# Activar el entorno virtual
source "$BASE_DIR/../mlx-examples/env/bin/activate"

# Ruta al archivo YAML proporcionada como primer argumento
YAML_PATH="$1"

# Verifica la existencia del archivo YAML
if [ ! -f "$YAML_PATH" ]; then
    echo "Error: '$YAML_PATH' no such file or directory"
    exit 1
fi

# Crear directorios y preparar entorno del experimento
"$BASE_DIR/create_dirs.sh" "$YAML_PATH"

# Leer configuraciones del archivo YAML
MODEL=$(yq e '.model' "$YAML_PATH")
DATA=$(yq e '.data' "$YAML_PATH")
ITERS=$(yq e '.iters' "$YAML_PATH")
ADAPTER=$(yq e '.adapter-path' "$YAML_PATH")
SEED=$(yq e '.seed' "$YAML_PATH")
LORA_LAYERS=$(yq e '.lora-layers' "$YAML_PATH")
BATCH_SIZE=$(yq e '.batch-size' "$YAML_PATH")

# Cambiar al directorio del experimento
EXPERIMENT_DIR="$BASE_DIR/output/${MODEL}/$(basename ${DATA})/${LORA_LAYERS}/${BATCH_SIZE}"
mkdir -p "$EXPERIMENT_DIR"
cd "$EXPERIMENT_DIR" || exit 1

# # Ejecutar comandos para operaciones del modelo
# CMD="python -m mlx_lm.lora \
#   --model $MODEL \
#   --train \
#   --data \"$BASE_DIR/$DATA\" \
#   --iters $ITERS \
#   --seed $SEED \
#   --lora-layers $LORA_LAYERS \
#   --batch-size $BATCH_SIZE \
#   --adapter-path $ADAPTER"

# echo "Running command in $EXPERIMENT_DIR: $CMD"
# eval $CMD

# # Ejemplo adicional con adapter-path y test
# CMD="python -m mlx_lm.lora \
#   --model $MODEL \
#   --adapter-path $ADAPTER \
#   --test \
#   --data \"$BASE_DIR/$DATA\""

# echo "Running command: $CMD"
# eval $CMD

# Suponiendo que el experimento ha finalizado y quieres registrar los detalles
python "$BASE_DIR/register.py" \
    "$BASE_DIR/experiments_log.xlsx" \
    "$MODEL" \
    "$DATA" \
    "$ITERS" \
    "$BATCH_SIZE" \
    "$EXPERIMENT_DIR"