#!/bin/bash
# 🐜 HormigasAIS - Contrato de Confianza Soberana
# Autor: Cristhiam Leonardo Hernández Quiñonez (CLHQ)

echo "🤝 [CONTRATO] Iniciando vínculo Alpha <-> Estudiantes..."
TRUST_SEED="LBH-TRUST-$(date +%s)-CLHQ"

# Inyectar confianza en las identidades existentes
for i in {01..10}
do
    STUDENT_PATH="./students/hormiga_$i/identity.lbh"
    if [ -f "$STUDENT_PATH" ]; then
        # Actualización de status a VALIDADA
        sed -i 's/"status": ".*"/"status": "VALIDADA_POR_ALPHA"/' "$STUDENT_PATH"
        echo "{\"contrato_alpha\":\"$TRUST_SEED\", \"timestamp\":\"$(date +%s)\"}" >> "$STUDENT_PATH"
        echo "🐜 Hormiga $i: Vínculo de confianza grabado."
    fi
done

# Registro en el Core del mando superior
echo "{\"agente\":\"alpha\",\"nivel_confianza\":\"MAXIMO\",\"seed\":\"$TRUST_SEED\"}" > ./core/hormiga_alpha.lbh

echo "✅ [CONTRATO SELLADO] El enjambre reconoce a Alpha como raíz de confianza."
