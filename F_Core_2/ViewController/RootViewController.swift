//
//  ViewController.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/8/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var navigationViewBarCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var historyView: HistoryView!
    @IBOutlet weak var homeView: HomeView!
    @IBOutlet weak var settingsView: SettingsView!
    
    var rootViewControllerModel: RootViewControllerModel?
    var homeViewControllerModel: HomeViewControllerModel?
    var historyViewControllerModel: HistoryViewControllerModel?
    var settingsViewControllerModel: SettingsViewControllerModel?
    
    var locationManager: CLLocationManager?
    var lastLocationUpdateTime: Date?
    var location: [Geolocation:Double]?
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainScrollView.delegate = self
        self.rootViewControllerModel = RootViewControllerModel(frame: self.view.frame)
        self.loadHomeView()
        self.loadHistoryView()
        self.loadSettingsView()
        self.fetchLocationData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mainScrollView.setContentOffset(CGPoint(x: view.frame.width, y: 0), animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mainScrollView.setContentOffset(CGPoint(x: view.frame.width, y: 0), animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.location?[Geolocation.Latitude] = locationValue.latitude
        self.location?[Geolocation.Longitude] = locationValue.longitude
        self.lastLocationUpdateTime = Date()
    }
    
    private func fetchLocationData() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.showsBackgroundLocationIndicator = true
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.startUpdatingLocation()
        print("getting location")
    }
    
    private func loadHomeView() {
        self.homeViewControllerModel = HomeViewControllerModel()
        self.homeView.surveyButton.addTarget(self, action: #selector(openSurveyView), for: .touchUpInside)
        self.homeView.dealButton.addTarget(self, action: #selector(openDealSafariWindow), for: .touchUpInside)
    }
    
    private func loadHistoryView() {
        self.historyViewControllerModel = HistoryViewControllerModel()
        self.historyView.historyTableView.dataSource = self
        self.historyView.historyTableView.delegate = self
    }
    
    private func loadSettingsView() {
        self.settingsViewControllerModel = SettingsViewControllerModel(delegate: self)
        self.settingsView.numberOfQuestionPicker.dataSource = self
        self.settingsView.numberOfQuestionPicker.delegate = self
        self.hideOrShowPicker()
        
        self.settingsView.numberOfQuestionButton.addTarget(self, action: #selector(hideOrShowPicker), for: .touchUpInside)
        self.settingsView.notificationSwitch.addTarget(self, action: #selector(notificationSwitchChanged(_:)), for: .valueChanged)
        self.settingsView.suggestionsButton.addTarget(self, action: #selector(suggestionButtonClicked(_:)), for: .touchUpInside)
        self.settingsView.legalButton.addTarget(self, action: #selector(legalButtonClicked(_:)), for: .touchUpInside)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let offset = rootViewControllerModel?.getNavigationOffset(scrollview: scrollView) {
            self.navigationViewBarCenterConstraint.constant = offset
        }
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal), let buttonTitle = ButtonTitle(rawValue: title) else { return }
        self.rootViewControllerModel?.pageViewTo(scrollview: self.mainScrollView, title: buttonTitle)
    }
}

