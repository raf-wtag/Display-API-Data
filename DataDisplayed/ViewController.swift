//
//  ViewController.swift
//  DataDisplayed
//
//  Created by Fahim Rahman on 25/3/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var DailyData = [Daily]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(completionHandler: {
            data in
            self.DailyData = data
            
            print("length of the array is", self.DailyData.count)
            if !self.DailyData.isEmpty {
//                print("length of the array is before removing ", self.DailyData.count)
                self.DailyData.removeFirst()
//                print("length of the array is after removing", self.DailyData.count)
            }
            
            print("length of the array is", self.DailyData.count)
        })
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DailyData.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // Before using Extension
//        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM dd, yyyy"
//
//        return dateFormatter.string(from: date!)
        
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table_cell") as! CustomTableViewCell
//        cell?.textLabel?.text = String("Max Temp:\(Int(self.weatherData[indexPath.row].temp.max))°K    Min Temp: \(Int(self.weatherData[indexPath.row].temp.min))°K")

//
        if indexPath.row <= 6 {
//            cell?.textLabel?.text = "\(self.DailyData[indexPath.row].dt.fromUnixTimeStamp())"
//            cell?.detailTextLabel?.text = "Max: \(self.DailyData[indexPath.row].temp.max)°C                  Min: \(self.DailyData[indexPath.row].temp.min)°C "
            cell.forecastDate.text = "\(self.DailyData[indexPath.row].dt.fromUnixTimeStamp())"
            cell.forecastMaxTemp.text = "Max: \(self.DailyData[indexPath.row].temp.max)°C"
            cell.forecastMinTemp.text = "Min: \(self.DailyData[indexPath.row].temp.min)°C"
        }
        
//        print(indexPath.row)
        return cell
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath)
//    }

}


// MARK - later this function should move to separate folder

func fetchData(completionHandler: @escaping ([Daily]) -> Void) {
    
    var returnDailyData = [Daily]()
//    var weatherData =
    
    // Call API & Fetch the Data
    let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=23.8103&lon=90.4125&units=metric&exclude=current,minutely,hourly,alerts&appid=a32d1247d69743e1f60a87f3a5a904c8"
    
    let url = URL(string: urlString)
    
    let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
       
        guard let data = data, error == nil else {
            print("Error Occured")
            return
        }
        
//        if let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) {
//            print(jsonData)
//        }
                
        let result = try? JSONDecoder().decode(WeatherData.self, from: data)
        
        if let res = result {
            returnDailyData = res.daily
        }
        
        completionHandler(returnDailyData)
    })
    
    task.resume()
    
    completionHandler(returnDailyData)
}

extension Int {

    func  fromUnixTimeStamp() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        if let retData = dateFormatter.string(for: date) {
            return retData
        }
        return ""
    }

}
