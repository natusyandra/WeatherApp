//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Котик on 10.03.2022.
//

import UIKit

class ForecastCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static var reuseIdentifier: String = "ForecastCell"
    
    let weekdaylabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dailyForecast: [WeatherInfo] = []
    var collectionView : UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        collectionView = UICollectionView(frame: CGRect(x: 100, y: 0, width: (frame.width - 112), height: frame.height), collectionViewLayout: createCompositionalLayout())
        collectionView.register(HourlyCell.self, forCellWithReuseIdentifier: HourlyCell.reuseIdentifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        setupViews()
        layoutViews()
    }
    
    func setupViews() {
        addSubview(weekdaylabel)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            weekdaylabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            weekdaylabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            weekdaylabel.heightAnchor.constraint(equalToConstant: 30),
            weekdaylabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            self.createFeaturedSection()
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
    
    func createFeaturedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(0.75))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top:5, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return layoutSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.reuseIdentifier, for: indexPath) as! HourlyCell
        cell.configure(with: dailyForecast[indexPath.row])
        return cell
    }
    
    func configure(with item: ForecastTemperature) {
        weekdaylabel.text = item.weekDay
        dailyForecast = item.hourlyForecast ?? []
        collectionView.reloadData()
    }
}
