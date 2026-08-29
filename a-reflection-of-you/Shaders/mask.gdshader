shader_type canvas_item;

// Exposes a slot in the Inspector to assign your mask image
uniform sampler2D mask_texture : source_color;

void fragment() {
    vec4 main_color = texture(TEXTURE, UV);
    vec4 mask_color = texture(mask_texture, UV);
    main_color.a *= mask_color.a;
    COLOR = main_color;
}