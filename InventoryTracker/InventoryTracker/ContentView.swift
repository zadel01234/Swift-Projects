//
//  ContentView.swift
//  InventoryTracker
//
//  Created by Olufayo Emmanuel on 02/02/2026.
//


import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.createdAt, ascending: false)],
        animation: .default
    )
    private var products: FetchedResults<Product>

    @State private var showAddProduct = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(products) { product in
                    NavigationLink {
                        ProductDetailView(product: product)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(product.name ?? "Unnamed")
                                .font(.headline)

                            Text("Stock: \(product.quantity)")
                                .foregroundColor(.gray)

                            Text("₦\(product.sellPrice, specifier: "%.2f")")
                                .bold()
                        }
                    }
                }
                .onDelete(perform: deleteProduct)
            }
            .navigationTitle("Inventory")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddProduct = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddProduct) {
                AddProductView()
            }
        }
    }

    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}
