//
//  TestimonialSection.swift
//  SEACaterings
//
//  Created by Muhammad Ardiansyah Asrifah on 15/06/25.
//

import SwiftUI

struct TestimonialSection: View {
    @EnvironmentObject var viewModel: TestimonialViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "quote.bubble.fill")
                        .font(.title2)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.purple, Color.blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("Testimonial Pelanggan")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.purple, Color.blue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Spacer()
                }
                
                Text("Apa kata mereka tentang layanan kami")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.testimonials) { testimonial in
                        TestimonialCard(testimonial: testimonial)
                            .frame(width: 320)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
            
            
            HStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [Color.clear, Color.purple.opacity(0.3), Color.blue.opacity(0.3), Color.clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: 1)
            }
            .padding(.vertical, 10)
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "pencil.and.outline")
                        .font(.title3)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.orange, Color.red],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("Kirim Testimonial Anda")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.orange, Color.red],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
                
                VStack(spacing: 15) {
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                            .frame(width: 20)
                        
                        TextField("Nama Anda", text: $viewModel.nameInput)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                    )
                    
                    HStack(alignment: .top) {
                        Image(systemName: "text.bubble.fill")
                            .foregroundColor(.green)
                            .frame(width: 20)
                            .padding(.top, 4)
                        
                        TextField("Pesan Review", text: $viewModel.messageInput, axis: .vertical)
                            .lineLimit(3, reservesSpace: true)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.green.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.green.opacity(0.3), lineWidth: 1)
                            )
                    )
                    
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                            .frame(width: 20)
                        
                        Text("Rating:")
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        RatingSelector(rating: $viewModel.ratingInput)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.orange.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                            )
                    )
                    
                    
                    Button(action: {
                        viewModel.addTestimonial()
                        hideKeyboard()
                    }) {
                        HStack {
                            Image(systemName: "paperplane.fill")
                                .font(.title3)
                            
                            Text("Kirim Testimonial")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            viewModel.nameInput.isEmpty || viewModel.messageInput.isEmpty ?
                            LinearGradient(colors: [Color.gray.opacity(0.5)], startPoint: .leading, endPoint: .trailing) :
                            LinearGradient(
                                colors: [Color.purple, Color.blue, Color.cyan],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(
                            color: viewModel.nameInput.isEmpty || viewModel.messageInput.isEmpty ?
                            Color.clear : Color.purple.opacity(0.3),
                            radius: 8,
                            x: 0,
                            y: 4
                        )
                        .scaleEffect(viewModel.nameInput.isEmpty || viewModel.messageInput.isEmpty ? 0.98 : 1.0)
                    }
                    .disabled(viewModel.nameInput.isEmpty || viewModel.messageInput.isEmpty)
                    .animation(.easeInOut(duration: 0.2), value: viewModel.nameInput.isEmpty || viewModel.messageInput.isEmpty)
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.purple.opacity(0.2), Color.blue.opacity(0.2)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
            )
        }
    }
}

