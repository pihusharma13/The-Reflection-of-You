shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform float frequency = 10.0;
uniform float strength = 0.02;
uniform float speed = 5.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    uv.x += sin(uv.y * frequency + TIME * speed) * strength;
    COLOR = texture(screen_texture, uv);
}