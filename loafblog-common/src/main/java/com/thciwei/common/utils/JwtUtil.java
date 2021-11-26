package com.thciwei.common.utils;

import io.jsonwebtoken.*;

import java.util.Date;
import java.util.UUID;

public class JwtUtil {

    private static long time = 1000 * 60 * 60 * 24;
    private static String signature = "admin";

    public static String createToken(String username, String Avatar,String userId) {
        JwtBuilder jwtBuilder = Jwts.builder();
        String jwtToken = jwtBuilder
                .setHeaderParam("typ", "JWT")
                .setHeaderParam("alg", "HS256")
                //payload载荷
                .claim("username", username)
                .claim("role", "admin")
                .claim("userid",userId)
                .claim("avatar", Avatar)
                .setSubject("loafblog-web")
                .setExpiration(new Date(System.currentTimeMillis() + time))
                .setId(UUID.randomUUID().toString())
                .signWith(SignatureAlgorithm.HS256, signature)
                .compact();
        return jwtToken;
    }

    public static String createUniToken(String username) {
        JwtBuilder jwtBuilder = Jwts.builder();
        String jwtToken = jwtBuilder
                .setHeaderParam("typ", "JWT")
                .setHeaderParam("alg", "HS256")
                //payload载荷
                .claim("username", username)
                .claim("role", "admin")
                .setSubject("loafblog-web")
                .setExpiration(new Date(System.currentTimeMillis() + time))
                .setId(UUID.randomUUID().toString())
                .signWith(SignatureAlgorithm.HS256, signature)
                .compact();
        return jwtToken;
    }

    public static R parse(String token) {
        JwtParser parser = Jwts.parser();
        Jws<Claims> claimsJws = parser.setSigningKey(signature).parseClaimsJws(token);
        Claims claims = claimsJws.getBody();
        return R.ok().put("user",claims);

    }


}
