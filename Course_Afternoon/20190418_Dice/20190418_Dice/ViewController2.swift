//
//  ViewController2.swift
//  20190418_Dice
//
//  Created by Trevor Wu on 2019/4/18.
//  Copyright © 2019年 TxWStudio. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    var socketConnector: SocketDataManager!
    
    @IBOutlet weak var totalPointText: UILabel!
    @IBOutlet weak var totalPointServer: UILabel!
    @IBOutlet weak var winOrLoseText: UILabel!
    
    
    var totalPoint: String!
    var totalPointSer: String!
    var bigOrSmall: String!
    var tempInt: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        socketConnector = SocketDataManager(with: self)
        connect()
        
        totalPointText.text = totalPoint
        sleep(1)
    }
    
    func winOrLose(j: Int) {
        let i = Int(totalPoint)!
        
//        let j = 0
        
        print("i: \(i), j: \(j)  ")
        if bigOrSmall == "押大"{
            if i > 6 && j > 6 {
                winOrLoseText.text = "Alright, you got it."
            }  else {
                winOrLoseText.text = "褲子拿來"
            }
        } else if bigOrSmall == "押小" {
            if i <= 6  && j <= 6 {
                winOrLoseText.text = "Alright, you got it."
            } else {
                winOrLoseText.text = "褲子拿來"
            }
        }
    }
    
    func connect() {
        let ipAddr = "203.64.128.229"
        let portVal = "8705"
        
        let soc = DataSocket(ip: ipAddr, port: portVal)
        print(soc)
        socketConnector.connectWith(socket: soc)
        
        let msg = "RandomMessage"
        socketConnector.send(message: msg)
    }
    
    
    @IBAction func back(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController2: PresenterProtocol{
    func resetUIWithConnection(status: Bool) {
        print("resetUIWithConnection")
    }
    
    func updateStatusViewWith(status: String) {
        print("updateStatusViewWith")
    }
    
    func update(message: String){
        print("Updata func 內的數值: \(message)")
        totalPointServer.text = message
        self.totalPointSer = message
        
        
        let temp = message
        let temps = temp.replacingOccurrences(of: "\n", with: "", options: NSString.CompareOptions.literal, range: nil)
        let tempInt: Int! = (temps as NSString).integerValue

        print("TempInt 的數值： \(tempInt)")
        print(tempInt)
        print(type(of: tempInt))
        
        winOrLose(j: tempInt)
        /*
        if let text = messageHistoryView.text{
            let newText = """
            \(text)
            \(message)
            """
            messageHistoryView.text = newText
        }else{
            let newText = """
            \(message)
            """
            messageHistoryView.text = newText
        }
        
        let myRange=NSMakeRange(messageHistoryView.text.count-1, 0);
        messageHistoryView.scrollRangeToVisible(myRange)*/
        
        
    }
    
    
}
