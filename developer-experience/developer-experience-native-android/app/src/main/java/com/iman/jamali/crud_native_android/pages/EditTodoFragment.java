package com.iman.jamali.crud_native_android.pages;

import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;


import com.google.android.material.textfield.TextInputEditText;
import com.google.android.material.textfield.TextInputLayout;
import com.iman.jamali.crud_native_android.R;
import com.iman.jamali.crud_native_android.data.model.Todo;
import com.iman.jamali.crud_native_android.data.remote.TodoService;
import com.iman.jamali.crud_native_android.util.RetrofitClientInstance;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;
import java.util.UUID;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;


public class EditTodoFragment extends Fragment {
    private static final String ARG_TODO_ITEM_ID = "todoId";
    private String mTodoItemId;
    private boolean mIsEdit = false;
    private Todo mTodo = null;
    private TextInputEditText mTitleTiedt;
    private TextInputLayout mTitleTil;
    private TextInputEditText mDescriptionTiedt;
    private TextInputLayout mDescriptionTil;
    private TodoService service;

    public EditTodoFragment() {
        // Required empty public constructor
    }

    public static EditTodoFragment newInstance(@Nullable String todoItemId) {
        EditTodoFragment fragment = new EditTodoFragment();
        if (todoItemId != null) {
            Bundle args = new Bundle();
            args.putString(ARG_TODO_ITEM_ID, todoItemId);
            fragment.setArguments(args);
        }
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mTodoItemId = getArguments().getString(ARG_TODO_ITEM_ID);
            mIsEdit = true;
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view =  inflater.inflate(R.layout.fragment_edit_todo_item, container, false);
        mTitleTiedt = view.findViewById(R.id.tiedt_edit_todo_title);
        mTitleTil = view.findViewById(R.id.til_edit_todo_title);
        mDescriptionTiedt = view.findViewById(R.id.tiedt_edit_todo_description);
        mDescriptionTil = view.findViewById(R.id.til_edit_todo_description);
        Button mEditBtn = view.findViewById(R.id.btn_edit_blood_pressure_edit);
        Button mCancelBtn = view.findViewById(R.id.btn_edit_blood_pressure_cancel);
        Button mDeleteBtn = view.findViewById(R.id.btn_edit_blood_pressure_delete);
        service = RetrofitClientInstance.getRetrofitInstance().create(TodoService.class);
        if (mIsEdit) {
            getActivity().setTitle("Edit Todo");
            mEditBtn.setText("Update");
            mDeleteBtn.setVisibility(View.VISIBLE);
            populateFields();
        } else {
            getActivity().setTitle("Add Todo");
            mEditBtn.setText("Add");
        }
        mEditBtn.setOnClickListener(view1 -> submitTodo());
        mCancelBtn.setOnClickListener(view1 -> goBack());
        mDeleteBtn.setOnClickListener(view1 -> deleteTodo());

        setHasOptionsMenu(true);

        mTitleTiedt.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void afterTextChanged(Editable editable) {
                mTitleTil.setError(null);
            }
        });

        mDescriptionTiedt.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void afterTextChanged(Editable editable) {
                mDescriptionTil.setError(null);
            }
        });


        return view;
    }

    private void populateFields() {
        Call<Todo> call = service.getTodo(mTodoItemId);
        call.enqueue(new Callback<Todo>() {
            @Override
            public void onResponse(Call<Todo> call, Response<Todo> response) {
                if (response.isSuccessful() && response.body() != null) {
                    mTodo = response.body();
                    mTitleTiedt.setText(mTodo.getTitle());
                    mDescriptionTiedt.setText(mTodo.getDescription());
                }
            }

            @Override
            public void onFailure(Call<Todo> call, Throwable t) {
                Log.e("todo", "error getting todo item");
            }
        });
    }

    private void submitTodo() {
        String title = mTitleTiedt.getText().toString();
        String description = mDescriptionTiedt.getText().toString();
        if (title.isEmpty()) {
            mTitleTil.setError("Title is required!");
        }

        if (description.isEmpty()){
            mDescriptionTil.setError("Description is required!");
        }

        if (title.isEmpty() || description.isEmpty()) {
            return;
        }
        if (mIsEdit) {
            Todo updatedTodoItem = new Todo(mTodo.getId(), title, description, null);
            service.updateTodo(updatedTodoItem.getId(), updatedTodoItem).enqueue(new Callback<Void>() {
                @Override
                public void onResponse(Call<Void> call, Response<Void> response) {
                    if (response.isSuccessful()) {
                        goBack();
                    }
                }

                @Override
                public void onFailure(Call<Void> call, Throwable t) {
                    Log.e("todo", "error updating todo");
                }
            });

        } else {
            Todo newTodoItem = new Todo(null, title, description,null);
            service.addTodo(newTodoItem).enqueue(new Callback<Void>() {
                @Override
                public void onResponse(Call<Void> call, Response<Void> response) {
                    if (response.isSuccessful()) {
                        goBack();
                    }
                }

                @Override
                public void onFailure(Call<Void> call, Throwable t) {
                    Log.e("todo", "error posting todo");
                }
            });
        }
    }

    private void deleteTodo() {
        service.deleteTodo(mTodoItemId).enqueue(new Callback<Void>() {
            @Override
            public void onResponse(Call<Void> call, Response<Void> response) {
                goBack();
            }

            @Override
            public void onFailure(Call<Void> call, Throwable t) {
                Log.e("todo", "error deleting todo");
            }
        });
    }

    private void goBack() {
        FragmentManager fragmentManager = ((FragmentActivity) getActivity()).getSupportFragmentManager();
        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        fragmentTransaction.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_CLOSE);
        fragmentTransaction.remove(this);
        fragmentTransaction.commit();
        fragmentManager.popBackStack();
    }
}