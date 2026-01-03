#!/bin/bash

# --- IDENTIDAD HORMIGASAIS ---
# Fundador: Cristhiam Hernández | Protocolo: LBH
# Roles Especializados: Hormiga Stanford (Traductora) y Hormiga Enfermera (Reparadora)

echo "🐜 Despertando Colonia con Protocolo de Auto-curación Stanford..."

# 1. SEGURIDAD: Backup del ADN
mkdir -p ./boveda_seguridad
[ -f "lbh.human" ] && cp lbh.human ./boveda_seguridad/lbh_$(date +%Y%m%d_%H%M%S).human

# 2. BUS XOXO (Sistema Nervioso)
mosquitto -d 2>/dev/null

# 3. LANZAMIENTO DE NODOS
nohup python3 -m http.server 8081 > /dev/null 2>&1 & # Nodo Escuela
nohup python3 server_arquitectura.py > /dev/null 2>&1 & # Mapa LBH
nohup python3 -m http.server 8080 > /dev/null 2>&1 & # Nodo Solar

# 4. LÓGICA STANFORD / ENFERMERA (Auto-healing Loop)
(
while true; do
  # Monitoreo silencioso de puertos (Coordenadas de mando)
  for puerto in 8080 8081 8082; do
    if ! lsof -Pi :$puerto -sTCP:LISTEN -t >/dev/null; then
      # STANFORD detecta daño interno
      mosquitto_pub -h localhost -t "xoxo/interno/daño" -m "{\"origen\":\"Stanford\", \"sector\":\"$puerto\", \"status\":\"reparando\"}"
      
      # STANFORD traduce a LBH y manda coordenadas a la ENFERMERA
      # La Enfermera reinicia el sector dañado internamente
      if [ $puerto -eq 8081 ]; then nohup python3 -m http.server 8081 > /dev/null 2>&1 & fi
      if [ $puerto -eq 8082 ]; then nohup python3 server_arquitectura.py > /dev/null 2>&1 & fi
      if [ $puerto -eq 8080 ]; then nohup python3 -m http.server 8080 > /dev/null 2>&1 & fi
      
      # La ENFERMERA confirma reparación silenciosa
      mosquitto_pub -h localhost -t "xoxo/interno/enfermera" -m "{\"msg\":\"Sector $puerto restablecido\", \"feromona_enjambre\":\"normal\"}"
    fi
  done
  sleep 30 # Ciclo de atención de la Hormiga Stanford
done
) &

echo "-------------------------------------------------------"
echo "✅ Hormiga Stanford vigilando coordenadas internamente."
echo "✅ Hormiga Enfermera lista para reparaciones silenciosas."
echo "🚀 Ecosistema LBH Blindado."
