package com.iman.jamali.resource_use_native_android;

import static com.iman.jamali.resource_use_native_android.Test.transitiveClosure;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.widget.Button;


import java.util.concurrent.ThreadLocalRandom;

public class MainActivity extends AppCompatActivity {

    public static final String Log_TAG = "resource test results";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button testA = findViewById(R.id.test_a_btn);
        Button testB = findViewById(R.id.test_b_btn);
        Button testC = findViewById(R.id.test_c_btn);

        testA.setOnClickListener(view ->{
            long startTime = System.currentTimeMillis();
            Test.findPrimes(300000);
            long endTime = System.currentTimeMillis();
            Log.d("test A duration", String.valueOf(endTime - startTime));
        });

        testB.setOnClickListener(view ->{
            long startTime = System.currentTimeMillis();
            int min = 0;
            int max = 1;
            int n = 400;
            int m = 200000;
            int[][] graph = new int[m][n];
            for (int i = 0; i < m; i++) {
                int[] v = new int[n];
                for (int j = 0; j < n; j++) {
                    int randomNum = ThreadLocalRandom.current().nextInt(min, max + 1);
                    v[j] = randomNum;
                }
                graph[i] = v;
            }
            transitiveClosure(graph, n);
            long endTime = System.currentTimeMillis();
            long testDuration = endTime - startTime;
            Log.d(Log_TAG, "test B duration: " + (testDuration));
        });


        testC.setOnClickListener(view ->{
            Test.networkTest(500);
        });


    }
}