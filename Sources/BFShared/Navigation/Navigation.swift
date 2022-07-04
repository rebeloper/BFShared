//
//  Navigation.swift
//  
//
//  Created by Alex Nagy on 04.07.2022.
// 

import SwiftUI

public class Navigation: ObservableObject {
    
    // MARK: - Setup
    @Published var paths = [NavigationPath()]
    @Published var index = 0
    
    /// Pushes a new value to the end of this path.
    /// - Parameters:
    ///   - value: The value to push.
    func push<V>(_ value: V, completion: @escaping () -> () = {}) where V : Decodable, V : Encodable, V : Hashable {
        paths[index].push(value, completion: completion)
    }
    
    /// Pops values from the end of this path according to the provided `PopType`
    /// - Parameter type: The pop type
    func pop(_ type: NavigationPath.PopType = .one, completion: @escaping () -> () = {}) {
        paths[index].pop(type, completion: completion)
    }
    
    func onDismiss() {
        paths.removeLast()
        index -= 1
    }
    
    // MARK: - Sheet / FullScreenCover
    @Published var sheet1 = false
    @Published var sheet2 = false
    @Published var sheet3 = false
    @Published var sheet4 = false
    @Published var sheet5 = false
    @Published var sheet6 = false
    @Published var sheet7 = false
    @Published var sheet8 = false
    @Published var sheet9 = false
    @Published var sheet10 = false
    @Published var sheet11 = false
    @Published var sheet12 = false
    @Published var sheet13 = false
    @Published var sheet14 = false
    @Published var sheet15 = false
    @Published var sheet16 = false
    @Published var sheet17 = false
    @Published var sheet18 = false
    @Published var sheet19 = false
    @Published var sheet20 = false
    @Published var sheet21 = false
    @Published var sheet22 = false
    @Published var sheet23 = false
    @Published var sheet24 = false
    @Published var sheet25 = false
    @Published var sheet26 = false
    @Published var sheet27 = false
    @Published var sheet28 = false
    @Published var sheet29 = false
    @Published var sheet30 = false
    @Published var sheet31 = false
    @Published var sheet32 = false
    @Published var sheet33 = false
    @Published var sheet34 = false
    @Published var sheet35 = false
    @Published var sheet36 = false
    @Published var sheet37 = false
    @Published var sheet38 = false
    @Published var sheet39 = false
    @Published var sheet40 = false
    @Published var sheet41 = false
    @Published var sheet42 = false
    @Published var sheet43 = false
    @Published var sheet44 = false
    @Published var sheet45 = false
    @Published var sheet46 = false
    @Published var sheet47 = false
    @Published var sheet48 = false
    @Published var sheet49 = false
    @Published var sheet50 = false
    #if !os(macOS)
    @Published var fullScreenCover1 = false
    @Published var fullScreenCover2 = false
    @Published var fullScreenCover3 = false
    @Published var fullScreenCover4 = false
    @Published var fullScreenCover5 = false
    @Published var fullScreenCover6 = false
    @Published var fullScreenCover7 = false
    @Published var fullScreenCover8 = false
    @Published var fullScreenCover9 = false
    @Published var fullScreenCover10 = false
    @Published var fullScreenCover11 = false
    @Published var fullScreenCover12 = false
    @Published var fullScreenCover13 = false
    @Published var fullScreenCover14 = false
    @Published var fullScreenCover15 = false
    @Published var fullScreenCover16 = false
    @Published var fullScreenCover17 = false
    @Published var fullScreenCover18 = false
    @Published var fullScreenCover19 = false
    @Published var fullScreenCover20 = false
    @Published var fullScreenCover21 = false
    @Published var fullScreenCover22 = false
    @Published var fullScreenCover23 = false
    @Published var fullScreenCover24 = false
    @Published var fullScreenCover25 = false
    @Published var fullScreenCover26 = false
    @Published var fullScreenCover27 = false
    @Published var fullScreenCover28 = false
    @Published var fullScreenCover29 = false
    @Published var fullScreenCover30 = false
    @Published var fullScreenCover31 = false
    @Published var fullScreenCover32 = false
    @Published var fullScreenCover33 = false
    @Published var fullScreenCover34 = false
    @Published var fullScreenCover35 = false
    @Published var fullScreenCover36 = false
    @Published var fullScreenCover37 = false
    @Published var fullScreenCover38 = false
    @Published var fullScreenCover39 = false
    @Published var fullScreenCover40 = false
    @Published var fullScreenCover41 = false
    @Published var fullScreenCover42 = false
    @Published var fullScreenCover43 = false
    @Published var fullScreenCover44 = false
    @Published var fullScreenCover45 = false
    @Published var fullScreenCover46 = false
    @Published var fullScreenCover47 = false
    @Published var fullScreenCover48 = false
    @Published var fullScreenCover49 = false
    @Published var fullScreenCover50 = false
    
