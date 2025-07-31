global.gatlingGun = {
    name: "Gatling Gun",
	projectile: obj_projectile,
	projectileSprite: spr_bullet,
	projectileSpeed: 10,
	projectileSpread: 1,
	projectileDamage: 1,
	projectileDuration: 300,
	damageSpeedMultiplier: 0.01,
	
	loading: false,
	loadingDelay: 0,
	magazineCapacity: -1,
	magazine: -1,
	loadingSound: undefined,
	
	fireDelay: 2,
	fireSound: snd_m61VulcanShot
}

global.cannon = {
	name: "Cannon",
	projectile: obj_projectile,
	projectileSprite: spr_bullet,
	projectileSpeed: 7,
	projectileSpread: 1,
	projectileDamage: 5,
	projectileDuration: 300,
	damageSpeedMultiplier: 0.01,
	
	loading: true,
	loadingDelay: 120,
	magazineCapacity: 3,
	magazine: 3,
	loadingSound: snd_autoloader,
	
	fireDelay: 30,
	fireSound: snd_cannonShotEjectionPing
}

function weapon(_base) constructor {
    name = _base.name
	projectile = _base.projectile
	projectileSprite = _base.projectileSprite
	projectileSpeed = _base.projectileSpeed
	projectileSpread = _base.projectileSpread
	projectileDamage = _base.projectileDamage
	projectileDuration = _base.projectileDuration
	damageSpeedMultiplier = _base.damageSpeedMultiplier
	
	loading = _base.loading
	loadingDelay = _base.loadingDelay
	magazineCapacity = _base.magazineCapacity
	magazine = magazineCapacity
	loadingSound = _base.loadingSound
	
	fireDelay = _base.fireDelay
	fireSound = _base.fireSound
}

function turret(_localX, _localY, _spr, _turnRate, _base) : weapon(_base) constructor {
    x = _localX
	y = _localY
	sprite = _spr
	turnRate = _turnRate
	
	name += " turret"
}