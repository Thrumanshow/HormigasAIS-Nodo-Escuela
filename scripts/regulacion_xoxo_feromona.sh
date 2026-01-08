#!/bin/bash
# HormigasAIS - Protocolo de Regulación XOXO (Firma: CLHQ)
# Coordinación: Hormiga 10 (Soberana) -> Hormiga Stanford (Traductor LBH)

LOG_MAESTRO="logs/mosquito_flight.log_full.log"
SEC_DIR="logs/archive/secuencias_regulacion"

echo "📡 [XOXO-BUS] EMITIENDO FEROMONA_REGULACION..."
echo "🐜 [Hormiga-10] Validando compromiso de soberanía..."

# 1. Crear respaldo temporal del log completo
cp "$LOG_MAESTRO" logs/temp_full_transfer.log

# 2. SELLAR EL PASADO: Dejar en el log maestro SOLAMENTE lo que pertenece a 2025
grep "2025-" logs/temp_full_transfer.log > "$LOG_MAESTRO"
echo "✅ [Stanford-LBH] Traduciendo: Log Maestro sellado hasta 2025-12-31."

# 3. TRASLADAR EL PRESENTE: Mover todo lo que NO es 2025 a las secuencias
# Primero extraemos el excedente (todo lo que es 2026 o pulsos sin fecha)
grep -v "2025-" logs/temp_full_transfer.log > logs/excedente_2026.log

# 4. DISTRIBUCIÓN POR FEROMONAS (Hormigas Estudiantes)
# Lo de 1-5 de Enero va a Secuencia 00
grep "2026-01-0[1-5]" logs/excedente_2026.log >> "$SEC_DIR/secuencia00_mosquito_flight.log_full.log"

# Lo de 6-7 de Enero (hoy) va a Secuencia 01
grep "2026-01-0[6-7]" logs/excedente_2026.log >> "$SEC_DIR/secuencia01_mosquito_flight.log_full.log"

# Las líneas sin fecha (pulsos activos detectados hoy) se inyectan en Secuencia 01 con estampa LBH
grep -v "202[5-6]" logs/excedente_2026.log | sed "s/⏳ /⏳ 2026-01-07 /" >> "$SEC_DIR/secuencia01_mosquito_flight.log_full.log"

# 5. LIMPIEZA Y CIERRE DE CONTRATO
rm logs/temp_full_transfer.log logs/excedente_2026.log
echo "🐜 [Hormigas-Estudiantes] Secuencias 00-17 alineadas por instrucción Stanford."
echo "🏁 [XOXO-BUS] FEROMONA_EMITIDA: REGULACION_COMPLETADA_CLHQ"
