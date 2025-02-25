import UIKit

@available(iOS 15.0, *)
final class ViewControllerWrapper<T: UIViewController>: UIView {
    private var wrappedViewController: T
    private var addedToHierarchy = false

    init(viewController: T) {
        self.wrappedViewController = viewController
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !addedToHierarchy, let parentController = parentViewController {
            wrappedViewController.view.translatesAutoresizingMaskIntoConstraints = false
            parentController.addChild(wrappedViewController)
            addSubview(wrappedViewController.view)
            wrappedViewController.didMove(toParent: parentController)
            
            NSLayoutConstraint.activate([
                wrappedViewController.view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                wrappedViewController.view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                wrappedViewController.view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                wrappedViewController.view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ])
            
            addedToHierarchy = true
        }
    }
}
