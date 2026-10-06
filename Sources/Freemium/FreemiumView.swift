//
//  FreemiumView.swift
//  DailyIQ
//
//  Freemium Tier UI for DailyIQAI
//

import SwiftUI

struct FreemiumView: View {
    @StateObject private var viewModel = FreemiumViewModel()
    @State private var showingPaywall = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "brain.head.profile")
                                .foregroundColor(.blue)
                                .font(.title2)
                            Text("Free Cognitive Tier")
                                .font(.headline)
                                .foregroundColor(.blue)
                            Spacer()
                            Text("VIP Lv.\(viewModel.vipLevel)")
                                .font(.caption.bold())
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.15))
                                .cornerRadius(8)
                        }

                        Divider()

                        HStack {
                            Label("IQ Credits", systemImage: "sparkles")
                            Spacer()
                            Text("\(viewModel.credits)")
                                .font(.title3.bold())
                                .foregroundColor(.primary)
                        }

                        HStack {
                            Text("Daily Training Bonus:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            Button(action: {
                                _Concurrency.Task { await viewModel.signIn() }
                            }) {
                                Text(viewModel.signedInToday ? "Claimed" : "Claim (+10)")
                                    .font(.subheadline.bold())
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(viewModel.signedInToday)
                        }
                    }
                    .padding(.vertical, 4)
                } header: {
                    Text("Account & Quota")
                } footer: {
                    Text("100 initial cognitive credits included. All core Dual N-Back and spatial training modules are permanently free offline.")
                }

                Section("Pro Upgrades (Optional)") {
                    Button(action: {
                        showingPaywall = true
                    }) {
                        HStack {
                            Label("Upgrade to DailyIQAI Pro", systemImage: "crown.fill")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Cognitive Quota")
            .sheet(isPresented: $showingPaywall) {
                PaywallView()
            }
        }
    }
}

@MainActor
class FreemiumViewModel: ObservableObject {
    @Published var credits: Int = BuyservicesClient.freeTier.creditsOnRegister
    @Published var vipLevel: Int = BuyservicesClient.freeTier.vipLevelAuto
    @Published var signedInToday: Bool = false

    func signIn() async {
        guard !signedInToday else { return }
        credits += BuyservicesClient.freeTier.signinDaily
        signedInToday = true
    }
}
