allprojects {
    repositories {
        google()
        mavenCentral()
        // TODO: remove before merging, together with the purchases 11.0.0-SNAPSHOT pins.
        maven {
            url = uri("https://central.sonatype.com/repository/maven-snapshots/")
            content { includeGroup("com.revenuecat.purchases") }
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
