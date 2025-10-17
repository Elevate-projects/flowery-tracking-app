# Flowery Tracking 🚚🌸  

The **Flowery Tracking App** is a Flutter-based delivery management application designed for drivers in the Flowery ecosystem.  
It enables drivers to **accept**, **track**, and **complete** delivery orders seamlessly — ensuring a smooth connection between stores and customers.  

Built with scalability, performance, and real-time synchronization in mind, the app integrates **Firebase Firestore** to maintain live updates between the customer and driver apps.  

---

## Features ✨  

### 🚀 Onboarding & Authentication  
- **Onboarding Flow**: Introduction screens guiding drivers about the app purpose.  
- **Login / Apply**:  
  - Registered drivers can **log in** with email and password.  
  - New drivers can **apply** for registration through a dedicated flow.  
- **Forgot Password**: Reset password easily using email verification and OTP flow.  

---

### 📦 Order Management  
- **Home Screen (Pending Orders)**:  
  - Displays a real-time list of available delivery orders.  
  - Drivers can **accept** an order directly from the list.  
  - Once accepted, the order is locked until delivered.  

- **Order Details Screen**:  
  - View detailed information including:  
    - **User Details**  
    - **Store Details**  
    - **Order Details**  
  - Direct navigation to map views:  
    - **Store Map**: Displays the route from the driver’s current location to the store.  
    - **User Map**: Displays the route from the store to the customer’s location.  

- **Accepted Orders**:  
  - Real-time updates from Firestore.  
  - The driver cannot accept new orders until the current one is delivered.  

---

### 📜 Completed & Canceled Orders  
- **Orders History Screen**:  
  - Displays all **Completed** and **Canceled** orders.  
  - Each order includes detailed information such as user details, store details, and delivery time.  
  - Drivers can open any previous order to view its **Order Details Screen**.

---

### 👤 Profile & Settings  
- **Profile Screen**:  
  - View and edit personal information (name, phone number, etc.).  
  - Change the app language between **English** and **Arabic**.  
  - Log out securely anytime.  

---

## Technologies Used 🛠️  

- **Flutter**: Cross-platform framework for consistent performance.  
- **Dio + Retrofit**: Type-safe and efficient HTTP client for backend APIs.  
- **Firebase Firestore**: Real-time synchronization between driver and user apps.
- **Google Maps & Geolocation**:  
  - Displays store and user locations with live navigation.  
  - Calculates routes and distances dynamically.  
- **Bloc / Cubit (MVI Pattern)**: Reactive state management with clean separation of logic.  
- **Clean Architecture**: Scalable and testable project structure.  
- **Repository Pattern**: Abstracted data management layer.  
- **Dependency Injection**: Modular and maintainable architecture.  

---

## 📂 Project Structure  

```bash
lib/
├── api/
│   └── client/           # Retrofit API client
│   └── models/           # Data models
│   └── responses/        # API responses
│   └── data_source_impl/ # API implementations
├── data/
│   └── data_source/      # Local/remote data sources
│   └── repositories/     # Repository implementations
├── domain/
│   └── entities/         # Core business entities
│   └── repositories/     # Repository contracts
│   └── usecases/         # Business logic & use cases
├── presentation/
│   └── views/            # UI screens & widgets
│   └── view_models/      # Bloc/Cubit classes

```

---

## 🛠️ Setup Instructions

### 1.Clone the repository
```bash
git clone https://github.com/Elevate-projects/flowery-tracking-app.git
```
### 2.Navigate into the project directory
```bash
cd flowery-tracking-app
```
### 3.Install dependencies
```bash
flutter pub get
```
### 4.Run the app
```bash
flutter run
```

---

## Screenshots 📸

