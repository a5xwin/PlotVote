import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

plugins {
    // No need to add anything here for google-services
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Add this block to include the Google Services plugin classpath
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.3.15")
    }
}

// Optional: if you're customizing build output
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    evaluationDependsOn(":app")  // Ensure app module is loaded before others
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
