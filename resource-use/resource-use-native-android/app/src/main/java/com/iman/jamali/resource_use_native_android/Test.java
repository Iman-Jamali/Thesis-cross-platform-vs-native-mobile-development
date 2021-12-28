package com.iman.jamali.resource_use_native_android;

import android.annotation.SuppressLint;
import android.util.Log;

import com.iman.jamali.resource_use_native_android.data.model.Id;
import com.iman.jamali.resource_use_native_android.data.model.Message;
import com.iman.jamali.resource_use_native_android.data.model.Todo;
import com.iman.jamali.resource_use_native_android.data.remote.TodoService;
import com.iman.jamali.resource_use_native_android.util.RetrofitClientInstance;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public final class Test {
    public static final String Log_TAG = "resource test results";
    public static ArrayList<Integer> findPrimes (int maxNum) {
        ArrayList<Integer> primes = new ArrayList<>();
        for (int i = 0; i <= maxNum; i++) {
            if (isPrime(i)) {
                primes.add(i);
            }
        }
        return primes;
    }

    private static boolean isPrime (int num) {
        for (int i = 2; i < num; i++){
            if (num % i == 0) {
                return false;
            }
        }
        return num > 1;
    }

    public static void transitiveClosure(int graph[][], int V)
    {
        int reach[][] = new int[V][V];
        int  i, j, k;
        for (i = 0; i < V; i++)
            for (j = 0; j < V; j++)
                reach[i][j] = graph[i][j];

        for (k = 0; k < V; k++)
        {
            for (i = 0; i < V; i++)
            {
                for (j = 0; j < V; j++)
                {
                    reach[i][j] = (reach[i][j]!=0) ||
                            ((reach[i][k]!=0) && (reach[k][j]!=0))?1:0;
                }
            }
        }
    }

    public static void networkTest(int num) {
        final int[] counter = {0};
        long startTime = System.currentTimeMillis();
        Todo newTodo = new Todo("1", "todo title 1", "todo description 1");
        TodoService service = RetrofitClientInstance.getRetrofitInstance().create(TodoService.class);
        for (int i = 0; i < num; i++) {
            service.getTodo2("1").enqueue(new Callback<Todo>() {
                @Override
                public void onResponse(Call<Todo> call, Response<Todo> response) {
                    counter[0]= counter[0]+ 1;
                    checkFinish(startTime, num, counter[0]);
                }

                @Override
                public void onFailure(Call<Todo> call, Throwable t) {

                }
            });

            service.postTodo2(newTodo).enqueue(new Callback<Message>() {
                @Override
                public void onResponse(Call<Message> call, Response<Message> response) {
                    counter[0]= counter[0]+ 1;
                    checkFinish(startTime, num, counter[0]);
                }

                @Override
                public void onFailure(Call<Message> call, Throwable t) {

                }
            });

            service.patchTodo2("1", newTodo).enqueue(new Callback<Id>() {
                @Override
                public void onResponse(Call<Id> call, Response<Id> response) {
                    counter[0]= counter[0]+ 1;
                    checkFinish(startTime, num, counter[0]);
                }

                @Override
                public void onFailure(Call<Id> call, Throwable t) {

                }
            });

            service.deleteTodo2("1").enqueue(new Callback<Id>() {
                @Override
                public void onResponse(Call<Id> call, Response<Id> response) {
                    counter[0]= counter[0]+ 1;
                    checkFinish(startTime, num, counter[0]);
                }

                @Override
                public void onFailure(Call<Id> call, Throwable t) {

                }
            });
        }

    }
    public static void checkFinish(long startTime, int num, int counter) {
        if (counter == num * 4) {
            long endTime = System.currentTimeMillis();
            long testDuration = endTime - startTime;
            Log.d(Log_TAG, "test C duration: " + (testDuration));
        }
    }

}
