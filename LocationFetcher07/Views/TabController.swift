//
//  TabController.swift
//  WhatSticks13iOS
//
//  Created by Nick Rodriguez on 28/06/2024.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    

    var lineSelectedTab = UIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("- in TabController -")
        self.setupTabs()
        self.tabBar.backgroundColor = UIColor(named: "ColorTableTabModalBack")
        self.tabBar.tintColor = UIColor(named: "ColorTabBarSelected")
        self.tabBar.unselectedItemTintColor = UIColor(named: "ColorTabBarUnselected")
        self.tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor(named: "ColorTabBarSelected")!, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height:  tabBar.frame.height), lineWidth: 4.0)
        self.delegate = self
    }
    

    private func setupTabs(){
        let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeVC())
        let dash = self.createNav(with: "Dashboard", and: UIImage(systemName: "clock"), vc: DashboardVC())
//        let manage_data = self.createNav(with: "Manage Data", and: UIImage(systemName: "square.and.arrow.up"), vc: ManageDataVC())// <--- altered for TEST DAta
        let user = self.createNav(with: "Manage User", and: UIImage(systemName: "person"), vc: UserVC())

        home.tabBarItem.tag = 0
        dash.tabBarItem.tag = 1
//        manage_data.tabBarItem.tag = 2
        user.tabBarItem.tag = 3
        
//        self.setViewControllers([home,dash, manage_data, user], animated: true)
        self.setViewControllers([home,dash, user], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.tabBarItem.tag = 0
        
        return nav
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("Selected viewController: \(type(of: viewController))") // Print the actual class type
//        print("Selected viewController.children: \(viewController.children)")
        guard let nav_vc = viewController as? UINavigationController else {
            print("- Item is not a UINavigationController")
            return
        }
        if let _ = nav_vc.children[0] as? UserVC {
            print("-- TabController UserVC selected < ------ *")
            
        }

        if let _ = nav_vc.children[0] as? DashboardVC {
            print("goign to DashboardVC")
            populateUserLocationAppState()
            
        }
    }
    
    func populateUserLocationAppState() {
        for userLocation in LocationFetcher.shared.arryUserLocation {
            if let appState = AppStateMonitor.shared.arryAppState.first(where: { $0.timestamp >= userLocation.timestamp }) {
                userLocation.appState = appState.state
            }
        }
    }

}




