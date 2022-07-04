//
//  NavigationRoot.swift
//  
//
//  Created by Alex Nagy on 04.07.2022.
//

import SwiftUI

public struct NavigationRoot<Root: View>: View {
    
    @EnvironmentObject private var navigation: Navigation
    
    let index: Int = 0
    let root: () -> Root
    
    public init(_ root: @escaping () -> Root) {
        self.root = root
    }
    
    public var body: some View {
        NavigationStack(path: $navigation.paths[index]) {
            root()
        }
        .onAppear {
            navigation.index = index
        }
    }
}

