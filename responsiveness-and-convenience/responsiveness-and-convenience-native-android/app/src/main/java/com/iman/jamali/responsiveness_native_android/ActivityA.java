package com.iman.jamali.responsiveness_native_android;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;

public class ActivityA extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_a);
    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.d("after navigating to PageA", "" + System.currentTimeMillis());
    }
}