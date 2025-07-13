#version 450

layout(set = 0, binding = 0) uniform sampler2D u_texture;

layout(location = 0) in vec4 vColor;
layout(location = 1) in vec2 vTexCoord;

layout(location = 0) out vec4 fragColor;

void main() 
{
    vec4 texColor = texture(u_texture, vTexCoord);
    fragColor = mix(texColor, vColor, 0.7);
}