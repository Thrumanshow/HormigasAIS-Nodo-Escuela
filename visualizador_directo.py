import pandas as pd
import matplotlib.pyplot as plt
import os

def generar_grafico_vinculado():
    # El origen de la verdad es el stream de la Hormiga 07
    file_path = 'visual_demo_stream.csv'
    # Destinos de la imagen
    outputs = [
        'REPORTE_RENDIMIENTO_HORMIGAS.png',
        os.path.expanduser('~/xoxo-lbh-adapter/REPORTE_RENDIMIENTO_HORMIGAS.png')
    ]
    
    if not os.path.exists(file_path): return

    df = pd.read_csv(file_path, sep='\t')
    if df.empty: return

    # Configuración estética del gráfico LBH
    plt.figure(figsize=(10, 5))
    plt.plot(df['FECHA_HORA'], df['DATO_VALOR'], marker='o', color='#00ffcc', linewidth=2, label='HORMIGA_07_CORE')
    
    plt.title('HormigasAIS - Rendimiento Enjambre CORE (Vínculo Maestro)', color='white')
    plt.xticks(rotation=45, ha='right')
    plt.grid(True, linestyle='--', alpha=0.2)
    plt.legend()
    
    plt.gcf().set_facecolor('#0d1117') # GitHub Dark Theme
    plt.gca().set_facecolor('#0d1117')
    plt.gca().tick_params(colors='white')
    
    plt.tight_layout()
    
    for out in outputs:
        try:
            plt.savefig(out, facecolor='#0d1117')
        except:
            pass
    print("🎨 Gráfico distribuido a los nodos vinculados.")

if __name__ == "__main__":
    generar_grafico_vinculado()
