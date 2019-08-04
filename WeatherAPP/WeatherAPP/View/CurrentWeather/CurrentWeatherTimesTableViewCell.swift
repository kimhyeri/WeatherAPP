//
//  CurrentWeatherTimesTableViewCell.swift
//  WeatherAPP
//
//  Created by hyeri kim on 04/08/2019.
//  Copyright © 2019 hyeri kim. All rights reserved.
//

import UIKit

class CurrentWeatherTimesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
        registerNib()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerNib() {
        let timesNib = UINib(nibName: TimesCollectionViewCell.nibName, 
                             bundle: nil
        )
        collectionView.register(timesNib, 
                                forCellWithReuseIdentifier: TimesCollectionViewCell.reuseIdentifier
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CurrentWeatherTimesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimesCollectionViewCell.reuseIdentifier, for: indexPath) as? TimesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

extension CurrentWeatherTimesTableViewCell: CellReusable {}
extension CurrentWeatherTimesTableViewCell: NibLoadable {}