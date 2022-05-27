//
//  TreeUseCase.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 25/05/2022.
//

import Foundation
import Resolver

protocol TreeUseCaseProtocol {
    func getTreeList(startIndex: Int, withConnexion: Bool) async -> Result<[GeolocatedTree], UseCaseError>
}

fileprivate enum DatabaseMethod {
    case CDMethod, RealmMethod
}

struct TreeUseCase: TreeUseCaseProtocol {
    
    @Injected var treeListRemoteRepository: TreeListRemoteRepository
    @Injected var treeListCDRepository: TreeListCDRepository
    @Injected var treeListRealmRepository: TreeListRealmRepository
    
    private let dataBaseMethod: DatabaseMethod = .RealmMethod
    
    // MARK: - Get Methods
    func getTreeList(startIndex: Int, withConnexion: Bool) async -> Result<[GeolocatedTree], UseCaseError> {
        switch withConnexion {
            
            // Remote Trees
        case true:
            let result = await getRemoteTreeList(startIndex: startIndex)
            switch result {
            case .success(let geolocatedTrees):
                if(startIndex == 0){
                    await updateCDDataBase(geolocatedTrees: geolocatedTrees)
                    await updateRealmDataBase(geolocatedTrees: geolocatedTrees)
                }
                return .success(geolocatedTrees)
            case .failure(let error):
                return .failure(error)
            }
            
            // DataBase Trees
        case false:
            switch dataBaseMethod {
                
                // CD DataBase
            case .CDMethod:
                let result = await getCDLocalTrees()
                switch result {
                case .success(let geolocatedTrees):
                    return .success(geolocatedTrees)
                case .failure(let error):
                    return .failure(error)
                }
                
                // Realm Database
            case .RealmMethod:
                let result = await getRealmLocalTrees()
                switch result {
                case .success(let geolocatedTrees):
                    return .success(geolocatedTrees)
                case .failure(let error):
                    return .failure(error)
                }
            }
        }
    }
    
    // MARK: - Remote Call
    func getRemoteTreeList(startIndex: Int) async -> Result<[GeolocatedTree], UseCaseError> {
        do {
            
            let recordsData = try await treeListRemoteRepository.getTreeList(startIndex: startIndex)
            return .success(
                convertRecordsArrayToGeolocatedTreeArray(recordsData: recordsData)
            )
            
        } catch (let error) {
            
            switch error {
            case APIServiceError.decodingError:
                return .failure(.decodingError)
                
            default:
                return .failure(.networkError)
            }
            
        }
    }
    
    func convertRecordsArrayToGeolocatedTreeArray(recordsData: [RecordData]) -> [GeolocatedTree] {
        return recordsData.map({ item in
            GeolocatedTree(
                tree: item.fields.ToDomain(),
                lng: item.geometry.coordinates[0],
                lat: item.geometry.coordinates[1]
            )
        })
    }
    
    // MARK: - CoreData Call
    func getCDLocalTrees() async -> Result<[GeolocatedTree], UseCaseError> {
        do {
            let cdGeolocatedTrees = try await treeListCDRepository.loadLocalTrees()
            
            return .success(convertCDGeolocatedTreesArrayToGeolocatedTreeArray(cdGeolocatedTrees: cdGeolocatedTrees))
        } catch {
            return .failure(.decodingError)
        }
    }
    
    func convertCDGeolocatedTreesArrayToGeolocatedTreeArray(cdGeolocatedTrees: [CDGeolocatedTree]) -> [GeolocatedTree] {
        let geolocatedTrees: [GeolocatedTree] = cdGeolocatedTrees.map({ item in
            GeolocatedTree(
                tree: item.tree.ToDomain(),
                lng: item.lng,
                lat: item.lat
            )
        })
        
        return geolocatedTrees
    }
    
    // MARK: - Realm Call
    func getRealmLocalTrees() async -> Result<[GeolocatedTree], UseCaseError> {
        do {
            let realmGeolocatedTrees = try await treeListRealmRepository.loadLocalTrees()
            let geolocatedTress: [GeolocatedTree] = realmGeolocatedTrees.map({ item in
                GeolocatedTree(tree: item.tree!.ToDomain(), lng: item.lng, lat: item.lat)
            })
            return .success(geolocatedTress)
        } catch {
            return .failure(.decodingError)
        }
    }
    
    // MARK: - DataBase Register Method
    
    func updateCDDataBase(geolocatedTrees: [GeolocatedTree]) async {
        // Clear Database
        do {
            try await treeListCDRepository.clearDataBase()
            try await treeListCDRepository.saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: geolocatedTrees)
        } catch {
            print("DataBase cannot be Updated")
        }
    }
    
    func updateRealmDataBase(geolocatedTrees: [GeolocatedTree]) async {
        
        // Clear Database
        do {
            try await treeListRealmRepository.clearDataBase()
            try await treeListRealmRepository.saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: geolocatedTrees)
        } catch {
            print("Realm Database cannot be deleted")
        }
    }
}
