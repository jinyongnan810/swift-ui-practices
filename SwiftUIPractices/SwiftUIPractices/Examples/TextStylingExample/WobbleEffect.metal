//
//  WobbleEffect.metal
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/21.
//

#include <metal_stdlib>
using namespace metal;

[[stitchable]]
float2 wobble(float2 position, float amplitute) {
    return float2(position.x, position.y + sin(position.x) * amplitute);
}
