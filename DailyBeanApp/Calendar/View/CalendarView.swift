//
//  CalendarView.swift
//  DailyBeanApp
//
//  Created by Lidiane Gomes Barbosa on 05/05/23.
//

import UIKit
import RxSwift

enum CalendarDirection {
    case preview
    case next
}

class CalendarView: UIView {

    private var entity: CalendarListEntity?
    var observableDirection = PublishSubject<CalendarDirection>()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(systemName: "chevron.right"), for: .normal)
        view.tintColor = UIColor.primary
        view.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var previewButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        view.tintColor = UIColor.primary
        view.addTarget(self, action: #selector(didTapPreview), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .equalCentering
        return view
    }()
    
    private lazy var calendarView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backgroundColor
        view.isScrollEnabled = false
        view.delegate = self
        return view
    }()
    
    private lazy var calendarDataSource: UICollectionViewDiffableDataSource<Int, UUID> = {
        let cellRegistration = UICollectionView.CellRegistration<CalendarCollectionViewCell, CalendarEntity> { (cell, indexPath, entity) in
            cell.updateCell(entity)
        }
        
        let dataSource = UICollectionViewDiffableDataSource<Int, UUID>(collectionView: calendarView) {
            (collectionView, indexPath, id) -> UICollectionViewCell in
            let calendarEntity = self.entity?.item(with: id)
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: calendarEntity)
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
        backgroundColor = UIColor.backgroundColor
        setupViewHierarchy()
        setupConstraints()
        configureLayout()
    }
 
    private func setupViewHierarchy() {
        addSubview(headerStackView)
        addSubview(calendarView)
        headerStackView.addArrangedSubview(previewButton)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            nextButton.heightAnchor.constraint(equalToConstant: 20),
            nextButton.widthAnchor.constraint(equalToConstant: 20),
            previewButton.heightAnchor.constraint(equalToConstant: 20),
            previewButton.widthAnchor.constraint(equalToConstant: 20),
            
            calendarView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 24),
            calendarView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    private func configureLayout() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute((UIScreen.main.bounds.width - 2) / 8),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        calendarView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
    }

    private func applySnapshot(_ listEntity: CalendarListEntity) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UUID>()
        snapshot.appendSections([0])
        snapshot.appendItems(listEntity.listID(), toSection: 0)
        calendarDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: PUBLIC FUNCTIONS
    
    public func updateView(_ listEntity: CalendarListEntity) {
        self.entity = listEntity
        self.titleLabel.text = listEntity.title
        applySnapshot(listEntity)
    }
    
    public func updateSnapshot(_ id: UUID, status: BeanStatus) {
        entity?.updateImage(id, newImage: status.rawValue)
        var snapshot = calendarDataSource.snapshot()
        snapshot.reconfigureItems([id])
        calendarDataSource.apply(snapshot)
    }
    
    @objc func didTapNext() {
        observableDirection.onNext(.next)
    }
    
    @objc func didTapPreview() {
        observableDirection.onNext(.preview)
    }
}

extension CalendarView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // TODO: verificar a data selecionada
    }
}   
