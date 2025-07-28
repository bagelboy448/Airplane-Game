function weapons_initialize(_objectID) {
    with (_objectID) {
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