    public enum FullScreenCoverPath {
        case fullScreenCover1
        case fullScreenCover2
        case fullScreenCover3
        case fullScreenCover4
        case fullScreenCover5
        case fullScreenCover6
        case fullScreenCover7
        case fullScreenCover8
        case fullScreenCover9
        case fullScreenCover10
        case fullScreenCover11
        case fullScreenCover12
        case fullScreenCover13
        case fullScreenCover14
        case fullScreenCover15
        case fullScreenCover16
        case fullScreenCover17
        case fullScreenCover18
        case fullScreenCover19
        case fullScreenCover20
        case fullScreenCover21
        case fullScreenCover22
        case fullScreenCover23
        case fullScreenCover24
        case fullScreenCover25
        case fullScreenCover26
        case fullScreenCover27
        case fullScreenCover28
        case fullScreenCover29
        case fullScreenCover30
        case fullScreenCover31
        case fullScreenCover32
        case fullScreenCover33
        case fullScreenCover34
        case fullScreenCover35
        case fullScreenCover36
        case fullScreenCover37
        case fullScreenCover38
        case fullScreenCover39
        case fullScreenCover40
        case fullScreenCover41
        case fullScreenCover42
        case fullScreenCover43
        case fullScreenCover44
        case fullScreenCover45
        case fullScreenCover46
        case fullScreenCover47
        case fullScreenCover48
        case fullScreenCover49
        case fullScreenCover50
    }
    
