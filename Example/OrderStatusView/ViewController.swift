//
//  ViewController.swift
//  OrderStatusView
//
//  Created by paragdulam on 03/29/2018.
//  Copyright (c) 2018 paragdulam. All rights reserved.
//

import UIKit
import OrderStatusView

enum OrderState: Int {
    case PLACED = 0
    case RECIEVED
    case PROCESSING
    case PROCESSED
    case OUTFORDELIVERY
    case DELIVERED
}

class ViewController: UIViewController {

    
    @IBOutlet weak var orderStatusView: OrderStatusView!
    @IBOutlet weak var statusLabel: UILabel!
    var state: OrderState = .PLACED
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        orderStatusView.selectedStateColor = UIColor.yellow
        orderStatusView.normalStateColor = UIColor.white
        orderStatusView.layer.cornerRadius = 20.0
        orderStatusView.clipsToBounds = true
        setState()
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                self.setState()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setState() {
        switch self.state {
        case .PLACED:
            self.state = .RECIEVED
        case .RECIEVED:
            self.state = .PROCESSING
        case .PROCESSING:
            self.state = .PROCESSED
        case .PROCESSED:
            self.state = .OUTFORDELIVERY
        case .OUTFORDELIVERY:
            self.state = .DELIVERED
        case .DELIVERED:
            self.state = .PLACED
        }
        self.orderStatusView.setStatus(self.state.rawValue)
        self.statusLabel.text = self.textForState(state: self.state)
    }
    
    func textForState(state: OrderState) -> String {
        switch state {
            
        case .PLACED:
            return "Order Placed"
        case .RECIEVED:
            return "Order Recieved"
        case .PROCESSING:
            return "Order Processing.."
        case .PROCESSED:
            return "Order Processed"
        case .OUTFORDELIVERY:
            return "Order Out for Delivery"
        case .DELIVERED:
            return "Order Delivered"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

