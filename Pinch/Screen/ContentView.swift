//
//  ContentView.swift
//  Pinch
//
//  Created by Todd James on 7/1/22.
//

import SwiftUI

struct ContentView: View {
  // MARK: - PROPERTY
  @State private var isAnimating: Bool = false
  @State private var imageScale: CGFloat = 1
  @State private var imageOffset: CGSize = .zero

  // MARK: - FUNCTION

  func resetImageState() {
    return withAnimation(.spring()) {
      imageScale = 1
      imageOffset = .zero
    }
  }

  // MARK: CONTENT

  var body: some View {
    NavigationView {
      ZStack {
        // MARK: - PAGE IMAGE

        Image("magazine-front-cover")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .cornerRadius(10)
          .padding()
          .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
          .opacity(isAnimating ? 1 : 0)
          .offset(x: imageOffset.width, y: imageOffset.height) // needed for drag gesture
          .animation(.linear(duration: 1), value: isAnimating)
          .scaleEffect(imageScale) // scaleEffect is 1
          // MARK: - 1. TAP GESTURE
          .onTapGesture(count: 2, perform: {
            if imageScale == 1 {
              withAnimation(.spring()) {
                imageScale = 5 // scale to 5x on doubletap
              }
            } else {
              resetImageState()
            }
          })
          // MARK: - 2. DRAG GESTURE
          .gesture(
            DragGesture()
              .onChanged { value in
                withAnimation(.linear(duration: 1)) {
                  imageOffset = value.translation
                }
              }
              .onEnded { _ in
                if imageScale <= 1 { // if scale is <= 1 spring back to center, if zoomed and dragged, remain where its at when stop dragging
                  resetImageState() // helper function at top
                }
              }
          )

      } //: ZSTACK
      .navigationTitle("Pinch & Zoom")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear(perform: {
          isAnimating = true
      })
    } //: NAVIGATION
    .navigationViewStyle(.stack)
  }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.dark)
  }
}
