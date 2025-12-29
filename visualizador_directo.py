import pandas as pd
import matplotlib.pyplot as plt
import os

def generar_grafico_vinculado():
    try:
        # Leer CSV eliminando espacios en blanco en cabeceras
        df = pd.read_csv('visual_demo_stream.csv', skipinitialspace=True)
        df.columns = df.columns.str.strip() # Limpieza agresiva de nombres de columnas
        
        print(f"✅ Columnas detectadas y limpias: {list(df.columns)}")
        
        # Usar nombres de columna limpios
        plt.figure(figsize=(10,6))
        plt.plot(df['FECHA_HORA'], df['DATO_VALOR'], marker='o', color='#00ffcc', label='HORMIGA_07_CORE')
        plt.title('HormigasAIS - Pulso de Inteligencia Soberana')
        plt.xticks(rotation=45)
        plt.tight_layout()
        
        plt.savefig('REPORTE_RENDIMIENTO_HORMIGAS.png')
        print("🎨 [EXITO] Gráfico regenerado con éxito.")
    except Exception as e:
        print(f"❌ [ERROR CRITICO] No se pudo generar el gráfico: {e}")

if __name__ == "__main__":
    generar_grafico_vinculado()
