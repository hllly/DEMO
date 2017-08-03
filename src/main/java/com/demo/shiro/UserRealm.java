package com.demo.shiro;

import javax.annotation.Resource;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import com.demo.pojo.*;
import com.demo.service.UserService;

public class UserRealm extends AuthorizingRealm {
    @Resource
    private UserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        String nick = (String)principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        authorizationInfo.setRoles(userService.selectRolesByNick(nick));
        authorizationInfo.setStringPermissions(userService.selectPermissionsByNick(nick));
        return authorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String nick = (String)token.getPrincipal();
        LUser user = userService.selectUserByNick(nick);
        if(user == null) {throw new UnknownAccountException();}
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(
                user.getU_nick(),
                user.getU_pwd(),
                getName()
        );
        return authenticationInfo;
    }
}