//
//  Tab.swift
//  ScrollableMenu
//
//  Created by Eduardo Martin Lorenzo on 20/6/22.
//

import SwiftUI

struct Food: Identifiable {
    let id = UUID().uuidString
    var title: String
    var description: String
    var price: String
}

struct Tab: Identifiable {
    let id = UUID().uuidString
    var tab: String
    var foods: [Food]
}

var foods: [Food] = [
    Food(title: "Tarta de chocolate", description: "Es una tarta hecha por y para amantes del chocolate", price: "19€"),
    Food(title: "Galletas", description: "Deliciosas galletas que se comería el monstruo de las galletas", price: "2€"),
    Food(title: "Sandwich", description: "Bocadillo de jamón, queso y lechuga", price: "3€"),
    Food(title: "Pizza", description: "Comida italiana basada en una masa de pan, con tomate, queso y todos los ingredientes que quieras", price: "10€")
]

var tabsItems = [
    Tab(tab: "Estilo casero", foods: foods.shuffled()),
    Tab(tab: "Promociones", foods: foods.shuffled()),
    Tab(tab: "Aperitivos", foods: foods.shuffled()),
    Tab(tab: "McCafe", foods: foods.shuffled())
]
