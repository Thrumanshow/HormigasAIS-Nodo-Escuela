#!/bin/bash
# colony_flow_graph.sh
# Genera un gráfico de la arquitectura de la colonia (XOXO, Hormiga 10, Banca)

# Verificar si dot (Graphviz) está instalado
if ! command -v dot &> /dev/null; then
    echo "❌ Graphviz no está instalado. Instala con: pkg install graphviz"
    exit 1
fi

# Carpeta de salida
mkdir -p logs/graphs

# Archivo DOT
GRAPH_FILE="logs/graphs/colony_flow.dot"
OUTPUT_FILE="logs/graphs/colony_flow.png"

cat << 'DOT' > "$GRAPH_FILE"
digraph ColonyFlow {
    rankdir=LR;
    node [shape=box, style=filled, color=lightblue];

    XOXO [label="XOXO\nFiscalización\nContrato LBH"];
    Hormiga10 [label="Hormiga 10\nDestilación"];
    Banca [label="Banca\nCapitalización\nH-ASSETS"];

    Contract [shape=ellipse, color=lightgreen, label="Contrato LBH"];
    Asset [shape=ellipse, color=yellow, label="H-ASSET"];

    # Relaciones
    Contract -> XOXO [label="Asumido"];
    XOXO -> Hormiga10 [label="Flujo supervisado"];
    Hormiga10 -> Banca [label="Activos generados"];
    Banca -> Asset [label="Registro y emisión"];
}
DOT

# Generar PNG
dot -Tpng "$GRAPH_FILE" -o "$OUTPUT_FILE"

echo "✅ Gráfico generado: $OUTPUT_FILE"
