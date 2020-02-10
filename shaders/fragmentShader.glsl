precision mediump float; 


DEFINE_FRAGMENT_SHADER_INPUT(uv0, vec2);

DEFINE_FRAGMENT_SHADER_INPUT(cameraDistance, float);

DEFINE_FRAGMENT_SHADER_OUTPUT(FragColor, vec4)

DEFINE_SAMPLER_2D(tex);

BEGIN_UNIFORM_BUFFER(SceneUniforms)
    UNIFORM_BUFFER_PROPERTY(viewProj, mat4);
    UNIFORM_BUFFER_PROPERTY(cameraPosition, vec4);
    UNIFORM_BUFFER_PROPERTY(backgroundColor, vec4);
    UNIFORM_BUFFER_PROPERTY(fadeDistance, vec4);
END_UNIFORM_BUFFER()

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// All components are in the range [0…1], including hue.
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}



void main() {
    
    float nearFade = fadeDistance.x;
    float farFade = fadeDistance.y;
    
    float dVal = (cameraDistance - nearFade) / (farFade - nearFade);
    float lerp= max(min(dVal, 1.0), 0.0);
    lerp = sqrt(lerp);
    vec4 color = SAMPLE_TEXTURE_2D(tex, uv0);

    vec3 hsvColor = rgb2hsv(color.xyz);
    vec3 hsvBackgroundColor = rgb2hsv(backgroundColor.xyz);
    
    vec3 hsvFadeColor = mix(hsvColor, hsvBackgroundColor, lerp);;
    vec3 fadeColor = hsv2rgb(hsvFadeColor);
    float fadeAlpha = mix(color.w,backgroundColor.w,lerp);


    FRAMENT_SHADER_OUTPUT(FragColor) = nearFade<0.0 ? color : vec4(fadeColor, fadeAlpha);
}
