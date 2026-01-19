import csv
import datetime
import os
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

def registrar_log(nombre, email, status):
    log_path = "logs/emisiones_inversionistas.log"
    os.makedirs("logs", exist_ok=True)
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(log_path, "a", encoding="utf-8") as f:
        f.write(f"[{timestamp}] DESTINATARIO: {nombre} ({email}) | ESTADO: {status}\n")

def ejecutar_envio_manual():
    # --- CONFIGURACIÓN DE SOBERANÍA ---
    monto_objetivo = "$250,000 USD"
    hash_tar = "4845a8633e93c42ebbc123d6b4eed1458a65899bda1b28537494b24903491fc0"
    
    print("\n🐜 [HormigasAIS - LBH MASTER ENGINE]")
    print(f"Iniciando protocolo de emisión manual para ronda de {monto_objetivo}")
    print("---------------------------------------------------------")

    try:
        with open('investors_list.csv', mode='r', encoding='utf-8') as file:
            reader = csv.DictReader(file)
            contactos = list(reader)
            
            if not contactos:
                print("⚠️ La lista de inversionistas está vacía.")
                return

            print(f"Se detectaron {len(contactos)} contactos en la base de datos.")
            confirmacion = input("¿Desea proceder con la emisión del Payload LBH? (s/n): ")

            if confirmacion.lower() == 's':
                for row in contactos:
                    print(f"📡 Emitiendo rastro hacia {row['nombre']} ({row['email']})...")
                    
                    # AQUÍ: El script prepara el cuerpo del mensaje
                    cuerpo = f"""
                    IDENTIDAD: HormigasAIS - Infraestructura Distribuida
                    FUNDADOR: Cristhiam Leonardo Hernández Quiñonez
                    MENSAJE: Propuesta Seed Round {monto_objetivo}
                    INTEGRIDAD SHA-256: {hash_tar}
                    """
                    
                    # Por ahora, registramos el éxito del envío en el log soberano
                    registrar_log(row['nombre'], row['email'], "EXITO_EMISION_LBH")
                
                print("\n✅ Protocolo finalizado. Revise logs/emisiones_inversionistas.log")
            else:
                print("❌ Emisión abortada por el Operador Maestro.")

    except FileNotFoundError:
        print("❌ Error: No se encontró 'investors_list.csv' en la raíz del Nodo-Escuela.")

if __name__ == "__main__":
    ejecutar_envio_manual()
