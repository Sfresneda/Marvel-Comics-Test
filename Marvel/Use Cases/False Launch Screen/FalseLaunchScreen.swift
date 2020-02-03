//
//  FalseLaunchScreen.swift
//  Marvel
//
//  Created by Sergio Fresneda on 2/1/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

class FalseLaunchScreen: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var hulkLabel: UILabel!
    
    // MARK: - Vars
    private lazy var feedback = UINotificationFeedbackGenerator()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showHulkAnimation()
    }
    
    // MARK: - Setup
    private func showHulkAnimation() {
        self.hulkLabel.text = "Hulk Comics"
        
        self.hulkLabel.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.hulkLabel.textColor = UIColor.greenHulk
            self.hulkLabel.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.hulkLabel.alpha = 0
                self.feedback.notificationOccurred(.warning)
            }, completion: { _ in
                self.navigateToMasterView()
            })
        })
    }
    
    // MARK: - Helpers
    private func navigateToMasterView() {
        guard let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = UINavigationController.init(rootViewController: UseCases.masterView.viewController)
    }
}
