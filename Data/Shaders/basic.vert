#version 450

layout(location = 0) in vec2 inVert;       // Typically [-1,1] or [0,1] quad coordinates
layout(location = 1) in vec4 inColor;
layout(location = 2) in vec2 inPos;
layout(location = 3) in vec2 inSize;
layout(location = 4) in float inRot;

layout(location = 0) out vec4 vColor;
layout(location = 1) out vec2 vTexCoord;

void main() {
    float c = cos(inRot);
    float s = sin(inRot);
    mat2 rot = mat2(c, -s, s, c);
    
    vec2 scaled = inVert * inSize;
    vec2 rotated = rot * scaled;
    vec2 finalPos = rotated + inPos;

    gl_Position = vec4(finalPos, 0.0, 1.0);
    vColor = inColor;
}