package Bean;

import java.io.Serializable;

public class cadidate implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String regno;
    private String mobile;
    private String email;
    private String department;
    private String password;
    private String status;

    // 🔹 No-argument constructor (mandatory for Bean)
    public cadidate() {
    }

    // 🔹 Parameterized constructor (optional)
    public cadidate(String name, String regno, String mobile,
                            String email, String department, String password) {
        this.name = name;
        this.regno = regno;
        this.mobile = mobile;
        this.email = email;
        this.department = department;
        this.password = password;
        this.status = "PENDING";
    }

    // 🔹 Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRegno() {
        return regno;
    }

    public void setRegno(String regno) {
        this.regno = regno;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
