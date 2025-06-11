import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var showResetPassword = false
    @State private var animateGradient = false

    var body: some View {
        NavigationStack {
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
                    ZStack {
                        animatedBackgroundCircles(in: geometry)

                        ScrollView {
                            loginFormView(geometry: geometry)
                        }
                    }
                }
            }
            .onAppear {
                withAnimation {
                    animateGradient = true
                }
            }
            .frame(minWidth: 500, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
            .sheet(isPresented: $viewModel.showRegister) {
                RegisterView(viewModel: viewModel)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Oops!"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("Coba Lagi"))
                )
            }
        }
    }

    private func animatedBackgroundCircles(in geometry: GeometryProxy) -> some View {
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
                    x: geometry.size.width * 0.8 - CGFloat(index * 60),
                    y: geometry.size.height * 0.3 + CGFloat(index * 40)
                )
                .scaleEffect(animateGradient ? 1.2 : 0.8)
                .animation(
                    Animation.easeInOut(duration: 3)
                        .repeatForever(autoreverses: true)
                        .delay(Double(index) * 0.5),
                    value: animateGradient
                )
        }
    }

    private func loginFormView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 32) {
            Spacer(minLength: 60)
            headerView()
            credentialFields()
            loginButtons()
            additionalInfo()
        }
        .frame(maxWidth: 700)
        .padding(.horizontal, geometry.size.width > 600 ? 100 : 20)
        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

    private func headerView() -> some View {
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
                    .frame(width: 80, height: 80)
                    .shadow(color: .red.opacity(0.3), radius: 20, x: 0, y: 10)

                Image(systemName: "film.fill")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
            }

            VStack(spacing: 8) {
                Text("Cinea")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.white, Color.gray.opacity(0.8)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )

                Text("Temukan film favorit Anda")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
    }

    private func credentialFields() -> some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.gray)
                        .frame(width: 20)
                    Text("Email")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }

                TextField("Masukkan email Anda", text: $viewModel.user.email)
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
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.gray)
                        .frame(width: 20)
                    Text("Password")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }

                SecureField("Masukkan password Anda", text: $viewModel.user.password)
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
            }
        }
    }

    private func loginButtons() -> some View {
        VStack(spacing: 16) {
            Button(action: {
                viewModel.login()
            }) {
                HStack {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 20))
                    Text("Masuk ke Cinea")
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

            Button(action: {
                viewModel.showRegister = true
            }) {
                HStack(spacing: 4) {
                    Text("Belum punya akun?")
                        .foregroundColor(.gray)
                    Text("Daftar sekarang")
                        .foregroundColor(.red)
                        .fontWeight(.semibold)
                }
                .font(.system(size: 16))
            }

            Button(action: {
                showResetPassword = true
            }) {
                Text("Lupa password?")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .underline()
            }
        }
    }

    private func additionalInfo() -> some View {
        VStack(spacing: 8) {
            HStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                Text("atau")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
            }

            Text("Nikmati ribuan film berkualitas HD")
                .font(.system(size: 12))
                .foregroundColor(.gray.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 40)
    }
}

#Preview {
    LoginView()
}
