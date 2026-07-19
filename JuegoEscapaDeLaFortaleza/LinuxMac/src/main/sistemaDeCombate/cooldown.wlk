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
