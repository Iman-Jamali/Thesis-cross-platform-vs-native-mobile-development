package com.iman.jamali.crud_native_android.data.remote;


import com.iman.jamali.crud_native_android.data.model.Todo;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.DELETE;
import retrofit2.http.GET;
import retrofit2.http.PATCH;
import retrofit2.http.POST;
import retrofit2.http.PUT;
import retrofit2.http.Path;

public interface TodoService {
    @GET("todos")
    Call<Todo[]> getTodos();

    @GET("todos/{todoId}")
    Call<Todo> getTodo(@Path("todoId") String todoId);

    @POST("todos")
    Call<Void> addTodo(@Body Todo todo);

    @PATCH("todos/{todoId}")
    Call<Void> updateTodo(@Path("todoId") String todoId, @Body Todo todo);

    @DELETE("todos/{todoId}")
    Call<Void> deleteTodo(@Path("todoId") String todoId);
}