    private func toggleFullScreenCoverPath(_ path: FullScreenCoverPath) {
        switch path {
        case .fullScreenCover1:
            fullScreenCover1.toggle()
        case .fullScreenCover2:
            fullScreenCover2.toggle()
        case .fullScreenCover3:
            fullScreenCover3.toggle()
        case .fullScreenCover4:
            fullScreenCover4.toggle()
        case .fullScreenCover5:
            fullScreenCover5.toggle()
        case .fullScreenCover6:
            fullScreenCover6.toggle()
        case .fullScreenCover7:
            fullScreenCover7.toggle()
        case .fullScreenCover8:
            fullScreenCover8.toggle()
        case .fullScreenCover9:
            fullScreenCover9.toggle()
        case .fullScreenCover10:
            fullScreenCover10.toggle()
        case .fullScreenCover11:
            fullScreenCover11.toggle()
        case .fullScreenCover12:
            fullScreenCover12.toggle()
        case .fullScreenCover13:
            fullScreenCover13.toggle()
        case .fullScreenCover14:
            fullScreenCover14.toggle()
        case .fullScreenCover15:
            fullScreenCover15.toggle()
        case .fullScreenCover16:
            fullScreenCover16.toggle()
        case .fullScreenCover17:
            fullScreenCover17.toggle()
        case .fullScreenCover18:
            fullScreenCover18.toggle()
        case .fullScreenCover19:
            fullScreenCover19.toggle()
        case .fullScreenCover20:
            fullScreenCover20.toggle()
        case .fullScreenCover21:
            fullScreenCover21.toggle()
        case .fullScreenCover22:
            fullScreenCover22.toggle()
        case .fullScreenCover23:
            fullScreenCover23.toggle()
        case .fullScreenCover24:
            fullScreenCover24.toggle()
        case .fullScreenCover25:
            fullScreenCover25.toggle()
        case .fullScreenCover26:
            fullScreenCover26.toggle()
        case .fullScreenCover27:
            fullScreenCover27.toggle()
        case .fullScreenCover28:
            fullScreenCover28.toggle()
        case .fullScreenCover29:
            fullScreenCover29.toggle()
        case .fullScreenCover30:
            fullScreenCover30.toggle()
        case .fullScreenCover31:
            fullScreenCover31.toggle()
        case .fullScreenCover32:
            fullScreenCover32.toggle()
        case .fullScreenCover33:
            fullScreenCover33.toggle()
        case .fullScreenCover34:
            fullScreenCover34.toggle()
        case .fullScreenCover35:
            fullScreenCover35.toggle()
        case .fullScreenCover36:
            fullScreenCover36.toggle()
        case .fullScreenCover37:
            fullScreenCover37.toggle()
        case .fullScreenCover38:
            fullScreenCover38.toggle()
        case .fullScreenCover39:
            fullScreenCover39.toggle()
        case .fullScreenCover40:
            fullScreenCover40.toggle()
        case .fullScreenCover41:
            fullScreenCover41.toggle()
        case .fullScreenCover42:
            fullScreenCover42.toggle()
        case .fullScreenCover43:
            fullScreenCover43.toggle()
        case .fullScreenCover44:
            fullScreenCover44.toggle()
        case .fullScreenCover45:
            fullScreenCover45.toggle()
        case .fullScreenCover46:
            fullScreenCover46.toggle()
        case .fullScreenCover47:
            fullScreenCover47.toggle()
        case .fullScreenCover48:
            fullScreenCover48.toggle()
        case .fullScreenCover49:
            fullScreenCover49.toggle()
        case .fullScreenCover50:
            fullScreenCover50.toggle()
        }
    }
    #endif
    
    public enum SheetPath {
        case sheet1
        case sheet2
        case sheet3
        case sheet4
        case sheet5
        case sheet6
        case sheet7
        case sheet8
        case sheet9
        case sheet10
        case sheet11
        case sheet12
        case sheet13
        case sheet14
        case sheet15
        case sheet16
        case sheet17
        case sheet18
        case sheet19
        case sheet20
        case sheet21
        case sheet22
        case sheet23
        case sheet24
        case sheet25
        case sheet26
        case sheet27
        case sheet28
        case sheet29
        case sheet30
        case sheet31
        case sheet32
        case sheet33
        case sheet34
        case sheet35
        case sheet36
        case sheet37
        case sheet38
        case sheet39
        case sheet40
        case sheet41
        case sheet42
        case sheet43
        case sheet44
        case sheet45
        case sheet46
        case sheet47
        case sheet48
        case sheet49
        case sheet50
    }
    
