package imple;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



import dbcon.dbconn;


import Bean.cadidate;
import Bean.candidatebean;
import Bean.eligible;
import Bean.nomibean;
import Bean.votebean;
import Bean.voter;
import Bean.voterbean;
import inter.inter;

public class imple  implements inter{
	Connection con;

	@Override
	public int vreg(voterbean vb) {
		
		int u=0;
		try{
		con=dbconn.create();	
		PreparedStatement ps = con.prepareStatement("INSERT INTO `vote`.`voterreg` VALUES(?,?,?,?,?,?)");
		ps.setString(1, vb.getName());
		ps.setString(2, vb.getEmail());
		ps.setString(3, vb.getMobile());
		
		ps.setString(4, vb.getDistrict());
		ps.setString(5, vb.getAssem());
		ps.setString(6,  vb.getOtp());

		u=ps.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return u;
}
	
	public boolean checkEmailExists(String email) {
	    boolean exists = false;
	    try {
	    	con=dbconn.create();
	        PreparedStatement ps = con.prepareStatement("SELECT * FROM `vote`.`voterreg` WHERE email = ?");
	        ps.setString(1, email);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            exists = true;
	        }
	        con.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return exists;
	}

	

	@Override
	public boolean vlog(voterbean vl) {
		boolean b=false;
		try
		{
		    
			con=dbconn.create();
			PreparedStatement ps = con.prepareStatement("SELECT * FROM `vote`.`voterreg` where email=? and assem=? and district=?");
			ps.setString(1, vl.getEmail());
			ps.setString(2, vl.getAssem());
			ps.setString(3, vl.getDistrict());
			
			ResultSet rs=ps.executeQuery();
			b=rs.next();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return b;
		
	}
	

	@Override
	public int creg(candidatebean cb) {
		int u=0;
		try{
		con=dbconn.create();	
		PreparedStatement ps = con.prepareStatement("INSERT INTO `vote`.studentreg VALUES(?,?,?,?,?)");
		ps.setString(1, cb.getName());
		ps.setString(2, cb.getEmail());
		ps.setString(3, cb.getMobile());
		ps.setString(4, cb.getPass());
		ps.setString(5, cb.getCapss());

		u=ps.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return u;
}
	

	@Override
	public boolean clog(candidatebean cl) {
		boolean b=false;
		try
		{
		
			con=dbconn.create();
			PreparedStatement ps = con.prepareStatement("SELECT * FROM `vote`.candidatereg where email=? and Assembly=? and district=?");
			ps.setString(1, cl.getEmail());
			ps.setString(2, cl.getPass());
			ps.setString(3, cl.getCapss());
			
			ResultSet rs=ps.executeQuery();
			b=rs.next();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return b;
		
	}


	@Override
	public int vid(voter v) {
		int u=0;
		try{
		con=dbconn.create();	
		PreparedStatement ps = con.prepareStatement("INSERT INTO `vote`.`voteid` VALUES(?,?,?,?,?,?,?,?)");
		ps.setString(1, v.getDistrict());
		ps.setString(2, v.getAssemly());
		ps.setString(3, v.getEmail());
		ps.setString(4, v.getMobile());
		ps.setString(5, v.getPic());
		ps.setString(6, "Apply");
		ps.setString(7, v.getEdate());
		ps.setString(8, v.getVkey());
		u=ps.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return u;
}


//	@Override
//	public int cid(cadidate c) {
//		int u=0;
//		try{
//		con=dbconn.create();	
//		PreparedStatement ps = con.prepareStatement("INSERT INTO `vote`.`candidateid` VALUES(?,?,?,?,?,?)");
//		ps.setString(1, c.getDistrict());
//		ps.setString(2, c.getAssemly());
//		ps.setString(3, c.getEmail());
//		ps.setString(4, c.getMobile());
//		ps.setString(5, c.getPic());
//		ps.setString(6, "Apply");
//		u=ps.executeUpdate();
//		}catch(Exception e)
//		{
//			e.printStackTrace();
//		}
//		return u;
//}


	@Override
	public int nomi(nomibean nb) {
		int u=0;
		try{
		con=dbconn.create();	
		PreparedStatement ps = con.prepareStatement("INSERT INTO `vote`.`application` VALUES(?,?,?,?,?,?,?,?,?)");
		ps.setString(1, nb.getPic());
		ps.setString(2, nb.getEmail());
		ps.setString(3, nb.getDistrict());
		ps.setString(4, nb.getAssem());
		ps.setString(5, nb.getNumber());
		ps.setString(6, nb.getCandidatename());
		ps.setString(7, nb.getDate());
		ps.setString(8, nb.getFilename());

		ps.setString(9, "Upload");
		u=ps.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return u;
}


	@Override
	public int eli(eligible eb) {
		int u=0;
		try{
		con=dbconn.create();	
		PreparedStatement ps = con.prepareStatement("INSERT INTO `vote`.`eligible` VALUES(?,?,?,?,?,?,?,?)");
		ps.setString(1, eb.getCname());
		ps.setString(2, eb.getPic());
		ps.setString(3, eb.getCemail());
		ps.setString(4, eb.getDistrict());
		ps.setString(5, eb.getAssembly());
	
		ps.setString(6, eb.getFile());
		ps.setString(7, "Eligible");
		ps.setString(8, eb.getParty());
		

		
		u=ps.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return u;
}


	@Override
	public int vote(votebean vb) {
		int u=0;
		try{
		con=dbconn.create();	
		PreparedStatement ps = con.prepareStatement("INSERT INTO `vote`.`votes` VALUES(id,?,?,?,?,?,?,?,?,?,?)");
		ps.setString(1, vb.getCname());
		ps.setString(2, vb.getCpic());
		ps.setString(3, vb.getDis());
		ps.setString(4, vb.getAss());
		ps.setString(5, vb.getParty());
		ps.setString(6, "Voteted");
		ps.setString(7, vb.getPhash());
		ps.setString(8, vb.getAhash());
	
		ps.setString(9, vb.getMail());
		ps.setString(10, vb.getVoter());


		
		u=ps.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return u;

	}


	@Override
	public boolean check(nomibean re) {
		boolean check=false;
		con=dbconn.create();
		 
		 try {
			PreparedStatement ps=con.prepareStatement("SELECT * FROM `vote`.`voterreg` where ass='"+re.getAssem()+"' and partyName='"+re.getDate()+"'");
			 ResultSet rs=ps.executeQuery();
				check=rs.next();
		 } catch (SQLException e) {
				
				e.printStackTrace();
			}
		return check;
	}


	@Override
	public boolean ch(voterbean vo) {
		boolean ch=false;
		con=dbconn.create();
		 
		 try {
			PreparedStatement ps=con.prepareStatement(" SELECT * FROM `vote`.`voterreg` where email='"+vo.getEmail()+"' and otp='"+vo.getOtp()+"'");
			 ResultSet rs=ps.executeQuery();
				ch=rs.next();
		 } catch (SQLException e) {
				
				e.printStackTrace();
			}
		return ch;
	}

	@Override
	public int cid(cadidate c) {
		// TODO Auto-generated method stub
		return 0;
	}

}

