//
//  BeanView.swift
//  PadroesDeProjetos
//
//  Created by Lidiane Gomes Barbosa on 03/05/23.
//

import UIKit
import RxSwift

enum BeanStatus: String, CaseIterable {
    case overjoyed
    case happy
    case neutral
    case sad
    case pained
    case `default`
}

class BeanButton: UIButton {
    
    private lazy var status: BeanStatus = .neutral {
        didSet {
            setBackgroundImage(UIImage(named: status.rawValue), for: .normal)
        }
    }
    
    private var action: ((BeanStatus) -> Void)?

    // MARK: INITIALIZERS
    
    init() {
        super.init(frame: .zero)
    }
    
    init(status: BeanStatus = .neutral, action: ((BeanStatus) -> Void)?) {
        super.init(frame: .zero)
        self.status = status
        self.action = action
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
    
    // MARK: ACTIONS
    
    @objc private func didTapButton() {
        action?(status)
    }
    
    func updateStatus(_ status: BeanStatus) {
        self.status = status
    }
}
