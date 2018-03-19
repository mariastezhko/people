//
//  ViewController.swift
//  People
//
//  Created by Maria Stezhko on 3/19/18.
//  Copyright © 2018 Maria Stezhko. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController {

    var people = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "http://swapi.co/api/people/")
        // create a URLSession to handle the request tasks
        let session = URLSession.shared
        // create a "data task" to make the request and run the completion handler
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            //print("in here")
            // see: Swift nil coalescing operator (double questionmark)
            //print(data ?? "no data") // the "no data" is a default value to use if data is nil
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    //print(jsonResult)
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! NSArray
                        //print(resultsArray.count)
                        //print(resultsArray[0])
                        for i in 0..<resultsArray.count {
                                let resultsArray2 = resultsArray[i] as! NSDictionary
                                //print(resultsArray.firstObject)
                                //print(resultsArray2["name"])
                                let name = resultsArray2["name"]
                                if name != nil {
                                    self.people.append(name as! String)
                                    print(name as! String)
                                }
                                //let indexPath = IndexPath(row: i, section: 0)
                                //self.tableView.cellForRow(at: indexPath)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }
                }
            } catch {
                print(error)
            }
        })
        // execute the task and wait for the response before
        // running the completion handler. This is async!
        task.resume()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = people[indexPath.row]
        // return the cell so that it can be rendered
        return cell
    }

    
    

}

