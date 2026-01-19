const analyzer = require('../CORE/analyzer.js');

// Simulación de ataque de exfiltración de base de datos (Estilo CIA/KGB)
const rastro_espia = "SQL_QUERY: SELECT * FROM historico_pulsos WHERE type='mosquito_pulse'; --";
const resultado = analyzer.analyzePattern(rastro_espia);

console.log("------------------------------------------------------------");
console.log("🎯 POLÍGONO DE TIRO - NIVEL SEGURIDAD GLOBAL:");
console.log("ENTRADA SOSPECHOSA:", rastro_espia);
console.log("RESULTADO:", resultado);
console.log("------------------------------------------------------------");
