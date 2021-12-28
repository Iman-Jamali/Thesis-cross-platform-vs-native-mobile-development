package com.iman.jamali.resource_use_native_android.data.remote;

import com.iman.jamali.resource_use_native_android.data.model.Id;
import com.iman.jamali.resource_use_native_android.data.model.Message;
import com.iman.jamali.resource_use_native_android.data.model.Todo;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.DELETE;
import retrofit2.http.GET;
import retrofit2.http.PATCH;
import retrofit2.http.POST;
import retrofit2.http.Path;

public interface TodoService {
    @GET("todos/{id}")
    Call<Todo> getTodo2(@Path("id") String id);

    @POST("todos")
    Call<Message> postTodo2(@Body Todo todo);

    @PATCH("todos/{id}")
    Call<Id> patchTodo2(@Path("id") String id, @Body Todo todo);

    @DELETE("todos/{id}")
    Call<Id> deleteTodo2(@Path("id") String id);
}
