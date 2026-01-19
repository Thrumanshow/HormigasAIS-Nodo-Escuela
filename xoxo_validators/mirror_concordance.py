import os
import yaml
import hashlib

# Rutas relativas desde Nodo-Escuela
PROTOCOL_FILE = "../HormigasAIS--LBH-Protocol-/config/REGLAMENTOS_externo.yaml"
SHOWCASE_LOG = "../HormigasAIS-Commercial-Showcase/XOXO_CONCORDANCIA.log"

def check_concordance():
    print("🐜 XOXO: Iniciando verificación de concordancia reglamentaria...")
    
    if not os.path.exists(PROTOCOL_FILE):
        return "❌ ERROR: No se encontró el REGLAMENTOS_externo.yaml en Protocol-Node."

    with open(PROTOCOL_FILE, 'r') as f:
        config = yaml.safe_load(f)
    
    # Validar Firma Lógica
    firma = config['REGLAMENTOS_externo']['huella']['firma_logica']
    if firma != "LBH-SANDBOX-COMMERCIAL-ROOT":
        return "❌ ERROR: Firma de autoridad no coincide."

    # Generar Ticket de Concordancia para el Showcase
    token = hashlib.sha256(firma.encode()).hexdigest()[:16]
    
    with open(SHOWCASE_LOG, 'w') as log:
        log.write(f"STAMP: {token}\nSTATUS: VALIDATED_BY_XOXO\nTYPE: OPTICAL_SANDBOX")
    
    return f"✅ CONCORDANCIA CREADA: Token {token} inyectado en Showcase."

if __name__ == "__main__":
    print(check_concordance())
