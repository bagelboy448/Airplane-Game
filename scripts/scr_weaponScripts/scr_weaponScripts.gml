function weapons_initialize(_objectID) {
    with (_objectID) {
		if (!variable_instance_exists(self, "weaponTimers"))
			weaponTimers = ds_map_create()
		if (!variable_instance_exists(self, "weapons"))
			weapons = []
		else
			for (var i = 0; i < array_length(weapons); i++) {
				weaponTimers[? weapons[i]] = {
				    loadTimer: 0,
					fireTimer: 0
				}
			}
	}
}

function weapons_fire(_objectID, _struct) {
    with (_objectID) {
	    if (weaponTimers[? _struct].fireTimer == 0 && (_struct.loading ? _struct.magazine > 0 : true)) {
		    instance_create_depth(x, y, depth - 1, _struct.projectile, {
			    sprite_index: _struct.projectileSprite,
				speed: _struct.projectileSpeed + velocity.magnitude() * dcos(image_angle - velocity.direction()),
				direction: image_angle + random(_struct.projectileSpread) * choose(1, -1),
				damage: _struct.projectileDamage,
				duration: _struct.projectileDuration
			})
			
			if (_struct.loading)
				_struct.magazine--
				
			audio_play_sound(_struct.fireSound, 0, false)
			
			weaponTimers[? _struct].fireTimer = _struct.fireDelay
		}
	}
}

function weapons_update(_objectID, _struct) {
    with (_objectID) {
		
		if (_struct.loading && _struct.magazine < _struct.magazineCapacity) {
		    if (weaponTimers[? _struct].loadTimer == 0) {
			    _struct.magazine++
				weaponTimers[? _struct].loadTimer = _struct.loadingDelay
				audio_play_sound(_struct.loadingSound, 0, false)
			}
			else weaponTimers[? _struct].loadTimer--
		}
		
		if (weaponTimers[? _struct].fireTimer > 0) {
		    weaponTimers[? _struct].fireTimer--
		}
		
	}
}

function turrets_initialize(_objectID) {
    with (_objectID) {
	    if (!variable_instance_exists(self, "weaponTimers"))
			weaponTimers = ds_map_create()
		if (!variable_instance_exists(self, "turrets"))
			turrets = []
		else
			for (var i = 0; i < array_length(turrets); i++) {
				weaponTimers[? turrets[i]] = {
				    loadTimer: 0,
					fireTimer: 0
				}
			}
	}
}

function turrets_draw(_objectID, _struct) {
    with (_objectID) {
	    var localX = _struct.x - sprite_xoffset
		var localY = _struct.y - sprite_yoffset
		
		var cosA = dcos(image_angle)
		var sinA = dsin(image_angle)
		
		var rotatedX = x + localX * cosA - localY * -sinA
		var rotatedY = y + localX * -sinA + localY * cosA
		var angle = image_angle + _struct.angle
		
		draw_sprite_ext(_struct.sprite, 0, rotatedX, rotatedY, 1, 1, angle, c_white, 1)
		
		_struct.info.absoluteX = rotatedX
		_struct.info.absoluteY = rotatedY
		_struct.info.absoluteAngle = angle
	}
}

function turrets_fire(_objectID, _struct) {
    with (_objectID) {
	    if (weaponTimers[? _struct].fireTimer == 0 && (_struct.loading ? _struct.magazine > 0 : true)) {
		    instance_create_depth(_struct.info.absoluteX, _struct.info.absoluteY, depth - 1, _struct.projectile, {
			    sprite_index: _struct.projectileSprite,
				speed: _struct.projectileSpeed + velocity.magnitude() * dcos(image_angle - velocity.direction()),
				direction: _struct.info.absoluteAngle + random(_struct.projectileSpread) * choose(1, -1),
				damage: _struct.projectileDamage,
				duration: _struct.projectileDuration
			})
			
			if (_struct.loading)
				_struct.magazine--
				
			audio_play_sound(_struct.fireSound, 0, false)
			
			weaponTimers[? _struct].fireTimer = _struct.fireDelay
		}
	}
}

function turrets_update(_objectID, _struct) {
    weapons_update(_objectID, _struct)
}