shader_type spatial;
render_mode unshaded;

uniform float wavelength = 10.0;
uniform float wavespeed = 1.0;
uniform float alpha = 0.25;
uniform float displacement = 0.0;
uniform float displacement_speed = 1.0;

uniform sampler2D noise_texture;
uniform sampler2D noise_displacement_texture;
uniform sampler2D gradiant;

void vertex()
{
	vec3 perlin = texture(noise_displacement_texture, UV + (TIME * displacement_speed)).rgb;
	VERTEX = VERTEX + (perlin * NORMAL * displacement);
}


void fragment()
{
	vec3 perlin = texture(noise_texture, UV).rgb;
	float ndotp = dot(VIEW, perlin) * wavelength;
	float waves =  (1.0 + sin(ndotp + TIME * wavespeed)) / 2.0;
	vec4 color = texture(gradiant, vec2(waves, 0.5));
	ALBEDO = color.rgb;
	ALPHA = min(color.a, alpha);
}