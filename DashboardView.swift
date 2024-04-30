import SwiftUI

struct DashboardView: View {
    @Binding var name: String
    @Binding var height: String
    @Binding var weight: String
    @Binding var currentDate: String
    @Binding var currentDay: String
    
    // Data
    @State var playerInfo: PlayerInfo?
    @State var questCount: String?
    
    // State
    @State var isNavigate = false
    
    var body: some View {
        ZStack {
            Color("PrimaryColor").edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
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
                        
                        Text("0/0 EXP")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 5) {
                        Text("Level")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                        
                        // Level badge
                        Text("\(self.playerInfo?.level ?? 0) 🔥")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
                // Date label
                HStack(alignment: .center, spacing: 0) {
                    Text("\(self.currentDay), ")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                    
                    Text(self.currentDate)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                    
                }.padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                
                ScrollView {
                    VStack(alignment: .leading) {
                        // Card
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("⚔️  Daily Quests")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .leading) {
                                    // icon arrow.right.circle.fill
                                    Image(
                                        systemName: "arrow.right"
                                    )
                                    .foregroundColor(Color("AccentColor"))
                                    .
                                    font(.system(size: 20))
                                }
                            }
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading) {
                                        Text("Primary Quest")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14))
                                            .fontWeight(.light)
                                        Text("\(self.questCount ?? "No") Quests")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                    
                                    VStack(alignment: .leading) {
                                        Text("Mana Level (Water)")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14))
                                            .fontWeight(.light)
                                        Text("2 / 8 Bottles")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                    }
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .leading) {
                                    ProgressBar(progress: 0.0, trackColor: Color.gray, progressColor: Color("AccentColor"),
                                                size: 100)
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            
                            Button(action: {
                                self.navigate()
                            }) {
                                Text("View Daily Quest")
                                    .foregroundColor(Color("PrimaryColor"))
                                    .font(.system(size: 14))
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color("AccentColor"))
                                    .cornerRadius(10)
                            }.padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                        }
                        .background(Color("SecondaryColor"))
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        .navigationDestination(isPresented: self.$isNavigate) {
                            MainQuestView()
                        }
                        
                        // Habit Challenge
                        HStack(alignment: .center, spacing: 0) {
                            Text("Side Quest")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                            
                        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                        
                        // Card
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("⚗️ Refill Your Mana !")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("In 'Solo Leveling' vitality is key to your quest. To stay strong, replenish your mana (water) regularly.")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                
                                Text(" Goals : Drinks 8 Bottles of Water Today")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            }
                            
                            Button(action: {
                                print("Button Clicked")
                            }) {
                                Text("Mark As Complete")
                                    .foregroundColor(Color("PrimaryColor"))
                                    .font(.system(size: 14))
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color("AccentColor"))
                                    .cornerRadius(10)
                            }.padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                        }
                        .background(Color("SecondaryColor"))
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        
                        Spacer()
                    }
                }
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
            
//            self.questCount = "\(player.playerInfo.today.completeTask) / \(player.playerInfo.today.tasks.count)"
            
            self.questCount = "0/3"
        }
    }
    
    func navigate() {
        self.isNavigate = true
    }
}

struct DashboardView_Previews: PreviewProvider {
    // Define some example variables for preview
    @State static var name = "John Doe"
    @State static var height = "170"
    @State static var weight = "45"
    @State static var currentDate = "24 February 2024"
    @State static var currentDay = "Sunday"

    static var previews: some View {
        DashboardView(
            name: $name,
            height: $height,
            weight: $weight,
            currentDate: $currentDate,
            currentDay: $currentDay
        )
    }
}
