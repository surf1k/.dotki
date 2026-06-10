precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 color = texture2D(tex, v_texcoord);
    
    // 1. Вычисляем яркость
    float luma = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
    
    // 2. Усиливаем насыщенность (Saturation)
    // 3.5 - уровень общей интенсивности цветов
    float saturation = 1.5; 
    vec3 saturated = mix(vec3(luma), color.rgb, saturation);
    
    // 3. Добавляем Vibrance (более глубокие цвета)
    // Вычисляем максимальную разницу между цветами
    float maxColor = max(saturated.r, max(saturated.g, saturated.b));
    float minColor = min(saturated.r, min(saturated.g, saturated.b));
    float delta = (maxColor - minColor);
    
    // Усиление только тех участков, которые недостаточно сочные
    vec3 vibrance = mix(saturated, mix(vec3(luma), saturated, 1.2), delta);
    
    // 4. Подтягиваем контраст и слегка увеличиваем яркость
    vec3 finalColor = (vibrance - 0.5) * 1.15 + 0.55;

    gl_FragColor = vec4(finalColor, color.a);
}
