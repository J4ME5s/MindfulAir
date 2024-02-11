

import SwiftUI

enum cityName: String, CaseIterable, Identifiable {
    case nyc, atl, chicago, la
    var id: Self { self }
}

struct ContentView: View {
    
    @State public var cityInput: String = String()
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(
                        RadialGradient(
                            colors: [.white, .teal],
                            center: .center,
                            startRadius: 0.0,
                            endRadius: 650)
                    )
            }
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Image("Image")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("Welcome to Mindful Air")
                        .font(Font.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.teal)
                    Text("Choose a city to get started")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.teal)
                    
                    TextField("Your City Here", text: $cityInput)
                        .frame(width: 250.0)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: chartPage()) {
                        // Reformat this "button" later
                        Text("Enter")
                    }
                    .padding()
                })
        }
    }
}


#Preview {
    ContentView()
}
