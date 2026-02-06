<%-- 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>

<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>

<%@ page import="org.json.JSONObject" %>

<%@ page import="com.amazonaws.auth.AWSStaticCredentialsProvider" %>
<%@ page import="com.amazonaws.auth.BasicAWSCredentials" %>
<%@ page import="com.amazonaws.client.builder.AwsClientBuilder" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3ClientBuilder" %>
<%@ page import="com.amazonaws.services.s3.model.ObjectMetadata" %>
<%@ page import="com.amazonaws.services.s3.model.PutObjectRequest" %>

<%@ page import="org.web3j.protocol.Web3j" %>
<%@ page import="org.web3j.protocol.http.HttpService" %>
<%@ page import="org.web3j.crypto.Credentials" %>
<%@ page import="org.web3j.crypto.RawTransaction" %>
<%@ page import="org.web3j.crypto.TransactionEncoder" %>
<%@ page import="org.web3j.protocol.core.methods.response.EthSendTransaction" %>
<%@ page import="org.web3j.protocol.core.DefaultBlockParameterName" %>
<%@ page import="org.web3j.utils.Numeric" %>

<%@ page import="dbcon.dbconn" %>

<%

final String FILEBASE_KEY = "9AED1223862989DD6BE1";
final String FILEBASE_SECRET = "5mxSXGVbqHbTYtTgzxari6hvXf34e0I026MaN0yH";
final String FILEBASE_S3_ENDPOINT = "https://s3.filebase.com";
final String FILEBASE_BUCKET = "blockchainprismkyc";
final String GANACHE_URL = "http://192.168.1.49:7545";
final String PRIVATE_KEY = "0xa9b88ed8155d97cfd0954d64a27762d9ebc0b04753012184173edc1b36d5a2b9";


String cname = request.getParameter("cname");
String cemail = request.getParameter("cemail");
String dis = request.getParameter("dis");
String mail = request.getParameter("mail");


if (cname == null || cemail == null) {
    response.sendRedirect("Error.jsp?error=Missing+parameters");
    return;
}

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

int generatedId = -1;

byte[] blobpic = null;
byte[] blobsymbol = null;


try {
    con = dbconn.create();
    ps = con.prepareStatement("SELECT * FROM studentvoute.eligible WHERE email = ?");
    ps.setString(1, cemail);
    rs = ps.executeQuery();
    if (rs.next()) {
        blobpic = rs.getBytes(2);      
        blobsymbol = rs.getBytes(6);  
    }
    if (rs != null) rs.close();
    if (ps != null) ps.close();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=DB+eligible+fetch+failed");
    return;
}


String prehash = "";
String afterhash = "";

try {
    ps = con.prepareStatement("SELECT phash, ahash FROM studentvoute.votes WHERE mail = ? ORDER BY id DESC LIMIT 1");
    ps.setString(1, "vote");
    rs = ps.executeQuery();
    if (rs.next()) {
        prehash = rs.getString(1);
        afterhash = rs.getString(2);
    }
    if (rs != null) rs.close();
    if (ps != null) ps.close();
} catch (Exception e) {
    
}


if (afterhash != null && !afterhash.isEmpty()) {
    prehash = afterhash;
}


String phas = "";
String aphas = "";
try {
    Bean.Block genesisBlock = new Bean.Block("VoteBlockGenesis", "0");
    phas = genesisBlock.hash;
    Bean.Block secondBlock = new Bean.Block("VoteBlockNext", genesisBlock.hash);
    aphas = secondBlock.hash;
} catch (Exception e) {
  
    phas = String.valueOf(System.currentTimeMillis());
    aphas = String.valueOf(System.currentTimeMillis() + 1);
}


