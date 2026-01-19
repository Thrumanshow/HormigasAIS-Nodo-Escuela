const fs = require('fs');
const path = require('path');

function analyzePattern(logEntry) {
    console.log("🔍 [hola_ant] Analizando rastro binario...");
    let veredicto = "✅ Rastro limpio. Vigilancia continua.";
    
    // 1. Detección de Plagio (Lalo)
    if (logEntry.includes("fastlane") || logEntry.includes("metadata")) {
        veredicto = "⚠️ ALERTA: Intento de absorción de identidad visual detectado (Pattern: Lalo).";
    }
    
    // 2. Detección de Inyección (Nivel CIA/KGB)
    if (logEntry.includes("DROP") || logEntry.includes("SELECT") || logEntry.includes("chmod 777") || logEntry.includes("../")) {
        veredicto = "🚨 CRÍTICO: Intento de escalada de privilegios o salto de directorio detectado.";
    }

    // REGISTRO DE FEROMONA (Escribir en el log para XOXO)
    if (veredicto.includes("⚠️") || veredicto.includes("🚨")) {
        const logPath = path.join(__dirname, '../LOGS/alerts.log');
        const timestamp = new Date().toISOString();
        fs.appendFileSync(logPath, `[${timestamp}] ${veredicto}\n`);
    }

    return veredicto;
}

module.exports = { analyzePattern };
