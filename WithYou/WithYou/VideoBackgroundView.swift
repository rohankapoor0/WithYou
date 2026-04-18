import SwiftUI
import AVKit

struct VideoBackgroundView: UIViewRepresentable {
    let videoName: String

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        guard let path = Bundle.main.path(forResource: videoName, ofType: "mov") else {
            print("❌ Video not found:", videoName)
            return view
        }

        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        player.isMuted = true
        player.actionAtItemEnd = .none

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill // ✅ THIS IS THE KEY
        playerLayer.frame = UIScreen.main.bounds

        view.layer.addSublayer(playerLayer)

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }

        player.play()

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let layer = uiView.layer.sublayers?.first as? AVPlayerLayer {
            layer.frame = UIScreen.main.bounds
        }
    }
}
