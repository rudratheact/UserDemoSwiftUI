//
//  ContentView.swift
//  UserDemoSwiftUI
//
//  Created by Rudra on 26/02/21.
//

import SwiftUI

// MARK:- Model
struct User: Identifiable {
    let id: Int
    let name: String
    let location: String
}

// MARK:- API Call
protocol DataService {
    func getUsers(completion: @escaping ([User]) -> Void)
}

class AppDataService: DataService {
    func getUsers(completion: @escaping ([User]) -> Void) {
        DispatchQueue.main.async {
            completion([
                User(id: 1, name: "Alex", location: "USA"),
                User(id: 2, name: "Sue", location: "China"),
                User(id: 3, name: "Rishi", location: "India"),
                User(id: 4, name: "Antony", location: "UK"),
            ])
        }
    }
}

// MARK:- View Model
class ViewModel: ObservableObject {
        @Published var users = [User]()
        
        let dataService: DataService
        
        init(dataService: DataService = AppDataService()) {
            self.dataService = dataService
        }
        
        func getUsers() {
            dataService.getUsers { [weak self] users in
                self?.users = users
            }
        }
    }

// MARK:- View
struct ContentView: View {
    @StateObject var viewModel: ViewModel
       
       init(viewModel: ViewModel = .init()) {
           _viewModel = StateObject(wrappedValue: viewModel)
       }
       
       var body: some View {
           List(viewModel.users) { user in
            HStack {
                Text(user.name)
                    .bold()
                    .foregroundColor(.blue)
                Spacer()
                Text(user.location).italic()
            }
           }
           .onAppear(perform: viewModel.getUsers)
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(id: 0, name: "Dummy", location: "Denmark")
            let viewModel = ViewModel()
            viewModel.users = [user]
            
            return ContentView(viewModel: viewModel)
        }
}
