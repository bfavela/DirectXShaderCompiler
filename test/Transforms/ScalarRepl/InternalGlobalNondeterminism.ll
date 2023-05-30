; Scalar replacement was non-deterministic with the order of these globals due to pointer casting
;
; RUN: opt < %s -scalarrepl -S | FileCheck %s


@"\01?FrameParams_weather_windFlowMapPrevFrame@@3V?$Texture2D@V?$vector@M$03@@@@C" = external global %"class.Texture2D<vector<float, 4> >", align 4
@"\01?FrameParams_global_fakeMiscTexture@@3V?$Texture2D@V?$vector@M$03@@@@A" = external global %"class.Texture2D<vector<float, 4> >", align 4
@"\01?FrameParams_weather_windFlowMap@@3V?$Texture2D@V?$vector@M$03@@@@B" = external global %"class.Texture2D<vector<float, 4> >", align 4

%"class.Texture2D<vector<float, 4> >" = type { <4 x float>, %"class.Texture2D<vector<float, 4> >::mips_type" }
%"class.Texture2D<vector<float, 4> >::mips_type" = type { i32 }
%struct.FrameParams__Constants = type { <4 x i32> }

define void @test() {
  %1 = load %"class.Texture2D<vector<float, 4> >", %"class.Texture2D<vector<float, 4> >"* @"\01?FrameParams_global_fakeMiscTexture@@3V?$Texture2D@V?$vector@M$03@@@@A"
  %2 = load %"class.Texture2D<vector<float, 4> >", %"class.Texture2D<vector<float, 4> >"* @"\01?FrameParams_weather_windFlowMap@@3V?$Texture2D@V?$vector@M$03@@@@B"
  %3 = load %"class.Texture2D<vector<float, 4> >", %"class.Texture2D<vector<float, 4> >"* @"\01?FrameParams_weather_windFlowMapPrevFrame@@3V?$Texture2D@V?$vector@M$03@@@@C"

   ret void
}


; CHECK: alloca [
