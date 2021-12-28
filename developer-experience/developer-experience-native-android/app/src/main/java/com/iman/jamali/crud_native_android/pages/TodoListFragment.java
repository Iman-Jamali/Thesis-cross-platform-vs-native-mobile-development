package com.iman.jamali.crud_native_android.pages;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;


import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.iman.jamali.crud_native_android.R;
import com.iman.jamali.crud_native_android.adapter.TodoAdapter;
import com.iman.jamali.crud_native_android.data.model.Todo;
import com.iman.jamali.crud_native_android.data.remote.TodoService;
import com.iman.jamali.crud_native_android.util.RetrofitClientInstance;

import java.util.Arrays;
import java.util.Comparator;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class TodoListFragment extends Fragment {
    private Context mContext;
    private RecyclerView mRecyclerView;

    public static TodoListFragment newInstance() {
        return new TodoListFragment();
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        View view =  inflater.inflate(R.layout.todo_list_fragment, container, false);
        mContext = view.getContext();
        ((Activity) mContext).setTitle("Todo List");
        fetchData();
        FloatingActionButton addFab = view.findViewById(R.id.fab_todo_add);
        addFab.setOnClickListener(view1 -> addTodoItem());
        mRecyclerView = view.findViewById(R.id.rv_todo_list);
        RecyclerView.LayoutManager rvLayoutManager = new LinearLayoutManager(mContext);
        mRecyclerView.setLayoutManager(rvLayoutManager);
        return view;
    }

    public void fetchData() {
        TodoService service = RetrofitClientInstance.getRetrofitInstance().create(TodoService.class);
        Call<Todo[]> call = service.getTodos();
        call.enqueue(new Callback<Todo[]>() {
            @Override
            public void onResponse(Call<Todo[]> call, Response<Todo[]> response) {
                if (response.isSuccessful() && response.body() != null) {
                    Todo[] todos = response.body();
                    Arrays.sort(todos, new Comparator<Todo>() {
                        @Override
                        public int compare(Todo todo1, Todo todo2) {
                            return todo2.getUpdatedAt().compareTo(todo1.getUpdatedAt());
                        }
                    });
                    setAdapter(todos);
                }
            }

            @Override
            public void onFailure(Call<Todo[]> call, Throwable t) {
                Log.e("todo", "error getting todos");
            }
        });
    }

    private void setAdapter(Todo[] todos) {
        TodoAdapter adapter = new TodoAdapter(mContext, todos, this);
        RecyclerView.ItemDecoration itemDecoration = new
                DividerItemDecoration(mContext, DividerItemDecoration.VERTICAL);
        mRecyclerView.addItemDecoration(itemDecoration);
        mRecyclerView.setAdapter(adapter);
    }

    private void addTodoItem() {
        Fragment fragment = EditTodoFragment.newInstance(null);
        FragmentManager fragmentManager = ((FragmentActivity) getActivity()).getSupportFragmentManager();
        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        fragmentTransaction.replace(R.id.container, fragment, fragment.getClass().getName());
        fragmentTransaction.addToBackStack(null);
        fragmentTransaction.commit();
    }

}