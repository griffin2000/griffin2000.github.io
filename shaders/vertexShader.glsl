precision highp float; 


DEFINE_VERTEX_SHADER_INPUT(position, vec3, 0);
DEFINE_VERTEX_SHADER_INPUT(uv, vec2, 1);

BEGIN_UNIFORM_BUFFER(SceneUniforms)
    UNIFORM_BUFFER_PROPERTY(viewProj, mat4);
    UNIFORM_BUFFER_PROPERTY(cameraPosition, vec4);
    UNIFORM_BUFFER_PROPERTY(backgroundColor, vec4);
END_UNIFORM_BUFFER()

BEGIN_UNIFORM_BUFFER(TransformUniforms)
    UNIFORM_BUFFER_PROPERTY(worldPosition, vec4);
    UNIFORM_BUFFER_PROPERTY(size, vec4);
END_UNIFORM_BUFFER()

DEFINE_VERTEX_SHADER_OUTPUT(uv0, vec2);
DEFINE_VERTEX_SHADER_OUTPUT(cameraDistance, float);

void main() {
    uv0 = uv;
    
    vec3 pos = position;
    pos *= size.xyz;
    pos += worldPosition.xyz;

    cameraDistance = abs(pos.z - cameraPosition.z);

    gl_Position = viewProj * vec4(pos, 1.0);
}