//
//  SearchListTVC.swift
//  Weather
//
//  Created by akashlal on 13/03/22.
//

import UIKit

class SearchListTVC: UITableViewCell {

    @IBOutlet weak var cityTitle: UILabel!
    @IBOutlet weak var citySubtitle: UILabel!
    
    var location: SearchResultModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDesign()
    }

    private func setupDesign() {
        cityTitle.textColor = Color.darkestText
        citySubtitle.textColor = Color.darkerText
    }
    
    func configure(for location: SearchResultModel) {
        self.location = location
        setupLabels()
    }
    
    private func setupLabels() {
        cityTitle.text = location?.name
        let state = location?.state ?? ""
        let country = location?.country ?? ""
        citySubtitle.text = state
        if state.isEmpty {
            citySubtitle.text = country
        } else {
            citySubtitle.text = state + ", " + country
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cityTitle.text = nil
        self.citySubtitle.text = nil
        self.location = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
