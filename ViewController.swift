//
//  ViewController.swift
//  loginPanel
//
//  Created by Vishwa Raj on 11/11/16.
//  Copyright © 2016 innov8. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
//                for result in results as! [NSManagedObject]
//                {
//                    if (result.value(forKey: "username") as? String) != nil
//                    {
//                       self.performSegue(withIdentifier: "mainSegue", sender: nil)
//                    }
//                    
//                }
                
                self.performSegue(withIdentifier: "mainSegue", sender: nil)
            }
           
        }
        catch
        {
            print("Error in fetching the data!")
        }
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(_ sender: UIButton) {
        
        let url = "http://vishwaraj.xyz/iOSServer/login.php"
        
        Alamofire.request( url ,method: .get).responseJSON {
            response in
            
            if let JSON = response.result.value as? [[String: AnyObject]]
            {
                for value in JSON {
                    let myusername = value["username"] as! NSString
                    if myusername as String == self.username.text!
                    {
                        let mypassword = value["password"] as! NSString
                        if mypassword as String == self.password.text!
                        {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            let context = appDelegate.persistentContainer.viewContext
                            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
                            newUser.setValue(self.username.text!, forKey: "username")
                            newUser.setValue(self.password.text!, forKey: "password")
                            
                            do
                            {
                                try context.save()
                                print("Data saved")
                                
                            }
                                
                            catch
                            {
                                print("Error in saving data")
                            }

                            
                            self.performSegue(withIdentifier: "mainSegue", sender: nil)
                        }
                    }
                }
            }
            
        }

        
    }
    

}

