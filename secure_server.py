import http.server
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
import base64

# CONFIGURACIÓN DE ACCESO SOBERANO
USER = "cristhiam"
PASS = "LBH2025_SOBERANO" # Cambia esta clave si deseas

class SecureHandler(http.server.SimpleHTTPRequestHandler):
    def do_AUTHHEAD(self):
        self.send_response(401)
        self.send_header('WWW-Authenticate', 'Basic realm="HormigasAIS Alpha Node"')
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):
        auth_header = self.headers.get('Authorization')
        encoded_credentials = base64.b64encode(f"{USER}:{PASS}".encode()).decode()
        
        if auth_header is None or auth_header != f"Basic {encoded_credentials}":
            self.do_AUTHHEAD()
            self.wfile.write(b'Acceso Denegado: Se requiere firma de Ingeniero de Protocolos.')
        else:
            super().do_GET()

if __name__ == '__main__':
    print(f"--- SERVIDOR SOBERANO ACTIVADO ---")
    print(f"Acceso: http://localhost:8080")
    print(f"Usuario: {USER}")
    http.server.HTTPServer(('', 8080), SecureHandler).serve_forever()
