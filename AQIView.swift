import SwiftUI
import Charts
struct AQIView: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}
var safePollutants: [AQIView] = [
    .init(type: "PM2.5", count: 9.0),
    .init(type: "PM10", count: 150),
    .init(type: "NO2", count: 188)
]
    
var data: [AQIView] = [
    .init(type: "PM2.5", count: 10.0),
    .init(type: "PM10", count: 160.0),
    .init(type: "NO2", count: 168.0)
]

struct chartPage: View {
    var factsOverlay: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(
                RadialGradient(
                    colors: [.teal, .white],
                    center: .center,
                    startRadius: 100,
                    endRadius: 800)
            )
            .frame(width: 350, height: 350)
            .offset(x: 0, y: 200)
        
    } // factsOverlay
    var safeChart: some View {
        Chart {
            ForEach(safePollutants) { shape in
                BarMark(
                    x: .value("Shape Color", safePollutants[0].type),
                    y: .value("Total Count", safePollutants[0].count)
                )
                .foregroundStyle(.gray)
                BarMark(
                    x: .value("Shape Color", safePollutants[1].type),
                    y: .value("Total Count", safePollutants[1].count)
                )
                .foregroundStyle(.gray)
                BarMark(
                    x: .value("Shape Color", safePollutants[2].type),
                    y: .value("Total Count", safePollutants[2].count)
                )
                .foregroundStyle(.gray)
            } // ForEach
        } // Chart
        .frame(width: 300, height: 300, alignment: .top)
        .offset(x: 0, y: -185)
        .opacity(0.5)
    } // safeChart
    
    var aboutText: some View {
       VStack {
           Text("PM2.5")
               .font(.title3)
           Text("For every increase in PM2.5 concentration, risks of mental illnesses such as depression increase by 6.67%.")
           Text("PM10")
               .font(.title3)
           Text("For every 19 micrograms per cubic meters, risk  of emergency visits for depressive episodes increased by 7.2%.")
           Text("NO2")
               .font(.title3)
           Text("This pollutant can have a negative impact on your sleep, which can affect mental health")
       }
       .frame(width: 300.0) // VStack
       .offset(x: 0, y: +200)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    RadialGradient(
                        colors: [.white, .teal],
                        center: .center,
                        startRadius: 0.0,
                        endRadius: 650)
                )
        } // ZStack
        .ignoresSafeArea()
        .overlay(
            VStack {
                Chart {
                    ForEach(data) { shape in
                        BarMark(
                            x: .value("Shape Color", data[0].type),
                            y: .value("Total Count", data[0].count)
                        )
                        .foregroundStyle(.teal)
                        BarMark(
                            x: .value("Shape Color", data[1].type),
                            y: .value("Total Count", data[1].count)
                        )
                        .foregroundStyle(.teal)
                        BarMark(
                            x: .value("Shape Color", data[2].type),
                            y: .value("Total Count", data[2].count)
                        )
                        .foregroundStyle(.teal)
                    } // ForEach
                } // Chart
                .frame(width: 300, height: 300, alignment: .top)
                .offset(x: 0, y: -160)
                Text("Today's Pollutants")
                    .font(.custom("Copperplate", fixedSize: 35))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.teal)
                    .offset(x: 0, y: -160)
                    .padding(0)
            } // VStack
            ) // overlay
        
        
        .overlay(factsOverlay)
        .overlay(safeChart)
        .overlay(aboutText)
    }
}

#Preview {
    chartPage()
}