int insertedRows = 0;
try {
    
    ps = con.prepareStatement(
        "INSERT INTO studentvoute.votes VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
        Statement.RETURN_GENERATED_KEYS
    );

    ps.setString(1, cname);
    ps.setBytes(2, blobpic);
    ps.setString(3, dis);
    ps.setString(4," ");
    ps.setString(5, "Voted");
    ps.setString(6, prehash);
    ps.setString(7, aphas);
    ps.setString(8, cemail);
    ps.setString(9, mail);
    ps.setBytes(10, blobsymbol);
    ps.setString(11, "");
    ps.setString(12, "");
    ps.setString(13, " ");

    insertedRows = ps.executeUpdate();

    rs = ps.getGeneratedKeys();
    if (rs.next()) {
        generatedId = rs.getInt(1);
    }
    if (rs != null) rs.close();
    ps.close();

} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=Insert+vote+failed");
    return;
}

if (insertedRows <= 0 || generatedId == -1) {
    response.sendRedirect("Error.jsp?error=Insert+vote+failed+or+no+id");
    return;
}


String cid = null;
try {
    JSONObject voteJson = new JSONObject();
    voteJson.put("id", generatedId);
    voteJson.put("cname", cname);
    voteJson.put("cemail", cemail);
    voteJson.put("district", dis);
    voteJson.put("mail", mail);
    voteJson.put("phash", phas);
    voteJson.put("ahash", aphas);

    String jsonString = voteJson.toString();

    
    BasicAWSCredentials awsCreds = new BasicAWSCredentials(FILEBASE_KEY, FILEBASE_SECRET);
    AwsClientBuilder.EndpointConfiguration endpoint = new AwsClientBuilder.EndpointConfiguration(FILEBASE_S3_ENDPOINT, "us-east-1");

    AmazonS3 s3 = AmazonS3ClientBuilder.standard()
                    .withEndpointConfiguration(endpoint)
                    .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
                    .withPathStyleAccessEnabled(true)
                    .build();

    String objectKey = "vote_" + generatedId + ".json";

    byte[] contentBytes = jsonString.getBytes("UTF-8");
    InputStream input = new ByteArrayInputStream(contentBytes);
    ObjectMetadata metadata = new ObjectMetadata();
    metadata.setContentType("application/json");
    metadata.setContentLength(contentBytes.length);

    PutObjectRequest putReq = new PutObjectRequest(FILEBASE_BUCKET, objectKey, input, metadata);
    s3.putObject(putReq);

    
    try {
        ObjectMetadata meta = s3.getObjectMetadata(FILEBASE_BUCKET, objectKey);
       
        String ipfsCid = meta.getUserMetaDataOf("ipfs-hash");      
        if (ipfsCid == null) ipfsCid = meta.getUserMetaDataOf("cid");
        if (ipfsCid == null) ipfsCid = meta.getUserMetaDataOf("x-amz-meta-ipfs-hash");
        if (ipfsCid == null) ipfsCid = meta.getUserMetaDataOf("x-amz-meta-cid");

        if (ipfsCid != null && !ipfsCid.trim().isEmpty()) {
            cid = ipfsCid;
        } else {
            
            cid = objectKey;
        }
    } catch (Exception e) {
        
        cid = objectKey;
    }

} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=Filebase+upload+failed");
    return;
}


String txHash = null;
String senderAddress = null;
try {
    Web3j web3 = Web3j.build(new HttpService(GANACHE_URL));
    Credentials creds = Credentials.create(PRIVATE_KEY);
    senderAddress = creds.getAddress();


    BigInteger nonce = web3.ethGetTransactionCount(senderAddress, DefaultBlockParameterName.PENDING)
                          .send()
                          .getTransactionCount();

   
    BigInteger gasPrice = web3.ethGasPrice().send().getGasPrice();
    BigInteger gasLimit = BigInteger.valueOf(300_000); 


    byte[] cidBytes = cid.getBytes("UTF-8");
    String cidHex = Numeric.toHexString(cidBytes);

    
    RawTransaction raw = RawTransaction.createTransaction(
            nonce,
            gasPrice,
            gasLimit,
            senderAddress,
            BigInteger.ZERO,
            cidHex
    );

    byte[] signedMessage = TransactionEncoder.signMessage(raw, creds);
    String hexValue = Numeric.toHexString(signedMessage);

    EthSendTransaction ethSend = web3.ethSendRawTransaction(hexValue).send();

    if (ethSend.getError() != null) {
        System.err.println("Ganache tx error: " + ethSend.getError().getMessage());
        response.sendRedirect("Error.jsp?error=Ganache+tx+error");
        return;
    }

    txHash = ethSend.getTransactionHash();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=Ganache+transaction+failed");
    return;
}


