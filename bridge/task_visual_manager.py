import pandas as pd
import matplotlib.pyplot as plt
import sys
import os

def ejecutar_render(agente_id):
    csv_file = 'visual_demo_stream.csv'
    output_image = 'REPORTE_RENDIMIENTO_HORMIGAS.png'

    if not os.path.exists(csv_file):
        return False

    try:
        # Leer y limpiar datos
        df = pd.read_csv(csv_file)
        # Convertir a numérico y eliminar errores (NaN)
        df['DATO_VALOR'] = pd.to_numeric(df['DATO_VALOR'], errors='coerce')
        df = df.dropna(subset=['DATO_VALOR'])

        if df.empty:
            return False

        # Ventana deslizante de los últimos 25 puntos
        df_plot = df.tail(25)

        plt.style.use('dark_background')
        fig, ax = plt.subplots(figsize=(10, 5))
        
        # El gráfico se ajusta solo para evitar el error NaN/Inf
        ax.plot(range(len(df_plot)), df_plot['DATO_VALOR'], 
                marker='o', linestyle='-', color='#00ff00', linewidth=2)

        ax.set_title(f'NODO ESCUELA: Monitoreo LBH [{agente_id}]', color='#00ff00')
        ax.set_ylabel('Carga / Temperatura (°C)')
        ax.grid(True, alpha=0.1)

        plt.tight_layout()
        plt.savefig(output_image)
        plt.close()
        return True
    except Exception as e:
        print(f"⚠️ Error visual: {e}")
        return False

if __name__ == "__main__":
    id_agente = sys.argv[1] if len(sys.argv) > 1 else "HORMIGA_07_CORE"
    if ejecutar_render(id_agente):
        print(f"🎨 Gráfico regenerado para {id_agente}")
