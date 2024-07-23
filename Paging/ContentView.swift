//

import SwiftUI

struct LazyPageView<Content: View>: View {
    @ViewBuilder var content: Content
    @State private var idx = 0
    var body: some View {
        Group(subviews: content) { coll in
            VStack {
                HStack {
                    Button("Previous") { idx -= 1 }
                        .disabled(idx < 1)
                    Button("Next") { idx += 1 }
                        .disabled(idx >= coll.endIndex-1)
                }
            }
            HStack {
                let range = idx == 0 ? idx...idx : idx-1...idx
                ForEach(range, id: \.self) { ix in
                    coll[ix]
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        LazyPageView {
            ForEach(0..<100) { ix in
                VStack {
                    Text("Subview \(ix)")
                    Counter()
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hue: .init(ix)/100, saturation: 0.8, brightness: 0.9), in: .rect(cornerRadius: 8))
                .onAppear {
                    print("onAppear", ix)
                }
            }
        }
        .font(.largeTitle)
        .padding()
    }
}

struct Counter: View {
    @State var value = 0
    var body: some View {
        Button("\(value)") { value += 1 }
    }
}

#Preview {
    ContentView()
}
