//
//  Invoice.swift
//  Abacus-Assg
//
//  Created by tezar on 10/10/22.
//

import Foundation

enum PaymentType: String {
    case CASH = "CASH"
    case CREDIT_CARD = "CREDIT_CARD"
    case DEBID_CARD = "DEBID_CARD"

}
enum SplitBillType: String {
    case EQUAL = "EQUAL"
    case PER_ITEM = "PER_ITEM"
    case NONE = "NONE"

}

struct Item {
    private let id: Int
    let name: String
    let price: Double
    let qty: Int
    let payby: Int

    init(id: Int, name: String, price: Double,qty: Int, payby: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.qty = qty
        self.payby = payby
    }

}
class Invoice {
    private let items: [Item]
    var discount: Double?
    var receiptNo: String
    var paid : Double
    var paymentType: PaymentType

    var totalAmt: Double = 0.0
    var surchage: Double? //1.2%
    var returnAmt: Double = 0.0
    var remainingAmt: Double = 0.0
    var tax: Double = 0.0 // 7%

    init(items: [Item], paymentType: PaymentType, discountRate: Double?,paid : Double, receipt: String) {
        self.items = items
        self.paymentType = paymentType
        self.receiptNo = receipt
        self.paid = paid
        calTotalAmt()
        if let rate = discountRate{
            calDiscount(rate)
            totalAmt = totalAmt - (self.discount ?? 0)
        }
        if paymentType == .CREDIT_CARD {
            calSurcharge()
        }

        if self.paid > self.totalAmt {
            returnAmt = self.paid - self.totalAmt
        }
        else if self.paid < self.totalAmt {
            remainingAmt = self.totalAmt - self.paid
        }
        self.calTax()
    }
    func setDiscountAmount(_ discount: Double) {
        self.discount = discount
        totalAmt = totalAmt - (self.discount ?? 0)

    }
    func splitBillEqual(_ noOfPayee: Double) -> Double  {
        return totalAmt / noOfPayee

    }
    func getItems() -> [Item] {
        return self.items
    }
    private func calDiscount(_ discountRate: Double) {
        self.discount = self.totalAmt * (discountRate/100)
    }
    private func calSurcharge() {
        self.surchage = self.totalAmt * (1.2/100)
    }
    private func calTax() {
        self.tax = self.totalAmt * (7.0/100)
    }
    func calTotalAmt(){
        for item in items {
            self.totalAmt += item.price * Double(item.qty)
        }
    }
}
