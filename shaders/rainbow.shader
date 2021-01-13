shader_type canvas_item;

uniform float speed = 5.0;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = sin(TIME * 10.0) + (UV.x / 1.3);
	COLOR.g = (UV.y / 1.3);
	COLOR.b = (UV.x / 1.3);
}

void vertex() {

}