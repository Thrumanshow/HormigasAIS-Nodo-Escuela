import datetime
import os

def vigilar_repositorio_soberano():
    # MODO MAESTRO: Canal externo eliminado tras aprendizaje exitoso.
    # El reporte ahora es interno y soberano.
    
    try:
        timestamp = datetime.datetime.now().strftime('%d/%m/%Y %H:%M:%S')
        
        # LOG SOBERANO (Local)
        log_path = "logs/vigilancia_activa.log"
        mensaje = f"[{timestamp}] LBH_STATUS: OPERATIVO_SOBERANO | NODO: SM | MODO: MAESTRO\n"
        
        with open(log_path, "a") as f:
            f.write(mensaje)
            
        print(f"✅ [HORMIGA-CENTINELA] Pulso local registrado en {log_path}. (Canal Telegram purgado)")

    except Exception as e:
        print(f"❌ ERROR CRÍTICO EN NODO SOBERANO: {e}")

if __name__ == "__main__":
    vigilar_repositorio_soberano()
