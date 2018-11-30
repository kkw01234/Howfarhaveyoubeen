package kr.co.howfarhaveyoubeen.www.handler.dao.googlevision;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Algorithm {
	public static Algorithm it;
	public static Algorithm getInstance() {
		if(it==null) {
			it=new Algorithm();
		}
		return it;
	}
 
	
	
	 public int BoyesMoore_Search(String text, String pattern) {
	        int patLen  = pattern.length(); //패턴의 길이
	        int textLen = text.length();
	    //텍스트와 패턴이 일치하지 않았을 때에
	    //이동 범위
	        int[] skip = new int[65536];  //정수 최대값
	        int i;
	        int j;
	        
	        //표 skip작성
	        Arrays.fill(skip, patLen);
	        for (int x = 0; x < patLen -1; x++){
	            skip[pattern.charAt(x)] = patLen - x - 1;
	        }
	        //포인터를 초기화한다. 패턴을 뒤에서부터 비교하기 때문에
	        i = patLen - 1;
	        //텍스트의 가장 마지막에 도달할 때까지 반복한다
	        while (i < textLen) {
	            //포인터 j가 패턴의 마지막 문자를 가리키도록 한다
	            j = patLen -1;
	            //텍스트와 패턴이 일치하는 동안 반복한다
	            while (text.charAt(i) == pattern.charAt(j)) {
	                //처음 문자까지 일치했다면 탐색은 성공이다
	                if (j == 0)   {return i;}
	                i--; j--;
	            }
	            i = i + Math.max(skip[text.charAt(i)], patLen - j);
	        }
	        //결국 발견하지 못했을때
	        return -1;
	    }

	 
	  public List<Integer> KMPsearch(String string, String pattern) {
	        List<Integer> searchIndex = new ArrayList<>();
	 
	        char[] s = string.toCharArray();
	        char[] p = pattern.toCharArray();
	        int[] pi = getPI(pattern);
	        int n = string.length();
	        int m = pattern.length();
	        int j = 0;
	 
	        for (int i = 0; i < n; i++) {
	            while (j > 0 && s[i] != p[j]) {// j > 0 : 한 글자 라도 일치한 것이 있는지
	                j = pi[j - 1];
	            }
	            if (s[i] == p[j]) {
	                if (j == m - 1) {
	                    searchIndex.add(i - m + 1);
	                    j = pi[j];
	                } else {
	                    j++;
	                }
	            }
	        }
	 
	        return searchIndex;
	    }
	 
	    /**
	     * 탐색 실패 시 i번째까지 일치 할 경우 몇글자를 건너뛰어야 하는지 알려주는 pi 배열을 구한다.<br/>
	     * pi 배열을 구할 때도 search 방식을 적용하여 O(M) 의 시간복잡도를 갖는다.<br/>
	     *
	     * @return pi 배열
	     */
	    public int[] getPI(String pattern) {
	        int m = pattern.length();
	        int j = 0;
	        char[] p = pattern.toCharArray();
	        int[] pi = new int[m];
	 
	        for (int i = 1; i < m; i++) {
	            while (j > 0 && p[i] != p[j]) {
	                j = pi[j - 1];
	            }
	            if (p[i] == p[j]) {
	                pi[i] = ++j;
	            }
	        }
	 
	        return pi;
	    }
}
