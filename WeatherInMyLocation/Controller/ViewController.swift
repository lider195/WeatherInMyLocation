import UIKit
import MapKit
final class ViewController: UIViewController{
    // MARK: - Properties
    // MARK: Public
    
    // MARK: Private
    private let map = MKMapView()
    private let locationManager = CLLocationManager()
    private let myLocationButton = UIButton()
    private let weatherButton = UIButton()
    private let viewWeather = UIView()
    private var selectedLatitude: Double = 0.0
    private var selectedLongitude: Double = 0.0
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        mapSetup()
        setupConstrains()
        setupButton()
    }
    // MARK: - API
    
    // MARK: - Setups
    private func addSubviews(){
        view.addSubview(map)
        map.addSubview(myLocationButton)
        map.addSubview(weatherButton)
    }
    private func mapSetup(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
    }
    private func setupConstrains(){
        map.translatesAutoresizingMaskIntoConstraints = false
        map.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        map.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        map.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        myLocationButton.translatesAutoresizingMaskIntoConstraints = false
        myLocationButton.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: -90).isActive = true
        myLocationButton.trailingAnchor.constraint(equalTo: map.trailingAnchor, constant: -40).isActive = true
        myLocationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myLocationButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        weatherButton.translatesAutoresizingMaskIntoConstraints = false
        weatherButton.leadingAnchor.constraint(equalTo: map.leadingAnchor, constant: 40).isActive = true
        weatherButton.bottomAnchor.constraint(equalTo: map.bottomAnchor, constant: -90).isActive = true
        weatherButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        weatherButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    private func setupButton(){
        let configurator = UIImage.SymbolConfiguration(pointSize: 50,
                                                       weight: .bold,
                                                       scale: .large)
        let resultImage = UIImage(systemName: "location.circle.fill",
                                  withConfiguration: configurator)
        myLocationButton.setImage(resultImage,
                                  for: .normal)
        myLocationButton.addTarget(self,
                                   action: #selector(myLocation),
                                   for: .touchUpInside)
        let weatherImage = UIImage(systemName: "cloud.rain.fill",
                                   withConfiguration: configurator)
        weatherButton.setImage(weatherImage,
                               for: .normal)
        weatherButton.addTarget(self,
                                action: #selector(weatherInMyLocation),
                                for: .touchUpInside)
    }
    // MARK: - Helpers
    @objc private func myLocation(){
        let myLatitude = (locationManager.location?.coordinate.latitude)!
        let myLongitude = (locationManager.location?.coordinate.longitude)!
        
        let location = CLLocationCoordinate2D(latitude: myLatitude,
                                              longitude: myLongitude)
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: 3000,
                                                  longitudinalMeters: 3000)
        map.setRegion(coordinateRegion, animated: true)
        selectedLatitude = myLatitude
        selectedLongitude = myLongitude
    }
    
    @objc private func weatherInMyLocation(){
        ApiManager.instance.getAllWeather(myLatitude:selectedLatitude , myLongitude: selectedLongitude){ data in
            print("\(data.main.temp)°C")}
        
    }
}

