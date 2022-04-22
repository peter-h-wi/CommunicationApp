//
//  LoginView.swift
//  communication-magic
//
//  Created by George Andrade on 4/3/22.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
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
                VStack(spacing: 15) {
                    Image(colorScheme == .dark ? "logoBigBlack-no-bg" : "logoBigWhite-no-bg")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 50)
                    Picker(selection: $vm.logIn, label: Text("sign in or sign up")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    if !vm.logIn {
                        HStack {
                            Text("Name")
                                .frame(width: 80, alignment: .leading)
                            TextField("Name", text: $vm.name)
                                .textFieldStyle(.roundedBorder)
                                .disableAutocorrection(true)
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("Role")
                                .frame(width: 80, alignment: .leading)
                            TextField("Role", text: $vm.role)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding(.horizontal)
                    }
                    HStack {
                        Text("Email")
                            .frame(width: 80, alignment: .leading)
                        TextField("Email", text: $vm.email)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    .padding(.horizontal)

                    HStack {
                        Text("Password")
                            .frame(width: 80, alignment: .leading)
                        SecureField("Password", text: $vm.password)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    .padding(.horizontal)
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
                        }
                        .background(Color.blue)
                        .cornerRadius(5)
                        .padding(.horizontal)
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
