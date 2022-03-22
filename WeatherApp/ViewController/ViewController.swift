//
//  ViewController.swift
//  WeatherApp
//
//  Created by Котик on 02.03.2022.
//

import UIKit

class ViewController: UIViewController {
    //Test
    
    let networkManager = WeatherNetworkManager()
    
    let currentLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "...Location"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 38, weight: .heavy)
        
        return label
    }()
    
    let currentDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        return label
    }()
    
    let tempSymbol: UIImageView = {
        let label = UIImageView()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let tempDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Weather"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        return label
    }()
    
    var currentTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Temp"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 70, weight: .heavy)
        
        return label
    }()
    
    let maxTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  °C"
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let minTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  °C"
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(handleAddPlaceButton)),
            UIBarButtonItem(image: UIImage(systemName: "thermometer"), style: .done, target: self, action: #selector(handleShowForecast)),
            UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(handleRefresh))
        ]
        
        transparentNavigationBar()
        setupViews()
        layoutViews()
    }
    
    func loadData(city: String) {
        networkManager.fetchCurrentWeather(city: city) { (weather) in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
            
            DispatchQueue.main.async {
                self.currentTemp.text = weather.main.temp.celcius()
                self.maxTemp.text = weather.main.temp_min.celcius()
                self.minTemp.text = weather.main.temp_max.celcius()
                self.currentLocation.text = "\(weather.name ?? "") , \(weather.sys.country ?? "")"
                self.tempDescription.text = weather.weather[0].description
                self.currentDate.text = stringDate
                self.tempSymbol.downloaded(from: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png")
                UserDefaults.standard.set("\(weather.name ?? "")", forKey: "SelectedCity")
            }
        }
    }
    
    func setupViews() {
        view.addSubview(currentLocation)
        view.addSubview(currentDate)
        view.addSubview(currentTemp)
        view.addSubview(tempSymbol)
        view.addSubview(currentTemp)
        view.addSubview(tempDescription)
        view.addSubview(minTemp)
        view.addSubview(maxTemp)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            currentLocation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  0),
            currentLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            currentLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            currentLocation.heightAnchor.constraint(equalToConstant: 70),
            
            currentDate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            currentDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            currentDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            currentDate.heightAnchor.constraint(equalToConstant: 70),
            
            currentTemp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            currentTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            currentTemp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            currentTemp.heightAnchor.constraint(equalToConstant: 70),
            
            tempDescription.topAnchor.constraint(equalTo: currentTemp.bottomAnchor, constant: 20),
            tempDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            tempDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            tempSymbol.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            tempSymbol.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tempSymbol.heightAnchor.constraint(equalToConstant: 100),
            tempSymbol.widthAnchor.constraint(equalToConstant: 100),
            
            minTemp.bottomAnchor.constraint(equalTo: tempSymbol.bottomAnchor, constant: 20),
            minTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            minTemp.heightAnchor.constraint(equalToConstant: 20),
            minTemp.widthAnchor.constraint(equalToConstant: 100),
            
            maxTemp.topAnchor.constraint(equalTo: minTemp.bottomAnchor),
            maxTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            maxTemp.heightAnchor.constraint(equalToConstant: 20),
            maxTemp.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    //MARK: - Handlers
    @objc func handleAddPlaceButton() {
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "City Name"
        }
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            print("City Name: \(firstTextField.text)")
            guard let cityname = firstTextField.text else { return }
            self.loadData(city: cityname) // Calling the loadData function
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action : UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        //        self.loadData(city: "Moscow") // Calling the loadData function
    }
    
    @objc func handleShowForecast() {
//        self.navigationController?.pushViewController(ForecastViewController(), animated: true)
        let nav = UINavigationController(rootViewController: ForecastViewController())
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func handleRefresh() {
        let city = UserDefaults.standard.string(forKey: "SelectedCity") ?? ""
        loadData(city: city)
    }
    
    func transparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
        
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

