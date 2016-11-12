//
//  mainController.swift
//  loginPanel
//
//  Created by Vishwa Raj on 12/11/16.
//  Copyright © 2016 innov8. All rights reserved.
//

import UIKit
import CoreData


class mainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    context.delete(result)
//                    if result.value(forKey: "username") != nil
//                    {
//                        print("\(result) deleted")
//                        context.delete(result)
//                    }
                }
            }
            else
            {
                print("The data to delete could not found.")
            }
            
        }
        catch
        {
            print("Data could not be able to delete!")
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
