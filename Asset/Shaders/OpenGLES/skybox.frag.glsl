#version 300 es
precision mediump float;
precision highp int;

struct cube_vert_output
{
    highp vec4 pos;
    highp vec3 uvw;
};

struct Light
{
    highp float lightIntensity;
    uint lightType;
    int lightCastShadow;
    int lightShadowMapIndex;
    uint lightAngleAttenCurveType;
    uint lightDistAttenCurveType;
    highp vec2 lightSize;
    uvec4 lightGuid;
    highp vec4 lightPosition;
    highp vec4 lightColor;
    highp vec4 lightDirection;
    highp vec4 lightDistAttenCurveParams[2];
    highp vec4 lightAngleAttenCurveParams[2];
    highp mat4 lightVP;
    highp vec4 padding[2];
};

uniform highp sampler2DArray SPIRV_Cross_Combinedskyboxsamp0;

in highp vec3 _entryPointOutput_uvw;
layout(location = 0) out highp vec4 _entryPointOutput;

highp vec3 exposure_tone_mapping(highp vec3 color)
{
    return vec3(1.0) - exp((-color) * 1.0);
}

highp vec3 gamma_correction(highp vec3 color)
{
    return pow(max(color, vec3(0.0)), vec3(0.4545454680919647216796875));
}

highp vec4 _skybox_frag_main(cube_vert_output _entryPointOutput_1)
{
    highp vec4 outputColor = textureLod(SPIRV_Cross_Combinedskyboxsamp0, vec3(vec4(_entryPointOutput_1.uvw, 0.0).xyz), 0.0);
    highp vec3 param = outputColor.xyz;
    highp vec3 _69 = exposure_tone_mapping(param);
    outputColor = vec4(_69.x, _69.y, _69.z, outputColor.w);
    highp vec3 param_1 = outputColor.xyz;
    highp vec3 _75 = gamma_correction(param_1);
    outputColor = vec4(_75.x, _75.y, _75.z, outputColor.w);
    return outputColor;
}

void main()
{
    cube_vert_output _entryPointOutput_1;
    _entryPointOutput_1.pos = gl_FragCoord;
    _entryPointOutput_1.uvw = _entryPointOutput_uvw;
    cube_vert_output param = _entryPointOutput_1;
    _entryPointOutput = _skybox_frag_main(param);
}

