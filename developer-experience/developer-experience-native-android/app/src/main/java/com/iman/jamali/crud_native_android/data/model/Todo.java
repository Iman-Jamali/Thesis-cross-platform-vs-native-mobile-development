package com.iman.jamali.crud_native_android.data.model;

import com.google.gson.annotations.Expose;

public class Todo {
    private final String id;
    @Expose
    private final String title;
    @Expose
    private final String description;
    private final String updatedAt;

    public Todo(String id, String title, String description, String updatedAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.updatedAt = updatedAt;
    }

    public String getId() {
        return id;
    }
    public String getTitle() {
        return title;
    }
    public String getDescription() {
        return description;
    }
    public String getUpdatedAt() {
        return updatedAt;
    }
}
