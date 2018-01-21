//
// FX Version: fx_5_0
//
// 2 local buffer(s)
//
cbuffer CBufferPerFrame
{
    float4  AmbientColor = { 1, 1, 1, 0 };// Offset:    0, size:   16
    float4  LightColor = { 1 };         // Offset:   16, size:   16
    float3  LightPosition = { 0 };      // Offset:   32, size:   12
    float   LightRadius = 10;           // Offset:   44, size:    4
    float3  CameraPosition;             // Offset:   48, size:   12
    float2  ShadowMapSize = { 1024 };   // Offset:   64, size:    8
}

cbuffer CBufferPerObject
{
    float4x4 WorldViewProjection : WORLDVIEWPROJECTION;// Offset:    0, size:   64
    float4x4 World : WORLD;             // Offset:   64, size:   64
    float4  SpecularColor : SPECULAR = { 1 };// Offset:  128, size:   16
    float   SpecularPower : SPECULARPOWER = 25;// Offset:  144, size:    4
    float4x4 ProjectiveTextureMatrix;   // Offset:  160, size:   64
}

//
// 6 local object(s)
//
Texture2D ColorTexture;
Texture2D ShadowMap;
SamplerComparisonState PcfShadowMapSampler
{
    Filter   = uint(COMPARISON_MIN_MAG_LINEAR_MIP_POINT /* 148 */);
    AddressU = uint(BORDER /* 4 */);
    AddressV = uint(BORDER /* 4 */);
    BorderColor = float4(1, 1, 1, 1);
    ComparisonFunc = uint(LESS_EQUAL /* 4 */);
};
SamplerState ShadowMapSampler
{
    Filter   = uint(MIN_MAG_MIP_POINT /* 0 */);
    AddressU = uint(BORDER /* 4 */);
    AddressV = uint(BORDER /* 4 */);
    BorderColor = float4(1, 1, 1, 1);
};
SamplerState ColorSampler
{
    Filter   = uint(MIN_MAG_MIP_LINEAR /* 21 */);
    AddressU = uint(WRAP /* 1 */);
    AddressV = uint(WRAP /* 1 */);
};
RasterizerState BackFaceCulling
{
    CullMode = uint(BACK /* 3 */);
};

