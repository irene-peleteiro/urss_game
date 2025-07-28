shader_type canvas_item;

// Global Y position of the cutoff
uniform float global_cutoff_y = 0;
// Global Y position of the sprite
uniform float sprite_global_y = 0;

void fragment() {
	// Calculate the global Y position of this pixel
	float pixel_global_y = sprite_global_y + (UV.y * float(textureSize(TEXTURE, 0).y));

	if (pixel_global_y > global_cutoff_y) {
		discard;
	}
	if (abs(pixel_global_y - global_cutoff_y) < 1.0) {
		COLOR.rgb = vec3(1.0, 0.0, 0.0); // Red line for debug
	}
}
