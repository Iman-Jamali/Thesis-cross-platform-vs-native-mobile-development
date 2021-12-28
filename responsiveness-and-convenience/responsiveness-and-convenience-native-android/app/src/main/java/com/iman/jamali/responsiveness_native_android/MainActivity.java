package com.iman.jamali.responsiveness_native_android;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button goToABtn = findViewById(R.id.goToPageABtn);

        goToABtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d("start navigating to PageA", "" + System.currentTimeMillis());
                startActivity(new Intent(MainActivity.this, ActivityA.class));
            }
        });
    }
}