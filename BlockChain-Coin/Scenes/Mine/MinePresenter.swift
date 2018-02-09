//
//  MinePresenter.swift
//  BlockChain-Coin
//
//  Created by Maxime Bornemann on 08/02/2018.
//  Copyright © 2018 BlockChain-Coin.net. All rights reserved.
//

import UIKit

protocol MinePresentationLogic {
    func handlePoolConnecting(address: String)
    func handlePoolConnected(address: String)
    func handlePoolConnectionError(address: String?, error: PoolStoreError)
    func handlePoolDisconnected()
    func handlePoolStats(stats: StatsModel)
}

class MinePresenter: MinePresentationLogic {
    weak var viewController: MineDisplayLogic?
    
    func handlePoolConnecting(address: String) {
        let viewModel = PoolStatusViewModel(state: .connecting, address: address)
        
        viewController?.handlePoolStatus(viewModel: viewModel)
    }
    
    func handlePoolConnected(address: String) {
        let viewModel = PoolStatusViewModel(state: .connected, address: address)
        
        viewController?.handlePoolStatus(viewModel: viewModel)
    }
    
    func handlePoolConnectionError(address: String?, error: PoolStoreError) {
        let viewModel = PoolStatusViewModel(state: .error(error.localizedDescription), address: address)
        
        viewController?.handlePoolStatus(viewModel: viewModel)
    }
    
    func handlePoolDisconnected() {
        let viewModel = PoolStatusViewModel(state: .disconnected, address: nil)
        
        viewController?.handlePoolStatus(viewModel: viewModel)
    }
    
    func handlePoolStats(stats: StatsModel) {
        let viewModel = MinerStatsViewModel(hashRate: stats.hashRate, totalHashes: stats.allTimeHashes, sharesFound: stats.submittedHashes)
        
        viewController?.handleMinerStats(viewModel: viewModel)
    }
}
