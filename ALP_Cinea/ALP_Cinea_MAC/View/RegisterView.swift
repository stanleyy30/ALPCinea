import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var animateGradient = false
    @State private var showPasswordRequirements = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2), Color.black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            GeometryReader { geometry in
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.red.opacity(0.1), Color.clear],
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
                                    LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
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
                        formSection
                        registerButton
                        loginLink
                        footer
                    }
                    .frame(maxWidth: 600)
                    .padding(.horizontal, 24)
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            withAnimation {
                animateGradient = true
            }
        }
    }
    
    var formSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            fieldView(icon: "person.fill", title: "Username", placeholder: "Pilih username unik", text: $viewModel.user.username, isSecure: false)

            fieldView(icon: "envelope.fill", title: "Email", placeholder: "Masukkan alamat email", text: $viewModel.user.email, isSecure: false)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.gray)
                        .frame(width: 20)
                    Text("Password")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: { showPasswordRequirements.toggle() }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.gray.opacity(0.7))
                            .font(.system(size: 14))
                    }
                }

                SecureField("Buat password yang kuat", text: $viewModel.user.password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.05))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.1), lineWidth: 1)))
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

            // Confirm Password Section
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
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.05))
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                !viewModel.user.confirmPassword.isEmpty &&
                                viewModel.user.password != viewModel.user.confirmPassword ?
                                Color.red.opacity(0.5) : Color.white.opacity(0.1),
                                lineWidth: 1
                            )))
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
    }

    
    var registerButton: some View {
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
            .background(LinearGradient(colors: [Color.red, Color.orange], startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.white)
            .cornerRadius(16)
            .shadow(color: .red.opacity(0.3), radius: 10, x: 0, y: 5)
        }
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
    }
    
    var loginLink: some View {
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
        .padding(.top, 4)
    }
    
    var footer: some View {
        VStack(spacing: 16) {
            Text("Dengan mendaftar, Anda menyetujui")
                .font(.system(size: 12))
                .foregroundColor(.gray.opacity(0.7))
            
            HStack(spacing: 16) {
                Button("Syarat & Ketentuan") {}
                    .font(.system(size: 12))
                    .foregroundColor(.red.opacity(0.8))
                
                Text("•")
                    .foregroundColor(.gray.opacity(0.5))
                
                Button("Kebijakan Privasi") {}
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
        .padding(.top, 20)
    }
    
    func fieldView(icon: String, title: String, placeholder: String, text: Binding<String>, isSecure: Bool) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .frame(width: 20)
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
            }
            
            if isSecure {
                SecureField(placeholder, text: text)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.05))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.1), lineWidth: 1)))
                    .foregroundColor(.white)
            } else {
#if os(iOS)
                TextField(placeholder, text: text)
                    .autocapitalization(.none)
                    .keyboardType(.default)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.05))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.1), lineWidth: 1)))
                    .foregroundColor(.white)
#else
                TextField(placeholder, text: text)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.05))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.1), lineWidth: 1)))
                    .foregroundColor(.white)
#endif
            }
        }
    }
}

#Preview {
    RegisterView(viewModel: AuthViewModel())
}