<img src="https://github.com/user-attachments/assets/33ea2d14-f1d5-4e8b-9323-cf2f664dacae" alt="Screenshot 1" width="300"/>
<img src="https://github.com/user-attachments/assets/d7d99a6d-ff1b-4003-a77a-71dc195f0cd9" alt="Screenshot 2" width="300"/>
<img src="https://github.com/user-attachments/assets/87ee9db2-d810-4a4e-9827-234583aa110b" alt="Screenshot 3" width="300"/>
<img src="https://github.com/user-attachments/assets/4fbbafbe-1118-42c0-b4d0-7b2d6e3e89b0" alt="Screenshot 4" width="300"/>
<img src="https://github.com/user-attachments/assets/dce5c511-e59e-4b7e-8c33-879583735f13" alt="Screenshot 5" width="300"/>
<img src="https://github.com/user-attachments/assets/398ed745-b20e-4461-bffc-c7195926abf2" alt="Screenshot 6" width="300"/>
<img src="https://github.com/user-attachments/assets/1ae97b7d-316f-47b4-8d0e-d4f1ff2e411b" alt="Screenshot 7" width="300"/>
<img src="https://github.com/user-attachments/assets/122492ff-b220-44c8-81dc-3fc460c49e54" alt="Screenshot 8" width="300"/>
<img src="https://github.com/user-attachments/assets/33a351af-6c19-4ed1-b4fc-64cdb7230252" alt="Screenshot 9" width="300"/>
<img src="https://github.com/user-attachments/assets/c7b1eee5-03a7-419a-a5b2-3268f9f953d3" alt="Screenshot 10" width="300"/>
<img src="https://github.com/user-attachments/assets/bb51fd6b-36ee-41db-bd6c-f65cc25826a0" alt="Screenshot 11" width="300"/>
<img src="https://github.com/user-attachments/assets/8aa4d507-a04a-46cf-bb48-2d4e34f6c238" alt="Screenshot 12" width="300"/>
<img src="https://github.com/user-attachments/assets/452d6041-f60a-4373-9c9f-247234d087a9" alt="Screenshot 13" width="300"/>
<img src="https://github.com/user-attachments/assets/e7c7d634-b8ef-49d2-8ba7-fb5790b80eb8" alt="Screenshot 14" width="300"/>
<img src="https://github.com/user-attachments/assets/10856be5-56b8-4caa-b773-cf15d5f0021a" alt="Screenshot 15" width="300"/>
<img src="https://github.com/user-attachments/assets/8676839b-db77-4e30-ae08-b000be4acc8b" alt="Screenshot 16" width="300"/>
<img src="https://github.com/user-attachments/assets/a3caa442-802c-4a70-a261-b7b6bed0b943" alt="Screenshot 17" width="300"/>
<img src="https://github.com/user-attachments/assets/d8b1a45f-3b27-4c71-82e2-e32481582231" alt="Screenshot 18" width="300"/>
<img src="https://github.com/user-attachments/assets/e36566fb-dc59-4af6-950a-bbcc7b0f28c2" alt="Screenshot 19" width="300"/>
<img src="https://github.com/user-attachments/assets/17a7b7ef-6e58-448b-97f0-04b34aa4a554" alt="Screenshot 20" width="300"/>
<img src="https://github.com/user-attachments/assets/fbafa17c-2c55-46dc-9b0b-e24ed0f827fd" alt="Screenshot 21" width="300"/>
<img src="https://github.com/user-attachments/assets/929f2211-8638-4e4f-9d0a-64440cfd8272" alt="Screenshot 22" width="300"/>
<img src="https://github.com/user-attachments/assets/7b77e2ee-d71b-4b50-885c-71cda5b8d464" alt="Screenshot 23" width="300"/>
<img src="https://github.com/user-attachments/assets/6808b6b8-49d2-4f58-8ffb-0cae530972fe" alt="Screenshot 24" width="300"/>
<img src="https://github.com/user-attachments/assets/6b89007b-e408-4510-89ce-3ec7c5db6bd9" alt="Screenshot 25" width="300"/>
<img src="https://github.com/user-attachments/assets/62d8c0ef-6a83-444e-a13b-61cffd3f6acb" alt="Screenshot 26" width="300"/>
<img src="https://github.com/user-attachments/assets/c8d87dc7-b91d-432e-b372-d979b6bfa784" alt="Screenshot 27" width="300"/>
<img src="https://github.com/user-attachments/assets/a34859c1-90ae-4da2-bdb1-30323ac339ce" alt="Screenshot 28" width="300"/>
<img src="https://github.com/user-attachments/assets/1c2fbcb1-0420-4e2f-853e-5d069fdf4835" alt="Screenshot 29" width="300"/>
<img src="https://github.com/user-attachments/assets/bf80121b-6ada-4e3a-9414-d775595c6d61" alt="Screenshot 30" width="300"/>
<img src="https://github.com/user-attachments/assets/0e852d5f-4596-4781-9eea-c63a1d58a6dd" alt="Screenshot 31" width="300"/>
<img src="https://github.com/user-attachments/assets/8698e4ea-13c0-410a-8509-8f5ce8cc027e" alt="Screenshot 32" width="300"/>


---

## Download 📥
- Coming Soon...
