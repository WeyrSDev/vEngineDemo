//
// FX Version: fx_5_0
//
// 1 local buffer(s)
//
cbuffer CBufferPerObject
{
    float   BloomThreshold = 0.300000012;// Offset:    0, size:    4
    float   BloomIntensity = 1.25;      // Offset:    4, size:    4
    float   BloomSaturation = 1;        // Offset:    8, size:    4
    float   SceneIntensity = 1;         // Offset:   12, size:    4
    float   SceneSaturation = 1;        // Offset:   16, size:    4
}

//
// 3 local object(s)
//
Texture2D ColorTexture;
Texture2D BloomTexture;
SamplerState TrilinearSampler
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
    // 3 technique(s)
    //
    technique11 bloom_extract
    {
        pass p0
        {
            VertexShader = asm {
                //
                // Generated by Microsoft (R) HLSL Shader Compiler 6.3.9600.16384
                //
                //
                //
                // Input signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // POSITION                 0   xyzw        0     NONE   float   xyzw
                // TEXCOORD                 0   xy          1     NONE   float   xy  
                //
                //
                // Output signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // SV_Position              0   xyzw        0      POS   float   xyzw
                // TEXCOORD                 0   xy          1     NONE   float   xy  
                //
                vs_5_0
                dcl_globalFlags refactoringAllowed
                dcl_input v0.xyzw
                dcl_input v1.xy
                dcl_output_siv o0.xyzw, position
                dcl_output o1.xy
                mov o0.xyzw, v0.xyzw
                mov o1.xy, v1.xyxx
                ret 
                // Approximately 3 instruction slots used
                            
            };
            GeometryShader = NULL;
            PixelShader = asm {
                //
                // Generated by Microsoft (R) HLSL Shader Compiler 6.3.9600.16384
                //
                //
                // Buffer Definitions: 
                //
                // cbuffer CBufferPerObject
                // {
                //
                //   float BloomThreshold;              // Offset:    0 Size:     4
                //      = 0x3e99999a 
                //   float BloomIntensity;              // Offset:    4 Size:     4 [unused]
                //      = 0x3fa00000 
                //   float BloomSaturation;             // Offset:    8 Size:     4 [unused]
                //      = 0x3f800000 
                //   float SceneIntensity;              // Offset:   12 Size:     4 [unused]
                //      = 0x3f800000 
                //   float SceneSaturation;             // Offset:   16 Size:     4 [unused]
                //      = 0x3f800000 
                //
                // }
                //
                //
                // Resource Bindings:
                //
                // Name                                 Type  Format         Dim Slot Elements
                // ------------------------------ ---------- ------- ----------- ---- --------
                // TrilinearSampler                  sampler      NA          NA    0        1
                // ColorTexture                      texture  float4          2d    0        1
                // CBufferPerObject                  cbuffer      NA          NA    0        1
                //
                //
                //
                // Input signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // SV_Position              0   xyzw        0      POS   float       
                // TEXCOORD                 0   xy          1     NONE   float   xy  
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
                dcl_constantbuffer cb0[1], immediateIndexed
                dcl_sampler s0, mode_default
                dcl_resource_texture2d (float,float,float,float) t0
                dcl_input_ps linear v1.xy
                dcl_output o0.xyzw
                dcl_temps 2
                sample_indexable(texture2d)(float,float,float,float) r0.xyzw, v1.xyxx, t0.xyzw, s0
                add r0.xyzw, r0.xyzw, -cb0[0].xxxx
                add r1.x, -cb0[0].x, l(1.000000)
                div_sat o0.xyzw, r0.xyzw, r1.xxxx
                ret 
                // Approximately 5 instruction slots used
                            
            };
        }

    }

    technique11 bloom_composite
    {
        pass p0
        {
            VertexShader = asm {
                //
                // Generated by Microsoft (R) HLSL Shader Compiler 6.3.9600.16384
                //
                //
                //
                // Input signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // POSITION                 0   xyzw        0     NONE   float   xyzw
                // TEXCOORD                 0   xy          1     NONE   float   xy  
                //
                //
                // Output signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // SV_Position              0   xyzw        0      POS   float   xyzw
                // TEXCOORD                 0   xy          1     NONE   float   xy  
                //
                vs_5_0
                dcl_globalFlags refactoringAllowed
                dcl_input v0.xyzw
                dcl_input v1.xy
                dcl_output_siv o0.xyzw, position
                dcl_output o1.xy
                mov o0.xyzw, v0.xyzw
                mov o1.xy, v1.xyxx
                ret 
                // Approximately 3 instruction slots used
                            
            };
            GeometryShader = NULL;
            PixelShader = asm {
                //
                // Generated by Microsoft (R) HLSL Shader Compiler 6.3.9600.16384
                //
                //
                // Buffer Definitions: 
                //
                // cbuffer CBufferPerObject
                // {
                //
                //   float BloomThreshold;              // Offset:    0 Size:     4 [unused]
                //      = 0x3e99999a 
                //   float BloomIntensity;              // Offset:    4 Size:     4
                //      = 0x3fa00000 
                //   float BloomSaturation;             // Offset:    8 Size:     4
                //      = 0x3f800000 
                //   float SceneIntensity;              // Offset:   12 Size:     4
                //      = 0x3f800000 
                //   float SceneSaturation;             // Offset:   16 Size:     4
                //      = 0x3f800000 
                //
                // }
                //
                //
                // Resource Bindings:
                //
                // Name                                 Type  Format         Dim Slot Elements
                // ------------------------------ ---------- ------- ----------- ---- --------
                // TrilinearSampler                  sampler      NA          NA    0        1
                // ColorTexture                      texture  float4          2d    0        1
                // BloomTexture                      texture  float4          2d    1        1
                // CBufferPerObject                  cbuffer      NA          NA    0        1
                //
                //
                //
                // Input signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // SV_Position              0   xyzw        0      POS   float       
                // TEXCOORD                 0   xy          1     NONE   float   xy  
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
                dcl_constantbuffer cb0[2], immediateIndexed
                dcl_sampler s0, mode_default
                dcl_resource_texture2d (float,float,float,float) t0
                dcl_resource_texture2d (float,float,float,float) t1
                dcl_input_ps linear v1.xy
                dcl_output o0.xyzw
                dcl_temps 3
                sample_indexable(texture2d)(float,float,float,float) r0.xyzw, v1.xyxx, t0.xyzw, s0
                dp3 r1.x, r0.xyzx, l(0.299000, 0.587000, 0.114000, 0.000000)
                add r1.yzw, r0.xxyz, -r1.xxxx
                mad r0.xyz, cb0[1].xxxx, r1.yzwy, r1.xxxx
                mul r0.xyzw, r0.xyzw, cb0[0].wwww
                sample_indexable(texture2d)(float,float,float,float) r1.xyzw, v1.xyxx, t1.xyzw, s0
                dp3 r2.x, r1.xyzx, l(0.299000, 0.587000, 0.114000, 0.000000)
                add r2.yzw, r1.xxyz, -r2.xxxx
                mad r1.xyz, cb0[0].zzzz, r2.yzwy, r2.xxxx
                mul r1.xyzw, r1.xyzw, cb0[0].yyyy
                mov_sat r2.xyzw, r1.xyzw
                add r2.xyzw, -r2.xyzw, l(1.000000, 1.000000, 1.000000, 1.000000)
                mad o0.xyzw, r0.xyzw, r2.xyzw, r1.xyzw
                ret 
                // Approximately 14 instruction slots used
                            
            };
        }

    }

    technique11 no_bloom
    {
        pass p0
        {
            VertexShader = asm {
                //
                // Generated by Microsoft (R) HLSL Shader Compiler 6.3.9600.16384
                //
                //
                //
                // Input signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // POSITION                 0   xyzw        0     NONE   float   xyzw
                // TEXCOORD                 0   xy          1     NONE   float   xy  
                //
                //
                // Output signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // SV_Position              0   xyzw        0      POS   float   xyzw
                // TEXCOORD                 0   xy          1     NONE   float   xy  
                //
                vs_5_0
                dcl_globalFlags refactoringAllowed
                dcl_input v0.xyzw
                dcl_input v1.xy
                dcl_output_siv o0.xyzw, position
                dcl_output o1.xy
                mov o0.xyzw, v0.xyzw
                mov o1.xy, v1.xyxx
                ret 
                // Approximately 3 instruction slots used
                            
            };
            GeometryShader = NULL;
            PixelShader = asm {
                //
                // Generated by Microsoft (R) HLSL Shader Compiler 6.3.9600.16384
                //
                //
                // Resource Bindings:
                //
                // Name                                 Type  Format         Dim Slot Elements
                // ------------------------------ ---------- ------- ----------- ---- --------
                // TrilinearSampler                  sampler      NA          NA    0        1
                // ColorTexture                      texture  float4          2d    0        1
                //
                //
                //
                // Input signature:
                //
                // Name                 Index   Mask Register SysValue  Format   Used
                // -------------------- ----- ------ -------- -------- ------- ------
                // SV_Position              0   xyzw        0      POS   float       
                // TEXCOORD                 0   xy          1     NONE   float   xy  
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
                dcl_sampler s0, mode_default
                dcl_resource_texture2d (float,float,float,float) t0
                dcl_input_ps linear v1.xy
                dcl_output o0.xyzw
                sample_indexable(texture2d)(float,float,float,float) o0.xyzw, v1.xyxx, t0.xyzw, s0
                ret 
                // Approximately 2 instruction slots used
                            
            };
        }

    }

}

