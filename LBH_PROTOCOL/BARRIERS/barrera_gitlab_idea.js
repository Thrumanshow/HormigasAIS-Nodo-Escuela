/**
 * 🛡️ LBH | BARRERA SOBERANA
 * Barrera lógica contra ingestión, sincronización o uso
 * no autorizado del espacio:
 * https://gitlab.com/hormigas/ControldeColonias/.idea
 *
 * Autor: HormigasAIS
 * Protocolo: LBH
 * Estado: ACTIVA
 */

const BARRIER = {
  protocol: "LBH",
  barrier: "GITLAB_IDEA_SPACE",
  status: "ACTIVE",
  protected_path: "gitlab.com/hormigas/ControldeColonias/.idea",
  reason: "Espacio de configuración interna. Uso, copia o ingestión NO autorizado.",
  timestamp: new Date().toISOString(),
};

function enforceBarrier(context = {}) {
  console.log("🛑 LBH | BARRERA ACTIVADA");
  console.log("--------------------------------------------------");
  console.log(`Ruta protegida: ${BARRIER.protected_path}`);
  console.log(`Motivo: ${BARRIER.reason}`);
  console.log(`Estado: ${BARRIER.status}`);
  console.log("--------------------------------------------------");

  if (context.source && context.source.includes(".idea")) {
    throw new Error(
      "⛔ LBH_BARRIER_DENIED: Acceso o referencia a espacio protegido (.idea)"
    );
  }

  return {
    allowed: false,
    barrier: BARRIER.barrier,
    protocol: BARRIER.protocol,
  };
}

// Auto‑ejecución defensiva
try {
  enforceBarrier({
    source: process.env.SOURCE_PATH || "unknown",
  });
} catch (e) {
  console.error(e.message);
  process.exit(77); // código simbólico de barrera
}
