//
//  TapCounterViewModel.swift
//  TapCounterCombine
//
//  Created by 仲優樹 on 2025/06/25.
//

import Foundation
import Combine

class TapCounterViewModel: ObservableObject {
    @Published var tapCount: Int = 0
    @Published var isGoalReached: Bool = false
    
    private let tapSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let goal = 10
    
    init() {
        tapSubject
            .scan(0) { count, _ in count + 1 } // 1回押すたびに +1
            .handleEvents(receiveOutput: { [weak self] count in
                self?.tapCount = count
            })
            .map { $0 >= self.goal } // 目標に到達したか？
            .removeDuplicates()
            .assign(to: \.isGoalReached, on: self)
            .store(in: &cancellables)
    }
    
    func registerTap() {
        tapSubject.send(())
    }
    
    func reset() {
        tapCount = 0
        isGoalReached = false
    }
}
