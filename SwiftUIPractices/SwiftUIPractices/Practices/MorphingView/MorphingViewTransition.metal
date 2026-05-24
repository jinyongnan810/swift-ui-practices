#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;

// Samples the already-composited SwiftUI layer after the opacity transition.
// Pixels with enough alpha are restored to full opacity; faint pixels are
// discarded. This creates the hard morphing cutoff used by MorphingModifier.
[[ stitchable ]]
half4 MorphingOpacityCutoff(float2 position, SwiftUI::Layer layer) {
    half4 color = layer.sample(position);

    if (color.a >= half(0.5)) {
        // SwiftUI layer samples are premultiplied, so divide RGB by alpha before
        // returning a fully opaque color.
        half alpha = max(color.a, half(0.0001));
        return half4(color.rgb / alpha, half(1.0));
    }

    return half4(0.0);
}
