//
//  ViewController.swift
//  TabBar07
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class HomeVC: TemplateVC {
    var locationFetcher: LocationFetcher!
    
    let vwLocationStatus = LocationStatusView()
    let vwDemoSwitcher = DemoSwitchView()
    let btnRequestLocationFetcherPermission = UIButton()
    let btnStartCollectionLocation = UIButton()
    let btnStopCollectionLocation = UIButton()
    let btnCheckUserDefaultUserLocation = UIButton()
    let btnDeleteUserDefaultUserLocation = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationFetcher = LocationFetcher.shared
        locationFetcher.updateStatus = { [weak self] count in
            self?.vwLocationStatus.updateStatus?(count)
        }// This instantiates the updateStatus declared in LocationFetcher
        self.setup_TopSafeBar()
        setup_vwLocationStatus()
        setup_vwDemoSwitcher()
        setup_btnRequestLocationFetcherPermission()
        setup_btnStartCollectionLocation()
        setup_btnStopCollectionLocation()
        setup_btnCheckUserDeafultUserLocation()
        setup_btnDeleteUserDefaultUserLocation()
        if let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
            print("Documents Directory: \(documentsPath)")
        }
    }
    func setup_vwLocationStatus(){
        vwLocationStatus.updateStatus = { [weak self] count in
            self?.vwLocationStatus.lblLocationCount.text = "Location Count: \(count)"
        }
        vwLocationStatus.accessibilityIdentifier = "vwStatus"
        vwLocationStatus.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vwLocationStatus)
        NSLayoutConstraint.activate([
            vwLocationStatus.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor, constant: heightFromPct(percent: 3)),
            vwLocationStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 2)),
            vwLocationStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -1)),
        ])
    }
    func setup_vwDemoSwitcher(){

        vwDemoSwitcher.accessibilityIdentifier = "vwDemoSwitcher"
        vwDemoSwitcher.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vwDemoSwitcher)
        NSLayoutConstraint.activate([
            vwDemoSwitcher.topAnchor.constraint(equalTo: vwLocationStatus.bottomAnchor, constant: heightFromPct(percent: 3)),
            vwDemoSwitcher.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 2)),
            vwDemoSwitcher.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -1)),
        ])
    }
    func setup_btnRequestLocationFetcherPermission(){
        btnRequestLocationFetcherPermission.accessibilityIdentifier = "btnRequestLocationFetcherPermission"
        btnRequestLocationFetcherPermission.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btnRequestLocationFetcherPermission)
        btnRequestLocationFetcherPermission.setTitle("Location Fetcher Permission", for: .normal)
        let ui_color_btnUserLoc = UIColor(red: 0.2, green: 0.5, blue: 0.5, alpha: 1.0)
        btnRequestLocationFetcherPermission.layer.borderColor = ui_color_btnUserLoc.cgColor
        btnRequestLocationFetcherPermission.layer.borderWidth = 2
        btnRequestLocationFetcherPermission.backgroundColor = ui_color_btnUserLoc
        btnRequestLocationFetcherPermission.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            btnRequestLocationFetcherPermission.topAnchor.constraint(equalTo: vwDemoSwitcher.bottomAnchor, constant: heightFromPct(percent: 3)),
            btnRequestLocationFetcherPermission.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnRequestLocationFetcherPermission.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -1)),
        ])
        btnRequestLocationFetcherPermission.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnRequestLocationFetcherPermission.addTarget(self, action: #selector(touchUpInside_permission(_:)), for: .touchUpInside)
    }
    @objc func touchUpInside_permission(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        locationFetcher.locationManager.requestAlwaysAuthorization()
        templateAlert(alertMessage: "Requested permission")
    }
    

}

