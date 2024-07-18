//
//  MainViewController.swift
//  VK_task
//
//  Created by Kirill Smirnov on 18.07.2024.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var weathers = Weather.allWeathers
    private var selectedWeather: Weather?

    private var collectionView: UICollectionView!
    private var weatherImageView: UIImageView!
    private var weatherLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCollectionView()
        setupWeatherImageView()
        setupWeatherLabel()
        
        selectedWeather = weathers.randomElement()
        updateWeatherView(animated: false)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "WeatherCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupWeatherImageView() {
        weatherImageView = UIImageView()
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherImageView)

        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            weatherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupWeatherLabel() {
        weatherLabel = UILabel()
        weatherLabel.textAlignment = .center
        weatherLabel.font = UIFont.systemFont(ofSize: 24)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherLabel)

        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 20),
            weatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func updateWeatherView(animated: Bool) {
        guard let weather = selectedWeather else { return }
        
        if animated {
            UIView.transition(with: weatherImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.weatherImageView.image = UIImage(named: weather.imageName)
            }, completion: nil)
            
            UIView.transition(with: weatherLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.weatherLabel.text = weather.name
            }, completion: nil)
        } else {
            weatherImageView.image = UIImage(named: weather.imageName)
            weatherLabel.text = weather.name
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let weather = weathers[indexPath.row]
        cell.configure(with: weather)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedWeather = weathers[indexPath.row]
        updateWeatherView(animated: true)
    }
}
