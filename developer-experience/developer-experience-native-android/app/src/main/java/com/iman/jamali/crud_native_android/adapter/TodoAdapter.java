package com.iman.jamali.crud_native_android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import androidx.recyclerview.widget.RecyclerView;

import com.iman.jamali.crud_native_android.R;
import com.iman.jamali.crud_native_android.data.model.Todo;
import com.iman.jamali.crud_native_android.pages.EditTodoFragment;
import com.iman.jamali.crud_native_android.pages.TodoListFragment;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;


public class TodoAdapter extends RecyclerView.Adapter<TodoAdapter.ViewHolder> {
    private final Todo[] mTodoItems;
    private final Context mContext;
    TodoListFragment mTodoListFragment;

    static class ViewHolder extends RecyclerView.ViewHolder {
        TextView titleTV;
        TextView descriptionTV;
        TextView dateTV;
        ConstraintLayout containerCL;

        ViewHolder(View itemView) {
            super(itemView);
            titleTV = itemView.findViewById(R.id.titleTV);
            descriptionTV = itemView.findViewById(R.id.descriptionTV);
            dateTV = itemView.findViewById(R.id.dateTV);
            containerCL = itemView.findViewById(R.id.listContainerCl);
        }
    }

    public TodoAdapter(Context context, Todo[] items, TodoListFragment todoListFragment) {
        this.mContext = context;
        this.mTodoItems = items;
        this.mTodoListFragment = todoListFragment;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(mContext);
        View itemView = inflater.inflate(R.layout.todo_item, parent, false);
        return new ViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        Todo item = mTodoItems[position];
        holder.titleTV.setText(item.getTitle());
        holder.descriptionTV.setText(item.getDescription());
        String itemDateString = item.getUpdatedAt();
        DateFormat utcFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.CANADA);
        utcFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
        Date date = null;
        try {
            date = utcFormat.parse(itemDateString);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        SimpleDateFormat outputDateFormat = new SimpleDateFormat("yyyy-MM-dd, HH:mm:ss", Locale.CANADA);
        holder.dateTV.setText(outputDateFormat.format(date));
        holder.containerCL.setOnClickListener(view -> {
            Fragment fragment = EditTodoFragment.newInstance(item.getId());
            FragmentManager fragmentManager = ((FragmentActivity) mContext).getSupportFragmentManager();
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.container, fragment, fragment.getClass().getName());
            fragmentTransaction.addToBackStack(null);
            fragmentTransaction.commit();
        });
    }

    @Override
    public int getItemCount() {
        return mTodoItems.length;
    }
}
