//
//  CalendarCollectionViewCell.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 12/05/23.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private lazy var beanImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        beanImage.layer.cornerRadius = 20
        beanImage.clipsToBounds = true
    }
    private func setup() {
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(beanImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            dayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            beanImage.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 8),
            beanImage.widthAnchor.constraint(equalToConstant: 40),
            beanImage.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func updateCell(_ entity: CalendarEntity) {
        clearCell()
        if let day = entity.day {
            dayLabel.text = day
            beanImage.image = UIImage(named: "disabled")
        }
      
        if let imageName = entity.beanImage {
            beanImage.image = UIImage(named: imageName)
        }
    }
    
    private func clearCell() {
        dayLabel.text = nil
        beanImage.image = nil
    }
}
