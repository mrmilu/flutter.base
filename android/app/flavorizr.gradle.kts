import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("beta") {
            dimension = "flavor-type"
            applicationId = "com.flutterbase.beta"
            signingConfig = signingConfigs.getByName("release_beta")
            resValue(type = "string", name = "app_name", value = "FlutterBase (Beta)")
        }
        create("live") {
            dimension = "flavor-type"
            applicationId = "com.flutterbase.live"
            signingConfig = signingConfigs.getByName("release_live")
            resValue(type = "string", name = "app_name", value = "FlutterBase")
        }
    }
}