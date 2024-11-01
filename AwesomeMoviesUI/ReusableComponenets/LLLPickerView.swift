import SwiftUI

public protocol Defaultable: RawRepresentable, Hashable where RawValue == String {
    static var `default`: Self { get }
}

public struct LLLPickerView<T: Defaultable & CaseIterable>: View {
    @Binding var selectedItem: T
    var items: [T]

    public init(
        selectedItem: Binding<T>,
        items: [T] = Array(T.allCases)
    ) {
        _selectedItem = selectedItem
        self.items = items
    }

    public var body: some View {
        Picker("", selection: $selectedItem) {
            if selectedItem != T.default {
                Text(T.default.rawValue).tag(T.default)
            }

            ForEach(items.filter { $0 != T.default }, id: \.self) { item in
                Text(item.rawValue).tag(item)
            }
        }
        .pickerStyle(.segmented)
        .animation(.interactiveSpring, value: selectedItem)
    }
}
