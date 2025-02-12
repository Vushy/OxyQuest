RSRC                    ShaderMaterial            ��������                                                  resource_local_to_scene    resource_name    code    script    shader    shader_parameter/circle_color    shader_parameter/circle_speed    shader_parameter/circle_width    shader_parameter/circle_count    shader_parameter/circle_size    shader_parameter/glow_strength    shader_parameter/glow_radius        
   local://9       .   res://addons/copilot-advanced/small_icon.tres �         Shader          �  shader_type canvas_item;

uniform vec4 circle_color : source_color = vec4(0.0, 1.0, 1.0, 1.0);
uniform float circle_speed : hint_range(0.0, 10.0) = 1.0;
uniform float circle_width : hint_range(0.0, 1.0) = 0.1;
uniform float circle_count : hint_range(1.0, 20.0) = 6.0;
uniform float circle_size : hint_range(0.1, 2.0) = 0.5;

// Glow settings
uniform float glow_strength : hint_range(0.0, 1.0) = 0.5;
uniform float glow_radius : hint_range(0.0, 1.0) = 0.2;

void fragment() {
    vec2 uv = UV * 3.0 - vec2(1.5, 1.5);
    float len = length(uv);
    
    float circle = 0.0;
    for (float i = 0.0; i < circle_count; i++) {
        float t = i / circle_count;
        float time_offset = t * 6.28318; // 2 * PI
        float radius = (1.0 - t * circle_size) * (1.0 + sin(TIME * circle_speed + time_offset) * 0.1);
        float circle_strength = smoothstep(radius - circle_width, radius, len) - smoothstep(radius, radius + circle_width, len);
        circle = max(circle, circle_strength);
    }

    // Glow effect
    float glow = smoothstep(circle_width, circle_width + glow_radius, circle);
    circle += glow_strength * glow;

    vec4 col = vec4(circle_color.rgb * circle, circle_color.a * circle);
    COLOR = col;
}          ShaderMaterial 	                      �r?��?��Q?  �?        �@   )   333333�?         @	   )   �������?
        �?   )   �������?      RSRC