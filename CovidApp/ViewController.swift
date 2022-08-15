//
//  ViewController.swift
//  CovidApp
//
//  Created by 山崎颯汰 on 2022/08/14.
//

import UIKit

class ViewController: UIViewController {
    
    let colors = Colors()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpGradation()
        setUpContent()
        
        
    }

    func setUpGradation(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/2)
        gradientLayer.colors = [colors.bluePurple.cgColor, colors.blue.cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setUpContent(){
        let contentView = UIView()
        contentView.frame.size = CGSize(width: view.frame.size.width, height: 340)
        contentView.center = CGPoint(x: view.center.x, y: view.center.y)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 30
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.5
        view.addSubview(contentView)
        
        view.backgroundColor = .systemGray6
        
        let labelFont = UIFont.systemFont(ofSize: 15, weight: .heavy)
        let size = CGSize(width: 150, height: 50)
        let color = colors.bluePurple
        let leftX = view.frame.size.width * 0.33
        let rightX = view.frame.size.width * 0.80
        setUpLabel("Covid in Japan", size: CGSize(width: 180, height: 35), centerX: view.center.x, y: -60, font: .systemFont(ofSize: 25, weight: .heavy), color: .white, contentView)
        setUpLabel("PCR数", size: size, centerX: leftX, y: 20, font:labelFont, color: color, contentView)
        setUpLabel("感染者数", size: size, centerX: rightX, y: 20, font:labelFont, color: color, contentView)
        setUpLabel("入院者数", size: size, centerX: leftX, y: 120, font:labelFont, color: color, contentView)
        setUpLabel("重傷者数", size: size, centerX: rightX, y: 120, font:labelFont, color: color, contentView)
        setUpLabel("死者数", size: size, centerX: leftX, y: 220, font:labelFont, color: color, contentView)
        setUpLabel("退院者数", size: size, centerX: rightX, y: 220, font:labelFont, color: color, contentView)
        
        let height = view.frame.size.height / 2
        setUpButton("健康管理", size: size, y: height + 190, color: colors.blue, parentView: view)
        setUpButton("県別状況", size: size, y: height + 240, color: colors.blue, parentView: view)
        
        setUpImageButton("bubble.left", x: view.frame.size.width - 60).addTarget(self, action: #selector(chatAction), for: .touchDown)
        setUpImageButton("goforward", x: 20).addTarget(self, action: #selector(reloadAction), for: .touchDown)
        
        let imageView = UIImageView()
        let image = UIImage(named: "virus")
        imageView.image = image
        imageView.frame = CGRect(x: view.frame.size.width, y: -65, width: 50, height: 50)
        contentView.addSubview(imageView)
        
        UIView.animate(withDuration: 1.5, delay: 0.5, options: [.curveEaseIn], animations: {imageView.frame = CGRect(x: self.view.frame.size.width - 100, y: -65, width: 50, height: 50)
            imageView.transform = CGAffineTransform(rotationAngle: -90)
        }, completion: nil)
        
        setUpAPI(parentView: contentView)
    }
    
    func setUpAPI(parentView: UIView){
        let pcr = UILabel()
        let positive = UILabel()
        let hospitalize = UILabel()
        let severe = UILabel()
        let death = UILabel()
        let discharge = UILabel()
        
        let size = CGSize(width: 200, height: 40)
        let leftX = view.frame.size.width * 0.38
        let rightX = view.frame.size.width * 0.85
        let font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        let color = colors.blue
        
        setUpAPILabel(pcr, size: size, centerX: leftX, y: 60, font: font, color: color, parentView)
        setUpAPILabel(positive, size: size, centerX: rightX, y: 60, font: font, color: color, parentView)
        setUpAPILabel(hospitalize, size: size, centerX: leftX, y: 160, font: font, color: color, parentView)
        setUpAPILabel(severe, size: size, centerX: rightX, y: 160, font: font, color: color, parentView)
        setUpAPILabel(death, size: size, centerX: leftX, y: 260, font: font, color: color, parentView)
        setUpAPILabel(discharge, size: size, centerX: rightX, y: 260, font: font, color: color, parentView)
        
        CovidAPI.getTotal(completion: {(result: CovidInfo.Total) -> Void in
            DispatchQueue.main.async {
                pcr.text = "\(result.pcr)"
                positive.text = "\(result.positive)"
                hospitalize.text = "\(result.hospitalize)"
                severe.text = "\(result.severe)"
                death.text = "\(result.death)"
                discharge.text = "\(result.discharge)"
            }
        })
    }
    
    func setUpAPILabel(_ label: UILabel, size: CGSize, centerX: CGFloat, y: CGFloat, font: UIFont, color: UIColor, _ parentView: UIView){
        label.frame.size = size
        label.center.x = centerX
        label.frame.origin.y = y
        label.font = font
        label.textColor = color
        parentView.addSubview(label)
        
    }
    
    func setUpImageButton(_ name: String, x: CGFloat) -> UIButton{
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: name), for: .normal)
        button.frame.size = CGSize(width: 40, height: 40)
        button.tintColor = .white
        button.frame.origin = CGPoint(x: x, y: 50)
        view.addSubview(button)
        return button
    }
    
    @objc func chatAction(){
        print("タップchat")
        
    }
    
    @objc func reloadAction(){
        loadView()
        viewDidLoad()
        print("タップreload")
    }

    func setUpButton(_ title: String, size: CGSize, y: CGFloat, color: UIColor, parentView: UIView){
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.frame.size = size
        button.center.x = view.center.x
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.kern: 8.0])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.frame.origin.y = y
        button.setTitleColor(color, for: .normal)
        parentView.addSubview(button)
    }
    
    func setUpLabel(_ text: String, size: CGSize, centerX: CGFloat, y: CGFloat, font: UIFont, color: UIColor, _ parentView: UIView){
        let label = UILabel()
        label.text = text
        label.frame.size = size
        label.center.x = centerX
        label.frame.origin.y = y
        label.font = font
        label.textColor = color
        parentView.addSubview(label)
    }
}

