plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.zoomapp"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.zoomapp"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true  // Kotlin DSL uses `isMinifyEnabled`, not `minifyEnabled`
            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),  // Fixed: `getDefaultProguardFile` (no typo)
                "proguard-rules.pro")

        }
    }
}

flutter {
    source = "../.."
}

//dependencies {
//    implementation(platform("com.google.firebase:firebase-bom:33.16.0"))  // BOM manages versions
//
//    // Add ALL Firebase services you use (no versions needed - BOM handles it)
//    implementation 'com.google.firebase:firebase-analytics'    // Recommended for all projects
//    implementation 'com.google.firebase:firebase-auth'         // For Firebase Auth
//    implementation 'com.google.firebase:firebase-firestore'    // For Cloud Firestore
//    implementation 'com.google.android.gms:play-services-auth:20.7.0'  // For Google Sign-In
//}