package kr.co.howfarhaveyoubeen.www.handler.dao.googlevision;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import com.google.cloud.vision.v1.*;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.protobuf.ByteString;

public class GoogleVisionDAO {
	public static GoogleVisionDAO it;
	public static GoogleVisionDAO getInstance() {
		if(it == null) {
			it = new GoogleVisionDAO();
		}
		return it;
	}
	//OCR 인식-> List 구조로 (JSON 구조) //ArrayList 방식
	public ArrayList<String> detectText(String filePath) throws Exception, IOException {
		  List<AnnotateImageRequest> requests = new ArrayList<>();
		  List<EntityAnnotation> labels=null;
		  ArrayList<String> text= new ArrayList<>();
		  ArrayList<String> fromtext= new ArrayList<>();
		  System.out.println(filePath);
		  ByteString imgBytes = ByteString.readFrom(new FileInputStream(filePath));

		  Image img = Image.newBuilder().setContent(imgBytes).build();
		  Feature feat = Feature.newBuilder().setType(Type.TEXT_DETECTION).build();
		  AnnotateImageRequest request =
		      AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
		  requests.add(request);
		  
		  try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
		    BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
		    List<AnnotateImageResponse> responses = response.getResponsesList();
		    for(AnnotateImageResponse res : responses) {
		    	  if (res.hasError()) {
				        System.out.printf("Error: %s\n", res.getError().getMessage());		   
				      }
		    	  for(EntityAnnotation annotation : res.getTextAnnotationsList()) {
		    		  System.out.println(annotation.getDescription()); //테스트용
		    		  text.add(annotation.getDescription());
		    	  }
		    }
		  }catch(Exception e) {
			  e.printStackTrace();
		  }
		  int x=-1;
		  for(int i=0;i<text.size();i++) {
			  if(text.get(i).toLowerCase().contains("from")) {
				  x=i;
				  break;
			  }
		  }
		  if(x==-1) {
			System.out.println("ERROR");
			fromtext.add("검색결과 문자가 없습니다.");
		  }else {
			for(int j=x;j<text.size();j++) {
				fromtext.add(text.get(j));
			}
		  }
		  
		return fromtext;
		}
	
	//OCR 인식-> List 구조로 (JSON 구조) String형으로 변환
	public String detectText2(String filePath) throws Exception, IOException {
			  System.out.println("OCR 스타트");
			  long starttime=System.currentTimeMillis();
			  List<AnnotateImageRequest> requests = new ArrayList<>();
			  String text = "";
			  System.out.println(filePath);
			  ByteString imgBytes = ByteString.readFrom(new FileInputStream(filePath));

			  Image img = Image.newBuilder().setContent(imgBytes).build();
			  Feature feat = Feature.newBuilder().setType(Type.TEXT_DETECTION).build();
			  AnnotateImageRequest request =
			      AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
			  requests.add(request);
			  try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
				System.out.println("try 진입");
			    BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			    System.out.println("Batch");
			    List<AnnotateImageResponse> responses = response.getResponsesList();
			  
			    for(AnnotateImageResponse res : responses) {
			    	  if (res.hasError()) {
					        System.out.printf("Error: %s\n", res.getError().getMessage());		   
					      }
			    	  for(EntityAnnotation annotation : res.getTextAnnotationsList()) {
			    		  //System.out.println(annotation.getDescription()); //테스트용
			    		  text+=annotation.getDescription()+" ";
			    	  }
			    }
			  }catch(Exception e) {
				  e.printStackTrace();
			  }
			  
			  long endtime = System.currentTimeMillis();
			  System.out.println("OCR 실행 시간 : "+ (endtime - starttime)/1000.0);
			return text;
			}
		
	public ArrayList<String> fromArray(String textList) {//StringTokenizer로 3개 받아와서
		long starttime=System.currentTimeMillis();
		
		ArrayList<String> objArr = new ArrayList<>();
		
		StringTokenizer st = new StringTokenizer(textList);
		while(st.hasMoreTokens()) {
			if(st.nextToken().toLowerCase().contains("from")) {
				break;
			}
		}
		
		for(int i=0;i<3;i++) {
			objArr.add(st.nextToken());
		}
		long endtime = System.currentTimeMillis();
		System.out.println("From 실행 시간 : "+ (endtime - starttime)/1000.0);
		return objArr;
	}
	public ArrayList<String> toArray(String textList) {//StringTokenizer 3개 받아와서 3개를 프런트로
		long starttime=System.currentTimeMillis();
		StringTokenizer st = new StringTokenizer(textList);
		ArrayList<String> objArr = new ArrayList<>();
		boolean from = false;
		
		while(st.hasMoreTokens()) {
			String data = st.nextToken();
			if(data.toLowerCase().contains("from")) { //From이 나올때까지 계속 돌림 (From 뒤에 무조건 to가 나오기 때문)
				from = true;
			}
			if(from == true && data.toLowerCase().contains("to")) {	
				break;
			}
		
		}
		for(int i=0;i<3;i++) {
			
			objArr.add(st.nextToken());
		}
		long endtime = System.currentTimeMillis();
		System.out.println("to 실행 시간 : "+ (endtime - starttime)/1000.0);
		return objArr;
	}
}
