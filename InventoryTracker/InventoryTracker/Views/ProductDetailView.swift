//
//  ProductDetailView.swift
//  InventoryTracker
//
//  Created by Olufayo Emmanuel on 02/02/2026.
//

import Foundation
//import SwiftUI
//
//struct ProductDetailView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    let product: Product
//
//    @State private var showRecordSale = false
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text(product.name ?? "")
//                .font(.largeTitle)
//                .bold()
//
//            Text("Stock: \(product.quantity)")
//                .font(.title2)
//
//            Text("Selling Price: ₦\(product.sellPrice, specifier: "%.2f")")
//                .font(.title3)
//
//            Button {
//                showRecordSale = true
//            } label: {
//                Text("Record Sale")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("Product")
//        .sheet(isPresented: $showRecordSale) {
//            RecordSaleView(product: product)
//        }
//    }
//}


import SwiftUI
import CoreData

struct ProductDetailView: View {
    private var totalUnitsSold: Int {
        sales.reduce(0) { $0 + Int($1.quantity) }
    }
    
    private var totalRevenue: Double {
        Double(totalUnitsSold) * product.sellPrice
    }

    private var totalCost: Double {
        Double(totalUnitsSold) * product.costPrice
    }

    private var profit: Double {
        totalRevenue - totalCost
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    let product: Product

    @State private var showRecordSale = false

    @FetchRequest var sales: FetchedResults<Sale>

    init(product: Product) {
        self.product = product

        _sales = FetchRequest<Sale>(
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Sale.date, ascending: false)
            ],
            predicate: NSPredicate(format: "product == %@", product)
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(product.name ?? "")
                    .font(.largeTitle)
                    .bold()

                Text("Stock: \(product.quantity)")
                    .font(.title2)

                Text("Selling Price: ₦\(product.sellPrice, specifier: "%.2f")")
                    .font(.title3)

                Button {
                    showRecordSale = true
                } label: {
                    Text("Record Sale")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Profit Summary")
                        .font(.headline)

                    HStack {
                        Text("Units sold")
                        Spacer()
                        Text("\(totalUnitsSold)")
                    }

                    HStack {
                        Text("Revenue")
                        Spacer()
                        Text("₦\(totalRevenue, specifier: "%.2f")")
                    }

                    HStack {
                        Text("Cost")
                        Spacer()
                        Text("₦\(totalCost, specifier: "%.2f")")
                    }

                    HStack {
                        Text("Profit")
                        Spacer()
                        Text("₦\(profit, specifier: "%.2f")")
                            .foregroundColor(profit >= 0 ? .green : .red)
                            .bold()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)


                Divider()

                // 📊 SALES HISTORY
                VStack(alignment: .leading, spacing: 10) {
                    Text("Sales History")
                        .font(.headline)

                    if sales.isEmpty {
                        Text("No sales yet")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(sales) { sale in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Quantity sold: \(sale.quantity)")
                                        .bold()

                                    Text(sale.date ?? Date(), style: .date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                    }
                }
                
            }
            .padding()
        }
        .navigationTitle("Product")
        .sheet(isPresented: $showRecordSale) {
            RecordSaleView(product: product)
        }
    }
}
