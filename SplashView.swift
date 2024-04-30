import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            OnboardingView()
        } else {
            ZStack {
                Color("PrimaryColor").edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        Image("splash")
                            .font(.system(size: 80))
                            .foregroundColor(.red)
                        HStack(spacing: 0) {
                            Text("Solo")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Text("Leveling")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .fontWeight(.light)
                        }
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }

                    // button
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
