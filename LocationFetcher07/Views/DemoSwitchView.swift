//
//  DemoSwitchView.swift
//  LocationFetcher07
//
//  Created by Nick Rodriguez on 17/08/2024.
//

import UIKit

class DemoSwitchView: UIView{
    var locationFetcher:LocationFetcher!
    
    let lblTitleDemoSwitchView = UILabel()
    
    let lblStartMonitoringSignificantLocationChanges = UILabel()
    let swtchStartMonitoringSignificantLocationChanges = UISwitch()
    
    let lblStartUpdatingLocation = UILabel()
    let swtchStartUpdatingLocation = UISwitch()
    
    let lblRequestLocation = UILabel()
    let swtchRequestLocation = UISwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // This triggers as soon as the app starts
        locationFetcher = LocationFetcher.shared
        setup_DemoSwitchViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup_DemoSwitchViews(){
        lblTitleDemoSwitchView.text = "Demo Switches"
        lblTitleDemoSwitchView.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        lblTitleDemoSwitchView.numberOfLines = 0
        lblTitleDemoSwitchView.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(lblTitleDemoSwitchView)
        lblTitleDemoSwitchView.accessibilityIdentifier="lblTitleDemoSwitchView"
        
        
        lblStartMonitoringSignificantLocationChanges.text = "StartMonitoringSignificantLocationChanges: "
        lblStartMonitoringSignificantLocationChanges.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(lblStartMonitoringSignificantLocationChanges)
        lblStartMonitoringSignificantLocationChanges.accessibilityIdentifier="lblOptionalView01"
        
        
        swtchStartMonitoringSignificantLocationChanges.accessibilityIdentifier = "swtchStartMonitoringSignificantLocationChanges"
        swtchStartMonitoringSignificantLocationChanges.translatesAutoresizingMaskIntoConstraints = false
        swtchStartMonitoringSignificantLocationChanges.addTarget(self, action: #selector(switchStartMonitoringSignificantLocationChanges(_:)), for: .valueChanged)
        self.addSubview(swtchStartMonitoringSignificantLocationChanges)
        
        lblStartUpdatingLocation.text = "startUpdatingLocation:  "
        lblStartUpdatingLocation.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(lblStartUpdatingLocation)
        lblStartUpdatingLocation.accessibilityIdentifier="lblOptionalView02"
        
        
        swtchStartUpdatingLocation.accessibilityIdentifier = "swtchStartUpdatingLocation"
        swtchStartUpdatingLocation.translatesAutoresizingMaskIntoConstraints = false
        swtchStartUpdatingLocation.addTarget(self, action: #selector(switchStartUpdatingLocation(_:)), for: .valueChanged)
        self.addSubview(swtchStartUpdatingLocation)
        
        lblRequestLocation.text = "requestLocation:  "
        lblRequestLocation.translatesAutoresizingMaskIntoConstraints=false
        self.addSubview(lblRequestLocation)
        lblRequestLocation.accessibilityIdentifier="lblRequestLocation"
        
        
        swtchRequestLocation.accessibilityIdentifier = "swtchRequestLocation"
        swtchRequestLocation.translatesAutoresizingMaskIntoConstraints = false
        swtchRequestLocation.addTarget(self, action: #selector(switchRequestLocation(_:)), for: .valueChanged)
        self.addSubview(swtchRequestLocation)
        
        
        
        
        NSLayoutConstraint.activate([
            lblTitleDemoSwitchView.topAnchor.constraint(equalTo: self.topAnchor, constant: heightFromPct(percent: 3)),
            lblTitleDemoSwitchView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: widthFromPct(percent: 2)),
            lblTitleDemoSwitchView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            
            
            lblStartMonitoringSignificantLocationChanges.topAnchor.constraint(equalTo: lblTitleDemoSwitchView.bottomAnchor, constant: heightFromPct(percent: 2)),
            lblStartMonitoringSignificantLocationChanges.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 3)),
            
            swtchStartMonitoringSignificantLocationChanges.centerYAnchor.constraint(equalTo: lblStartMonitoringSignificantLocationChanges.centerYAnchor),
            swtchStartMonitoringSignificantLocationChanges.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            
            lblStartUpdatingLocation.topAnchor.constraint(equalTo: lblStartMonitoringSignificantLocationChanges.bottomAnchor, constant: heightFromPct(percent: 2)),
            lblStartUpdatingLocation.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 3)),
            
            swtchStartUpdatingLocation.centerYAnchor.constraint(equalTo: lblStartUpdatingLocation.centerYAnchor),
            swtchStartUpdatingLocation.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            
            lblRequestLocation.topAnchor.constraint(equalTo: lblStartUpdatingLocation.bottomAnchor, constant: heightFromPct(percent: 2)),
            lblRequestLocation.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthFromPct(percent: 3)),
            
            swtchRequestLocation.centerYAnchor.constraint(equalTo: lblRequestLocation.centerYAnchor),
            swtchRequestLocation.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: widthFromPct(percent: -2)),
            
            swtchRequestLocation.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: heightFromPct(percent: -3)),
        ])
    }
    
    /* Objc Methods*/
    @objc private func switchStartMonitoringSignificantLocationChanges(_ sender: UISwitch) {
        if sender.isOn {
            locationFetcher.locationManager.startMonitoringSignificantLocationChanges()
            print("isON: startMonitoringSignificantLocationChanges()")
            
            // All other switches turned off
            self.swtchStartUpdatingLocation.isOn = false
            self.swtchRequestLocation.isOn = false
            
            // All other switches enabled
            self.swtchStartUpdatingLocation.isEnabled = true
            self.swtchRequestLocation.isEnabled = true

//            delegate?.case_option_1_Offline_and_generic_name()
        } else {
            locationFetcher.locationManager.stopMonitoringSignificantLocationChanges()
        }
    }
    
    @objc private func switchStartUpdatingLocation(_ sender: UISwitch) {
        print("--- Currently not working --- ")
        if sender.isOn {
//            locationFetcher.locationManager.startUpdatingLocation()
            print("isON: startUpdatingLocation()")
            
            // All other switches turned off
            self.swtchStartMonitoringSignificantLocationChanges.isOn = false
            self.swtchRequestLocation.isOn = false
            
            // All other switches enabled
            self.swtchStartMonitoringSignificantLocationChanges.isEnabled = true
            self.swtchRequestLocation.isEnabled = true

//            delegate?.case_option_1_Offline_and_generic_name()
        } else {
//            locationFetcher.locationManager.stopUpdatingLocation()
        }
    }
    
    @objc private func switchRequestLocation(_ sender: UISwitch) {
        if sender.isOn {
            locationFetcher.locationManager.startUpdatingLocation()
            print("isON: startUpdatingLocation()")
            
            // All other switches turned off
            self.swtchStartMonitoringSignificantLocationChanges.isOn = false
            self.swtchStartUpdatingLocation.isOn = false
            
            // All other switches enabled
            self.swtchStartMonitoringSignificantLocationChanges.isEnabled = true
            self.swtchStartUpdatingLocation.isEnabled = true

        }else {
            locationFetcher.locationManager.stopUpdatingLocation()
        }
    }
}
