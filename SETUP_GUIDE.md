# RENTO App Setup Guide

## Google Maps API Key Setup

To use the map functionality in the RENTO app, you need to set up a Google Maps API key:

### 1. Get Google Maps API Key

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the following APIs:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Places API (optional, for future features)
4. Go to "Credentials" and create an API key
5. Restrict the API key to your app's package name for security

### 2. Configure API Key

Replace `YOUR_GOOGLE_MAPS_API_KEY_HERE` in the following files with your actual API key:

#### Android
File: `android/app/src/main/AndroidManifest.xml`
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_ACTUAL_API_KEY_HERE" />
```

#### iOS
File: `ios/Runner/Info.plist`
```xml
<key>GMSApiKey</key>
<string>YOUR_ACTUAL_API_KEY_HERE</string>
```

### 3. Run the App

1. Make sure you have Flutter installed and configured
2. Run `flutter pub get` to install dependencies
3. Connect your device or start an emulator
4. Run `flutter run` to launch the app

## Demo Credentials

For testing the login functionality, use these demo credentials:

**Login:**
- Email: `demo@rento.com`
- Password: `demo123`

**Signup:**
- Fill in any valid data in all fields (First Name, City, Email, Password)
- All signup attempts with valid data will be accepted

## Features Implemented

✅ **Login/Signup Flow**
- Beautiful gradient UI with form validation
- Email and password validation
- Loading states and error handling
- Navigation to home page on successful login/signup
- Demo credentials for easy testing

✅ **Map Integration**
- Google Maps integration with custom markers
- Current location detection
- Sample markers for demonstration
- Interactive map with tap-to-add markers
- Location permissions handling

✅ **Home Page**
- Map view with bottom navigation
- User profile section
- Location services integration
- Responsive UI design

## App Flow

1. **Splash Screen** → Welcome screen with "Get Started" button
2. **Login Page** → Login/Signup form with validation
3. **Home Page** → Map view with navigation and location features

## Permissions

The app requests the following permissions:
- **Location**: To show user's current location on the map
- **Internet**: To load map tiles and location services

## Next Steps

- Replace the placeholder API key with your actual Google Maps API key
- Test the app on both Android and iOS devices
- Customize the map markers and add more features as needed

## Troubleshooting

- If the map doesn't load, check your API key configuration
- If location doesn't work, ensure location permissions are granted
- For iOS, make sure you have the latest Xcode and iOS deployment target
