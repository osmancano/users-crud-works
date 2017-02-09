package com.ironyard.controller;

import com.ironyard.data.Movie;
import com.ironyard.data.MovieUser;
import com.ironyard.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpRequest;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.lang.reflect.Array;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.stream.Stream;

/**
 * Created by jasonskipper on 2/6/17.
 */
@Controller
public class UserController {

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private static String UPLOADED_FOLDER = "/tmp/";

    @RequestMapping(path = "/open/authenticate", method = RequestMethod.POST)
    public String login(HttpSession session, Model data, @RequestParam(name = "username") String usr, @RequestParam String password){
        MovieUser found = userRepo.findByUsernameAndPassword(usr, password);
        String destinationView = "home";
        if(found == null){
            // no user found, login must fail
            destinationView = "login";
            data.addAttribute("message", "User/Pass combination not found.");
        }else{
            session.setAttribute ("user", found);
            destinationView = "redirect:/secure/movies";
        }
        return destinationView;
    }

    @RequestMapping(path = "/secure/logout")
    public String login(HttpSession session){
        session.removeAttribute("user");
        String destinationView = "/open/login";
        return destinationView;
    }

    @RequestMapping(path = "/secure/users")
    public String listUsers(Model xyz){
        String destination = "users";
        Iterable found = userRepo.findAll();
        // put list into model
        xyz.addAttribute("uList", found);
        // go to jsp
        return destination;
    }

    @RequestMapping(path = "/secure/user/create", method = RequestMethod.POST,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String createMovie(Model dataToJsp, MovieUser aUser){
        // save to database
        userRepo.save(aUser);
        // if successful save, add message
        if(aUser.getId()>0) {
            dataToJsp.addAttribute("success_user_operation_msg",
                    String.format("User '%s' was created!", aUser.getUsername()));
        }
        return "forward:/secure/users";
    }

    @RequestMapping(path = "/secure/user/select", method = RequestMethod.GET)
    public String selectUserForEdit(Model mapOfDataForJsp, @RequestParam Long id){
        MovieUser selectedUser = userRepo.findOne(id);
        mapOfDataForJsp.addAttribute("selectedUser", selectedUser);
        String dest = "/secure/editUser";
        return dest;
    }

    @RequestMapping(path = "/secure/user/delete", method = RequestMethod.GET)
    public String deleteUser(HttpSession session,Model dataToJsp, @RequestParam Long id){
        MovieUser loggedInUser = (MovieUser) session.getAttribute("user");
        String msg = "Logged in user is not allowed to be deleted";
        if(loggedInUser.getId()!= id) {
            userRepo.delete(id);
            msg = "User is deleted successfully !";
        }
        dataToJsp.addAttribute("success_user_operation_msg",msg);
        return "forward:/secure/users";
    }

    @RequestMapping(path = "/secure/user/upload",
            method = RequestMethod.POST)
    public String upload(Model dataToJsp,@RequestParam("usersFile") MultipartFile usersFile){
        if (usersFile.isEmpty()) {
            String msg = "Please choose file!";
            dataToJsp.addAttribute("success_user_operation_msg",msg);
            return "forward:/secure/users";
        }
           try{
               byte[] bytes = usersFile.getBytes();
               Path path = Paths.get(UPLOADED_FOLDER + usersFile.getOriginalFilename());
               Files.write(path, bytes);
           } catch (IOException e) {
               e.printStackTrace();
           }
           try {
               File file = new File(UPLOADED_FOLDER + usersFile.getOriginalFilename());
               FileReader fr = new FileReader(file);
               BufferedReader br = new BufferedReader(fr);
               String line;
               String[] arrayVar;
               while((line = br.readLine()) != null){
                   arrayVar = line.split(",");
                   MovieUser foundUser = userRepo.findByUsername(arrayVar[0]);
                   if(foundUser != null){
                       foundUser.setPassword(arrayVar[1]);
                       foundUser.setDisplayName(arrayVar[2]);
                       userRepo.save(foundUser);
                   }else{
                       MovieUser mUser = new MovieUser(arrayVar[0],arrayVar[1],arrayVar[2]);
                       userRepo.save(mUser);
                   }

               }
               br.close();
               fr.close();
           }catch (IOException e) {
               e.printStackTrace();
           }
        String msg = "Users are uploaded successfully!";
        dataToJsp.addAttribute("success_user_operation_msg",msg);
        return "forward:/secure/users";
    }
}
