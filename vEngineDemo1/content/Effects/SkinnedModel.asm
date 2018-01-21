//
// FX Version: fx_5_0
//
// 3 local buffer(s)
//
cbuffer CBufferPerFrame
{
    float4  AmbientColor = { 1, 1, 1, 0 };// Offset:    0, size:   16
    float4  LightColor = { 1 };         // Offset:   16, size:   16
    float3  LightPosition = { 0 };      // Offset:   32, size:   12
    float   LightRadius = 10;           // Offset:   44, size:    4
    float3  CameraPosition;             // Offset:   48, size:   12
}

cbuffer CBufferPerObject
{
    float4x4 WorldViewProjection : WORLDVIEWPROJECTION;// Offset:    0, size:   64
    float4x4 World : WORLD;             // Offset:   64, size:   64
    float4  SpecularColor : SPECULAR = { 1 };// Offset:  128, size:   16
    float   SpecularPower : SPECULARPOWER = 25;// Offset:  144, size:    4
}

cbuffer CBufferSkinning
{
    float4x4 BoneTransforms[60];        // Offset:    0, size: 3840
}

//
// 2 local object(s)
//
Texture2D ColorTexture;
SamplerState ColorSampler
{
    Filter   = uint(MIN_MAG_MIP_LINEAR /* 21 */);
    AddressU = uint(WRAP /* 1 */);
    AddressV = uint(WRAP /* 1 */);
};

