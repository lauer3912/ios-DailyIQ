//
//  PaywallView.swift
//  DailyIQ
//
//  Self-Service Paywall for DailyIQAI
//

import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var openAIKey = ""
    @State private var isSavedKey = false

    var body: some View {
        NavigationStack {
            Form {
                Section("DailyIQAI Pro Pass") {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Adaptive N-Back & Longitudinal IQ Analytics")
                            .font(.headline)
                        Text("Unlock unlimited cognitive sprints, personalized weakness targeting, and offline data export.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)

                    Button {} label: {
                        HStack {
                            Text("Monthly Pro")
                            Spacer()
                            Text("$4.99 / mo").bold()
                        }
                    }

                    Button {} label: {
                        HStack {
                            Text("Annual Pro Pass")
                            Spacer()
                            Text("$29.99 / yr").bold().foregroundColor(.blue)
                        }
                    }
                }

                Section("Credit Packs") {
                    HStack {
                        Text("1,000 Neural Credits")
                        Spacer()
                        Button("$4.99") {}
                            .buttonStyle(.bordered)
                    }
                }

                Section("Bring Your Own API Key (Optional)") {
                    SecureField("OpenAI API Key (sk-...)", text: $openAIKey)
                    Button {
                        isSavedKey = true
                    } label: {
                        Text(isSavedKey ? "Key Saved to Keychain" : "Save Key")
                    }
                    .disabled(openAIKey.isEmpty)
                }

                Section {
                    Text("Subscriptions auto-renew until cancelled in App Store Settings. Terms & Privacy apply.")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Upgrade DailyIQAI")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
