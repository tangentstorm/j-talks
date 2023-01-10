shader_type canvas_item;

const vec2 WH0 = vec2(3.5, 2.5);
const vec2 XY0 = vec2(-2.5, -1.25);
uniform vec2 shift = vec2(0.0, 0.0);
uniform float scale = 1.0;

// csq: complex square
vec2 csq(vec2 v) { return vec2((v.x*v.x)-(v.y*v.y), 2.0*(v.x * v.y)); }

void fragment() {
	vec2 c = (UV * WH0) + XY0;
	c = (c - shift) / scale + shift;
	vec2 z = vec2(0.0, 0.0); float s = 0.0; int n = 128;
	for (int i=0; i<n; i++) { z=csq(z)+c; s += (length(z)<2.0?1.0:0.0); }
	COLOR.rgb = vec3(1.0-s/float(n));
}
