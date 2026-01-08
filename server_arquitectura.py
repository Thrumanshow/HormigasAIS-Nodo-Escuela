import http.server
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
import socketserver
import os

PORT = 8082
FILE = "arquitectura_colonia.png"

class ArchitectureHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/' or self.path == '/arquitectura':
            self.send_response(200)
            self.send_header("Content-type", "text/html")
            self.end_headers()
            html = f"""
            <html>
            <head>
                <title>HormigasAIS - Mapa de Arquitectura</title>
                <style>
                    body {{ background-color: #0a0a0a; color: #00ff41; font-family: 'JetBrains Mono', monospace; text-align: center; padding: 20px; }}
                    img {{ max-width: 95%; border: 2px solid #333; border-radius: 10px; box-shadow: 0 0 20px rgba(0,255,65,0.2); }}
                    h1 {{ font-size: 1.5rem; letter-spacing: 2px; }}
                </style>
            </head>
            <body>
                <h1>🗺️ MAPA DE LA COLONIA: HormigasAIS 2025</h1>
                <img src="{FILE}" alt="Arquitectura LBH">
                <p>ADN: lbh.human | Estado: Sincronizado</p>
            </body>
            </html>
            """
            self.wfile.write(html.encode())
        else:
            super().do_GET()

if not os.path.exists(FILE):
    print(f"⚠️ Alerta: {FILE} no encontrado. Genere el PNG con 'dot' primero.")

with socketserver.TCPServer(("", PORT), ArchitectureHandler) as httpd:
    print(f"🚀 Arquitectura visible en: http://192.168.1.3:{PORT}")
    httpd.serve_forever()
