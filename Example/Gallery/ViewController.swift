//
//  MainViewController.swift
//  LifeHash Gallery
//
//  Created by Wolf McNally on 5/3/19.
//

import WolfKit
import LifeHash
import UIImageColors

class MainViewController: ViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    private lazy var frontImageView = LifeHashView() • {
        $0.contentMode = .scaleAspectFit
        $0.alpha = 0
    }

    private lazy var backImageView = LifeHashView() • {
        $0.contentMode = .scaleAspectFit
        $0.alpha = 0
    }

    override func build() {
        super.build()

        view.backgroundColor = .black

        view => [
            backImageView,
            frontImageView
        ]

        backImageView.constrainFrameToFrame(insets: .init(all: 40))
        frontImageView.constrainFrameToFrame(insets: .init(all: 40))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //updateImage(animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }

    private func updateImage(animated: Bool) {
        swap(&frontImageView, &backImageView)
        view.bringSubviewToFront(frontImageView)

        let index = Int.random(in: 0 ..< 1_000_000)
        let string = String(index)
        let data = string |> toUTF8
        frontImageView.input = data
        let colors = frontImageView.image!.getColors(quality: .highest)!
        let backgroundColor = (colors.nonNeutral ?? .black).darkened(by: 0.2)
        _ = animation(animated, duration: 2) {
            self.frontImageView.alpha = 1
            self.view.backgroundColor = backgroundColor
        }.map { _ in
            self.backImageView.alpha = 0
        }
    }

    private var canceler: Cancelable?

    private func startTimer() {
        canceler = dispatchRepeatedOnMain(atInterval: 10) { [unowned self] _ in
            self.updateImage(animated: true)
        }
    }

    private func stopTimer() {
        canceler?.cancel()
    }
}

extension UIImageColors {
    var nonNeutral: UIColor? {
        let prioritized = [detail, secondary, primary, background]
        let notBlackOrWhite: [UIColor] = prioritized.compactMap {
            guard let color = $0 else { return nil }
            let e = Color(color)
            if e != .black && e != .white {
                return color
            } else {
                return nil
            }
        }
        return notBlackOrWhite.first
    }
}
