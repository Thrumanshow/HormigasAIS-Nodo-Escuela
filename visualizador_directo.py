import pandas as pd
import matplotlib.pyplot as plt
import os

def generar_grafico_vinculado():
    try:
        df = pd.read_csv('visual_demo_stream.csv', skipinitialspace=True)
        df.columns = df.columns.str.strip()
        plt.figure(figsize=(10,6))
        plt.plot(df['FECHA_HORA'], df['DATO_VALOR'], marker='o', color='#00ffcc', linewidth=2)
        plt.title('HormigasAIS - Pulso de Inteligencia Soberana')
        plt.savefig('REPORTE_RENDIMIENTO_HORMIGAS.png')
        print("🎨 Gráfico actualizado en Nodo Escuela.")
    except Exception as e:
        print(f"❌ Error visual: {e}")

if __name__ == "__main__":
    generar_grafico_vinculado()
