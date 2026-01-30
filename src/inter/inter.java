package inter;

import Bean.cadidate;
import Bean.candidatebean;
import Bean.eligible;
import Bean.nomibean;
import Bean.votebean;
import Bean.voter;
import Bean.voterbean;

public interface inter {
	
	public int vreg(voterbean vb);
	
	public boolean vlog(voterbean vl);
	
	public int creg(candidatebean cb);
	
	public boolean clog(candidatebean cl);
	
	public int vid(voter v);
	
	public int cid(cadidate c);
	
	public int nomi(nomibean nb);
	
	public int eli(eligible eb);
	
	public int vote(votebean vb);
	public boolean check(nomibean re);
	public boolean ch(voterbean vo);

}
