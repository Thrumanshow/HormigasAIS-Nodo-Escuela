const analyzer = require('../CORE/analyzer.js');
const responder = require('../CORE/responder.js');

const rastro_intruso = "INTENTO DE ACCESO: chmod 777 LBH_PROTOCOL/";
console.log("🐜 [hola_ant] Detectando movimiento sospechoso en la entrada del nido...");

const veredicto = analyzer.analyzePattern(rastro_intruso);
console.log("Veredicto:", veredicto);

responder.ejecutarRespuesta(veredicto);
