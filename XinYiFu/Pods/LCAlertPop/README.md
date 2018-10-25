# LCAlertPop
Replace UIAlertView.


import UIKit



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func showSuccess(_ sender: AnyObject) {
        let alert = LCAlertPop()
        _ = alert.addButton("First Button", target:self, selector:#selector(ViewController.firstButton))
        _ = alert.addButton("Second Button") {
            print("Second button tapped")
        }
        _ = alert.showSuccess(kSuccessTitle, subTitle: kSubtitle)
    }
    
    
    
    @IBAction func showError(_ sender: AnyObject) {
        _ = LCAlertPop().showError("bigTitle", subTitle:"subTitle", closeButtonTitle:"OK")
    }
    
    @IBAction func showNotice(_ sender: AnyObject) {
        let appearance = LCAlertPop.LCAppearance(dynamicAnimatorActive: true)
        _ = LCAlertPop(appearance: appearance).showNotice(kNoticeTitle, subTitle: kSubtitle)
    }
    
    @IBAction func showWarning(_ sender: AnyObject) {
        _ = LCAlertPop().showWarning(kWarningTitle, subTitle: kSubtitle)
    }
    
    @IBAction func showInfo(_ sender: AnyObject) {
        _ = LCAlertPop().showInfo(kInfoTitle, subTitle: kSubtitle)
    }
    
    @IBAction func showEdit(_ sender: AnyObject) {
        let appearance = LCAlertPop.LCAppearance(showCloseButton: true)
        let alert = LCAlertPop(appearance: appearance)
        let txt = alert.addTextField("Enter your name")
        _ = alert.addButton("Show Name") {
            print("Text value: \(txt.text ?? "NA")")
        }
        _ = alert.showEdit(kInfoTitle, subTitle:kSubtitle)
    }
    
    @IBAction func showWait(_ sender: AnyObject) {
        let appearance = LCAlertPop.LCAppearance(
            showCloseButton: false
        )
        
        let alert = LCAlertPop(appearance: appearance).showWait("Download", subTitle: "Processing...", closeButtonTitle: nil, timeout: nil, colorStyle: nil, colorTextButton: 0xFFFFFF, circleIconImage: nil, animationStyle: LCAnimationStyle.topToBottom)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            alert.setSubTitle("Progress: 10%")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alert.setSubTitle("Progress: 50%")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    alert.setSubTitle("Progress: 70%")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        alert.close()
                    }
                }
            }
        }
    }
    
    @IBAction func showCustomSubview(_ sender: AnyObject) {
        // Create custom Appearance Configuration
        let appearance = LCAlertPop.LCAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false,
            dynamicAnimatorActive: true
        )
        
        // Initialize LCAlertView using custom Appearance
        let alert = LCAlertPop(appearance: appearance)
        
        // Creat the subview
        let subview = UIView(frame: CGRect(x: 0,y: 0,width: 216,height: 70))
        let x = (subview.frame.width - 180) / 2
        
        // Add textfield 1
        let textfield1 = UITextField(frame: CGRect(x: x,y: 10,width: 180,height: 25))
        textfield1.layer.borderColor = UIColor.green.cgColor
        textfield1.layer.borderWidth = 1.5
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "Username"
        textfield1.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield1)
        
        // Add textfield 2
        let textfield2 = UITextField(frame: CGRect(x: x,y: textfield1.frame.maxY + 10,width: 180,height: 25))
        textfield2.isSecureTextEntry = true
        textfield2.layer.borderColor = UIColor.blue.cgColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield1.layer.borderColor = UIColor.blue.cgColor
        textfield2.placeholder = "Password"
        textfield2.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield2)
        
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        _ = alert.addButton("Login") {
            print("Logged in")
        }
        
        // Add Button with visible timeout and custom Colors
        let showTimeout = LCButton.ShowTimeoutConfiguration(prefix: "(", suffix: " s)")
        _ = alert.addButton("Timeout Button", backgroundColor: UIColor.brown, textColor: UIColor.yellow, showTimeout: showTimeout) {
            print("Timeout Button tapped")
        }
        
        let timeoutValue: TimeInterval = 10.0
        let timeoutAction: LCAlertPop.LCTimeoutConfiguration.ActionType = {
            print("Timeout occurred")
        }
        
        _ = alert.showInfo("Login", subTitle: "", timeout: LCAlertPop.LCTimeoutConfiguration(timeoutValue: timeoutValue, timeoutAction: timeoutAction))
    }
    
    @IBAction func showCustomAlert(_ sender: AnyObject) {
        let appearance = LCAlertPop.LCAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false,
            //            dynamicAnimatorActive: true,
            buttonsLayout: .horizontal
        )
        let alert = LCAlertPop(appearance: appearance)
        _ = alert.addButton("First Button", target:self, selector:#selector(ViewController.firstButton))
        _ = alert.addButton("Second Button") {
            print("Second button tapped")
        }
        
        let icon = UIImage(named:"custom_icon.png")
        let color = UIColor.orange
        
        _ = alert.showCustom("Custom Color", subTitle: "Custom color", color: color, icon: icon!)
    }
    
    @objc func firstButton() {
        print("First button tapped")
    }
}


