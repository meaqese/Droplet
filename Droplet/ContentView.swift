//
//  ContentView.swift
//  Droplet
//
//  Created by me on 27.12.2024.
//

import SwiftUI


struct ContentView: View {
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Canvas { context, size in
                let centerPoint = CGPoint(x: size.width / 2, y: size.height / 2)
                
                let circleBack = context.resolveSymbol(id: 1)!
                let circleFront = context.resolveSymbol(id: 2)!
                
                context.addFilter(.alphaThreshold(min: 0.4, color: .yellow))
                context.addFilter(.blur(radius: 30))
                

                context.drawLayer { ctx in
                    ctx.draw(circleBack, at: centerPoint)
                    ctx.draw(circleFront, at: centerPoint)
                }
                
            } symbols: {
                Circle()
                    .fill(.yellow)
                    .frame(width: 100)
                    .tag(1)
                Circle()
                    .frame(width: 100)
                    .offset(x: dragOffset.width, y: dragOffset.height)
                    .tag(2)
            }
            
            Circle()
                .foregroundStyle(.red)
                .opacity(max(abs(dragOffset.height), abs(dragOffset.width)) / 200)
                .frame(width: 100)
                .offset(x: dragOffset.width, y: dragOffset.height)
                .overlay {
                    Image(systemName: "cloud.sun.rain.fill")
                        .symbolRenderingMode(.hierarchical)
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .offset(x: dragOffset.width, y: dragOffset.height)
                }
        }
        .gesture(
            DragGesture()
                .onChanged { val in
                    dragOffset = val.translation
                }
                .onEnded { _ in
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                        dragOffset = .zero
                    }
                }
            )
           
    }
}




#Preview {
    ContentView()
}
