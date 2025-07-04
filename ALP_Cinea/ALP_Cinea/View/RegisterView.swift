import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var animateGradient = false
    @State private var showPasswordRequirements = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.1, green: 0.1, blue: 0.2),
                    Color.black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            GeometryReader { geometry in
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.red.opacity(0.1),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: 100
                            )
                        )
                        .frame(width: 200, height: 200)
                        .offset(
                            x: geometry.size.width * 0.2 + CGFloat(index * 60),
                            y: geometry.size.height * 0.7 - CGFloat(index * 40)
                        )
                        .scaleEffect(animateGradient ? 1.2 : 0.8)
                        .animation(
                            Animation.easeInOut(duration: 3)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.7),
                            value: animateGradient
                        )
                }
            }
            
            ScrollView {
                VStack(spacing: 32) {
                    Spacer(minLength: 40)
                    
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.red, Color.orange],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 70, height: 70)
                                .shadow(color: .red.opacity(0.3), radius: 15, x: 0, y: 8)
                            
                            Image(systemName: "person.badge.plus.fill")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 8) {
                            Text("Bergabung dengan Cinea")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color.white, Color.gray.opacity(0.8)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                            
                            Text("Mulai petualangan film Anda")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                Text("Username")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)
                            }
                            
                            TextField("Pilih username unik", text: $viewModel.user.username)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.05))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                        )
                                )
                                .foregroundColor(.white)
                                .autocapitalization(.none)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                Text("Email")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)
                            }
                            
                            TextField("Masukkan alamat email", text: $viewModel.user.email)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.05))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                        )
                                )
                                .foregroundColor(.white)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                Text("Password")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)
                                Spacer()
                                Button(action: {
                                    showPasswordRequirements.toggle()
                                }) {
                                    Image(systemName: "info.circle")
                                        .foregroundColor(.gray.opacity(0.7))
                                        .font(.system(size: 14))
                                }
                            }
                            
                            SecureField("Buat password yang kuat", text: $viewModel.user.password)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.05))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                        )
                                )
                                .foregroundColor(.white)
                            
                            if showPasswordRequirements {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Password harus mengandung:")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    HStack {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(viewModel.user.password.count >= 8 ? .green : .gray.opacity(0.5))
                                            .font(.caption)
                                        Text("Minimal 8 karakter")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.top, 4)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "lock.rotation")
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                Text("Konfirmasi Password")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)
                            }
                            
                            SecureField("Ketik ulang password", text: $viewModel.user.confirmPassword)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.05))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(
                                                    !viewModel.user.confirmPassword.isEmpty &&
                                                    viewModel.user.password != viewModel.user.confirmPassword ?
                                                    Color.red.opacity(0.5) : Color.white.opacity(0.1),
                                                    lineWidth: 1
                                                )
                                        )
                                )
                                .foregroundColor(.white)
                            
                            if !viewModel.user.confirmPassword.isEmpty &&
                               viewModel.user.password != viewModel.user.confirmPassword {
                                HStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                    Text("Password tidak cocok")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                                .padding(.top, 4)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // Register Button
                    Button(action: {
                        viewModel.register()
                    }) {
                        HStack {
                            Image(systemName: "ticket.fill")
                                .font(.system(size: 18))
                            Text("Daftar Sekarang")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                colors: [Color.red, Color.orange],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(color: .red.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    .disabled(
                        viewModel.user.username.isEmpty ||
                        viewModel.user.email.isEmpty ||
                        viewModel.user.password.isEmpty ||
                        viewModel.user.confirmPassword.isEmpty ||
                        viewModel.user.password != viewModel.user.confirmPassword
                    )
                    .opacity(
                        viewModel.user.username.isEmpty ||
                        viewModel.user.email.isEmpty ||
                        viewModel.user.password.isEmpty ||
                        viewModel.user.confirmPassword.isEmpty ||
                        viewModel.user.password != viewModel.user.confirmPassword ? 0.6 : 1.0
                    )
                    
                    // Login Link
                    Button(action: {
                        viewModel.showRegister = false
                    }) {
                        HStack(spacing: 4) {
                            Text("Sudah punya akun?")
                                .foregroundColor(.gray)
                            Text("Masuk sekarang")
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                        }
                        .font(.system(size: 16))
                    }
                    
                    Spacer(minLength: 40)
                    
                    // Terms & Footer
                    VStack(spacing: 16) {
                        Text("Dengan mendaftar, Anda menyetujui")
                            .font(.system(size: 12))
                            .foregroundColor(.gray.opacity(0.7))
                        
                        HStack(spacing: 16) {
                            Button("Syarat & Ketentuan") {
                                // Handle terms action
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.red.opacity(0.8))
                            
                            Text("•")
                                .foregroundColor(.gray.opacity(0.5))
                            
                            Button("Kebijakan Privasi") {
                                // Handle privacy action
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.red.opacity(0.8))
                        }
                        
                        HStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 1)
                            Text("Cinea")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.red.opacity(0.8))
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 1)
                        }
                    }
                    .padding(.horizontal, 40)
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            withAnimation {
                animateGradient = true
            }
        }
    }
}

#Preview {
    RegisterView(viewModel: AuthViewModel())
}
