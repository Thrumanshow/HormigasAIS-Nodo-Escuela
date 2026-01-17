import os
import hashlib

FORBIDDEN_KEYWORDS = ["exec", "eval", "import", "socket", "os.system"]
AUTHORIZED_ROOT = "LBH-SANDBOX-COMMERCIAL-ROOT"

def verify_local_authority(file_path):
    print(f"📡 [XOXO-NODO-ESCUELA]: Validando contrato local...")
    
    if not os.path.exists(file_path):
        return "❌ ERROR: Constitución no encontrada en el Nodo-Escuela."

    with open(file_path, 'r') as f:
        content = f.read()

    if AUTHORIZED_ROOT not in content:
        return "❌ ERROR: Firma de autoridad CLHQ no detectada en el origen."

    for word in FORBIDDEN_KEYWORDS:
        if word in content.lower():
            return f"❌ ALERTA DE SEGURIDAD: Código prohibido detectado: {word}"

    file_hash = hashlib.sha256(content.encode()).hexdigest()
    return f"✅ ORIGEN VALIDADO: Hash {file_hash[:12]} | Listo para espejo."

if __name__ == "__main__":
    # Apunta al archivo que acabamos de crear en la raíz del Nodo-Escuela
    target = "./LBH_COMMERCIAL_SANDBOX.md"
    print(verify_local_authority(target))