    private func toggleSheetPath(_ path: SheetPath) {
        switch path {
        case .sheet1:
            sheet1.toggle()
        case .sheet2:
            sheet2.toggle()
        case .sheet3:
            sheet3.toggle()
        case .sheet4:
            sheet4.toggle()
        case .sheet5:
            sheet5.toggle()
        case .sheet6:
            sheet6.toggle()
        case .sheet7:
            sheet7.toggle()
        case .sheet8:
            sheet8.toggle()
        case .sheet9:
            sheet9.toggle()
        case .sheet10:
            sheet10.toggle()
        case .sheet11:
            sheet11.toggle()
        case .sheet12:
            sheet12.toggle()
        case .sheet13:
            sheet13.toggle()
        case .sheet14:
            sheet14.toggle()
        case .sheet15:
            sheet15.toggle()
        case .sheet16:
            sheet16.toggle()
        case .sheet17:
            sheet17.toggle()
        case .sheet18:
            sheet18.toggle()
        case .sheet19:
            sheet19.toggle()
        case .sheet20:
            sheet20.toggle()
        case .sheet21:
            sheet21.toggle()
        case .sheet22:
            sheet22.toggle()
        case .sheet23:
            sheet23.toggle()
        case .sheet24:
            sheet24.toggle()
        case .sheet25:
            sheet25.toggle()
        case .sheet26:
            sheet26.toggle()
        case .sheet27:
            sheet27.toggle()
        case .sheet28:
            sheet28.toggle()
        case .sheet29:
            sheet29.toggle()
        case .sheet30:
            sheet30.toggle()
        case .sheet31:
            sheet31.toggle()
        case .sheet32:
            sheet32.toggle()
        case .sheet33:
            sheet33.toggle()
        case .sheet34:
            sheet34.toggle()
        case .sheet35:
            sheet35.toggle()
        case .sheet36:
            sheet36.toggle()
        case .sheet37:
            sheet37.toggle()
        case .sheet38:
            sheet38.toggle()
        case .sheet39:
            sheet39.toggle()
        case .sheet40:
            sheet40.toggle()
        case .sheet41:
            sheet41.toggle()
        case .sheet42:
            sheet42.toggle()
        case .sheet43:
            sheet43.toggle()
        case .sheet44:
            sheet44.toggle()
        case .sheet45:
            sheet45.toggle()
        case .sheet46:
            sheet46.toggle()
        case .sheet47:
            sheet47.toggle()
        case .sheet48:
            sheet48.toggle()
        case .sheet49:
            sheet49.toggle()
        case .sheet50:
            sheet50.toggle()
        }
    }
    
    private enum Path {
        case sheet(_ path: SheetPath)
        #if !os(macOS)
        case fullScreenCover(_ path: FullScreenCoverPath)
        #endif
    }
    
    private func present(_ path: Path, completion: @escaping () -> () = {}) {
        paths.append(NavigationPath())
        index += 1
        switch path {
        case .sheet(path: let path):
            toggleSheetPath(path)
        #if !os(macOS)
        case .fullScreenCover(path: let path):
            toggleFullScreenCoverPath(path)
        #endif
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            completion()
        })
    }
    
    private func dismiss(_ path: Path, completion: @escaping () -> () = {}) {
        switch path {
        case .sheet(path: let path):
            toggleSheetPath(path)
        #if !os(macOS)
        case .fullScreenCover(path: let path):
            toggleFullScreenCoverPath(path)
        #endif
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            completion()
        })
    }
    
    /// Presents a sheet for the specified `SheetPath`
    /// - Parameter path: the sheet path
    public func presentSheet(_ path: SheetPath, completion: @escaping () -> () = {}) {
        present(.sheet(path), completion: completion)
    }
    
    #if !os(macOS)
    /// Presents a full screen cover for the specified `FullScreenCoverPath`
    /// - Parameter path: the full screen cover path
    public func presentFullScreenCover(_ path: FullScreenCoverPath, completion: @escaping () -> () = {}) {
        present(.fullScreenCover(path), completion: completion)
    }
    #endif
    
    /// Dismisses a sheet for the specified `SheetPath`
    /// - Parameter path: the sheet path
    public func dismissSheet(_ path: SheetPath, completion: @escaping () -> () = {}) {
        dismiss(.sheet(path), completion: completion)
    }
    
    #if !os(macOS)
    /// Dismisses a full screen cover for the specified `FullScreenCoverPath`
    /// - Parameter path: the full screen cover path
    public func dismissFullScreenCover(_ path: FullScreenCoverPath, completion: @escaping () -> () = {}) {
        dismiss(.fullScreenCover(path), completion: completion)
    }
    #endif
    
}