// Buttons not used yet
extension HomeVC {
    func setup_btnStartCollectionLocation(){
        btnStartCollectionLocation.accessibilityIdentifier = "btnStartCollectionLocation"
        btnStartCollectionLocation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btnStartCollectionLocation)
        btnStartCollectionLocation.setTitle("Location Fetcher Start", for: .normal)
        let ui_color_btnUserLoc = UIColor(red: 0.2, green: 0.5, blue: 0.5, alpha: 1.0)
        btnStartCollectionLocation.layer.borderColor = ui_color_btnUserLoc.cgColor
        btnStartCollectionLocation.layer.borderWidth = 2
        btnStartCollectionLocation.backgroundColor = ui_color_btnUserLoc
        btnStartCollectionLocation.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            btnStartCollectionLocation.topAnchor.constraint(equalTo: btnRequestLocationFetcherPermission.bottomAnchor, constant: heightFromPct(percent: 3)),
            btnStartCollectionLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnStartCollectionLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -1)),
        ])
        btnStartCollectionLocation.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnStartCollectionLocation.addTarget(self, action: #selector(touchUpInside_startLocationCollection(_:)), for: .touchUpInside)
    }
    @objc func touchUpInside_startLocationCollection(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
//        locationFetcher.startUpdatingLocation()
        templateAlert(alertMessage: "Currently doing nothing - locationFetcher.startUpdatingLocation()")
    }
    
    func setup_btnStopCollectionLocation(){
        btnStopCollectionLocation.accessibilityIdentifier = "btnStopCollectionLocation"
        btnStopCollectionLocation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btnStopCollectionLocation)
        btnStopCollectionLocation.setTitle("Location Fetcher Stop", for: .normal)
        let ui_color_btnUserLoc = UIColor(red: 0.9, green: 0.5, blue: 0.5, alpha: 1.0)
        btnStopCollectionLocation.layer.borderColor = ui_color_btnUserLoc.cgColor
        btnStopCollectionLocation.layer.borderWidth = 2
        btnStopCollectionLocation.backgroundColor = ui_color_btnUserLoc
        btnStopCollectionLocation.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            btnStopCollectionLocation.topAnchor.constraint(equalTo: btnStartCollectionLocation.bottomAnchor, constant: heightFromPct(percent: 3)),
            btnStopCollectionLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnStopCollectionLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -1)),
        ])
        btnStopCollectionLocation.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnStopCollectionLocation.addTarget(self, action: #selector(touchUpInside_stopLocationCollection(_:)), for: .touchUpInside)
    }
    @objc func touchUpInside_stopLocationCollection(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
//        locationFetcher.stopMonitoringLocationChanges()
        templateAlert(alertMessage: "Currently doing nothing - locationFetcher.stopMonitoringLocationChanges()")
    }
    
    private func setup_btnCheckUserDeafultUserLocation(){
        btnCheckUserDefaultUserLocation.accessibilityIdentifier = "btnCheckUserDefaultUserLocation"
        btnCheckUserDefaultUserLocation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btnCheckUserDefaultUserLocation)
        btnCheckUserDefaultUserLocation.setTitle("Display arryUserLocation", for: .normal)
        let ui_color_btnUserLoc = UIColor(red: 0.8, green: 0.5, blue: 0.5, alpha: 1.0)
        btnCheckUserDefaultUserLocation.layer.borderColor = ui_color_btnUserLoc.cgColor
        btnCheckUserDefaultUserLocation.layer.borderWidth = 2
        btnCheckUserDefaultUserLocation.backgroundColor = ui_color_btnUserLoc
        btnCheckUserDefaultUserLocation.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            btnCheckUserDefaultUserLocation.topAnchor.constraint(equalTo: btnStopCollectionLocation.bottomAnchor, constant: heightFromPct(percent: 3)),
            btnCheckUserDefaultUserLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnCheckUserDefaultUserLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -1)),
        ])
        btnCheckUserDefaultUserLocation.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnCheckUserDefaultUserLocation.addTarget(self, action: #selector(touchUpInside_displayLocations(_:)), for: .touchUpInside)
    }
    @objc func touchUpInside_displayLocations(_ sender: UIButton){
        templateAlert(alertMessage: "Currently doing nothing - display lists -- > just go to DashVC")
        //        locationFetcher.loadUserLocation()
//        if locationFetcher.arryUserDayLocation.count > 0 {
//            print("there exists a userLocationArray in UserDefaults")
//            //            // Do something with userLocationArray
//            print("location count: \(locationFetcher.arryUserDayLocation.count)")
//            if let encodedData = UserDefaults.standard.data(forKey: "arryUserLocation") {
//                do {
//                    let decodedArray = try JSONDecoder().decode([UserDayLocation].self, from: encodedData)
//                    self.templateAlert(alertTitle: "We have Locations!!", alertMessage: "\(decodedArray)",backScreen: false,dismissView: false)
//                    print("Successfully loaded arryDataSourceObjects from UserDefaults")
//                } catch {
//                    print("Failed to decode DataSourceObject: \(error)")
//                }
//            }
//        } else {
//            print("there does NOT exists a userLocationArray in UserDefaults")
//        }
    }
    
    private func setup_btnDeleteUserDefaultUserLocation(){
        btnDeleteUserDefaultUserLocation.accessibilityIdentifier = "btnDeleteUserDefaultUserLocation"
        btnDeleteUserDefaultUserLocation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btnDeleteUserDefaultUserLocation)
        btnDeleteUserDefaultUserLocation.setTitle("Delete UserDefaults: arryUserLocation", for: .normal)
        let ui_color_btnUserLoc = UIColor(red: 0.99, green: 0.2, blue: 0.2, alpha: 1.0)
        btnDeleteUserDefaultUserLocation.layer.borderColor = ui_color_btnUserLoc.cgColor
        btnDeleteUserDefaultUserLocation.layer.borderWidth = 2
        btnDeleteUserDefaultUserLocation.backgroundColor = ui_color_btnUserLoc
        btnDeleteUserDefaultUserLocation.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            btnDeleteUserDefaultUserLocation.topAnchor.constraint(equalTo: btnCheckUserDefaultUserLocation.bottomAnchor, constant: heightFromPct(percent: 3)),
            btnDeleteUserDefaultUserLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 2)),
            btnDeleteUserDefaultUserLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: widthFromPct(percent: -1)),
        ])
        btnDeleteUserDefaultUserLocation.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnDeleteUserDefaultUserLocation.addTarget(self, action: #selector(touchUpInside_deleteUserDefaults(_:)), for: .touchUpInside)
    }
    @objc func touchUpInside_deleteUserDefaults(_ sender: UIButton){
//        UserDefaults.standard.removeObject(forKey: "arryUserLocation")
//        locationFetcher.loadUserLocation()
//        print("deleted UserDefaults for arryUserLocation")
        templateAlert(alertMessage: "Currently doing nothing - no UserDefaults yet")
    }
}


