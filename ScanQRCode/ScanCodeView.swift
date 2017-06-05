//
//  ScanCodeView.swift
//  ScanQRCode
//
//  Created by 杨卢青 on 2017/6/5.
//  Copyright © 2017年 杨卢青. All rights reserved.
//

import UIKit
import AVFoundation

class ScanCodeView: UIView {

  public let tempLayer = CALayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	/// 初始化视图
	private func setupViews() {
		
		let screen = UIScreen.main.bounds
		
		let contentX = screen.width * 0.15
		let contentY = screen.height * 0.24
		
		let contentW = screen.width * 0.7
		let contentH = contentW
		
		
		
		let edgeBackgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
		
		// 中间扫描内容
		let scanContentLayer = CALayer()
		
		scanContentLayer.frame = CGRect(x: contentX, y: contentY, width: contentW, height: contentH)
		
		scanContentLayer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
		scanContentLayer.borderWidth = 0.7
		scanContentLayer.backgroundColor = UIColor.clear.cgColor
		layer.addSublayer(scanContentLayer)
		
		// 顶部 Layer
		let topLayer = CALayer()
		
		topLayer.frame = CGRect(x: 0, y: 0, width: screen.width, height: contentY)
		topLayer.backgroundColor = edgeBackgroundColor
		layer.addSublayer(topLayer)
		
		// 左边
		let leftLayer = CALayer()
		
		leftLayer.frame = CGRect(x: 0, y: contentY, width: contentX, height: contentH)
		leftLayer.backgroundColor = edgeBackgroundColor
		layer.addSublayer(leftLayer)
		
		// 右边
		let rightLayer = CALayer()
		
		rightLayer.frame = CGRect(x: contentX+contentW, y: contentY, width: contentX, height: contentH)
		rightLayer.backgroundColor = edgeBackgroundColor
		layer.addSublayer(rightLayer)
		
		// 底部
		let bottomLayer = CALayer()
		
		bottomLayer.frame = CGRect(x: 0, y: contentY+contentH, width: screen.width, height: screen.height-(contentY+contentH))
		
	}
	
	
	/// 照明灯开关点击事件, 切换照明灯状态
	///
	/// - Parameter button: 照明灯开关
	public func lightButtonAction(button: UIButton) {
		if button.isSelected {
			setLightState(isOn: false)
			button.isSelected = false
		} else {
			setLightState(isOn: true)
			button.isSelected = true
		}
	}
	
	
	/// 设置照明灯状态
	///
	/// - Parameter isOn: 是否打开
	private func setLightState(isOn: Bool) {
		guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else {
			return
		}
		if device.hasTorch {
			try? device.lockForConfiguration()
			
			if isOn {
				device.torchMode = .on
			} else {
				device.torchMode = .off
			}
			device.unlockForConfiguration()
		}
	}
}
