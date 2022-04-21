//
//  LoginView.swift
//  communication-magic
//
//  Created by George Andrade on 4/3/22.
//

import SwiftUI

struct LoginView: View {
    let didCompleteLoginProcess: () -> ()
    let didSignOut: Bool
    @StateObject var vm: LoginViewModel
    
    init(_ didCompleteLoginProcess: @escaping () -> (), _ didSignOut: Bool) {
        self.didSignOut = didSignOut
        self.didCompleteLoginProcess = didCompleteLoginProcess
        _vm = StateObject(wrappedValue: LoginViewModel(logIn: true, email: "", password: "", name: "", role: "", didSignOut: didSignOut))
    }
        
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    Picker(selection: $vm.logIn, label: Text("sign in or sign up")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    if !vm.logIn {
                        TextField("Name", text: $vm.name)
                                .padding(5)
//                                .background(.white)
//                                .foregroundColor(.black)
                        TextField("Role", text: $vm.role)
                            .padding(5)
//                            .background(.white)
//                            .foregroundColor(.black)
                    }
                    TextField("Email", text: $vm.email)
                            .keyboardType(.emailAddress)
                            .padding(5)
                            .autocapitalization(.none)
//                            .background(.white)
//                            .foregroundColor(.black)

                    SecureField("Password", text: $vm.password)
                        .padding(5)
                        .autocapitalization(.none)
//                        .background(.white)
//                        .foregroundColor(.black)

                    Button {
                        vm.logInOrSignUp()
                        vm.didCompleteLoginProcess = self.didCompleteLoginProcess
                    } label: {
                        HStack {
                            Spacer()
                            Text(vm.logIn ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                        
                    }
                }
            }
            .navigationBarTitle(vm.logIn ? "Log In" : "Create Account", displayMode: .large)
            .background(Color(.init(white: 0, alpha: 0.05)))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView({
            print("hacky way to get around autoclousure optional")
        }, false
        )
    }
}
