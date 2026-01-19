import os
import time
import sys
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.primitives import serialization

def generar_desafio_lbh():
    """Genera un reto binario único (Nonce)"""
    return os.urandom(32)

def firmar_con_maestro(desafio):
    """FIRMA REAL: El Maestro CLHQ usa su ADN digital (PrivKey)"""
    try:
        with open("auth_lbh/maestro_private.pem", "rb") as key_file:
            private_key = serialization.load_pem_private_key(
                key_file.read(),
                password=None,
            )
        
        firma = private_key.sign(
            desafio,
            padding.PSS(
                mgf=padding.MGF1(hashes.SHA256()),
                salt_length=padding.PSS.MAX_LENGTH
            ),
            hashes.SHA256()
        )
        return firma
    except FileNotFoundError:
        print("❌ ERROR: Llave PRIVADA no encontrada en auth_lbh/")
        sys.exit(1)

def verificar_firma_maestro(desafio, firma):
    """VERIFICACIÓN: El Nodo-Escuela valida con la PubKey"""
    try:
        with open("auth_lbh/maestro_public.pem", "rb") as key_file:
            public_key = serialization.load_pem_public_key(key_file.read())
        
        public_key.verify(
            firma,
            desafio,
            padding.PSS(
                mgf=padding.MGF1(hashes.SHA256()),
                salt_length=padding.PSS.MAX_LENGTH
            ),
            hashes.SHA256()
        )
        return True
    except Exception:
        return False

# Ejecución del Protocolo SOBERANO
print("\n--- [LBH v1.0] ACTIVANDO IDENTIDAD CRIPTOGRÁFICA ---")
desafio = generar_desafio_lbh()
print(f"📡 Desafío binario generado: {desafio.hex()[:32]}...")

# Generar la firma matemática
firma = firmar_con_maestro(desafio)
print(f"✍️  Pulso firmado con éxito (RSA-2048)")

# Validación final
if verificar_firma_maestro(desafio, firma):
    print("\n✅ ACCESO SOBERANO CONCEDIDO.")
    print("🛡️  Identidad verificada: Sin cookies, sin rastreo, 100% LBH.")
else:
    print("\n❌ FALLO CRÍTICO: Firma no válida o alterada.")
    sys.exit(1)
