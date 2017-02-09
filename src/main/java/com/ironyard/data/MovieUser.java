package com.ironyard.data;

import javax.persistence.*;
import java.util.List;

/**
 * Created by jasonskipper on 2/6/17.
 */
@Entity
public class MovieUser {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "movieuser_sequence")
    @SequenceGenerator(name="movieuser_sequence", sequenceName = "mvusr_sequence")
    private long id;
    private String username;
    private String password;
    private String displayName;

    @ManyToMany
    private List<Movie> favorites;

    public MovieUser(){
    }

    public MovieUser(String username, String password, String displayName) {
        this.username = username;
        this.password = password;
        this.displayName = displayName;
    }

    public List<Movie> getFavorites() {
        return favorites;
    }

    public void setFavorites(List<Movie> favorites) {
        this.favorites = favorites;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }
}