//
// 1 groups(s)
//
fxgroup
{
    //
    // 3 technique(s)
    //
    technique11 shadow_mapping
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
                //   float2 ShadowMapSize;              // Offset:   64 Size:     8 [unused]
                //      = 0x44800000 0x44800000 
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
                //   float4x4 ProjectiveTextureMatrix;  // Offset:  160 Size:    64
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
                // TEXCOORD                 3   xyzw        4     NONE   float   xyzw
                //
                vs_5_0
                dcl_globalFlags refactoringAllowed
                dcl_constantbuffer cb0[3], immediateIndexed
                dcl_constantbuffer cb1[14], immediateIndexed
                dcl_input v0.xyzw
                dcl_input v1.xy
                dcl_input v2.xyz
                dcl_output_siv o0.xyzw, position
                dcl_output o1.xyz
                dcl_output o2.xy
                dcl_output o2.z
                dcl_output o3.xyz
                dcl_output o4.xyzw
                dcl_temps 2
                dp4 o0.x, v0.xyzw, cb1[0].xyzw
                dp4 o0.y, v0.xyzw, cb1[1].xyzw
                dp4 o0.z, v0.xyzw, cb1[2].xyzw
                dp4 o0.w, v0.xyzw, cb1[3].xyzw
                dp3 r0.x, v2.xyzx, cb1[4].xyzx
                dp3 r0.y, v2.xyzx, cb1[5].xyzx
                dp3 r0.z, v2.xyzx, cb1[6].xyzx
                dp3 r0.w, r0.xyzx, r0.xyzx
                rsq r0.w, r0.w
                mul o1.xyz, r0.wwww, r0.xyzx
                dp4 r0.x, v0.xyzw, cb1[4].xyzw
                dp4 r0.y, v0.xyzw, cb1[5].xyzw
                dp4 r0.z, v0.xyzw, cb1[6].xyzw
                add r1.xyz, -r0.xyzx, cb0[2].xyzx
                mov o3.xyz, r0.xyzx
                dp3 r0.x, r1.xyzx, r1.xyzx
                sqrt r0.x, r0.x
                div r0.x, r0.x, cb0[2].w
                add_sat o2.z, -r0.x, l(1.000000)
                mov o2.xy, v1.xyxx
                dp4 o4.x, v0.xyzw, cb1[10].xyzw
                dp4 o4.y, v0.xyzw, cb1[11].xyzw
                dp4 o4.z, v0.xyzw, cb1[12].xyzw
                dp4 o4.w, v0.xyzw, cb1[13].xyzw
                ret 
                // Approximately 25 instruction slots used
                            
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
                //   float2 ShadowMapSize;              // Offset:   64 Size:     8 [unused]
                //      = 0x44800000 0x44800000 
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
                //   float4x4 ProjectiveTextureMatrix;  // Offset:  160 Size:    64 [unused]
                //
                // }
                //
                //
                // Resource Bindings:
                //
                // Name                                 Type  Format         Dim Slot Elements
                // ------------------------------ ---------- ------- ----------- ---- --------
                // ShadowMapSampler                  sampler      NA          NA    0        1
                // ColorSampler                      sampler      NA          NA    1        1
                // ColorTexture                      texture  float4          2d    0        1
                // ShadowMap                         texture  float4          2d    1        1
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
                // TEXCOORD                 3   xyzw        4     NONE   float   xyzw
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
                dcl_sampler s1, mode_default
                dcl_resource_texture2d (float,float,float,float) t0
                dcl_resource_texture2d (float,float,float,float) t1
                dcl_input_ps linear v1.xyz
                dcl_input_ps linear v2.xy
                dcl_input_ps linear v2.z
                dcl_input_ps linear v3.xyz
                dcl_input_ps linear v4.xyzw
                dcl_output o0.xyzw
                dcl_temps 5
                add r0.xyz, -v3.xyzx, cb0[2].xyzx
                dp3 r0.w, r0.xyzx, r0.xyzx
                rsq r0.w, r0.w
                mul r0.xyz, r0.wwww, r0.xyzx
                add r1.xyz, -v3.xyzx, cb0[3].xyzx
                dp3 r0.w, r1.xyzx, r1.xyzx
                rsq r0.w, r0.w
                dp3 r1.w, v1.xyzx, v1.xyzx
                rsq r1.w, r1.w
                mul r2.xyz, r1.wwww, v1.xyzx
                dp3 r1.w, r2.xyzx, r0.xyzx
                mad r0.xyz, r1.xyzx, r0.wwww, r0.xyzx
                dp3 r0.w, r0.xyzx, r0.xyzx
                rsq r0.w, r0.w
                mul r0.xyz, r0.wwww, r0.xyzx
                dp3 r0.x, r2.xyzx, r0.xyzx
                sample_indexable(texture2d)(float,float,float,float) r2.xyzw, v2.xyxx, t0.xyzw, s1
                ge r0.y, r1.w, l(0.000000)
                max r0.z, r1.w, l(0.000000)
                ge r0.w, r0.x, l(0.000000)
                and r0.y, r0.y, r0.w
                log r0.x, r0.x
                mul r0.x, r0.x, cb1[9].x
                exp r0.x, r0.x
                and r0.x, r0.x, r0.y
                mul r1.xyz, cb0[0].wwww, cb0[0].xyzx
                mul r0.yzw, r2.xxyz, r0.zzzz
                mul r3.xyz, cb0[1].wwww, cb0[1].xyzx
                mul r0.yzw, r0.yyzw, r3.xxyz
                mul r0.yzw, r0.yyzw, v2.zzzz
                min r0.x, r2.w, r0.x
                mul r3.xyz, cb1[8].wwww, cb1[8].xyzx
                mul r3.xyz, r0.xxxx, r3.xyzx
                mul r3.xyz, r3.xyzx, v2.zzzz
                ge r0.x, v4.w, l(0.000000)
                div r4.xyz, v4.xyzx, v4.wwww
                sample_indexable(texture2d)(float,float,float,float) r1.w, r4.xyxx, t1.yzwx, s0
                if_nz r0.x
                  add r0.x, r1.w, l(0.005000)
                  lt r0.x, r0.x, r4.z
                  movc r0.x, r0.x, l(0), l(1.000000)
                  mul r0.yzw, r0.xxxx, r0.yyzw
                  mul r3.xyz, r0.xxxx, r3.xyzx
                endif 
                mad r0.xyz, r1.xyzx, r2.xyzx, r0.yzwy
                add o0.xyz, r3.xyzx, r0.xyzx
                mov o0.w, l(1.000000)
                ret 
                // Approximately 48 instruction slots used
                            
            };
            RasterizerState = BackFaceCulling;
        }

    }

    technique11 shadow_mapping_manual_pcf
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
                //   float2 ShadowMapSize;              // Offset:   64 Size:     8 [unused]
                //      = 0x44800000 0x44800000 
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
                //   float4x4 ProjectiveTextureMatrix;  // Offset:  160 Size:    64
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
                // TEXCOORD                 3   xyzw        4     NONE   float   xyzw
                //
                vs_5_0
                dcl_globalFlags refactoringAllowed
                dcl_constantbuffer cb0[3], immediateIndexed
                dcl_constantbuffer cb1[14], immediateIndexed
                dcl_input v0.xyzw
                dcl_input v1.xy
                dcl_input v2.xyz
                dcl_output_siv o0.xyzw, position
                dcl_output o1.xyz
                dcl_output o2.xy
                dcl_output o2.z
                dcl_output o3.xyz
                dcl_output o4.xyzw
                dcl_temps 2
                dp4 o0.x, v0.xyzw, cb1[0].xyzw
                dp4 o0.y, v0.xyzw, cb1[1].xyzw
                dp4 o0.z, v0.xyzw, cb1[2].xyzw
                dp4 o0.w, v0.xyzw, cb1[3].xyzw
                dp3 r0.x, v2.xyzx, cb1[4].xyzx
                dp3 r0.y, v2.xyzx, cb1[5].xyzx
                dp3 r0.z, v2.xyzx, cb1[6].xyzx
                dp3 r0.w, r0.xyzx, r0.xyzx
                rsq r0.w, r0.w
                mul o1.xyz, r0.wwww, r0.xyzx
                dp4 r0.x, v0.xyzw, cb1[4].xyzw
                dp4 r0.y, v0.xyzw, cb1[5].xyzw
                dp4 r0.z, v0.xyzw, cb1[6].xyzw
                add r1.xyz, -r0.xyzx, cb0[2].xyzx
                mov o3.xyz, r0.xyzx
                dp3 r0.x, r1.xyzx, r1.xyzx
                sqrt r0.x, r0.x
                div r0.x, r0.x, cb0[2].w
                add_sat o2.z, -r0.x, l(1.000000)
                mov o2.xy, v1.xyxx
                dp4 o4.x, v0.xyzw, cb1[10].xyzw
                dp4 o4.y, v0.xyzw, cb1[11].xyzw
                dp4 o4.z, v0.xyzw, cb1[12].xyzw
                dp4 o4.w, v0.xyzw, cb1[13].xyzw
                ret 
                // Approximately 25 instruction slots used
                            
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
                //   float2 ShadowMapSize;              // Offset:   64 Size:     8
                //      = 0x44800000 0x44800000 
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
                //   float4x4 ProjectiveTextureMatrix;  // Offset:  160 Size:    64 [unused]
                //
                // }
                //
                //
                // Resource Bindings:
                //
                // Name                                 Type  Format         Dim Slot Elements
                // ------------------------------ ---------- ------- ----------- ---- --------
                // ShadowMapSampler                  sampler      NA          NA    0        1
                // ColorSampler                      sampler      NA          NA    1        1
                // ColorTexture                      texture  float4          2d    0        1
                // ShadowMap                         texture  float4          2d    1        1
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
                // TEXCOORD                 3   xyzw        4     NONE   float   xyzw
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
                dcl_constantbuffer cb0[5], immediateIndexed
                dcl_constantbuffer cb1[10], immediateIndexed
                dcl_sampler s0, mode_default
                dcl_sampler s1, mode_default
                dcl_resource_texture2d (float,float,float,float) t0
                dcl_resource_texture2d (float,float,float,float) t1
                dcl_input_ps linear v1.xyz
                dcl_input_ps linear v2.xy
                dcl_input_ps linear v2.z
                dcl_input_ps linear v3.xyz
                dcl_input_ps linear v4.xyzw
                dcl_output o0.xyzw
                dcl_temps 7
                add r0.xyz, -v3.xyzx, cb0[2].xyzx
                dp3 r0.w, r0.xyzx, r0.xyzx
                rsq r0.w, r0.w
                mul r0.xyz, r0.wwww, r0.xyzx
                add r1.xyz, -v3.xyzx, cb0[3].xyzx
                dp3 r0.w, r1.xyzx, r1.xyzx
                rsq r0.w, r0.w
                dp3 r1.w, v1.xyzx, v1.xyzx
                rsq r1.w, r1.w
                mul r2.xyz, r1.wwww, v1.xyzx
                dp3 r1.w, r2.xyzx, r0.xyzx
                mad r0.xyz, r1.xyzx, r0.wwww, r0.xyzx
                dp3 r0.w, r0.xyzx, r0.xyzx
                rsq r0.w, r0.w
                mul r0.xyz, r0.wwww, r0.xyzx
                dp3 r0.x, r2.xyzx, r0.xyzx
                sample_indexable(texture2d)(float,float,float,float) r2.xyzw, v2.xyxx, t0.xyzw, s1
                ge r0.y, r1.w, l(0.000000)
                max r0.z, r1.w, l(0.000000)
                ge r0.w, r0.x, l(0.000000)
                and r0.y, r0.y, r0.w
                log r0.x, r0.x
                mul r0.x, r0.x, cb1[9].x
                exp r0.x, r0.x
                and r0.x, r0.x, r0.y
                mul r1.xyz, cb0[0].wwww, cb0[0].xyzx
                mul r0.yzw, r2.xxyz, r0.zzzz
                mul r3.xyz, cb0[1].wwww, cb0[1].xyzx
                mul r0.yzw, r0.yyzw, r3.xxyz
                mul r0.yzw, r0.yyzw, v2.zzzz
                min r0.x, r2.w, r0.x
                mul r3.xyz, cb1[8].wwww, cb1[8].xyzx
                mul r3.xyz, r0.xxxx, r3.xyzx
                mul r3.xyz, r3.xyzx, v2.zzzz
                ge r0.x, v4.w, l(0.000000)
                div r4.xyz, v4.xyzx, v4.wwww
                div r5.xy, l(1.000000, 1.000000, 1.000000, 1.000000), cb0[4].xyxx
                sample_indexable(texture2d)(float,float,float,float) r1.w, r4.xyxx, t1.yzwx, s0
                mov r5.z, l(0)
                add r6.xyzw, r4.xyxy, r5.xzzy
                sample_indexable(texture2d)(float,float,float,float) r2.w, r6.xyxx, t1.yzwx, s0
                sample_indexable(texture2d)(float,float,float,float) r3.w, r6.zwzz, t1.yzwx, s0
                add r5.xy, r4.xyxx, r5.xyxx
                sample_indexable(texture2d)(float,float,float,float) r4.w, r5.xyxx, t1.yzwx, s0
                if_nz r0.x
                  add r0.x, r1.w, l(0.005000)
                  add r1.w, r2.w, l(0.005000)
                  add r2.w, r3.w, l(0.005000)
                  add r3.w, r4.w, l(0.005000)
                  lt r0.x, r0.x, r4.z
                  lt r1.w, r1.w, r4.z
                  movc r1.w, r1.w, l(0), l(1.000000)
                  lt r2.w, r2.w, r4.z
                  lt r3.w, r3.w, r4.z
                  movc r3.w, r3.w, l(0), l(1.000000)
                  mul r4.xy, r4.xyxx, cb0[4].xyxx
                  frc r4.xy, r4.xyxx
                  movc r4.zw, r0.xxxx, l(0,0,0,-0.000000), l(0,0,1.000000,-1.000000)
                  add r0.x, r1.w, r4.w
                  mad r0.x, r4.x, r0.x, r4.z
                  movc r4.zw, r2.wwww, l(0,0,0,-0.000000), l(0,0,1.000000,-1.000000)
                  add r1.w, r3.w, r4.w
                  mad r1.w, r4.x, r1.w, r4.z
                  add r1.w, -r0.x, r1.w
                  mad r0.x, r4.y, r1.w, r0.x
                  mul r0.yzw, r0.xxxx, r0.yyzw
                  mul r3.xyz, r0.xxxx, r3.xyzx
                endif 
                mad r0.xyz, r1.xyzx, r2.xyzx, r0.yzwy
                add o0.xyz, r3.xyzx, r0.xyzx
                mov o0.w, l(1.000000)
                ret 
                // Approximately 72 instruction slots used
                            
            };
            RasterizerState = BackFaceCulling;
        }

    }

    technique11 shadow_mapping_pcf
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
                //   float2 ShadowMapSize;              // Offset:   64 Size:     8 [unused]
                //      = 0x44800000 0x44800000 
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
                //   float4x4 ProjectiveTextureMatrix;  // Offset:  160 Size:    64
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
                // TEXCOORD                 3   xyzw        4     NONE   float   xyzw
                //
                vs_5_0
                dcl_globalFlags refactoringAllowed
                dcl_constantbuffer cb0[3], immediateIndexed
                dcl_constantbuffer cb1[14], immediateIndexed
                dcl_input v0.xyzw
                dcl_input v1.xy
                dcl_input v2.xyz
                dcl_output_siv o0.xyzw, position
                dcl_output o1.xyz
                dcl_output o2.xy
                dcl_output o2.z
                dcl_output o3.xyz
                dcl_output o4.xyzw
                dcl_temps 2
                dp4 o0.x, v0.xyzw, cb1[0].xyzw
                dp4 o0.y, v0.xyzw, cb1[1].xyzw
                dp4 o0.z, v0.xyzw, cb1[2].xyzw
                dp4 o0.w, v0.xyzw, cb1[3].xyzw
                dp3 r0.x, v2.xyzx, cb1[4].xyzx
                dp3 r0.y, v2.xyzx, cb1[5].xyzx
                dp3 r0.z, v2.xyzx, cb1[6].xyzx
                dp3 r0.w, r0.xyzx, r0.xyzx
                rsq r0.w, r0.w
                mul o1.xyz, r0.wwww, r0.xyzx
                dp4 r0.x, v0.xyzw, cb1[4].xyzw
                dp4 r0.y, v0.xyzw, cb1[5].xyzw
                dp4 r0.z, v0.xyzw, cb1[6].xyzw
                add r1.xyz, -r0.xyzx, cb0[2].xyzx
                mov o3.xyz, r0.xyzx
                dp3 r0.x, r1.xyzx, r1.xyzx
                sqrt r0.x, r0.x
                div r0.x, r0.x, cb0[2].w
                add_sat o2.z, -r0.x, l(1.000000)
                mov o2.xy, v1.xyxx
                dp4 o4.x, v0.xyzw, cb1[10].xyzw
                dp4 o4.y, v0.xyzw, cb1[11].xyzw
                dp4 o4.z, v0.xyzw, cb1[12].xyzw
                dp4 o4.w, v0.xyzw, cb1[13].xyzw
                ret 
                // Approximately 25 instruction slots used
                            
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
                //   float2 ShadowMapSize;              // Offset:   64 Size:     8 [unused]
                //      = 0x44800000 0x44800000 
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
                //   float4x4 ProjectiveTextureMatrix;  // Offset:  160 Size:    64 [unused]
                //
                // }
                //
                //
                // Resource Bindings:
                //
                // Name                                 Type  Format         Dim Slot Elements
                // ------------------------------ ---------- ------- ----------- ---- --------
                // PcfShadowMapSampler             sampler_c      NA          NA    0        1
                // ColorSampler                      sampler      NA          NA    1        1
                // ColorTexture                      texture  float4          2d    0        1
                // ShadowMap                         texture  float4          2d    1        1
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
                // TEXCOORD                 3   xyzw        4     NONE   float   xyzw
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
                dcl_sampler s0, mode_comparison
                dcl_sampler s1, mode_default
                dcl_resource_texture2d (float,float,float,float) t0
                dcl_resource_texture2d (float,float,float,float) t1
                dcl_input_ps linear v1.xyz
                dcl_input_ps linear v2.xy
                dcl_input_ps linear v2.z
                dcl_input_ps linear v3.xyz
                dcl_input_ps linear v4.xyzw
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
                sample_indexable(texture2d)(float,float,float,float) r1.xyzw, v2.xyxx, t0.xyzw, s1
                min r0.y, r0.y, r1.w
                mul r2.xyz, cb1[8].wwww, cb1[8].xyzx
                mul r0.yzw, r0.yyyy, r2.xxyz
                mul r0.yzw, r0.yyzw, v2.zzzz
                mul r2.xyz, r0.xxxx, r1.xyzx
                mul r3.xyz, cb0[1].wwww, cb0[1].xyzx
                mul r2.xyz, r2.xyzx, r3.xyzx
                mul r2.xyz, r2.xyzx, v2.zzzz
                div r3.xyz, v4.xyzx, v4.wwww
                sample_c_lz_indexable(texture2d)(float,float,float,float) r0.x, r3.xyxx, t1.xxxx, s0, r3.z
                mul r2.xyz, r0.xxxx, r2.xyzx
                mul r3.xyz, cb0[0].wwww, cb0[0].xyzx
                mad r1.xyz, r3.xyzx, r1.xyzx, r2.xyzx
                mad o0.xyz, r0.yzwy, r0.xxxx, r1.xyzx
                mov o0.w, l(1.000000)
                ret 
                // Approximately 41 instruction slots used
                            
            };
            RasterizerState = BackFaceCulling;
        }

    }

}

