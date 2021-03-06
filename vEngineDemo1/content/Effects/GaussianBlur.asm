//
// FX Version: fx_5_0
//
// 1 local buffer(s)
//
cbuffer CBufferPerFrame
{
    float2  SampleOffsets[9];           // Offset:    0, size:  136
    float   SampleWeights[9];           // Offset:  144, size:  132
}

//
// 2 local object(s)
//
Texture2D ColorTexture;
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
    // 2 technique(s)
    //
    technique11 blur
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
                // cbuffer CBufferPerFrame
                // {
                //
                //   float2 SampleOffsets[9];           // Offset:    0 Size:   136
                //   float SampleWeights[9];            // Offset:  144 Size:   132
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
                // CBufferPerFrame                   cbuffer      NA          NA    0        1
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
                dcl_constantbuffer cb0[18], dynamicIndexed
                dcl_sampler s0, mode_default
                dcl_resource_texture2d (float,float,float,float) t0
                dcl_input_ps linear v1.xy
                dcl_output o0.xyzw
                dcl_temps 3
                mov r0.xyzw, l(0,0,0,0)
                mov r1.x, l(0)
                loop 
                  ige r1.y, r1.x, l(9)
                  breakc_nz r1.y
                  add r1.yz, v1.xxyx, cb0[r1.x + 0].xxyx
                  sample_indexable(texture2d)(float,float,float,float) r2.xyzw, r1.yzyy, t0.xyzw, s0
                  mad r0.xyzw, r2.xyzw, cb0[r1.x + 9].xxxx, r0.xyzw
                  iadd r1.x, r1.x, l(1)
                endloop 
                mov o0.xyzw, r0.xyzw
                ret 
                // Approximately 12 instruction slots used
                            
            };
        }

    }

    technique11 no_blur
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

