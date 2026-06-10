precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 color = texture2D(tex, v_texcoord);
    
    // Коэффициенты для перевода в ч/б (Luma)
    float luma = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
    
    // Настройка насыщенности: 1.0 - без изменений, 2.0 - двойная сочность
    float saturation = 1.8; 
    
    vec3 finalColor = mix(vec3(luma), color.rgb, saturation);
    
    // Немного подтянем контраст, чтобы не было "пелены"
    finalColor = (finalColor - 0.5) * 1.1 + 0.5;

    gl_FragColor = vec4(finalColor, color.a);
}
