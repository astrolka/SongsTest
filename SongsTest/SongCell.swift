//
//  SongCellCollectionViewCell.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class SongCell: UICollectionViewCell {
    
    private weak var viewModel: SongViewModel?

    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var songNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
    }

    func bindViewModel(_ viewModel: SongViewModel) {
        self.viewModel = viewModel
        authorLabel.text = viewModel.author
        songNameLabel.text = viewModel.songName
    }
    
}
