package com.demo.service;

import com.demo.dao.*;
import com.demo.pojo.MappingRP;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.HashSet;
import java.util.Optional;
import com.demo.pojo.LUser;

/**
 * UserService
 */
@Service("userService")
public class UserService {
    private int DEFAULT_ID=-1;
    @Resource
    private LUserDao luserDao;
    @Resource
    private MappingURDao mappingURDao;
    @Resource
    private MappingRPDao mappingRPDao;
    @Resource
    private RoleDao roleDao;
    @Resource
    private PermissionDao permissionDao;

    public LUser selectUserByNick(String nick){
        return luserDao.selectUserByNick(nick);
    }

    public LUser selectUserByDefault(){return luserDao.selectUserByUid(1);}

    public int loginSuccess(String nick,String pwd){
        int flag;
        Optional<LUser> optUser=Optional.ofNullable(luserDao.selectUserByNick(nick));
        LUser user=optUser.orElse(new LUser(DEFAULT_ID,nick,pwd));
        if(user.getU_id()==DEFAULT_ID) {
            luserDao.addUser(nick,pwd);
            flag=-1;
            return flag;
        }
        if(user.getU_pwd().equals(pwd)){
            flag=1;
            return flag;
        }
        else {
            flag=0;
            return flag;
        }
    }

    public HashSet<String> selectRolesByNick(String nick){
        Optional<LUser> optUser=Optional.ofNullable(luserDao.selectUserByNick(nick));
        LUser user=optUser.orElse(luserDao.selectUserByUid(1));
        final HashSet<String> roles=new HashSet<>();
        mappingURDao.selectURByUid(user.getU_id()).stream().map(e->roles.add(roleDao.selectRoleByRid(e.getR_id()).getR_name()));
        return roles;
    }

    public HashSet<String> selectPermissionsByNick(String nick){
        HashSet<String> roles=selectRolesByNick(nick);
        final HashSet<MappingRP> permissionsR=new HashSet<>();
        roles.stream().forEach(e->permissionsR.addAll(mappingRPDao.selectRPByRid(roleDao.selectRoleByRname(e).getR_id())));
        final HashSet<String> permissions=new HashSet<>();
        permissionsR.stream().forEach(e->permissions.add(permissionDao.selectPermissionByPid(e.getP_id()).getP_name()));
        return permissions;
    }
}

















