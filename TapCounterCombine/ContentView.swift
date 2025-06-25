//
//  ContentView.swift
//  TapCounterCombine
//
//  Created by 仲優樹 on 2025/06/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TapCounterViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("👆 ボタン連打カウンター")
                .font(.title2)
                .bold()
            
            Text("カウント: \(viewModel.tapCount)")
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            Button("タップする") {
                viewModel.registerTap()
            }
            .font(.title2)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            if viewModel.isGoalReached {
                Text("🎉 ゴール達成！")
                    .font(.title2)
                    .foregroundColor(.green)
                
                Button("リセット") {
                    viewModel.reset()
                }
                .foregroundColor(.red)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
