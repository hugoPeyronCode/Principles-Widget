import SwiftUI

struct Mood: Identifiable {
    var id = UUID()
    let icon: String
    let color: Color
    let name: String
}

struct MoodSliderView: View {
    
    let mood: Mood
    let oppositeMood: Mood
    @Binding var score: Double
    
    var body: some View {
        HStack {
            MoodSymbolView(mood: mood, score: $score, position: 0)
            Slider(value: $score, in: 0...1)
                .padding()
                .tint(interpolatedTintColor)
            MoodSymbolView(mood: oppositeMood, score: $score, position: 1)
        }
    }
    
    private var interpolatedTintColor: Color {
        mood.color.interpolate(to: oppositeMood.color, fraction: score)
    }
}

struct MoodSymbolView: View {
    
    let mood: Mood
    @Binding var score: Double
    let position: Double
    
    var body: some View {
        VStack {
            Image(systemName: mood.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text(mood.name.uppercased())
                .font(.caption)
                .padding()
                .monospaced()
                .fontWeight(.light)
        }
        .foregroundStyle(interpolatedColor)
    }
    
    private var interpolatedColor: Color {
        if position == 0 {
            return Color.gray.interpolate(to: mood.color, fraction: 1 - score)
        } else {
            return Color.gray.interpolate(to: mood.color, fraction: score)
        }
    }
}

extension Color {
    func interpolate(to color: Color, fraction: Double) -> Color {
        var startRed: CGFloat = 0
        var startGreen: CGFloat = 0
        var startBlue: CGFloat = 0
        var startAlpha: CGFloat = 0

        var endRed: CGFloat = 0
        var endGreen: CGFloat = 0
        var endBlue: CGFloat = 0
        var endAlpha: CGFloat = 0

        UIColor(self).getRed(&startRed, green: &startGreen, blue: &startBlue, alpha: &startAlpha)
        UIColor(color).getRed(&endRed, green: &endGreen, blue: &endBlue, alpha: &endAlpha)

        let red = startRed + (endRed - startRed) * CGFloat(fraction)
        let green = startGreen + (endGreen - startGreen) * CGFloat(fraction)
        let blue = startBlue + (endBlue - startBlue) * CGFloat(fraction)
        let alpha = startAlpha + (endAlpha - startAlpha) * CGFloat(fraction)

        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

struct MoodSelectionView: View {
    
    let moodPairs: [(Mood, Mood)] = [
        (Mood(icon: "heart.fill", color: .pink, name: "In love"), Mood(icon: "heart.slash", color: .black, name: "Heartbroken")),
        (Mood(icon: "water.waves", color: .blue, name: "Peaceful"), Mood(icon: "flame", color: .red, name: "Angry")),
        (Mood(icon: "sun.max", color: .yellow, name: "Happy"), Mood(icon: "cloud.rain", color: .black, name: "Sad")),
        (Mood(icon: "bolt", color: .orange, name: "Energetic"), Mood(icon: "zzz", color: .purple, name: "Sleepy")),
        (Mood(icon: "leaf", color: .green, name: "Calm"), Mood(icon: "bolt.fill", color: .red, name: "Stressed")),
        (Mood(icon: "star", color: .yellow, name: "Excited"), Mood(icon: "moon", color: .blue, name: "Bored")),
        (Mood(icon: "sun.min", color: .pink, name: "Joyful"), Mood(icon: "umbrella", color: .cyan, name: "Gloomy")),
        (Mood(icon: "cloud.sun", color: .teal, name: "Content"), Mood(icon: "cloud.bolt", color: .black, name: "Restless")),
        (Mood(icon: "moon.stars", color: .indigo, name: "Dreamy"), Mood(icon: "cloud.fog", color: .gray, name: "Distracted"))
    ]
    
    @State private var scores: [UUID: Double] = [:]
    
    var body: some View {
        VStack {
            
            Text("Today I feel...")
                .monospaced()
                .padding()
            ScrollView(.vertical) {
                ForEach(moodPairs, id: \.0.id) { mood, oppositeMood in
                    ZStack {
                        Rectangle()
                            .foregroundStyle(.background)
                            .containerRelativeFrame([.horizontal, .vertical])
                        MoodSliderView(mood: mood, oppositeMood: oppositeMood, score: Binding(
                            get: { scores[mood.id, default: 0.5] },
                            set: { scores[mood.id] = $0 }
                        ))
                        .padding()
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
        }
    }
}

#Preview {
    MoodSelectionView()
}
