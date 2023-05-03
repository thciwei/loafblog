package com.thciwei.loafblog.picture.utils;

import org.csource.common.MyException;
import org.csource.fastdfs.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public class FastDFSUtils {
    private static StorageClient1 client1;

    static {
        try {
            ClientGlobal.initByProperties("fastdfs-client.properties");
            TrackerClient trackerClient = new TrackerClient();
            TrackerServer trackerServer = trackerClient.getConnection();
            client1 = new StorageClient1(trackerServer, null);

        } catch (IOException e) {
            e.printStackTrace();
        } catch (MyException e) {
            e.printStackTrace();
        }
    }

    public static String upload(MultipartFile file) throws IOException, MyException {
        String oldName = file.getOriginalFilename();
        return client1.upload_file1(file.getBytes(), oldName.substring(oldName.lastIndexOf(".") + 1), null);
    }
}
