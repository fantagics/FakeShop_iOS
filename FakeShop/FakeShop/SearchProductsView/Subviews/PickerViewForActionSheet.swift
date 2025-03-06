//
//  PickerViewForActionSheet.swift
//  FakeShop
//
//  Created by 이태형 on 3/5/25.
//

import UIKit

//Piker for ActionSheet
extension SearchProductsVC: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPicker{
            return Common.shared.categories.count
        } else if pickerView == sortTypePicker{
            return SortType.allCases.count
        } else{return 0}
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPicker{
            return Translation.language.ko[Common.shared.categories[row]]
        } else if pickerView == sortTypePicker{
            return Translation.language.ko[SortType(rawValue: row)?.str ?? "error"]
        } else {return nil}
    }
}
