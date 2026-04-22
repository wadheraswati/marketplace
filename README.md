# 🛒 Offline-first Marketplace (iOS - SwiftUI)

A lightweight offline-first marketplace app built using SwiftUI. Users can browse listings, create new listings offline, and automatically sync data when network connectivity is restored.

---

## 🚀 Features

- 📦 Browse listings (offline-first support)
- ➕ Create listings without internet
- ⭐ Favorite/unfavorite items
- 🔄 Automatic sync on network restore
- 🖼 Image attachment support
- ⚡ Smooth performance for 200+ listings

---

## 🏗 Architecture

**MVVM + Repository Pattern**

- **Views (SwiftUI)**
  - UI built with `LazyVStack`
  - Navigation & user interactions

- **ViewModels**
  - UI state management
  - Input validation
  - Business logic triggers

- **Repository Layer**
  - Single source of truth
  - Handles Core Data + sync queue
  - Offline-first persistence

- **Sync Engine**
  - Detects network changes
  - Syncs pending/failed items in background

---

## 🔄 Offline-first Flow

1. User creates listing → saved locally
2. Marked as `pending`
3. Sync triggered when:
   - App launches
   - Network becomes available
4. Status updated:
   - `synced` or `failed`

---

## 📊 Performance Considerations

- ⚡ Local DB-first loading (instant UI)
- 🧠 `LazyVStack` for efficient list rendering
- 🖼 Image compression + thumbnails
- 🔄 Background sync (non-blocking UI)
- 📦 Optimized for 200+ listings

---

## 🧪 Testing

- ViewModel validation tests
- Offline creation flow tests
- Sync success/failure tests
- Mock repository for isolation

---

## 🧠 Key Design Decisions

- Offline-first architecture
- No network dependency for UI rendering
- Dependency injection for testability
- Clear separation of concerns (View / VM / Repo)
- Background sync for performance

---

## 🛠 Tech Stack

- SwiftUI
- Core Data
- URLSession (async/await)
- PhotosUI
- Combine (@Published)

---

## 📈 Future Improvements

- Pagination for large datasets
- Exponential backoff retry mechanism
- BackgroundTasks framework sync
- Server-side conflict resolution
- Diffable list updates

---
