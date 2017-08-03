package com.demo.controller;

import com.demo.pojo.LUser;
import com.demo.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * controller about of user operations include login, logout
 */
@Controller
@RequestMapping("/user")
public class LoginController {
    private int DEFAULT_ID=-1;
    @Resource
    private UserService userService;
    @RequestMapping("/login")
    public ModelAndView login(HttpServletRequest request) {
        String nick = request.getParameter("nick");
        String pwd = request.getParameter("pwd");
        int result=userService.loginSuccess(nick,pwd);
        if(result==1){ return new ModelAndView("main","nick",nick); }
        else if (result==-1){
            String defaultNick=userService.selectUserByDefault().getU_nick();
            return new ModelAndView("main","nick",defaultNick);
        }
        else return new ModelAndView("index","errorCode",-1);
    }


    @RequestMapping(value = "/ajaxLogin", method=RequestMethod.POST,produces="application/json;charset=UTF-8" ,consumes = "application/json")
    @ResponseBody
    public   LUser ajaxLogin(@RequestBody LUser user){
        String nick = user.getU_nick();
        String pwd = user.getU_pwd();
        int result=userService.loginSuccess(nick,pwd);
        if(result==1){ return new LUser(0,nick,null); }
        else if (result==-1){ return new LUser(DEFAULT_ID,nick,pwd); }
        else return new LUser(DEFAULT_ID,null,null);
    }

    @RequestMapping(value = "/enter",method = RequestMethod.GET)
    public ModelAndView enter(@RequestParam("u_nick") String nick) {
        return new ModelAndView("main","nick",nick);
    }

}
























