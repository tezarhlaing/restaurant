//
//  ViewController.swift
//  Abacus-Assg
//
//  Created by tezar on 10/10/22.
//

import UIKit
enum GroupOption: Int {
    case G1 = 1
    case G2 = 2
    case G3 = 3

}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onClickButton(_ sender: UIButton) {
        var items : [Item] = []
        switch(sender.tag) {
        case GroupOption.G1.rawValue:
            items = self.setDataForG1()
            let B1 = items.filter { $0.payby == 1}
            let B2 = items.filter { $0.payby == 2}
            let B3 = items.filter { $0.payby == 3}

            let invoice1 = Invoice.init(items: B1, paymentType: .CASH, discountRate: nil, paid: 100, receipt: "12131_1")
            let invoice2 = Invoice.init(items: B2, paymentType: .CASH, discountRate: nil, paid: 30, receipt: "12131_2")
            let invoice3 = Invoice.init(items: B3, paymentType: .CASH, discountRate: nil, paid: 30, receipt: "12131_3")
            self.printOutPut(invoice1, gNo: "G1")
            self.printOutPut(invoice2, gNo: "G1")
            self.printOutPut(invoice3, gNo: "G1")

            break
        case GroupOption.G2.rawValue:
            items = self.setDataForG2()
            let invoice1 = Invoice.init(items: items, paymentType: .CREDIT_CARD, discountRate: 10.0, paid: 100, receipt: "12132")
            self.printOutPut(invoice1, gNo: "G2")

            break
        case GroupOption.G3.rawValue:
            items = self.setDataForG3()
            let invoice1 = Invoice.init(items: items, paymentType: .CASH, discountRate: nil, paid: 50, receipt: "12133")
            invoice1.setDiscountAmount(25.0)
            self.printOutPut(invoice1, gNo: "G3")

            break

        default:
            break
        }
    }
    private func printOutPut(_ invoice: Invoice, gNo: String) {
        print("Group-----\(gNo)------Receipt ---\(invoice.receiptNo)")
        for (index, item) in invoice.getItems().enumerated() {
            let price = item.price * Double(item.qty)
            let str = "\(index + 1)" + "." + item.name + "------\(item.price)x\(item.qty) = $\(price)"
            print(str)
        }
        print("SurCharge--------------$\(invoice.surchage ?? 0)")
        print("Tax--------------$\(invoice.tax)")
        print("Discount--------------\(invoice.discount ?? 0)")
        print("Paid--------------$\(invoice.paid)")
        
        print("Total--------------$\(invoice.totalAmt)")
        print("Return--------------$\(invoice.returnAmt)")
        print("Remaining--------------$\(invoice.remainingAmt)")


    }
    
    private func setDataForG1() -> [Item] {
        //Big Brekkie $16 Big Brekkie $16 Bruschetta $8 Poached Eggs $12 Coffee $5 Tea $3 Soda $4
        //#1 #2 #3 #3 #2 #1 #3
        var items : [Item] = []
        let i1 = Item.init(id: 1, name: "Big Brekkie", price: 16.0,qty: 1, payby: 1)
        let i2 = Item.init(id: 1, name: "Big Brekkie", price: 16.0,qty: 1, payby: 2)
        let i3 = Item.init(id: 2, name: "Bruschetta", price: 8.0,qty: 1, payby: 3)
        let i4 = Item.init(id: 3, name: "Poached Eggs", price: 12.0,qty: 1, payby: 3)
        let i5 = Item.init(id: 4, name: "Coffee", price: 5.0,qty: 1, payby: 2)
        let i6 = Item.init(id: 5, name: "Tea", price: 3.0,qty: 1, payby: 1)
        let i7 = Item.init(id: 6, name: "Soda", price: 4.0,qty: 1, payby: 3)
        items.append(i1)
        items.append(i2)
        items.append(i3)
        items.append(i4)
        items.append(i5)
        items.append(i6)
        items.append(i7)
        return items
    }
    private func setDataForG2() -> [Item] {
       // Coffee $3x3 Soda $4x1 Big Brekkie $16x3 Poached Eggs $12x1 Garden Salad $10x1
        var items : [Item] = []
        let i1 = Item.init(id: 5, name: "Tea", price: 3.0,qty: 1,payby: 1)
        let i2 = Item.init(id: 4, name: "Coffee", price: 3.0,qty: 3,payby: 1)
        let i3 = Item.init(id: 6, name: "Soda", price: 4.0,qty: 1, payby: 1)
        let i4 = Item.init(id: 1, name: "Big Brekkie", price: 16.0,qty: 3, payby: 1)
        let i5 = Item.init(id: 3, name: "Poached Eggs", price: 12.0,qty: 1, payby: 1)
        let i6 = Item.init(id: 7, name: "Garden Salad", price: 10.0,qty: 1, payby: 1)
        items.append(i1)
        items.append(i2)
        items.append(i3)
        items.append(i4)
        items.append(i5)
        items.append(i6)
        return items
    }
    private func setDataForG3() -> [Item] {
        var items : [Item] = []
        let i1 = Item.init(id: 5, name: "Tea", price: 3.0,qty: 2, payby: 1)
        let i2 = Item.init(id: 4, name: "Coffee", price: 3.0,qty: 3, payby: 1)
        let i3 = Item.init(id: 6, name: "Soda", price: 4.0,qty: 2, payby: 3)
        let i4 = Item.init(id: 2, name: "Bruschetta", price: 8.0,qty: 5, payby: 1)
        let i5 = Item.init(id: 1, name: "Big Brekkie", price: 16.0,qty: 5, payby: 1)
        let i6 = Item.init(id: 3, name: "Poached Eggs", price: 12.0,qty: 2, payby: 1)
        let i7 = Item.init(id: 7, name: "Garden Salad", price: 10.0,qty: 3, payby: 1)

        items.append(i1)
        items.append(i2)
        items.append(i3)
        items.append(i4)
        items.append(i5)
        items.append(i6)
        items.append(i7)
        return items
    }
}

