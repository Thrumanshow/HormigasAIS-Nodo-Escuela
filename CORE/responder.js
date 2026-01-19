const { exec } = require('child_process');

function ejecutarRespuesta(veredicto) {
    if (veredicto.includes("🚨 CRÍTICO")) {
        console.log("🔥 [hola_ant] ACTIVANDO DEFENSA EXTREMA...");
        
        // RUTA ABSOLUTA VALIDADA POR FIND
        const lockScript = "/data/data/com.termux/files/home/HormigasAIS-video-intelligence-checker/HormigasAIS-Nodo-Escuela/LBH_PROTOCOL/SCRIPTS/lbh_soberano_lock.sh";
        
        exec(`bash ${lockScript}`, (error, stdout, stderr) => {
            if (error) {
                console.error("❌ Fallo físico en el piquete: " + error.message);
                return;
            }
            console.log("🛡️ [PIQUETE] Nodo-Escuela BLOQUEADO SOBERANAMENTE.");
        });
    } else if (veredicto.includes("⚠️ ALERTA")) {
        console.log("💉 [PIQUETE] Marcando rastro de plagiador en LOGS/forensic.log...");
    }
}

module.exports = { ejecutarRespuesta };
