//
//  CalendarView.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 05/05/23.
//

import UIKit
import RxSwift

class CalendarView: UIView {

    private lazy var calendarView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var calendarDataSource: UICollectionViewDiffableDataSource<Int, RickMortyCharacterEntity> = {
        let cellRegistration = UICollectionView.CellRegistration<RickMortyViewCell, RickMortyCharacterEntity> { (cell, indexPath, entity) in
            cell.updateCell(entity)
        }
        
        let dataSource = UICollectionViewDiffableDataSource<Int, RickMortyCharacterEntity>(collectionView: collectionView) {
            (collectionView, indexPath, id) -> UICollectionViewCell in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: id)
        }
        return dataSource
    }()
   
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupViewHierarchy()
        setupConstraints()
    }
 
    private func setupViewHierarchy() {
        addSubview(calendarView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            calendarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
}

extension CalendarView: UICollectionViewDelegate {

}   
