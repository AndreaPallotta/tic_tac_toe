plugins {
    id("org.jetbrains.kotlin.jvm") version "1.8.10"
    application
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("com.google.guava:guava:31.1-jre")
}

testing {
    suites {
        val test by getting(JvmTestSuite::class) {
            useKotlinTest("1.8.10")
        }
    }
}

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(18))
    }
}

application {
    mainClass.set("tic_tac_kt.MainKt")
}

tasks.named<JavaExec>("run") {
    standardInput = System.console().reader()
}
