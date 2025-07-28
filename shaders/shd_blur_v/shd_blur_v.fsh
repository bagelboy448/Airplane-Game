//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 textureSize;
uniform float blurRadius;

void main() {
	
	vec2 texel = 1.0 / textureSize;
	vec4 totalColor = vec4(0);
	for (float i = -blurRadius; i <= blurRadius; i += 1.0) {
	    totalColor += texture2D(gm_BaseTexture, v_vTexcoord + vec2(0, i) * texel);
	}
	totalColor /= 2.0 * blurRadius + 1.0;
	
    gl_FragColor = v_vColour * totalColor;
}
