## Main actor-isolated property 'n' can not be referenced from a Sendable closure; this is an error in the Swift 6 language mode

### before

```swift
struct CosineTaylorPolynomialView: View {
    @State private var n = 1.0

    var body: some View {
        VStack {
            Chart {
                LinePlot(x: "x", y: "y") { x in
                    cos(x)
                }.foregroundStyle(.green)
                LinePlot(x: "x", y: "y") { _ in
                    1
                }.foregroundStyle(.black)
                LinePlot(x: "x", y: "y") { x in
                    taylorSeries(x: x, n: n)
                }.foregroundStyle(.red)
            }
            .chartXScale(domain: -10 ... 10)
            .chartYScale(domain: -10 ... 10)
            .aspectRatio(contentMode: .fit)
            .padding()

            Text("n = \(n.formatted())")
            Slider(value: $n, in: 1 ... 10, step: 1)
        }.padding()
    }
}
```

### after

```swift
struct CosineTaylorPolynomialView: View {
    @State private var n = 1.0

    var body: some View {
        VStack {
            Chart { [n] in // add this, or add let n = n
                LinePlot(x: "x", y: "y") { x in
                    cos(x)
                }.foregroundStyle(.green)
                LinePlot(x: "x", y: "y") { _ in
                    1
                }.foregroundStyle(.black)
                LinePlot(x: "x", y: "y") { x in
                    taylorSeries(x: x, n: n)
                }.foregroundStyle(.red)
            }
            .chartXScale(domain: -10 ... 10)
            .chartYScale(domain: -10 ... 10)
            .aspectRatio(contentMode: .fit)
            .padding()

            Text("n = \(n.formatted())")
            Slider(value: $n, in: 1 ... 10, step: 1)
        }.padding()
    }
}
```
