plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // Firebase services plugin
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.ash.plotvote"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.ash.plotvote"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug") // TODO: Replace with release config
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase Auth for Google Sign-In
    implementation("com.google.firebase:firebase-auth-ktx:22.3.0")
    
    // Google Sign-In
    implementation("com.google.android.gms:play-services-auth:20.7.0")
}
