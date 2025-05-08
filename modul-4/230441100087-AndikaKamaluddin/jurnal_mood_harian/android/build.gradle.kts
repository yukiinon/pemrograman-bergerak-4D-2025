allprojects {
    repositories {
        google()  // Pastikan repository Google ada
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

buildscript {
    dependencies {
        // Pastikan menambahkan classpath google-services di sini
        classpath("com.google.gms:google-services:4.3.15") // ✅ Versi terbaru
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
