//
//  WeatherViewController.swift
//  Clima
//
//  Created by Yuunan kin on 2024/12/07.
//

import CoreLocation
import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var conditionImage: UIImageView!

    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherManager.delegate = self
        locationManager.delegate = self
        checkLocationAuthorization()

        searchTextField.delegate = self
        searchTextField.clearsOnBeginEditing = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func currentLocationPressed(_: UIButton) {
        checkLocationAuthorization()
    }

    @IBAction func searchPressed(_: UIButton) {
        let text = searchTextField.text ?? ""
        search(text)
    }

    private func search(_ text: String) {
        searchTextField.endEditing(true)
        if text.isEmpty {
            return
        }
        weatherManager.request(withName: text)
        searchTextField.text = ""
    }

    private func searchWithLatLon(_ lat: Double, _ lon: Double) {
        weatherManager.request(withlat: lat, andLon: lon)
    }

    private func checkLocationAuthorization() {
        print("⭐️auth: \(locationManager.authorizationStatus)")
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            showLocationPermissionDeniedAlert()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }

    private func showLocationPermissionDeniedAlert() {
        print("⭐️showLocationPermissionDeniedAlert")
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1.5
        ) {
            let alertController = UIAlertController(
                title: "Location Permission Denied",
                message: "Please enable location services in Settings to allow the app to access your location.",
                preferredStyle: .alert
            )

            let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            alertController.addAction(settingsAction)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            search(text)
        }
        return true
    }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func onWeatherFetched(_ weather: Weather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.city
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImage.image = .init(systemName: weather.icon)
        }
    }

    func onFailed(_ error: any Error) {
        print("Fetch failed: \(error.localizedDescription)")
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        print("⭐️location is \(locations)")
        guard let lastLocation = locations.last else {
            return
        }

        manager.stopUpdatingLocation()

        let lat = lastLocation.coordinate.latitude
        let lon = lastLocation.coordinate.longitude
        searchWithLatLon(lat, lon)
    }

    func locationManager(
        _: CLLocationManager,
        didFailWithError error: any Error
    ) {
        print("failed to get location: \(error.localizedDescription)")
    }
}
