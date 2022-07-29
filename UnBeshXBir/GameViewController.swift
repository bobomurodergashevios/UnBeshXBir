//
//  GameViewController.swift
//  UnBeshXBir
//
//  Created by Bobomurod Ergashev on 15/07/22.
//

import UIKit
let windowWidth = UIScreen.main.bounds.width
let windowHeight = UIScreen.main.bounds.height

var ordered = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]

var baseView : UIView!

var buttons = [UIButton]()

var winList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]

private var lefttbtn : UIButton!
private var rightbtn : UIButton!
private var top : UIButton!
private var bottom : UIButton!
private var emptybuttontitle = [Int]()


class GameViewController: UIViewController {
    private var timer : Timer?
    private var timeLimit: Int = 10
    private var currentTime: Int = 0
    
    private var label : UILabel!
    
    var resetbtn : UIButton!
    var winnerlabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPress)))
        self.initGesture()
        self.startTimer()
        label = UILabel(frame: CGRect(x: 150, y: 100, width: 100, height: 40))
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
//        label.backgroundColor = .cyan
        label.text = "00 : 00"
        label.textAlignment = .center
        view.addSubview(label)
        
        baseView = UIView(frame: CGRect(x: 10, y: 200, width: windowWidth-20, height: windowWidth - 20))
        baseView.backgroundColor = .cyan
        view.addSubview(baseView)
        let space : CGFloat = 10
        let sizebtn :CGFloat = ((baseView.frame.width)-5*space) / 4
        var tagcount = 0
        for i in 1 ... 4{
            for j in 1 ... 4{
                drawbtn(size: CGRect(x: CGFloat(j)*space+CGFloat(j - 1) * sizebtn, y: CGFloat(i)*space+CGFloat(i - 1) * sizebtn, width: sizebtn, height: sizebtn)  , tag: tagcount)
                tagcount += 1
            }
        }
        buttons[15].isHidden = true
        
        winnerlabel = UILabel(frame: CGRect(x: 120, y: baseView.frame.minY + 10, width: 120, height: 50))
        winnerlabel.text = "YOU WIN MAGIC!!!"
        winnerlabel.font = .italicSystemFont(ofSize: 22)
        winnerlabel.textColor = .black
        winnerlabel.isHidden = true
        view.addSubview(winnerlabel)
        
        
        
        let leftimage = UIImage(named: "left")
        lefttbtn = UIButton(frame: CGRect(x: 130, y: baseView.frame.maxY + 70, width: 45, height: 45))
        lefttbtn.setImage(leftimage, for: .normal)
        lefttbtn.layer.cornerRadius = 8
        lefttbtn.tag = 1
        lefttbtn.addTarget(self, action: #selector(showdialog(_ :)), for: .touchUpInside)
        view.addSubview(lefttbtn)
        
        let rightimage = UIImage(named: "right")
        rightbtn = UIButton(frame: CGRect(x: 210, y: baseView.frame.maxY + 70, width: 45, height: 45))
        rightbtn.setImage(rightimage, for: .normal)
        rightbtn.layer.cornerRadius = 8
        rightbtn.tag = 2
        rightbtn.addTarget(self, action: #selector(showdialog(_ :)), for: .touchUpInside)
        view.addSubview(rightbtn)
        
        let topimage = UIImage(named: "top")
        top = UIButton(frame: CGRect(x: 170, y: baseView.frame.maxY + 17, width: 45, height: 45))
        top.setImage(topimage, for: .normal)
        top.layer.cornerRadius = 8
        top.tag = 3
        top.addTarget(self, action: #selector(showdialog(_ :)), for: .touchUpInside)
        view.addSubview(top)
        
        let bottomimage = UIImage(named: "bottom")
        bottom = UIButton(frame: CGRect(x: 170, y: rightbtn.frame.maxY + 7, width: 45, height: 45))
        bottom.setImage(bottomimage, for: .normal)
        bottom.layer.cornerRadius = 8
        bottom.tag = 4
        bottom.addTarget(self, action: #selector(showdialog(_ :)), for: .touchUpInside)
        view.addSubview(bottom)
        
        for i in 0 ... 200 {
            mixing()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @objc func onTimer(){
        print("timer is calling")
        self.currentTime += 1
        if currentTime > timeLimit {
            self.stopTimer()
            currentTime = 0
            timeAlertcheck()
         
        }
        let minut = currentTime / 60
        let second = currentTime % 60
        self.label.text = "0\(minut) : \((second < 10) ? "0\(second)" : "\(second)")"
    }
    private func startTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
        
    // timeinterval -> onTimer metodni har bir sekunda chaqiradi,5 sek bersak har besh sekundda chaqiradi
        
    }
     
    private func stopTimer(){
        self.timer?.invalidate()
        self.timer = nil
    }
//    @objc func onPress(){
//        print("press is active")
//    }
//    @objc func onLongPress(){
//        print("LongPressGesture is active")
//    }
//
  
    
    
    
    
    private func initGesture(){
//        let press = UITapGestureRecognizer(target: self, action: #selector(onPressGesture))
//        self.view.addGestureRecognizer(press)

//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressGesture(_:)))
//        self.view.addGestureRecognizer(longPress)

        let swipUp = UISwipeGestureRecognizer(target: self, action: #selector(onswipeGestue(_:)))
        swipUp.direction = .up
        self.view.addGestureRecognizer(swipUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(onswipeGestue(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(onswipeGestue(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(onswipeGestue(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

    }

    @objc func onPressGesture(_ gesture: UITapGestureRecognizer) {
        print("UITapGestureRecognizer is working")
    }
    
    @objc func onLongPressGesture(_ gesture: UILongPressGestureRecognizer ) {
        print("UILongPressGestureRecognizer is working")
    }
    
    @objc func onswipeGestue(_ gesture: UISwipeGestureRecognizer){
        var a : Int!
        currentTime = 0
        self.label.text = "00 : 00"
        self.stopTimer()
        self.startTimer()
        for i in 0 ... 15 {
            if buttons[i].isHidden{
                a = i
                break
            }
        }
    
        if gesture.direction == .up{
            print("UISwipeUpGestureRecognizer is working")
            if a+4 < buttons.count{
                replacing(a: a, value: a+4)
            }
        }
        if gesture.direction == .down{
            print("UISwipeDownGestureRecognizer is working")
            if a >= 4{
                replacing(a: a, value: a-4)
            }
        }
        if gesture.direction == .left{
            print("UISwipeLeftGestureRecognizer is working")
            if (a+1) % 4 != 0 && a+1 < buttons.count{
                replacing(a: a, value: a+1)
            }
        }
        if gesture.direction == .right{
            print("UISwipeRightGestureRecognizer is working")
            if (a-1) % 4 != 3 && a-1 >= 0{
                replacing(a: a, value: a-1)
            }
        }
       
    }
    
    
    func mixing(){
        var a : Int!
        var liststep  = [Int]()
        
        for i in 0 ... 15 {
            if buttons[i].isHidden{
                a = i
                break
            }
        }
        if a > 0 && a % 4 != 0{
            liststep.append(a-1)
        }
        if a < 15 && a % 4 != 3{
            liststep.append(a+1)
        }
        if a > 3{
            liststep.append(a-4)
        }
        
        if a < 12{
            liststep.append(a+4)
        }
        
        if let value = liststep.randomElement(){
            replacing(a: a,value: value)
        }
        
    }
    
    func replacing(a:Int,value:Int){
        
        let temp = ordered[a]
        ordered[a] = ordered[value]
        ordered[value] = temp
        buttons[a].setTitle("\(ordered[a])", for: .normal)
        buttons[a].isHidden = false
        buttons[value].isHidden = true
        
    }
    
    func replacing2(a:Int,value:Int,tag: Int){
        
        if a+4 < buttons.count && tag == 3{
            let temp = ordered[a]
            ordered[a] = ordered[value]
            ordered[value] = temp
            buttons[a].setTitle("\(ordered[a])", for: .normal)
            buttons[a].isHidden = false
            buttons[value].isHidden = true
        }else if (a+1) % 4 != 0 && a+1 < buttons.count && tag == 1{
            let temp = ordered[a]
            ordered[a] = ordered[value]
            ordered[value] = temp
            buttons[a].setTitle("\(ordered[a])", for: .normal)
            buttons[a].isHidden = false
            buttons[value].isHidden = true
            
        }else if (a-1) % 4 != 3 && a-1 >= 0  && tag == 2{
            let temp = ordered[a]
            ordered[a] = ordered[value]
            ordered[value] = temp
            buttons[a].setTitle("\(ordered[a])", for: .normal)
            buttons[a].isHidden = false
            buttons[value].isHidden = true
            
        }else if a >= 4 && tag == 4{
            let temp = ordered[a]
            ordered[a] = ordered[value]
            ordered[value] = temp
            buttons[a].setTitle("\(ordered[a])", for: .normal)
            buttons[a].isHidden = false
            buttons[value].isHidden = true
        }
        
    }
    
    @objc func pushshed(_ sender: UIButton){
        if sender.tag > 0 && sender.tag % 4 != 0 && buttons[sender.tag-1].isHidden{
            replacing(a: sender.tag - 1, value: sender.tag)
        }else  if sender.tag < 15 && sender.tag % 4 != 3 && buttons[sender.tag+1].isHidden{
            replacing(a: sender.tag + 1, value: sender.tag)
        }else  if sender.tag > 3 && buttons[sender.tag-4].isHidden{
            replacing(a: sender.tag - 4, value: sender.tag)
        }else  if sender.tag < 12 && buttons[sender.tag+4].isHidden{
            replacing(a: sender.tag + 4, value: sender.tag)
        }
        check()
        stopTimer()
        currentTime = 0
        label.text = "00 : 00"
        startTimer()
    }
    
    func drawbtn(size:CGRect,tag:Int){
        let btn = UIButton(frame: size)
        btn.tag = tag
        btn.setTitle(String(tag+1), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(pushshed(_ :)), for: .touchUpInside)
        buttons.append(btn)
        baseView.addSubview(btn)
    }
    
    func check(){
        for i in 0 ... 15{
            if let value = buttons[i].titleLabel?.text{
                if !emptybuttontitle.contains(Int(value) ?? 0){
                    emptybuttontitle.append(Int(value) ?? 0)
                }
            }
        }
        if emptybuttontitle == winList{
            winCheck()
        }
        emptybuttontitle.removeAll()
    }
    
    @objc func showdialog(_ sender: UIButton){
        var a : Int!
        currentTime = 0
        self.label.text = "00 : 00"
        self.stopTimer()
        self.startTimer()
        for i in 0 ... 15 {
            if buttons[i].isHidden{
                a = i
                break
            }
        }
        
        if sender.tag == 1{
            replacing2(a: a, value: a+1,tag: sender.tag)
        }else if sender.tag == 2{
            replacing2(a: a, value: a-1,tag: sender.tag)
        }else if sender.tag == 3{
            replacing2(a: a, value: a+4,tag: sender.tag)
        }else{
            replacing2(a: a, value: a-4,tag: sender.tag)
        }
        
        check()
    }
    
    func winCheck(){
        let alert = UIAlertController(title: "Nima", message: "YOU WIN BRO!", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        let restartAction = UIAlertAction(title: "NewGame", style: .default)
        { action in
            //shu buttonni bosilgandagi blok
            for i in 0 ... 200 {
                self.mixing()
            }
        }
        alert.addAction(restartAction)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    func timeAlertcheck(){
        let alert = UIAlertController(title: "Vaqt", message: "Vaqt chegaraasidan utib ketding brat!", preferredStyle: .alert)
        alert.modalPresentationStyle = .fullScreen
        present(alert, animated: true)
        let okAct = UIAlertAction(title: "OK", style: .default){ [self]action in
            self.mixing()
            startTimer()
        }
        alert.addAction(okAct)
    }
    
    
}
