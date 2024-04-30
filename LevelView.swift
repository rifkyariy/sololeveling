import SwiftUI

struct LevelView: View {
    @Binding var name: String
    @Binding var height: String
    @Binding var weight: String
    @Binding var currentDate: String
    @Binding var currentDay: String
    
    // Data
    @State var playerInfo: PlayerInfo?
    @State var questCount: String?
    
    // Radar Chart Data
    let attributes: [String] = ["STR", "INT", "SOC", "FOC", "LUC"]
    @State var attributeValues: [Double] = [4, 3, 2, 5, 4] // Example values
    
    // State
    @State var isNavigate = false
    
    var body: some View {
        ZStack {
            Color("PrimaryColor").edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                // Hero
                HStack(alignment: .center) {
                    Image("DefaultUser")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 10
                            )
                        )
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Hi ,\(self.name)")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .fontWeight(.black)
                        
                        Text(self.playerInfo?.title ?? "player_title")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                        
                        Text("150/300 EXP")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 5) {
                        Text("Level")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                        
                        // Level badge
                        Text("3 🔥")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                // Recap
                Text("Level Progress")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                
                // Radar Chart with Background
                ZStack {
                    RadarChartBackground(numberOfCircles: 5)
                        .stroke(Color.gray.opacity(0.1), lineWidth: 1) // Optional: Adjust line color and width
                        .frame(width: 200, height: 200)
                    
                    RadarChart(values: self.attributeValues, maxValue: 5, labels: self.attributes)
                        .frame(width: 200, height: 200)
                }
                .padding()
                
                // Stats
                VStack(alignment: .leading, spacing: 10) {
                    // Example stats
                    StatRow(title: "Strength", value: "1")
                    StatRow(title: "Intelligence", value: "2")
                    StatRow(title: "Focus", value: "5")
                    StatRow(title: "Socials", value: "3")
                    StatRow(title: "Luck", value: "1")
                    
                    StatRow(title: "Height", value: "\(self.height) cm")
                    StatRow(title: "Weight", value: "\(self.weight) kg")
                    StatRow(title: "Join Date", value: "\(self.currentDate)")
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                
                Spacer()
            }
        }
        .onAppear {
            self.fetchData()
        }
    }
    
    func fetchData() {
        let player = Helper.decodeJSONString()
        
        if let player = player {
            self.name = player.playerInfo.name
            self.height = String(player.playerInfo.height)
            self.weight = String(player.playerInfo.weight)
            
            self.playerInfo = player.playerInfo
            
            self.questCount = "\(player.playerInfo.today.completeTask) / \(player.playerInfo.today.tasks.count)"
        }
    }
    
    func navigate() {
        self.isNavigate = true
    }
}

struct LevelView_Previews: PreviewProvider {
    // Define some example variables for preview
    @State static var name = "John Doe"
    @State static var height = "170"
    @State static var weight = "45"
    @State static var currentDate = "24 February 2024"
    @State static var currentDay = "Sunday"

    static var previews: some View {
        LevelView(
            name: $name,
            height: $height,
            weight: $weight,
            currentDate: $currentDate,
            currentDay: $currentDay
        )
    }
}

struct StatRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(self.title)
                .foregroundColor(.white)
                .font(.system(size: 14))
                .fontWeight(.bold)
            
            Spacer()
            
            Text(self.value)
                .foregroundColor(.white)
                .font(.system(size: 14))
        }
    }
}

struct RadarChart: View {
    var values: [Double]
    var maxValue: Double
    var labels: [String]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0 ..< self.values.count) { i in
                    let angle = CGFloat(i) * 2 * .pi / CGFloat(self.values.count) - .pi / 2
                    let value = self.values[i]
                    let length = CGFloat(value / self.maxValue) * min(geometry.size.width, geometry.size.height) / 2
                    let x = geometry.size.width / 2 + length * cos(angle)
                    let y = geometry.size.height / 2 + length * sin(angle)
                    let labelPoint = CGPoint(x: x, y: y)
                    let label = self.labels[i]
                    
                    Path { path in
                        path.move(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                    .stroke(Color.blue, lineWidth: 2)
                    
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8, height: 8)
                        .position(x: x, y: y)
                    
                    Text(label)
                        .foregroundColor(.white)
                        .position(x: labelPoint.x + 20, y: labelPoint.y)
                }
            }
        }
    }
}

struct RadarChartBackground: Shape {
    let numberOfCircles: Int
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        var path = Path()
        
        // Draw concentric pentagons
        for i in 1 ... self.numberOfCircles {
            let radius = min(rect.width, rect.height) / CGFloat(self.numberOfCircles) * CGFloat(i)
            self.drawPentagon(at: center, withRadius: radius, into: &path)
        }
        
        return path
    }
    
    func drawPentagon(at center: CGPoint, withRadius radius: CGFloat, into path: inout Path) {
        let angleIncrement = 2 * CGFloat.pi / 5
        let startPoint = CGPoint(x: center.x + radius * cos(-CGFloat.pi / 2), y: center.y + radius * sin(-CGFloat.pi / 2))
        path.move(to: startPoint)
        
        for i in 1 ... 5 {
            let angle = CGFloat(i) * angleIncrement - CGFloat.pi / 2
            let point = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            path.addLine(to: point)
        }
        
        path.closeSubpath()
    }
}
