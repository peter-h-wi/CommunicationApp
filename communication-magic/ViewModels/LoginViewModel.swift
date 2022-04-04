//
//  LoginViewModel.swift
//  communication-magic
//
//  Created by George Andrade on 4/3/22.
//

import Foundation
import Firebase

class LoginViewModel : ObservableObject {
            
    @Published var logIn: Bool
    @Published var email : String
    @Published var password : String
    @Published var name: String
    @Published var role: String
    @Published var didSignOut: Bool
    
    var didCompleteLoginProcess: (() -> ())?
            
    var authListener: AuthStateDidChangeListenerHandle?

    init(logIn: Bool, email: String, password: String, name: String, role: String, didSignOut: Bool) {
        self.logIn = logIn
        self.email = email
        self.password = password
        self.name = name
        self.role = role
        self.didSignOut = didSignOut
        
        if didSignOut {
            try? FirebaseManager.shared.auth.signOut()
        }
    }

    func logInOrSignUp() {
        if logIn {
            loginUser()
        } else {
            createNewAccount()
        }
    }

    func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
            }
            #warning("Add logic for making it not possible to login user if they are not authenicated by firebase")
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            (self.didCompleteLoginProcess ?? {})()
        }
    }

    func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user in auth:", err)
                #warning("User will not be stored in auth if password is less than 6 characters but can move onto HomeView, fix soon")
                return
            }
            print("Successfully created user in auth: \(result?.user.uid ?? "")")
        }
        storeUserInformation()
    }
    
    func storeUserInformation() {
        authListener = FirebaseManager.shared.auth.addStateDidChangeListener { auth, user in
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { print("NO UID FOUND"); return }
            print(uid + " current user id")
            FirebaseManager.shared.firestore.collection("Members").document(uid).getDocument { snapshot, error in
                if let error = error {
                    print("User probably not yet defined (storeData)", error)
                }
                if snapshot?.data() != nil {
                    print("caught already made document")
                    return
                } else {
                    let userData = ["name": self.name, "role": self.role, "email": self.email, "online:": true, "uid": uid] as [String : Any]
                    FirebaseManager.shared.firestore.collection("Members")
                        .document(uid).setData(userData) { err in
                            if let err = err {
                                print(err)
                                print("Failed to store user in members")
                                return
                            }
                            print("Successfully stored user in members")
                            (self.didCompleteLoginProcess ?? {})()
                        }
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.removeListener()
        }
    }
    
    func removeListener() {
        FirebaseManager.shared.auth.removeStateDidChangeListener(authListener!)
        print("listener killed")
    }
}
