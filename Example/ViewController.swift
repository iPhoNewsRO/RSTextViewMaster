//
//  RSTextViewMasterDemo
//
//  Created by Radu Ursache (RanduSoft)
//  Based on jeasungLEE's TextViewMaster (https://github.com/JeaSungLEE/TextViewMaster)
//  Copyright © 2019 RanduSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: RSTextViewMaster!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.text = ""
        self.textView.delegate = self
        self.textView.placeHolder = "Input text"
        self.textView.isAnimate = true
        
        self.textView.maxHeight = 150 // optional, if you want to stop textview resizing eventually and go back to the default scrolling one
    }
    
}

extension ViewController: RSTextViewMasterDelegate {
    func growingTextView(growingTextView: RSTextViewMaster, willChangeHeight height: CGFloat) {
        self.view.layoutIfNeeded()
    }
}