try {
    ps = con.prepareStatement("UPDATE studentvoute.votes SET cid = ?, txhash = ?, sender_addr = ? WHERE id = ?");
    ps.setString(1, cid);
    ps.setString(2, txHash);
    ps.setString(3, senderAddress);
    ps.setInt(4, generatedId);
    ps.executeUpdate();
    if (ps != null) ps.close();
} catch (Exception e) {
    e.printStackTrace();
   
}


response.sendRedirect("votesucessfully.jsp?id=" + generatedId + "&cid=" + cid + "&tx=" + txHash);
%>
 --%>
 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="org.json.JSONObject" %>

<%@ page import="com.amazonaws.auth.*" %>
<%@ page import="com.amazonaws.client.builder.AwsClientBuilder" %>
<%@ page import="com.amazonaws.services.s3.*" %>
<%@ page import="com.amazonaws.services.s3.model.*" %>

<%@ page import="org.web3j.protocol.*" %>
<%@ page import="org.web3j.protocol.http.HttpService" %>
<%@ page import="org.web3j.crypto.*" %>
<%@ page import="org.web3j.protocol.core.*" %>
<%@ page import="org.web3j.utils.Numeric" %>

<%@ page import="dbcon.dbconn" %>

<%!
    
    public static String sha256(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(input.getBytes("UTF-8"));
            BigInteger number = new BigInteger(1, hash);
            StringBuilder hex = new StringBuilder(number.toString(16));
            while (hex.length() < 64) {
                hex.insert(0, '0');
            }
            return hex.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
%>

<%
String cname  = request.getParameter("cname");
String cemail = request.getParameter("cemail");
String dept   = request.getParameter("cdept");
String course   = request.getParameter("course");
String mail   = request.getParameter("mail");

if (cname == null || cemail == null) {
    response.sendRedirect("Error.jsp?error=Missing+parameters");
    return;
}


Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

String blobpic = null;
String blobsymbol = null;



try {
    con = dbconn.create();

    ps = con.prepareStatement(
        "SELECT image_url, symbol_url FROM studentvoute.eligible WHERE email=?"
    );
    ps.setString(1, cemail);
    rs = ps.executeQuery();

    if (rs.next()) {
        blobpic = rs.getString(1);
        blobsymbol = rs.getString(2);
        
        
    }

    rs.close();
    ps.close();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=Eligible+fetch+failed");
    return;
}


String prehash = "0";
String aphash = String.valueOf(System.currentTimeMillis());


int voteId = -1;

try {
    ps = con.prepareStatement(
        "INSERT INTO studentvoute.votes " +
        "(crollnum, pic_url, dept, status, cemail, mail, symol_url, txhash, course) " +
        "VALUES (?,?,?,?,?,?,?,?,?)",
        Statement.RETURN_GENERATED_KEYS
    );

    ps.setString(1, cname);
    ps.setString(2, blobpic);
    ps.setString(3, dept);
    
    ps.setString(4, "Voted");
    ps.setString(5, cemail);
    ps.setString(6, mail);
    ps.setString(7, blobsymbol);
    ps.setString(8, ""); 
    ps.setString(9, course);

    ps.executeUpdate();

    rs = ps.getGeneratedKeys();
    if (rs.next()) {
        voteId = rs.getInt(1);
    }

    rs.close();
    ps.close();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=Vote+insert+failed");
    return;
}


String txData = voteId + cname + cemail + dept + aphash;
String txHash = sha256(txData);


try {
    ps = con.prepareStatement(
        "UPDATE studentvoute.votes SET txhash=? WHERE id=?"
    );
    ps.setString(1, txHash);
    ps.setInt(2, voteId);
    ps.executeUpdate();
    ps.close();
} catch (Exception e) {
    e.printStackTrace();
}

response.sendRedirect(
    "votesucessfully.jsp?id=" + voteId + "&tx=" + txHash
);
%>
 