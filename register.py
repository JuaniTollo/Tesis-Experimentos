import pandas as pd
import sys
from pathlib import Path

def update_experiment_log(excel_path, data):
    # Verificar si el archivo Excel existe
    excel_path = Path(excel_path)
    if excel_path.exists():
        df = pd.read_excel(excel_path, engine='openpyxl')
    else:
        df = pd.DataFrame()

    # Crear un DataFrame con los nuevos datos
    new_data_df = pd.DataFrame([data])

    # Agregar nueva fila de datos usando concat en lugar de append
    df = pd.concat([df, new_data_df], ignore_index=True)

    # Guardar el DataFrame actualizado en el archivo Excel
    df.to_excel(excel_path, index=False, engine='openpyxl')

if __name__ == "__main__":
    # Recibir argumentos de la línea de comando
    excel_path = sys.argv[1]
    model = sys.argv[2]
    data = sys.argv[3]
    iters = sys.argv[4]
    batch_size = sys.argv[5]
    experiment_path = sys.argv[6]

    data_dict = {
        'Model': model,
        'Data': data,
        'Iters': iters,
        'Batch Size': batch_size,
        'Experiment Path': experiment_path
    }
    update_experiment_log(excel_path, data_dict)
