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
    private var backgroundImageView: UIImageView!
    private var weatherIcon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.95, alpha: 1.0)
        
        setupBackgroundImageView()
        setupCollectionView()
        setupWeatherImageView()
        setupWeatherLabel()
        setupWeatherIcon()
        
        selectedWeather = weathers.randomElement()
        updateWeatherView(animated: false)
    }

    private func setupBackgroundImageView() {
        backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: "WeatherCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func setupWeatherImageView() {
        weatherImageView = UIImageView()
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.layer.cornerRadius = 20
        weatherImageView.clipsToBounds = true
        weatherImageView.layer.shadowColor = UIColor.black.cgColor
        weatherImageView.layer.shadowOpacity = 0.5
        weatherImageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        weatherImageView.layer.shadowRadius = 8
        view.addSubview(weatherImageView)

        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            weatherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weatherImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            weatherImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupWeatherLabel() {
        weatherLabel = UILabel()
        weatherLabel.textAlignment = .center
        weatherLabel.font = UIFont.boldSystemFont(ofSize: 32)
        weatherLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.4, alpha: 1.0)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.layer.shadowColor = UIColor.black.cgColor
        weatherLabel.layer.shadowOpacity = 0.5
        weatherLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        weatherLabel.layer.shadowRadius = 4
        view.addSubview(weatherLabel)

        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 20),
            weatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weatherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setupWeatherIcon() {
        weatherIcon = UIImageView()
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 1.0)
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.layer.shadowColor = UIColor.black.cgColor
        weatherIcon.layer.shadowOpacity = 0.5
        weatherIcon.layer.shadowOffset = CGSize(width: 4, height: 4)
        weatherIcon.layer.shadowRadius = 8
        view.addSubview(weatherIcon)

        NSLayoutConstraint.activate([
            weatherIcon.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 20),
            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 100),
            weatherIcon.heightAnchor.constraint(equalToConstant: 100)
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
            
            UIView.transition(with: weatherIcon, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.weatherIcon.image = UIImage(systemName: weather.sfSymbolName)
            }, completion: nil)
        } else {
            weatherImageView.image = UIImage(named: weather.imageName)
            weatherLabel.text = weather.name
            weatherIcon.image = UIImage(systemName: weather.sfSymbolName)
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
