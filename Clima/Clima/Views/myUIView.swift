//
//  myUIView.swift
//  Clima
//
//  Created by 황원상 on 2022/07/04.
//

import UIKit

class myUIView: UIView {
    
    let tf:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Type the city for the weather"
        tf.returnKeyType = .search
        tf.becomeFirstResponder()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let image:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "flag")
        image.tintColor = UIColor(named: "MainColor")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var cityLable:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "city"
        label.textColor = UIColor(named: "MainColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tempLable:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "temp"
        label.textColor = UIColor(named: "MainColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let finderButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "flag"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let locationButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "flag"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stack1:UIStackView = {
        let st = UIStackView(arrangedSubviews: [locationButton, tf, finderButton])
        st.spacing = 5
        st.axis = .horizontal
        st.distribution = .fillEqually
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stack1)
        self.addSubview(image)
        self.addSubview(cityLable)
        self.addSubview(tempLable)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        //MARK: - 스택뷰
        NSLayoutConstraint.activate([
            stack1.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stack1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stack1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            stack1.heightAnchor.constraint(equalToConstant: 20),
            
            //MARK: - 이미지뷰
            image.topAnchor.constraint(equalTo: stack1.bottomAnchor, constant: 20),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 50),
            
            //MARK: - 시티레이블
            cityLable.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            cityLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            cityLable.heightAnchor.constraint(equalToConstant: 30),
            
            //MARK: - 온도레이블
            tempLable.topAnchor.constraint(equalTo: self.cityLable.bottomAnchor, constant: 10),
            tempLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            tempLable.heightAnchor.constraint(equalToConstant: 30)
        ])
        super.updateConstraints()
    }
}
