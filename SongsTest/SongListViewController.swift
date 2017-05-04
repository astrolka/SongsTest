//
//  SongListViewController.swift
//  SongsTest
//
//  Created by Александр Смоленский on 30.04.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit
import JSQDataSourcesKit

class SongListViewController: UIViewController {
    
    private let viewModel = SongListViewModel()
    fileprivate let interitemSpaceing: CGFloat = 5
    
    typealias CellFactory = ViewFactory<SongDataBaseModel, SongCell>
    typealias CollectionViewDataSource = DataSourceProvider<FetchedResultsController<SongDataBaseModel>, CellFactory, CellFactory>
    private var dataSourceProvider: CollectionViewDataSource!
    private var delegateProvider: FetchedResultsDelegateProvider<CellFactory>!
    private var frc: FetchedResultsController<SongDataBaseModel>!

    @IBOutlet private weak var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureCollectionViewDataSourceAndDelegate()
        bindViewModel()
        
    }
    
    private func configureCollectionView() {
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    private func configureCollectionViewDataSourceAndDelegate() {
        let cellFactory = CellFactory(reuseIdentifier: CellId) { (cell, model: SongDataBaseModel?, type, collectionView, indexPath) -> SongCell in
            let cellVM = SongViewModel(model: model)
            cell.bindViewModel(cellVM)
            return cell
        }
        
        frc = viewModel.fetchedResultsController()
        delegateProvider = FetchedResultsDelegateProvider(cellFactory: cellFactory, collectionView: collectionView!)
        frc.delegate = delegateProvider.collectionDelegate
        dataSourceProvider = CollectionViewDataSource(dataSource: frc, cellFactory: cellFactory, supplementaryFactory: cellFactory)
        collectionView.dataSource = dataSourceProvider?.collectionViewDataSource
    }
    
    private func bindViewModel() {
        title = viewModel.title
        viewModel.isLoading.bindAndFire { [weak self] (isActivityIndicatorVisible) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = isActivityIndicatorVisible
            if !isActivityIndicatorVisible {
                self?.refreshControl.endRefreshing()
            }
        }
        viewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func fetchData() {
        do {
            try frc.performFetch()
        } catch {
            print("Fetch error = \(error)")
        }
    }
    
    //MARK: - Actions
    
    func refreshAction(_ sender: UIRefreshControl) {
        viewModel.loadData()
    }
    
}

extension SongListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellSize = (width - interitemSpaceing) / 2
        return CGSize(width: cellSize, height: cellSize)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interitemSpaceing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interitemSpaceing
    }
}
