//
//  NavigationRootSheet.swift
//  
//
//  Created by Alex Nagy on 04.07.2022.
//

import SwiftUI

public struct NavigationRootSheet<Root>: View where Root: View {
    
    @EnvironmentObject private var navigation: Navigation
    
    var path: Navigation.SheetPath
    var detents: Set<PresentationDetent> = []
    var dragIndicator: Visibility = .hidden
    var root: () -> Root
    var onDismiss: (() -> Void)?
    
    public init(path: Navigation.SheetPath,
                detents: Set<PresentationDetent> = [],
                dragIndicator: Visibility = .hidden,
                _ root: @escaping () -> Root,
                onDismiss: (() -> Void)? = nil) {
        self.path = path
        self.detents = detents
        self.dragIndicator = dragIndicator
        self.root = root
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        EmptyView()
            .sheet(isPresented: isPresented(), onDismiss: {
                navigation.onDismiss()
                onDismiss?()
            }, content: {
                NavigationStack(path: $navigation.paths[navigation.index]) {
                    root()
                }
                .presentationDetents(detents)
                .presentationDragIndicator(dragIndicator)
            })
    }
    
    func isPresented() -> Binding<Bool> {
        switch path {
        case .sheet1:
            return $navigation.sheet1
        case .sheet2:
            return $navigation.sheet2
        case .sheet3:
            return $navigation.sheet3
        case .sheet4:
            return $navigation.sheet4
        case .sheet5:
            return $navigation.sheet5
        case .sheet6:
            return $navigation.sheet6
        case .sheet7:
            return $navigation.sheet7
        case .sheet8:
            return $navigation.sheet8
        case .sheet9:
            return $navigation.sheet9
        case .sheet10:
            return $navigation.sheet10
        case .sheet11:
            return $navigation.sheet11
        case .sheet12:
            return $navigation.sheet12
        case .sheet13:
            return $navigation.sheet13
        case .sheet14:
            return $navigation.sheet14
        case .sheet15:
            return $navigation.sheet15
        case .sheet16:
            return $navigation.sheet16
        case .sheet17:
            return $navigation.sheet17
        case .sheet18:
            return $navigation.sheet18
        case .sheet19:
            return $navigation.sheet19
        case .sheet20:
            return $navigation.sheet20
        case .sheet21:
            return $navigation.sheet21
        case .sheet22:
            return $navigation.sheet22
        case .sheet23:
            return $navigation.sheet23
        case .sheet24:
            return $navigation.sheet24
        case .sheet25:
            return $navigation.sheet25
        case .sheet26:
            return $navigation.sheet26
        case .sheet27:
            return $navigation.sheet27
        case .sheet28:
            return $navigation.sheet28
        case .sheet29:
            return $navigation.sheet29
        case .sheet30:
            return $navigation.sheet30
        case .sheet31:
            return $navigation.sheet31
        case .sheet32:
            return $navigation.sheet32
        case .sheet33:
            return $navigation.sheet33
        case .sheet34:
            return $navigation.sheet34
        case .sheet35:
            return $navigation.sheet35
        case .sheet36:
            return $navigation.sheet36
        case .sheet37:
            return $navigation.sheet37
        case .sheet38:
            return $navigation.sheet38
        case .sheet39:
            return $navigation.sheet39
        case .sheet40:
            return $navigation.sheet40
        case .sheet41:
            return $navigation.sheet41
        case .sheet42:
            return $navigation.sheet42
        case .sheet43:
            return $navigation.sheet43
        case .sheet44:
            return $navigation.sheet44
        case .sheet45:
            return $navigation.sheet45
        case .sheet46:
            return $navigation.sheet46
        case .sheet47:
            return $navigation.sheet47
        case .sheet48:
            return $navigation.sheet48
        case .sheet49:
            return $navigation.sheet49
        case .sheet50:
            return $navigation.sheet50
        }
    }
}

public extension View {
    func sheet<Root: View>(_ path: Navigation.SheetPath,
                           detents: Set<PresentationDetent> = [],
                           dragIndicator: Visibility = .hidden,
                           _ root: @escaping () -> Root,
                           onDismiss: (() -> Void)? = nil) -> some View {
        modifier(NavigationRootSheetModifier(path: path, detents: detents, dragIndicator: dragIndicator, root, onDismiss: onDismiss))
    }
}

public struct NavigationRootSheetModifier<Root: View>: ViewModifier {
    
    var path: Navigation.SheetPath
    var detents: Set<PresentationDetent> = []
    var dragIndicator: Visibility = .hidden
    var root: () -> Root
    var onDismiss: (() -> Void)?
    
    public init(path: Navigation.SheetPath,
                detents: Set<PresentationDetent> = [],
                dragIndicator: Visibility = .hidden,
                _ root: @escaping () -> Root,
                onDismiss: (() -> Void)? = nil) {
        self.path = path
        self.detents = detents
        self.dragIndicator = dragIndicator
        self.root = root
        self.onDismiss = onDismiss
    }
    
    public func body(content: Content) -> some View {
        content
            .background(
                NavigationRootSheet(path: path, detents: detents, dragIndicator: dragIndicator, root, onDismiss: onDismiss)
            )
    }
}


