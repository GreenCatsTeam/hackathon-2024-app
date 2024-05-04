package com.example.flutter_application_2

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
//        MapKitFactory.setLocale("YOUR_LOCALE")
        MapKitFactory.setApiKey("3e3f5bdc-293c-48bd-9698-78b9ec2d0549")
    }
}