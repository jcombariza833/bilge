//
//  StudentView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/7/21.
//

import SwiftUI
import Firebase

struct StudentView: View {
    @EnvironmentObject var store: AppStore
    var body: some View {
        VStack {
            Text("Student")
            Button("log out") {
                let firebaseAuth = Auth.auth()
               do {
                 try firebaseAuth.signOut()
               } catch let signOutError as NSError {
                 print("Error signing out: %@", signOutError)
               }
            }
            Button("request ") {
                let variables = UserVariable(email: "juan@gmail.com")
                var query = UserQuery<UserVariable>()
                query.variables = variables
                
                let payload = Payload(variables: variables, query: query.raw)
                let url = URL(string: "http://localhost:5001/bilge-85236/us-central1/graphql")!
                    var request = URLRequest(url: url)
                    request.httpBody = try! JSONEncoder().encode(payload)
                    request.httpMethod = "POST"
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    request.addValue( "Bearer " + store.state.session.token, forHTTPHeaderField: "Authorization")
                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                        guard let data = data else {
                            return print("data is null")
                        }
                        let swiftyJsonVar = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                        print(swiftyJsonVar)
                    }.resume()
            }
        }
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView()
    }
}
