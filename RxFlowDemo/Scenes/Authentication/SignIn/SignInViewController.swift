//
//  SignInViewController.swift
//  MyHealthPal-Playground
//
//  Created by sondt on 12/1/17.
//

import UIKit
import RxCocoa
import RxSwift
import ESTabBarController_swift

protocol SignInViewModelType {
    var signInTrigger: PublishSubject<Void> { get }
}

class SignInViewController: UIViewController {

    // UI
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!

    var viewModel: SignInViewModelType = SignInViewModel()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = ESTabBarItem(title: "Login", image: Asset.lockIcon.image, selectedImage: Asset.lockIcon.image)

        signInButton
            .rx.tap.asDriver()
            .drive(viewModel.signInTrigger)
            .disposed(by: disposeBag)
    }
}

