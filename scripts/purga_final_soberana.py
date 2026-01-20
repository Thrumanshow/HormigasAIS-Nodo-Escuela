import os

def purgar_script(filepath, nuevo_codigo):
    if os.path.exists(filepath):
        with open(filepath, "w") as f:
            f.write(nuevo_codigo)
        print(f"🚀 [PURGA] {filepath} ha sido evolucionado a Modo Maestro.")
    else:
        print(f"⚠️ [AVISO] {filepath} no encontrado.")

# 1. Código para notificador_island_soberano.py
codigo_notificador = """import datetime
import os

def notificar_soberano(mensaje):
    ahora = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    log_path = "logs/vigilancia_activa.log"
    
    # Redirección de Telegram a Log Local Soberano
    with open(log_path, "a") as f:
        f.write(f"[{ahora}] [ISLAND-MODE] {mensaje}\\n")
    
    print(f"✅ [{ahora}] Feromona emitida al XOXO-BUS local (Log).")

if __name__ == "__main__":
    notificar_soberano("Sincronización de Isla completada.")
"""

# 2. Código para protocolo_instruccion_soberana.py
codigo_protocolo = """import datetime
import os

def instruccion_maestra():
    ahora = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    log_path = "guardia_nocturna.log"
    
    # Registro puro en Memoria de la Colonia
    with open(log_path, "a") as f:
        f.write(f"🎓 [{ahora}] Instructora validando ruta de contratos soberanos (Local).\\n")
    
    print(f"✅ [{ahora}] Protocolo de instrucción ejecutado en modo local.")

if __name__ == "__main__":
    instruccion_maestra()
"""

purgar_script("notificador_island_soberano.py", codigo_notificador)
purgar_script("protocolo_instruccion_soberana.py", codigo_protocolo)

if __name__ == "__main__":
    print("🐜 [SISTEMA] Desacople de Telegram completado en todos los niveles.")
