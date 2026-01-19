const analyzer = require('../CORE/analyzer.js');

const rastro_sospechoso = "Intento de copia en path: fastlane/metadata/android";
const resultado = analyzer.analyzePattern(rastro_sospechoso);

console.log("------------------------------------------------------------");
console.log("🎯 POLÍGONO DE TIRO - RESULTADO:");
console.log(resultado);
console.log("------------------------------------------------------------");
