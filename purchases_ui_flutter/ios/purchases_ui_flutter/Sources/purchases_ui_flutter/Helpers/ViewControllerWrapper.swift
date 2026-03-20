import UIKit

@available(iOS 15.0, *)
final class ViewControllerWrapper<T: UIViewController>: UIView {
    private var wrappedViewController: T
    private let usesSafeAreaLayoutGuide: Bool
    private var addedToHierarchy = false

    init(viewController: T, usesSafeAreaLayoutGuide: Bool = true) {
        self.wrappedViewController = viewController
        self.usesSafeAreaLayoutGuide = usesSafeAreaLayoutGuide
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        attachWrappedViewControllerIfNeeded()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        attachWrappedViewControllerIfNeeded()
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        attachWrappedViewControllerIfNeeded()
    }

    override func removeFromSuperview() {
        cleanupViewControllerHierarchy()
        super.removeFromSuperview()
    }

    deinit {
        cleanupViewControllerHierarchy()
    }

    private func attachWrappedViewControllerIfNeeded() {
        guard !addedToHierarchy, let parentController = parentViewController else {
            return
        }

        wrappedViewController.view.translatesAutoresizingMaskIntoConstraints = false
        parentController.addChild(wrappedViewController)
        addSubview(wrappedViewController.view)
        wrappedViewController.didMove(toParent: parentController)

        let topAnchorGuide: NSLayoutYAxisAnchor
        let bottomAnchorGuide: NSLayoutYAxisAnchor
        let leadingAnchorGuide: NSLayoutXAxisAnchor
        let trailingAnchorGuide: NSLayoutXAxisAnchor

        if usesSafeAreaLayoutGuide {
            topAnchorGuide = safeAreaLayoutGuide.topAnchor
            bottomAnchorGuide = safeAreaLayoutGuide.bottomAnchor
            leadingAnchorGuide = safeAreaLayoutGuide.leadingAnchor
            trailingAnchorGuide = safeAreaLayoutGuide.trailingAnchor
        } else {
            topAnchorGuide = topAnchor
            bottomAnchorGuide = bottomAnchor
            leadingAnchorGuide = leadingAnchor
            trailingAnchorGuide = trailingAnchor
        }

        NSLayoutConstraint.activate([
            wrappedViewController.view.topAnchor.constraint(equalTo: topAnchorGuide),
            wrappedViewController.view.bottomAnchor.constraint(equalTo: bottomAnchorGuide),
            wrappedViewController.view.leadingAnchor.constraint(equalTo: leadingAnchorGuide),
            wrappedViewController.view.trailingAnchor.constraint(equalTo: trailingAnchorGuide)
        ])

        addedToHierarchy = true
    }

    private func cleanupViewControllerHierarchy() {
        guard addedToHierarchy else { return }
        wrappedViewController.willMove(toParent: nil)
        wrappedViewController.view.removeFromSuperview()
        wrappedViewController.removeFromParent()
        addedToHierarchy = false
    }
}
