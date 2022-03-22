//
//  HourlyCell.swift
//  WeatherApp
//
//  Created by Котик on 11.03.2022.
//

import Foundation
import UIKit

class HourlyCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "HourlyCell"
    
    let hourlyTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tempSymbol: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.systemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        setupViews()
        layoutViews()
    }
    
    func setupViews() {
        addSubview(hourlyTimeLabel)
        addSubview(tempSymbol)
        addSubview(tempLabel)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            hourlyTimeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            hourlyTimeLabel.heightAnchor.constraint(equalToConstant: 10),
            hourlyTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            hourlyTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tempSymbol.topAnchor.constraint(equalTo: hourlyTimeLabel.bottomAnchor, constant: 6),
            tempSymbol.centerXAnchor.constraint(equalTo: centerXAnchor),
            tempSymbol.heightAnchor.constraint(equalToConstant: 30),
            tempSymbol.widthAnchor.constraint(equalToConstant: 30),
            
            tempLabel.topAnchor.constraint(equalTo: tempSymbol.bottomAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            tempLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: WeatherInfo) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let date = dateFormatterGet.date(from: item.time) {
            hourlyTimeLabel.text = dateFormatter.string(from: date)
        }
        
        tempSymbol.downloaded(from: "https://openweathermap.org/img/wn/\(item.icon)@2x.png")
        kelvinToCelsiusConverter(weather: item)
    }
    
    func kelvinToCelsiusConverter(weather: WeatherInfo) {
        tempLabel.text = weather.temp.celcius()
    }
}
