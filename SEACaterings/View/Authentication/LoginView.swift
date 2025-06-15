//
//  LoginView.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var authManager = AuthenticationManager()
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showingRegistration = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                VStack {
                    Image(systemName: "fork.knife.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.orange)
                    
                    Text("SEA Catering")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Secure Login")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 30)
                
                
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Login") {
                        let result = authManager.login(email: email, password: password)
                        if !result.success {
                            alertMessage = result.message
                            showingAlert = true
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(email.isEmpty || password.isEmpty)
                    
                    Button("Don't have an account? Register") {
                        showingRegistration = true
                    }
                    .foregroundColor(.orange)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("")
            .navigationBarHidden(true)
            .alert("Login Error", isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            .sheet(isPresented: $showingRegistration) {
                RegistrationView(authManager: authManager)
            }
            .fullScreenCover(isPresented: $authManager.isAuthenticated) {
                MainAppView(authManager: authManager)
            }
        }
    }
}
