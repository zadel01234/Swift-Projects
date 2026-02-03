//
//  AddProductView.swift
//  InventoryTracker
//
//  Created by Olufayo Emmanuel on 02/02/2026.
//

import Foundation
import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var costPrice = ""
    @State private var sellPrice = ""
    @State private var quantity = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Product name", text: $name)

                TextField("Cost price", text: $costPrice)
                    .keyboardType(.decimalPad)

                TextField("Selling price", text: $sellPrice)
                    .keyboardType(.decimalPad)

                TextField("Quantity", text: $quantity)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add Product")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveProduct()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveProduct() {
        let product = Product(context: viewContext)
        product.id = UUID()
        product.name = name
        product.costPrice = Double(costPrice) ?? 0
        product.sellPrice = Double(sellPrice) ?? 0
        product.quantity = Int16(quantity) ?? 0
        product.createdAt = Date()

        try? viewContext.save()
        dismiss()
    }
}
