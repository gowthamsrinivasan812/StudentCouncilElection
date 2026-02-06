package Servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Objects;


public final class SHA256Utility {

    private static final String ALGORITHM = "SHA-256";
    private static final int BUFFER_SIZE = 8 * 1024;

   
    private SHA256Utility() { throw new AssertionError("No instances."); }

   
    public static byte[] hash(byte[] data) {
        Objects.requireNonNull(data, "data must not be null");
        try {
            MessageDigest md = MessageDigest.getInstance(ALGORITHM);
            return md.digest(data);
        } catch (NoSuchAlgorithmException e) {
            
            throw new IllegalStateException(ALGORITHM + " algorithm not available", e);
        }
    }

   
    public static byte[] hash(String text) {
        Objects.requireNonNull(text, "text must not be null");
        return hash(text.getBytes(StandardCharsets.UTF_8));
    }

    
    public static byte[] hash(InputStream is) throws IOException {
        Objects.requireNonNull(is, "InputStream must not be null");
        try {
            MessageDigest md = MessageDigest.getInstance(ALGORITHM);
            try (DigestInputStream dis = new DigestInputStream(is, md)) {
                byte[] buffer = new byte[BUFFER_SIZE];
                
                while (dis.read(buffer) != -1) { }
            }
            return md.digest();
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException(ALGORITHM + " algorithm not available", e);
        }
    }

   
    public static byte[] hash(File file) throws IOException {
        Objects.requireNonNull(file, "file must not be null");
        if (!file.isFile()) {
            throw new IllegalArgumentException("Provided File is not a regular file: " + file);
        }
        try (FileInputStream fis = new FileInputStream(file)) {
            return hash(fis);
        }
    }

   
    public static String hashToHex(byte[] data) {
        return bytesToHex(hash(data));
    }

   
    public static String hashToHex(String text) {
        return bytesToHex(hash(text));
    }

   
    public static String hashToBase64(byte[] data) {
        return Base64.getEncoder().encodeToString(hash(data));
    }

   
    public static String hashToBase64(String text) {
        return hashToBase4(text.getBytes(StandardCharsets.UTF_8));
    }

   
    private static String hashToBase4(byte[] data) {
        return Base64.getEncoder().encodeToString(hash(data));
    }

    
    public static boolean verifyHex(String text, String expectedHex) {
        Objects.requireNonNull(text, "text must not be null");
        Objects.requireNonNull(expectedHex, "expectedHex must not be null");
        String actualHex = hashToHex(text);
        return constantTimeEquals(actualHex.getBytes(StandardCharsets.UTF_8),
                                  expectedHex.getBytes(StandardCharsets.UTF_8));
    }

    
    public static boolean constantTimeEquals(byte[] a, byte[] b) {
        Objects.requireNonNull(a, "a must not be null");
        Objects.requireNonNull(b, "b must not be null");
        if (a.length != b.length) {
            
            int result = 0;
            int max = Math.max(a.length, b.length);
            for (int i = 0; i < max; i++) {
                byte x = i < a.length ? a[i] : 0;
                byte y = i < b.length ? b[i] : 0;
                result |= x ^ y;
            }
            return false;
        }
        int res = 0;
        for (int i = 0; i < a.length; i++) {
            res |= a[i] ^ b[i];
        }
        return res == 0;
    }

   
    public static String bytesToHex(byte[] bytes) {
        Objects.requireNonNull(bytes, "bytes must not be null");
        StringBuilder sb = new StringBuilder(bytes.length * 2);
        for (byte b : bytes) {
            int v = b & 0xFF;
            if (v < 16) sb.append('0');
            sb.append(Integer.toHexString(v));
        }
        return sb.toString();
    }

    
    public static byte[] hexToBytes(String hex) {
        Objects.requireNonNull(hex, "hex must not be null");
        String s = hex.trim();
        if ((s.length() & 1) != 0) {
            throw new IllegalArgumentException("Hex string must have even length");
        }
        int len = s.length() / 2;
        byte[] out = new byte[len];
        for (int i = 0; i < len; i++) {
            int hi = Character.digit(s.charAt(i * 2), 16);
            int lo = Character.digit(s.charAt(i * 2 + 1), 16);
            if (hi == -1 || lo == -1) {
                throw new IllegalArgumentException("Invalid hex character in: " + hex);
            }
            out[i] = (byte) ((hi << 4) + lo);
        }
        return out;
    }
}
