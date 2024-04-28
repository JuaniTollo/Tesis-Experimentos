#!/bin/bash

# Activar el entorno virtual
source ../../mlx-examples/env/bin/activate

# Leer configuraciones del archivo YAML
MODEL=$(yq e '.model' experiment_config.yaml)
DATA=$(yq e '.data' experiment_config.yaml)
ITERS=$(yq e '.iters' experiment_config.yaml)
ADAPTER=$(yq e '.adapter-path' experiment_config.yaml)
SEED=$(yq e '.seed' experiment_config.yaml)
LORA_LAYERS=$(yq e '.lora-layers' experiment_config.yaml)
BATCH_SIZE=$(yq e '.batch-size' experiment_config.yaml)

# Verificar los valores antes de ejecutar
echo "Model: $MODEL"
echo "Data: $DATA"
echo "Iters: $ITERS"
echo "Adapter Path: $ADAPTER"
echo "Seed: $SEED"
echo "Lora Layers: $LORA_LAYERS"
echo "Batch Size: $BATCH_SIZE"

# Construir el comando de experimento
CMD="python -m mlx_lm.lora \
  --model $MODEL \
  --train \
  --data $DATA \
  --iters $ITERS \
  --seed $SEED \
  --lora-layers $LORA_LAYERS \
  --batch-size $BATCH_SIZE \
  --adapter-path $ADAPTER"

# Ejecutar el comando de experimento
echo "Running command: $CMD"
eval $CMD

# Ejemplo adicional con adapter-path y test
CMD="python -m mlx_lm.lora \
  --model $MODEL \
  --adapter-path $ADAPTER \
  --test \
  --data $DATA"

# Ejecutar el comando de experimento
echo "Running command: $CMD"
eval $CMD
