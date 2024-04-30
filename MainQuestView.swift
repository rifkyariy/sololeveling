import SwiftUI

struct MainQuest: Identifiable {
    let id = UUID()
    let title: String
    let icon: String // Assuming icon is a system name
    let description: String
    let exp: Int // Experience points
    var completed: Bool
}

struct MainQuestView: View {
    @State private var mainQuests = [
        MainQuest(title: "Complete SwiftUI Tutorial", icon: "book", description: "Finish the SwiftUI tutorial series on Apple's website.", exp: 100, completed: false),
        MainQuest(title: "Build a To-Do App", icon: "checkmark.square", description: "Create a simple To-Do app using SwiftUI and CoreData.", exp: 150, completed: true),
        MainQuest(title: "Learn MVVM Architecture", icon: "list.dash", description: "Understand and implement Model-View-ViewModel architecture in SwiftUI projects.", exp: 200, completed: false)
        // Add more main quests as needed
    ]

    @State private var isShowAlert = false
    @State private var isCompletionAlert = false
    @State private var isNavigate = false
    @State private var currentTab = 1

    // Function to sort main quests by completion status
    private func sortMainQuests() {
        mainQuests.sort { !$0.completed && $1.completed }
    }

    var allTasksCompleted: Bool {
        !mainQuests.contains(where: { !$0.completed })
    }

    var totalExpAchieved: Int {
        mainQuests.reduce(0) { $0 + ($1.completed ? $1.exp : 0) }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color("PrimaryColor").edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading) {
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
                            Text("Hi, Buzz Lightyear")
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                                .fontWeight(.black)

                            Text("Nothing")
                                .foregroundColor(.white)
                                .font(.system(size: 14))

                            Text("0/0 EXP")
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
                            Text("1 🔥")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))

                    NavigationLink(destination: HomeView(
                        currentTab: Binding.constant(0)
                    )) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .imageScale(.large)

                            Text("Daily Quests")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .padding(EdgeInsets(
                                    top: 0,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 20
                                ))
                        }
                        .padding(EdgeInsets(
                            top: 10,
                            leading: 20,
                            bottom: 0,
                            trailing: 20
                        ))
                    }

                    Text("As a hero you need to complete all of this quests to prove your bravery, Goodluck hero !")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .fontWeight(.light)
                        .padding(EdgeInsets(
                            top: 5,
                            leading: 20,
                            bottom: 10,
                            trailing: 20
                        ))

                    List {
                        ForEach(mainQuests) { quest in
                            HStack(alignment: .center) {
                                Image(systemName: quest.icon)
                                    .foregroundColor(quest.completed ? .gray : .white) // Set icon color to gray if completed
                                    .font(.title)
                                    .padding(EdgeInsets(
                                        top: 0,
                                        leading: 0,
                                        bottom: 0,
                                        trailing: 10
                                    ))
                                VStack(alignment: .leading) {
                                    Text(quest.title)
                                        .foregroundColor(quest.completed ? .gray : .white) // Set text color to gray if completed
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .strikethrough(quest.completed, color: .gray) // Strike-through if completed
                                    Text(quest.description)
                                        .foregroundColor(quest.completed ? .gray : .white) // Set description color to gray if completed
                                        .font(.subheadline)
                                        .padding(EdgeInsets(
                                            top: 2,
                                            leading: 0,
                                            bottom: 2,
                                            trailing: 0
                                        ))
                                    Text("EXP: \(quest.exp)") // Display experience points
                                        .foregroundColor(quest.completed ? .gray : .white) // Set exp text color to gray if completed
                                        .font(.system(size: 12))
                                }

                                Spacer()

                                Button(action: {
                                    if let index = mainQuests.firstIndex(where: { $0.id == quest.id }) {
                                        mainQuests[index].completed.toggle()
                                        sortMainQuests() // Sort after update
                                    }
                                }) {
                                    Image(systemName: quest.completed ? "checkmark.square.fill" : "square")
                                        .foregroundColor(quest.completed ? .green : .white) // Set checkbox color to green if completed
                                }
                            }
                            .listRowBackground(Color.clear) // Set row background to clear
                            .padding(EdgeInsets(
                                top: 10,
                                leading: 10,
                                bottom: 10,
                                trailing: 10
                            ))
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear) // Set list background to clear
                    .padding(EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 10,
                        trailing: 0
                    ))

                    if allTasksCompleted {
                        Button(action: {
                            // Show completion alert

                            // Show confirmation alert
                            isShowAlert = true
                            isCompletionAlert = true
                        }) {
                            Text("Glad You Make It 🥳")
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("PurpleColor"))
                                .cornerRadius(10)
                        }
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                    } else {
                        Button(action: {
                            // Show confirmation alert
                            isShowAlert = true
                            isCompletionAlert = false
                        }) {
                            Text("Mark All as Complete")
                                .foregroundColor(Color("PrimaryColor"))
                                .font(.system(size: 14))
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("AccentColor"))
                                .cornerRadius(10)
                        }
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isNavigate) {
            HomeView(
                currentTab: Binding.constant(1))
        }
        .alert(isPresented: $isShowAlert) {
            if isCompletionAlert {
                Alert(
                    title: Text("Congratulations 🎉"),
                    message: Text("You're awesome! You completed all tasks and achieved \(totalExpAchieved) EXP."),
                    dismissButton: .default(Text("Okay")) {
                        // redirect to homeView
                        isNavigate = true
                    }
                )
            } else {
                Alert(
                    title: Text("Confirm"),
                    message: Text("Are you sure you want to complete all tasks?"),
                    primaryButton: .default(Text("Yes")) {
                        // Code to mark all quests as complete
                        mainQuests.indices.forEach { mainQuests[$0].completed = true }
                    },
                    secondaryButton: .cancel(Text("No"))
                )
            }
        }
        .onAppear {
            sortMainQuests()
        }
    }
}

struct MainQuestView_Previews: PreviewProvider {
    static var previews: some View {
        MainQuestView()
    }
}
