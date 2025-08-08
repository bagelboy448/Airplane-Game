global.gatlingGun = {
    name: "Gatling Gun",
	projectile: obj_projectile,
	projectileSprite: spr_bullet,
	projectileSpeed: 10,
	projectileSpread: 0.5,
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

function weapon(_baseWeapon) constructor {
    name = _baseWeapon.name
	projectile = _baseWeapon.projectile
	projectileSprite = _baseWeapon.projectileSprite
	projectileSpeed = _baseWeapon.projectileSpeed
	projectileSpread = _baseWeapon.projectileSpread
	projectileDamage = _baseWeapon.projectileDamage
	projectileDuration = _baseWeapon.projectileDuration
	damageSpeedMultiplier = _baseWeapon.damageSpeedMultiplier
	
	loading = _baseWeapon.loading
	loadingDelay = _baseWeapon.loadingDelay
	magazineCapacity = _baseWeapon.magazineCapacity
	magazine = magazineCapacity
	loadingSound = _baseWeapon.loadingSound
	
	fireDelay = _baseWeapon.fireDelay
	fireSound = _baseWeapon.fireSound
}

function gimbalWeapon(_localX, _localY, _turnRate, _baseWeapon)  : weapon(_baseWeapon) constructor {
	x = _localX
	y = _localY
	turnRate = _turnRate
	angle = 0
	
	name += " gimbal"
	
	info = {
		absoluteX: x, 
		absoluteY: y, 
		absoluteAngle: angle
	}
}

function turret(_localX, _localY, _spr, _turnRate, _baseWeapon, _range) : weapon(_baseWeapon) constructor {
    x = _localX
	y = _localY
	sprite = _spr
	turnRate = _turnRate
	angle = 0
	targetingRadius = _range
	
	name += " turret"
	
	info = {
	    absoluteX: x, 
		absoluteY: y, 
		absoluteAngle: angle
	}
}