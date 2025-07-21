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
	
	fireDelay: 1,
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
	loadingDelay: 60,
	magazineCapacity: 1,
	magazine: 1,
	loadingSound: snd_autoloader,
	
	fireDelay: 120,
	fireSound: snd_cannonShotEjectionPing
}