//
// 1 groups(s)
//
fxgroup
{
    //
    // 1 technique(s)
    //
    technique11 main11
    {
        pass p0
        {
            VertexShader = asm {
                //
                // Generated by Microsoft (R) HLSL Shader Compiler 6.3.9600.16384
                //
                //
                // Buffer Definitions: 
                //
                // cbuffer CBufferPerFrame
                // {
                //
                //   float4 AmbientColor;               // Offset:    0 Size:    16 [unused]
                //      = 0x3f800000 0x3f800000 0x3f800000 0x00000000 
                //   float4 LightColor;                 // Offset:   16 Size:    16 [unused]
                //      = 0x3f800000 0x3f800000 0x3f800000 0x3f800000 
                //   float3 LightPosition;              // Offset:   32 Size:    12
                //      = 0x00000000 0x00000000 0x00000000 
                //   float LightRadius;                 // Offset:   44 Size:     4
                //      = 0x41200000 
                //   float3 CameraPosition;             // Offset:   48 Size:    12 [unused]
                //
                // }
                //
                // cbuffer CBufferPerObject
                // {
                //
                //   float4x4 WorldViewProjection;      // Offset:    0 Size:    64
                //   float4x4 World;                    // Offset:   64 Size:    64
                //   float4 SpecularColor;              // Offset:  128 Size:    16 [unused]
                //      = 0x3f800000 0x3f800000 0x3f800000 0x3f800000 
                //   float SpecularPower;               // Offset:  144 Size:     4 [unused]
                //      = 0x41c80000 
                //
                // }
                //
                // cbuffer CBufferSkinning
                // {
                //
                //   float4x4 BoneTransforms[60];       // Offset:    0 Size:  3840
                //
                // }
                //
                //
                // Resource Bindings:
                //
                // Name                                 Type  Format         Dim Slot Elements
                // ------------------------------ ---------- ------- ----------- ---- --------
                // CBufferPerFrame                   cbuffer      NA          NA    0        1
                // CBufferPerObject                  cbuffer      NA          NA    1        1
                // CBufferSkinning                   cbuffer      NA          NA    2        1
                //
                //
                //
                // Input signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // POSITION                 0   xyzw        0     NONE   float   xyzw
                // TEXCOORD                 0   xy          1     NONE   float   xy  
                // NORMAL                   0   xyz         2     NONE   float   xyz 
                // BONEINDICES              0   xyzw        3     NONE    uint   xyzw
                // WEIGHTS                  0   xyzw        4     NONE   float   xyzw
                //
                //
                // Output signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // SV_Position              0   xyzw        0      POS   float   xyzw
                // NORMAL                   0   xyz         1     NONE   float   xyz 
                // TEXCOORD                 0   xy          2     NONE   float   xy  
                // TEXCOORD                 2     z         2     NONE   float     z 
                // TEXCOORD                 1   xyz         3     NONE   float   xyz 
                //
                vs_5_0
                dcl_globalFlags refactoringAllowed
                dcl_constantbuffer cb0[3], immediateIndexed
                dcl_constantbuffer cb1[7], immediateIndexed
                dcl_constantbuffer cb2[240], dynamicIndexed
                dcl_input v0.xyzw
                dcl_input v1.xy
                dcl_input v2.xyz
                dcl_input v3.xyzw
                dcl_input v4.xyzw
                dcl_output_siv o0.xyzw, position
                dcl_output o1.xyz
                dcl_output o2.xy
                dcl_output o2.z
                dcl_output o3.xyz
                dcl_temps 4
                ishl r0.xyzw, v3.xyzw, l(2, 2, 2, 2)
                mul r1.xyzw, v4.yyyy, cb2[r0.y + 0].xyzw
                mad r1.xyzw, cb2[r0.x + 0].xyzw, v4.xxxx, r1.xyzw
                mad r1.xyzw, cb2[r0.z + 0].xyzw, v4.zzzz, r1.xyzw
                mad r1.xyzw, cb2[r0.w + 0].xyzw, v4.wwww, r1.xyzw
                dp4 r2.x, v0.xyzw, r1.xyzw
                dp3 r1.x, v2.xyzx, r1.xyzx
                mul r3.xyzw, v4.yyyy, cb2[r0.y + 1].xyzw
                mad r3.xyzw, cb2[r0.x + 1].xyzw, v4.xxxx, r3.xyzw
                mad r3.xyzw, cb2[r0.z + 1].xyzw, v4.zzzz, r3.xyzw
                mad r3.xyzw, cb2[r0.w + 1].xyzw, v4.wwww, r3.xyzw
                dp4 r2.y, v0.xyzw, r3.xyzw
                dp3 r1.y, v2.xyzx, r3.xyzx
                mul r3.xyzw, v4.yyyy, cb2[r0.y + 2].xyzw
                mad r3.xyzw, cb2[r0.x + 2].xyzw, v4.xxxx, r3.xyzw
                mad r3.xyzw, cb2[r0.z + 2].xyzw, v4.zzzz, r3.xyzw
                mad r3.xyzw, cb2[r0.w + 2].xyzw, v4.wwww, r3.xyzw
                dp4 r2.z, v0.xyzw, r3.xyzw
                dp3 r1.z, v2.xyzx, r3.xyzx
                mul r3.xyzw, v4.yyyy, cb2[r0.y + 3].xyzw
                mad r3.xyzw, cb2[r0.x + 3].xyzw, v4.xxxx, r3.xyzw
                mad r3.xyzw, cb2[r0.z + 3].xyzw, v4.zzzz, r3.xyzw
                mad r0.xyzw, cb2[r0.w + 3].xyzw, v4.wwww, r3.xyzw
                dp4 r2.w, v0.xyzw, r0.xyzw
                dp3 r1.w, v2.xyzx, r0.xyzx
                dp4 o0.x, r2.xyzw, cb1[0].xyzw
                dp4 o0.y, r2.xyzw, cb1[1].xyzw
                dp4 o0.z, r2.xyzw, cb1[2].xyzw
                dp4 o0.w, r2.xyzw, cb1[3].xyzw
                dp4 r0.x, r1.xyzw, cb1[4].xyzw
                dp4 r0.y, r1.xyzw, cb1[5].xyzw
                dp4 r0.z, r1.xyzw, cb1[6].xyzw
                dp3 r0.w, r0.xyzx, r0.xyzx
                rsq r0.w, r0.w
                mul o1.xyz, r0.wwww, r0.xyzx
                dp4 r0.x, r2.xyzw, cb1[4].xyzw
                dp4 r0.y, r2.xyzw, cb1[5].xyzw
                dp4 r0.z, r2.xyzw, cb1[6].xyzw
                add r1.xyz, -r0.xyzx, cb0[2].xyzx
                mov o3.xyz, r0.xyzx
                dp3 r0.x, r1.xyzx, r1.xyzx
                sqrt r0.x, r0.x
                div r0.x, r0.x, cb0[2].w
                add_sat o2.z, -r0.x, l(1.000000)
                mov o2.xy, v1.xyxx
                ret 
                // Approximately 46 instruction slots used
                            
            };
            GeometryShader = NULL;
            PixelShader = asm {
                //
                // Generated by Microsoft (R) HLSL Shader Compiler 6.3.9600.16384
                //
                //
                // Buffer Definitions: 
                //
                // cbuffer CBufferPerFrame
                // {
                //
                //   float4 AmbientColor;               // Offset:    0 Size:    16
                //      = 0x3f800000 0x3f800000 0x3f800000 0x00000000 
                //   float4 LightColor;                 // Offset:   16 Size:    16
                //      = 0x3f800000 0x3f800000 0x3f800000 0x3f800000 
                //   float3 LightPosition;              // Offset:   32 Size:    12
                //      = 0x00000000 0x00000000 0x00000000 
                //   float LightRadius;                 // Offset:   44 Size:     4 [unused]
                //      = 0x41200000 
                //   float3 CameraPosition;             // Offset:   48 Size:    12
                //
                // }
                //
                // cbuffer CBufferPerObject
                // {
                //
                //   float4x4 WorldViewProjection;      // Offset:    0 Size:    64 [unused]
                //   float4x4 World;                    // Offset:   64 Size:    64 [unused]
                //   float4 SpecularColor;              // Offset:  128 Size:    16
                //      = 0x3f800000 0x3f800000 0x3f800000 0x3f800000 
                //   float SpecularPower;               // Offset:  144 Size:     4
                //      = 0x41c80000 
                //
                // }
                //
                //
                // Resource Bindings:
                //
                // Name                                 Type  Format         Dim Slot Elements
                // ------------------------------ ---------- ------- ----------- ---- --------
                // ColorSampler                      sampler      NA          NA    0        1
                // ColorTexture                      texture  float4          2d    0        1
                // CBufferPerFrame                   cbuffer      NA          NA    0        1
                // CBufferPerObject                  cbuffer      NA          NA    1        1
                //
                //
                //
                // Input signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // SV_Position              0   xyzw        0      POS   float       
                // NORMAL                   0   xyz         1     NONE   float   xyz 
                // TEXCOORD                 0   xy          2     NONE   float   xy  
                // TEXCOORD                 2     z         2     NONE   float     z 
                // TEXCOORD                 1   xyz         3     NONE   float   xyz 
                //
                //
                // Output signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // SV_Target                0   xyzw        0   TARGET   float   xyzw
                //
                ps_5_0
                dcl_globalFlags refactoringAllowed
                dcl_constantbuffer cb0[4], immediateIndexed
                dcl_constantbuffer cb1[10], immediateIndexed
                dcl_sampler s0, mode_default
                dcl_resource_texture2d (float,float,float,float) t0
                dcl_input_ps linear v1.xyz
                dcl_input_ps linear v2.xy
                dcl_input_ps linear v2.z
                dcl_input_ps linear v3.xyz
                dcl_output o0.xyzw
                dcl_temps 4
                add r0.xyz, -v3.xyzx, cb0[2].xyzx
                dp3 r0.w, r0.xyzx, r0.xyzx
                rsq r0.w, r0.w
                mul r0.xyz, r0.wwww, r0.xyzx
                add r1.xyz, -v3.xyzx, cb0[3].xyzx
                dp3 r0.w, r1.xyzx, r1.xyzx
                rsq r0.w, r0.w
                mad r1.xyz, r1.xyzx, r0.wwww, r0.xyzx
                dp3 r0.w, r1.xyzx, r1.xyzx
                rsq r0.w, r0.w
                mul r1.xyz, r0.wwww, r1.xyzx
                dp3 r0.w, v1.xyzx, v1.xyzx
                rsq r0.w, r0.w
                mul r2.xyz, r0.wwww, v1.xyzx
                dp3 r0.w, r2.xyzx, r1.xyzx
                dp3 r0.x, r2.xyzx, r0.xyzx
                ge r0.y, r0.w, l(0.000000)
                log r0.z, r0.w
                mul r0.z, r0.z, cb1[9].x
                exp r0.z, r0.z
                ge r0.w, r0.x, l(0.000000)
                max r0.x, r0.x, l(0.000000)
                and r0.y, r0.w, r0.y
                and r0.y, r0.z, r0.y
                sample_indexable(texture2d)(float,float,float,float) r1.xyzw, v2.xyxx, t0.xyzw, s0
                min r0.y, r0.y, r1.w
                mul r2.xyz, cb1[8].wwww, cb1[8].xyzx
                mul r0.yzw, r0.yyyy, r2.xxyz
                mul r2.xyz, r0.xxxx, r1.xyzx
                mul r3.xyz, cb0[1].wwww, cb0[1].xyzx
                mul r2.xyz, r2.xyzx, r3.xyzx
                mul r2.xyz, r2.xyzx, v2.zzzz
                mul r3.xyz, cb0[0].wwww, cb0[0].xyzx
                mad r1.xyz, r3.xyzx, r1.xyzx, r2.xyzx
                mad o0.xyz, r0.yzwy, v2.zzzz, r1.xyzx
                mov o0.w, l(1.000000)
                ret 
                // Approximately 37 instruction slots used
                            
            };
        }

    }

}
