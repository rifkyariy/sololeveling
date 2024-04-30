import SwiftUI

struct HomeView: View {
    // Data
    @State private var name: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""

    // Date formatter
    @State private var currentDate: String = ""
    @State private var currentDay: String = ""

    // Tab Viewer
    @Binding var currentTab: Int // Binding to control the currentTab from outside

    // Initializer to accept the binding
    init(currentTab: Binding<Int>) {
        _currentTab = currentTab
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("PrimaryColor").edgesIgnoringSafeArea(.all)

                TabView(selection: $currentTab) {
                    // Dashboard Tab
                    DashboardView(
                        name: $name,
                        height: $height,
                        weight: $weight,
                        currentDate: $currentDate,
                        currentDay: $currentDay
                    )
                    .tag(0)
//                        .badge(2)
                    .tabItem {
                        Label("Home", systemImage: "tray.and.arrow.down.fill")
                    }

                    // Recap Tab
                    LevelView(
                        name: $name,
                        height: $height,
                        weight: $weight,
                        currentDate: $currentDate,
                        currentDay: $currentDay
                    )
                    .tag(1)
                    .tabItem {
                        Image(systemName: "stairs")
                        Text("Level")
                    }
                }
                .tabViewStyle(DefaultTabViewStyle())
                .toolbarColorScheme(.dark, for: .tabBar)
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                self.loadBasicInfo()
                self.loadCurrentDate()
                self.loadCurrentDay()
            }
        }
    }

    // Renamed functions to follow Swift naming conventions
    func loadBasicInfo() {
        let (name, height, weight) = Helper.getBasicInfo()
        self.name = name ?? ""
        self.height = height ?? ""
        self.weight = weight ?? ""
    }

    func loadCurrentDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"

        currentDate = formatter.string(from: Date())
    }

    func loadCurrentDay() {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"

        currentDay = formatter.string(from: Date())
    }
}

struct ProgressBar: View {
    var progress: CGFloat
    var trackColor: Color
    var progressColor: Color
    var size: CGFloat // Size of the ProgressBar

    var body: some View {
        ZStack {
            Circle()
                .stroke(self.trackColor, style: StrokeStyle(lineWidth: 10)) // Reduce the line width for the track

            Circle()
                .trim(from: 0.0, to: self.progress)
                .stroke(self.progressColor, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)) // Reduce the line width for the progress
                .rotationEffect(Angle(degrees: -90))

            Text("\(Int(self.progress * 100))%")
                .font(.system(size: self.size * 0.25)) // Adjust the font size based on the size of the ProgressBar
                .foregroundColor(.white)
                .bold()
        }
        .frame(width: size, height: size) // Constrain the size of the ProgressBar
        .padding(20)
    }
}

struct HomeView_Previews: PreviewProvider {
    @State static var currentTab = 0 // Binding for preview

    static var previews: some View {
        HomeView(currentTab: $currentTab)
    }
}
