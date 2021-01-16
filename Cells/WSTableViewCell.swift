//
//  TableViewCell.swift
//  Word Scramble
//
//  Created by Vu Kim Duy on 16/1/21.
//

import UIKit

class WSTableViewCell : UITableViewCell
{
    static var reusableID : String { get { String(describing: self) } }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(text: String){
        self.textLabel?.text = text
    }
    
}
