shader_type canvas_item;

uniform float speed = 1.5;
uniform float inverse_amplitude = 8.0;
uniform float size = 1.0;

void vertex() {
	float t = sin(speed * TIME) / inverse_amplitude + size;
    float factor = UV.y;
    VERTEX.y = mix(VERTEX.y * t, VERTEX.y, factor);

}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
