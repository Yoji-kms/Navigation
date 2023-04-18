//
//  InfoViewModel.swift
//  Navigation
//
//  Created by Yoji on 07.03.2023.
//

import Foundation

final class InfoViewModel: InfoViewModelProtocol {
    var onStateDidChange: ((State) -> Void)?
    weak var coordinator: InfoCoordinator?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    
    enum State {
        case initial
        case loaded(residents: [Resident], planet: Planet?)
    }
    
    enum ViewInput {
        case printMessageBtnDidTap
        case loadData
    }
    
    enum NetworkHandle {
        case getTodoTitle
    }
    
    init() {}
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .printMessageBtnDidTap:
            self.coordinator?.presentAlert()
        case .loadData:
            Task {
                let netPlanet = await NetworkService.request(for: .planetsDataEp1) as? Planet
                
                actor ResidentsActor {
                    var residents: [Resident] = []
                    
                    func appendResident(newResident: Resident) {
                        residents.append(newResident)
                    }
                }
                
                let residentsActor = ResidentsActor()
                await netPlanet?.residents.asyncForEach { residentUrl in
                    guard let resident: Resident = await residentUrl.handleAsDecodable() else {
                        return
                    }
                    await residentsActor.appendResident(newResident: resident)
                }
                let netResidents = await residentsActor.residents
                self.state = .loaded(residents: netResidents, planet: netPlanet)
            }
        }
    }
    
    func updateStateNet(task: NetworkHandle) async -> Any? {
        switch task {
        case .getTodoTitle:
            return await NetworkService.request(for: .todo)
        }
    }
}
