//
//  LoadindIndicator.swift
//  VContact
//
//  Created by Wally on 25.05.2022.
//

import UIKit

class LoadindIndicator: UIViewController {
      
    @IBOutlet var loadElements: [UIImageView]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 3, delay: 0, options: .repeat, animations: {
                self.loadElements[0].alpha = 1
            
        })
        
        UIView.animate(withDuration: 2, delay: 1, options: .repeat, animations: {
                self.loadElements[1].alpha = 1
            
        })
        UIView.animate(withDuration: 1, delay: 2, options: .curveLinear, animations: {
                self.loadElements[2].alpha = 1
        })
    
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
