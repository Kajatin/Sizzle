//
//  Decor.swift
//  Sizzle
//
//  Created by Roland Kajatin on 19/02/2024.
//

import SwiftUI

struct Decor: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: "https://media.istockphoto.com/id/1457433817/photo/group-of-healthy-food-for-flexitarian-diet.jpg?b=1&s=612x612&w=0&k=20&c=V8oaDpP3mx6rUpRfrt2L9mZCD0_ySlnI7cd4nkgGAb8=")) { p in
                switch p {
                case .success(let image):
                    image.resizable().renderingMode(.original)
                        .scaledToFill()
                default:
                    ProgressView()
                }
            }
            
            Grid {
                GridRow {
                    PrepTile()
                    CookingTile()
                    ServingTile()
                    FavTile()
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct PrepTile: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("Prep time")
                .font(.custom("Fredoka", fixedSize: 20))
                .fontWeight(.bold)
                .opacity(0.6)
                
            Text("15")
                .font(.custom("Fredoka", fixedSize: 52))
                .fontWeight(.bold)
            
            Text("minutes")
                .font(.custom("Fredoka", fixedSize: 20))
                .fontWeight(.medium)
                .opacity(0.6)
        }
        .frame(width: 150, height: 120)
        .padding()
        .padding(.vertical)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundStyle(Color.darkGreen)
    }
}

struct CookingTile: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("Cooking time")
                .font(.custom("Fredoka", fixedSize: 20))
                .fontWeight(.bold)
                .opacity(0.6)
            
            Text("60")
                .font(.custom("Fredoka", fixedSize: 52))
                .fontWeight(.bold)
            
            Text("minutes")
                .font(.custom("Fredoka", fixedSize: 20))
                .fontWeight(.medium)
                .opacity(0.6)
        }
        .frame(width: 150, height: 120)
        .padding()
        .padding(.vertical)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundStyle(Color.darkGreen)
    }
}

struct ServingTile: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("")
                .font(.custom("Fredoka", fixedSize: 20))
                .fontWeight(.bold)
                .opacity(0.6)
            
            Text("4")
                .font(.custom("Fredoka", fixedSize: 52))
                .fontWeight(.bold)
            
            Text("Servings")
                .font(.custom("Fredoka", fixedSize: 20))
                .fontWeight(.medium)
                .opacity(0.6)
        }
        .frame(width: 150, height: 120)
        .padding()
        .padding(.vertical)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundStyle(Color.darkGreen)
    }
}

struct FavTile: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("")
                .font(.custom("Fredoka", fixedSize: 20))
                .fontWeight(.bold)
                .opacity(0.6)
            
            Image(systemName: "heart.fill")
                .font(.custom("Fredoka", fixedSize: 52))
                .fontWeight(.bold)
            
            Text("Favorite")
                .font(.custom("Fredoka", fixedSize: 20))
                .fontWeight(.medium)
                .opacity(0.6)
        }
        .frame(width: 150, height: 120)
        .padding()
        .padding(.vertical)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundStyle(Color.darkGreen)
        .colorMultiply(Color.lightGreen)
    }
}

#Preview {
    Decor()
}
