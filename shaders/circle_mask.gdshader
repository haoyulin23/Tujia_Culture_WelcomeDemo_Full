shader_type canvas_item;

uniform float radius : hint_range(0.1, 0.5) = 0.48;        // 圆半径，相对0..0.5
uniform float edge_softness : hint_range(0.0, 0.1) = 0.02; // 边缘柔和

void fragment() {
    vec4 col = texture(TEXTURE, UV);

    // 以控件中心为圆心，做等比圆（考虑贴图宽高比）
    vec2 p = UV - vec2(0.5);
    float aspect = TEXTURE_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.x; // = h/w
    p.x *= aspect;

    float d = length(p);
    float alpha = smoothstep(radius, radius - edge_softness, d); // 外→内渐变
    col.a *= 1.0 - alpha;

    COLOR = col;
}
