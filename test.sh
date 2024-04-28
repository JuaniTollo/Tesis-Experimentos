#!/bin/bash

# Activar el entorno virtual
source ../../mlx-examples/env/bin/activate

# Leer configuraciones del archivo YAML
MODEL=$(yq e '.model' experiment_config.yaml)
BASE_MODEL=$(yq e '.base_model' experiment_config.yaml)
BATCH_SIZE=$(yq e '.batch-size' experiment_config.yaml)
TEST_BATCHES=$(yq e '.test-batches' experiment_config.yaml)
DATA=$(yq e '.data' experiment_config.yaml)
ADAPTER=$(yq e '.adapter-path' experiment_config.yaml)

# Ejemplo adicional con adapter-path y test
# Note: Removed the extraneous colon after --adapter-path and ensured all variables are enclosed properly
CMD="python -m mlx_lm.lora \
  --model $MODEL \
  --test \
  --base_model $BASE_MODEL \
  --batch-size $BATCH_SIZE \
  --test-batches $TEST_BATCHES \
  --data $DATA \
  --adapter-path $ADAPTER"

# Ejecutar el comando de experimento
echo "Running command: $CMD"
eval $CMD

# This second CMD block looks redundant unless you need two different runs with slight variations. If not needed, it should be removed to avoid confusion and potential errors.
