//
//  RecordSaleView.swift
//  InventoryTracker
//
//  Created by Olufayo Emmanuel on 02/02/2026.
//

import Foundation
import SwiftUI

struct RecordSaleView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    let product: Product
    @State private var quantitySold = ""

    var body: some View {
        NavigationStack {
            Form {
                Text(product.name ?? "")
                TextField("Quantity sold", text: $quantitySold)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Record Sale")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        recordSale()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func recordSale() {
        let soldQty = Int16(quantitySold) ?? 0

        guard soldQty > 0, soldQty <= product.quantity else {
            return
        }

        let sale = Sale(context: viewContext)
        sale.id = UUID()
        sale.quantity = soldQty
        sale.date = Date()
        sale.product = product

        product.quantity -= soldQty

        try? viewContext.save()
        dismiss()
    }
}
