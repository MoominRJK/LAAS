//
//  ARView.swift
//  LAAS
//
//  Created by Sophie Lin on 11/2/22.
//

import UIKit
import ARKit

class ARView: UIView {
    lazy var ARView: ARSCNView = {
        let view = ARSCNView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.yellow
        setupViews()
    }
    
    private func setupViews() {
        setupARView()
    }

    private func setupARView() {
        self.addSubview(ARView)
        ARView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(self).multipliedBy(1)
        }
    }
}


