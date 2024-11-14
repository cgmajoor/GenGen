//
//  LoadingViewController.swift
//  GenGen
//
//  Created by Ceren Majoor on 10/11/2024.
//

import UIKit

class LoadingViewController: BaseViewController {
    private let prepopulateUseCase = PrepopulateDatabaseUseCase()
    private let router: AppRouter
    
    private let minimumLoadingDuration: TimeInterval = 1.0
    
    init(router: AppRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppTheme.Main.Color.background
        showLoadingOverlay()
        startPrepopulationWithMinimumDuration()
    }
    
    private func showLoadingOverlay() {
        LoadingOverlay.shared.show(over: self)
    }
    
    private func hideLoadingOverlay() {
        LoadingOverlay.shared.hide()
    }
    
    private func startPrepopulationWithMinimumDuration() {
        let startTime = Date()
        
        prepopulateUseCase.execute { [weak self] result in
            guard let self = self else { return }
            
            let elapsedTime = Date().timeIntervalSince(startTime)
            let remainingTime = self.minimumLoadingDuration - elapsedTime
            
            if remainingTime > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + remainingTime) {
                    self.completeLoading(result: result)
                }
            } else {
                self.completeLoading(result: result)
            }
        }
    }
    
    private func completeLoading(result: Result<Void, Error>) {
        hideLoadingOverlay()
        
        switch result {
        case .success:
            router.showMainTabBar()
        case .failure(let error):
            print("Failed to prepopulate database: \(error)")
            router.showMainTabBar()
        }
    }
}
