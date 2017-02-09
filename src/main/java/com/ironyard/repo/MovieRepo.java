package com.ironyard.repo;

import com.ironyard.data.Movie;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by jasonskipper on 2/6/17.
 */
public interface MovieRepo extends CrudRepository<Movie, Long> {
}
