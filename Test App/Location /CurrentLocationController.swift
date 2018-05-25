//
//  CurrentLocationController.swift
//  Test App
//
//  Created by Joga Singh on 18/05/18.
//  Copyright © 2018 Arethos. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class CurrentLocationController: UIViewController {

    // Global Var
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        // https://app.hyreshem.nu/objects.php
//        {"cities":[12],"rooms":[2],"min_kvm":1,"max_kvm":100,"max_rent":8000}
        // {"cities":[8,10,12],"rooms":[2,3],"min_kvm":1,"max_kvm":100,"max_rent":8000}
        
        let roomSelected = ["2"]
        let cities = ["12"]
        let dict = ["rooms" : roomSelected, "cities": cities, "min_kvm":"1","max_kvm":"100","max_rent":"8000"] as [String : Any]
        let json = ["data" : dict]
        
        print(json)
        sendFormDataUsingAlamofire()
        
    }

    func sendFormDataUsingAlamofire() -> () {
        let baseAddress = "https://app.hyreshem.nu/objects.php"
        let dict = ["rooms" : [2], "cities": [12], "min_kvm":1,"max_kvm":100,"max_rent":8000] as [String : Any]
        let parameters = ["data" : dict]
        print(parameters)
        let jsonData = try! JSONSerialization.data(withJSONObject: dict)
        print(jsonData)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        print(jsonString!)
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                let val = parameters["data"]
              //  let object = val?.description
            //    multipartFormData.append(jsonString, withName: "data")
                multipartFormData.append(jsonData, withName: "data", mimeType: "text/plain")
                },
            to: baseAddress,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if response.result.isSuccess{
                            let value = response.result.value
                            print(value!)
                        }
                        else
                        {
                           
                        }
                        //  protocolDelegate?.receiveJSON(methodName: methodName, JSONDictionary: json)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    // showAlert(title: "", message: str, target: target)
                }
        }
        )
    }
    
    
    
    func sendFormData(completionHandler: () -> ()) {
        // Create Params
     //   let roomSelected = ["2"]
     //   let cities = ["12"]
        let dict = ["rooms" : [2], "cities": [12], "min_kvm":1,"max_kvm":100,"max_rent":8000] as [String : Any]
        let json = ["data" : dict]
        let postString = "data=\(dict)"
        print(postString)
        // Create Data from Params
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let url = URL(string: "https://app.hyreshem.nu/objects.php")!
        // Create Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // insert json data to the request
//        request.httpBody = postString.description.data(using: String.Encoding.utf8)
        request.httpBody = jsonData
        request.addValue("application/x-www-form-urlencoded charset=utf-8", forHTTPHeaderField: "Content-Type")
        // Create Session Task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // API Response
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            // Expected Data
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            print(responseJSON!)
        }
        // Start Task
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension CurrentLocationController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertView.init(title: "Failed", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "Ok")
        alert.show()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // print(locations.last?.coordinate.latitude)
        let myLatitude: String = String(format: "%f", (locations.last?.coordinate.latitude)!)
        let myLongitude: String = String(format:"%f", (locations.last?.coordinate.longitude)!)
        latLabel.text = myLatitude
        longLabel.text = myLongitude
        
        geocoder.reverseGeocodeLocation(locations.last!) { (placemark, error) in
            guard let placemark = placemark, error == nil else { return }
            // you should always update your UI in the main thread
            DispatchQueue.main.async {
                //  update UI here
                self.address1Label.text = placemark.last!.thoroughfare
                self.address2Label.text = placemark.last!.subThoroughfare
                self.cityLabel.text = placemark.last!.locality
                self.stateLabel.text = placemark.last!.administrativeArea
                self.zipCodeLabel.text = placemark.last!.postalCode
                self.countryLabel.text = placemark.last!.country
                
            }
        }
        
    }

}
