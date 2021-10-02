//
//  picker.swift
//  text_to_speech
//
//  Created by Кирилл on 25.09.2021.
//

import Foundation
import SwiftUI

struct CustomPicker : UIViewRepresentable{
    @ObservedObject var userSettings = UserSettings()
    func makeCoordinator() -> CustomPicker.Coordinator {
        return CustomPicker.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<CustomPicker>) -> UIPickerView {
        
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(item: picker, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 80)
        picker.addConstraint(heightConstraint)
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIView(_ uiView: UIPickerView, context: UIViewRepresentableContext<CustomPicker>) {
    }
    class Coordinator : NSObject, UIPickerViewDelegate, UIPickerViewDataSource{
        var parent: CustomPicker
        @ObservedObject var userSettings = UserSettings()
        init(parent1 : CustomPicker)
        {
            parent = parent1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return data.count
        }
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth - 100 , height: 60))
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
            switch data[row]
            {
                case 0:
                    label.text = "white"
                case 1:
                    label.text = "blue"
                case 2:
                    label.text = "red"
                case 3:
                    label.text = "yellow"
                case 4:
                    label.text = "orange"
                case 5:
                    label.text = "pink"
                case 6:
                    label.text = "purple"
                default:
                    label.text = "white"
            }
            label.textColor = .white
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 23, weight: .bold)
            view.addSubview(label)
            return view
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            UserDefaults.standard.set(data[row], forKey: "Color")
        }
    }
}

var data: [Int] = [0, 1, 2, 3, 4, 5, 6]
