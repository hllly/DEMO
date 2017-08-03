package com.demo.controller;

import com.demo.file.FileMeta;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Iterator;
import java.util.LinkedList;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

@Controller
@RequestMapping("/file")
public class FileController {

    LinkedList<FileMeta> files = new LinkedList<>();
    FileMeta fileMeta = null;

    @RequestMapping("/lowUpload")
    public String upload2(HttpServletRequest request, HttpServletResponse response) throws
            IllegalStateException, IOException {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        if (multipartResolver.isMultipart(request)) {
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                MultipartFile file = multiRequest.getFile(iter.next());
                if (file != null) {
                    String myFileName = file.getOriginalFilename();
                    if (myFileName.trim() != "") {
                        String fileName = file.getOriginalFilename();
                        String realPath = request.getSession().getServletContext().getRealPath("\\WEB-INF\\media\\dynamic\\upload\\") + "\\";
                        System.out.println(realPath + fileName);
                        FileUtils.copyInputStreamToFile(file.getInputStream(), new File(realPath, fileName));
                    }
                }
            }
        }
        return "result";
    }


    /**
     * 结合jQuery fileUpLoad处理上传文件
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/highUpload", method = RequestMethod.POST)
    @ResponseBody
    public LinkedList<FileMeta> upload(MultipartHttpServletRequest request, HttpServletResponse response) {
        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf = null;
        String savePath=request.getSession().getServletContext().getRealPath("\\WEB-INF\\media\\dynamic\\upload\\") + "\\";
        while (itr.hasNext()) {
            mpf = request.getFile(itr.next());
            System.out.println(mpf.getOriginalFilename() + " uploaded! " + files.size());
            if (files.size() >= 10) files.pop();
            fileMeta = new FileMeta();
            fileMeta.setFileName(mpf.getOriginalFilename());
            fileMeta.setFileSize(mpf.getSize() / 1024 + " Kb");
            fileMeta.setFileType(mpf.getContentType());
            try {
                fileMeta.setBytes(mpf.getBytes());
                FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(savePath + mpf.getOriginalFilename()));
            } catch (IOException e) {
                e.printStackTrace();
            }
            files.add(fileMeta);
        }
        return files;
    }

    /**
     *
     * @param response
     * @param value
     */
    @RequestMapping(value = "/get/{value}", method = RequestMethod.GET)
    public void get(HttpServletResponse response, @PathVariable String value) {
        FileMeta getFile = files.get(Integer.parseInt(value));
        try {
            response.setContentType(getFile.getFileType());
            response.setHeader("Content-disposition", "attachment; filename=\"" + getFile.getFileName() + "\"");
            FileCopyUtils.copy(getFile.getBytes(), response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
