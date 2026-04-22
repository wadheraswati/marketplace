A lightweight marketplace app that supports browsing listings, creating new listings offline, favoriting items, and automatic background sync when network connectivity is restored.

**Features**

📦 Browse marketplace listings (offline-first)
⭐ Mark/unmark favorites
➕ Create new listings offline
🔄 Automatic sync when network is available
🖼 Image attachment with compression
⚡ Smooth scrolling for large set of listings


**Pattern:**

View → ViewModel → Repository → Local DB → Network API


**Performance Optimizations:**

LazyVStack for efficient list rendering
Thumbnail-based image storage
Background queue for sync operations
Batch processing for large datasets
Local-first loading (no network dependency for UI)


**🛠 Tech Stack**

SwiftUI
Core Data
URLSession (async/await)
Combine (light usage via @Published)
PhotosUI (image picker)
