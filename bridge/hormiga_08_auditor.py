import os
import pandas as pd

def auditoria_consistencia():
    print("🔍 [HORMIGA 08] Iniciando escaneo de integridad...")
    
    # 1. Validar existencia y permisos
    files = ['visual_demo_stream.csv', 'REPORTE_RENDIMIENTO_HORMIGAS.png']
    for f in files:
        if os.path.exists(f):
            os.chmod(f, 0o666)
            print(f"✅ Permisos corregidos para: {f}")
        else:
            print(f"⚠️ Alerta: {f} no encontrado. Creando buffer...")
            if 'csv' in f:
                with open(f, 'w') as fh: fh.write("FECHA_HORA\tID_HORMIGA\tESTADO\tDATO_VALOR\tFIRMA_LBH\n")

    # 2. Consistencia de Pasaporte LBH vs Datos
    try:
        df = pd.read_csv('visual_demo_stream.csv', sep='\t')
        if not df.empty:
            last_id = df['ID_HORMIGA'].iloc[-1]
            if "07_CORE" in last_id:
                print(f"🛡️ Pasaporte Validado: {last_id} coincide con el contrato CORE.")
            else:
                print("❌ Inconsistencia detectada: ID de agente no autorizado.")
    except Exception as e:
        print(f"⚠️ Error en lectura de datos: {e}")

    # 3. Limpieza de huellas temporales
    if os.path.exists('enjambre_actividad.log'):
        if os.path.getsize('enjambre_actividad.log') > 1000000: # 1MB
            os.system('tail -n 100 enjambre_actividad.log > temp.log && mv temp.log enjambre_actividad.log')
            print("🧹 Log de actividad rotado por la Hormiga 08.")

if __name__ == "__main__":
    auditoria_consistencia()
