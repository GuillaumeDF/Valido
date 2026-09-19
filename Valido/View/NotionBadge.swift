import SwiftUI

struct NotionBadge: View {
    let acquises: Int
    let total: Int

    var body: some View {
        Label("\(acquises)/\(total)", systemImage: "checkmark.seal.fill")
            .font(.caption.weight(.semibold))
            .foregroundStyle(acquises == 0 ? AnyShapeStyle(.secondary) : AnyShapeStyle(.tint))
            .accessibilityLabel("\(acquises) notions acquises sur \(total)")
    }
}
