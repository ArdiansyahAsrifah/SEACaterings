//
//  ContentView.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

class TestimonialViewModel: ObservableObject {
    @Published var testimonials: [Testimonial] = [
        Testimonial(name: "Rina", message: "Makanannya enak dan pelayanan cepat!", rating: 5),
        Testimonial(name: "Joko", message: "Porsi pas dan rasanya mantap.", rating: 4),
        Testimonial(name: "Sari", message: "Sangat memuaskan, pasti pesan lagi.", rating: 5)
    ]
    
    @Published var nameInput = ""
    @Published var messageInput = ""
    @Published var ratingInput = 3
    
    func addTestimonial() {
        guard !nameInput.isEmpty, !messageInput.isEmpty else { return }
        let newTestimonial = Testimonial(name: nameInput, message: messageInput, rating: ratingInput)
        testimonials.append(newTestimonial)
        nameInput = ""
        messageInput = ""
        ratingInput = 3
    }
}

struct ContentView: View {
    @StateObject private var featureVM = FeaturesViewModel()
    @StateObject private var navigationVM = NavigationViewModel()
    @StateObject private var testimonialVM = TestimonialViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    ScrollView {
                        switch navigationVM.selectedTab {
                        case .home:
                            VStack(spacing: 0) {
                                HeaderView()
                                
                                VStack(spacing: 30) {
                                    WelcomeSection()
                                        .scaleEffect(featureVM.animateWelcome ? 1.0 : 0.8)
                                        .opacity(featureVM.animateWelcome ? 1.0 : 0.0)
                                        .animation(.easeOut(duration: 0.6).delay(0.2), value: featureVM.animateWelcome)
                                    
                                    FeaturesSection(features: featureVM.features)
                                        .offset(y: featureVM.animateFeatures ? 0 : 50)
                                        .opacity(featureVM.animateFeatures ? 1.0 : 0.0)
                                        .animation(.easeOut(duration: 0.6).delay(0.4), value: featureVM.animateFeatures)
                                    
                                    
                                    TestimonialSection()
                                        .environmentObject(testimonialVM)
                                        .padding(.top, 30)
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                                .padding(.bottom, 50)
                            }
                            .onAppear {
                                featureVM.animateWelcome = true
                                featureVM.animateFeatures = true
                            }
                        case .menu:
                            MealPlansView()
                        case .subscription:
                            SubscriptionFormView()
                        case .contact:
                            ContactView()
                        }
                    }
                    .ignoresSafeArea(.container, edges: .top)
                    
                    if navigationVM.selectedTab == .home {
                        FloatingContactButton()
                    }
                    
                }
                ResponsiveNavigationBar(viewModel: navigationVM)
            }
            .navigationBarHidden(true)
        }
    }
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct FloatingContactButton: View {
    func openWhatsApp() {
        let phoneNumber = "628123456789"
        let appURL = URL(string: "https://wa.me/\(phoneNumber)")!
        
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            print("WhatsApp tidak tersedia")
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    openWhatsApp()
                }) {
                    HStack {
                        Image(systemName: "phone.fill")
                            .font(.title2)
                        Text("Hubungi Kami")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 0.42, green: 0.36, blue: 0.90), Color(red: 0.64, green: 0.61, blue: 1.0)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
