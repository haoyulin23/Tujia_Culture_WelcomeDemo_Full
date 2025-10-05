shader_type canvas_item;

void fragment() {
    vec2 uv = UV * 2.0 - vec2(1.0); // 坐标范围 -1~1
    float dist = length(uv);        // 距离中心
    if (dist > 1.0) {
        discard; // 丢掉圆外像素
    }
    COLOR = texture(TEXTURE, UV);
}
