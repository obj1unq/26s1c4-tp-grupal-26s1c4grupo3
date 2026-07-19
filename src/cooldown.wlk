// Sistema de cooldown genérico, adaptado de CooldownManager de portonol.
// Base para boss/dash/proyectiles (Fase 1 del plan). AUDITAR ANTES DE USAR:
// aún no está conectado a EnemigoFinal ni a ningún arma.
//
// Uso: el dueño (arma/enemigo) tiene `const cooldown = new CooldownManager(totalCooldownTime = N)`
// y en su tick llama `cooldown.onTimePassed(tiempoDelTick)`. Antes de atacar/usar,
// pregunta `cooldown.estaListo()`; al ejecutar la acción, llama `cooldown.activar()`.

class CooldownManager {
	const property totalCooldownTime
	var relativeCooldownTime = 0

	method estaListo() = relativeCooldownTime <= 0

	method onTimePassed(time) {
		if (!self.estaListo()) {
			relativeCooldownTime = (relativeCooldownTime - time).max(0)
		}
	}

	method activar() { relativeCooldownTime = totalCooldownTime }
}