class LocationStatusView: UIView {
    
    var locationFetcher: LocationFetcher!
    let lblLocationCount = UILabel()
    var updateStatus: ((Int) -> Void)?
    let lblAbout = UILabel()
    
    override init(frame: CGRect){
        super.init(frame:frame)
        locationFetcher = LocationFetcher.shared
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        lblLocationCount.accessibilityIdentifier="lblUserStatusTemporaryViewTitle"
        lblLocationCount.translatesAutoresizingMaskIntoConstraints = false
        if let unwp_arryLocs = locationFetcher.arryUserLocation {
            lblLocationCount.text = "Location Count: \(unwp_arryLocs.count)"
        }
        lblLocationCount.font = UIFont(name: "ArialRoundedMTBold", size: 20)
        lblLocationCount.numberOfLines=0
        self.addSubview(lblLocationCount)
        
        lblAbout.accessibilityIdentifier="lblAbout"
        lblAbout.translatesAutoresizingMaskIntoConstraints = false

        lblAbout.text = "Location Fetcher 06 does not shut off. It writes to a .json file. It uses locationManager.startMonitoringSignificantLocationChanges()"

        lblAbout.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        lblAbout.numberOfLines=0
        self.addSubview(lblAbout)
        
        
        NSLayoutConstraint.activate([
            lblLocationCount.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 3)),
            lblLocationCount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            lblLocationCount.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -1)),
//            lblLocationCount.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: heightFromPct(percent: -2))
            
            lblAbout.topAnchor.constraint(equalTo: lblLocationCount.bottomAnchor, constant: heightFromPct(percent: 1)),
            lblAbout.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 2)),
            lblAbout.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -1)),
            lblAbout.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: heightFromPct(percent: -2))
            
        ])
        
    }
}

