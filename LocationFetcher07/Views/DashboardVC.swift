//
//  DashboardVC.swift
//  TabBar07
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class DashboardVC: TemplateVC , UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    var locationFetcher: LocationFetcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGreen
        locationFetcher = LocationFetcher.shared
        self.setup_TopSafeBar()
        tableView.register(UserDayLocationCell.self, forCellReuseIdentifier: "UserDayLocationCell")
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() // Refresh the table view
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: vwTopSafeBar.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationFetcher.arryUserLocation.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDayLocationCell", for: indexPath) as! UserDayLocationCell
        let userDayLocation = locationFetcher.arryUserLocation[indexPath.row]
        cell.configure(with: userDayLocation)
        return cell
    }
}



class UserDayLocationCell: UITableViewCell {
    let timestampLabel = UILabel()
    let latitudeLabel = UILabel()
    let longitudeLabel = UILabel()
    let lblAppState = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        latitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        longitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        lblAppState.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(timestampLabel)
        contentView.addSubview(latitudeLabel)
        contentView.addSubview(longitudeLabel)
        contentView.addSubview(lblAppState)

        NSLayoutConstraint.activate([
            timestampLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            timestampLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timestampLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            latitudeLabel.topAnchor.constraint(equalTo: timestampLabel.bottomAnchor, constant: 8),
            latitudeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            latitudeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            longitudeLabel.topAnchor.constraint(equalTo: latitudeLabel.bottomAnchor, constant: 8),
            longitudeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            longitudeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            longitudeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            
            lblAppState.topAnchor.constraint(equalTo: longitudeLabel.bottomAnchor, constant: 8),
            lblAppState.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lblAppState.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lblAppState.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with userDayLocation: UserLocation) {
        timestampLabel.text = "Timestamp: \(userDayLocation.timestampString ?? "nil")"
        latitudeLabel.text = "Latitude: \(userDayLocation.latitude ?? 99999)"
        longitudeLabel.text = "Longitude: \(userDayLocation.longitude ?? 9999)"
        lblAppState.text = "state: \(userDayLocation.appState ?? "nil")"
        switch userDayLocation.appState{
        case "App Entered Background":
            self.backgroundColor = UIColor(named: "ColorRow1")
        case "App Will Enter Foreground":
            self.backgroundColor = UIColor(named: "ColorRow3TextFields")
        case "App Terminated":
            self.backgroundColor = .blue
        default:
            self.backgroundColor = UIColor(named: "ColorRow2")
        }
    }
}
