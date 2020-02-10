
#define BEGIN_UNIFORM_BUFFER(name)
#define END_UNIFORM_BUFFER()
#define UNIFORM_BUFFER_PROPERTY(_name, _type) uniform _type _name

#define DEFINE_VERTEX_SHADER_INPUT(_name, _type, _index) attribute _type _name
#define DEFINE_VERTEX_SHADER_OUTPUT(_name, _type) varying _type _name

#define DEFINE_FRAGMENT_SHADER_INPUT(_name, _type) varying _type _name
#define DEFINE_FRAGMENT_SHADER_OUTPUT(_name, _type) 

#define DEFINE_SAMPLER_2D(name) uniform sampler2D name
#define SAMPLE_TEXTURE_2D(_sampler, _uv) texture2D(_sampler, _uv)

#define FRAMENT_SHADER_OUTPUT(name)  gl_FragColor







