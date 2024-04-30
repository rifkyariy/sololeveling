import Combine
import SwiftUI

struct OnboardingView: View {
    @State private var currentTab = 0
    @State private var isNavigate = false
    
    // Form
    @State private var name = ""
    @State private var height = "0"
    @State private var weight = "0"
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PrimaryColor").edgesIgnoringSafeArea(.all)
                
                TabView(selection: $currentTab,
                        content: {
                            // Onboarding 1
                            VStack {
                                // Skip Button
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        saveBasicInfo()
                                    }) {
                                        Text("Skip Intro")
                                            .foregroundColor(.white)
                                            .fontWeight(.light)
                                    }
                                    .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 40))
                                }
                                Spacer()
                        
                                // Image
                                Image("Onboarding1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 220, height: 220)
                                    .padding(
                                        EdgeInsets(
                                            top: 30,
                                            leading: 0,
                                            bottom: 20,
                                            trailing: 0
                                        )
                                    )
                        
                                // Title
                                Text("Hi, Tell us your name")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .padding(
                                        EdgeInsets(
                                            top: 0,
                                            leading: 0,
                                            bottom: 10,
                                            trailing: 0
                                        )
                                    )
                        
                                Text("write your wonderful name below")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 17))
                                    .fontWeight(.light)
                        
                                // Form Input
                                VStack {
                                    TextField("Fullname", text: $name)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .foregroundColor(.white) // Set text color to white
                                        .background(Color.clear)
                                        .cornerRadius(16)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.white, lineWidth: 2) // Add a white border
                                        )
                                        .accentColor(.white) // Set accent color to white for the cursor
                                        .colorScheme(.dark) // Ensure the color scheme is set to dark for proper visibility
                                }
                                .padding()
                        
                                // Button
                                Spacer() // Spacer to push the button to the bottom
                        
                                Button(action: {
                                    // set currentTab to 1
                                    currentTab = 1
                                }) {
                                    Text("Next")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            Color("AccentColor")
                                        )
                                        .cornerRadius(50)
                                }
                                .frame(width: .infinity)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 60, trailing: 20))
                        
                            }.tabItem {
                                Text("Onboarding 1")
                            }.tag(0)
                    
                            // Onboarding 2
                            VStack {
                                // Skip Button
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        saveBasicInfo()
                                    }) {
                                        Text("Skip Intro")
                                            .foregroundColor(.white)
                                            .fontWeight(.light)
                                    }
                                    .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 40))
                                }
                                Spacer()
                
                                // Image
                                Image("Onboarding1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 220, height: 220)
                                    .padding(
                                        EdgeInsets(
                                            top: 30,
                                            leading: 0,
                                            bottom: 20,
                                            trailing: 0
                                        )
                                    )
                
                                // Title
                                Text("Setup Basic Information")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .padding(
                                        EdgeInsets(
                                            top: 0,
                                            leading: 0,
                                            bottom: 10,
                                            trailing: 0
                                        )
                                    )
                
                                Text("Tell us about yourself")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 17))
                                    .fontWeight(.light)
                
                                // Form Input
                                VStack(alignment: .leading) {
                                    Text("Height (cm)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12))
                                        .fontWeight(.light)
                                        .padding(.bottom, 5)
                                    TextField("Height", text: $height)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.clear)
                                        .cornerRadius(16)
                                        .keyboardType(.numberPad)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.white, lineWidth: 2) // Add a white border
                                        )
                                    Text("Weight (kg)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12))
                                        .fontWeight(.light)
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))

                                    TextField("Weight", text: $weight)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.clear)
                                        .cornerRadius(16)
                                        .keyboardType(.numberPad)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.white, lineWidth: 2) // Add a white border
                                        )
                                }
                                .padding()
                
                                // Button
                                Spacer() // Spacer to push the button to the bottom
                
                                Button(action: {
                                    // save basic info
                                    saveBasicInfo()
                                }) {
                                    Text("Finish")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            Color("AccentColor")
                                                .frame(width: .infinity)
                                        )
                    
                                        .cornerRadius(50)
                                }
                                .frame(width: .infinity)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 60, trailing: 20))
                
                            }.tabItem {
                                Text("Onboarding 2")
                            }.tag(1)
                    
                        })
                        .tabViewStyle(PageTabViewStyle())
                        .transition(.slide)
            }
            .navigationDestination(isPresented: $isNavigate) {
                HomeView(currentTab: Binding.constant(0))
            }
            .onAppear {
                checkIfNeedOnboarding()
            }
        }
    }
    
    func saveBasicInfo() {
        // check if all data empty and add dummy data
        if name.isEmpty {
            name = "Guest"
        }
        
        if height.isEmpty {
            height = "0"
        }
        
        if weight.isEmpty {
            weight = "0"
        }
        
        // Save the basic information to UserDefaults
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(height, forKey: "height")
        UserDefaults.standard.set(weight, forKey: "weight")
        
        // Generate First Time Data
        Helper.generateFirstTimeData()
        
        // navigate to home
        isNavigate = true
        
        print("Name: \(name), Height: \(height), Weight: \(weight)", "isNavigate: \(isNavigate)")
    }
    
    func checkIfNeedOnboarding() {
        // check if the user has completed onboarding
        let isOnboardingCompleted = Helper.checkIfBasicInfoIsExist()
        
        if isOnboardingCompleted {
            // navigate to home
            isNavigate = true
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
