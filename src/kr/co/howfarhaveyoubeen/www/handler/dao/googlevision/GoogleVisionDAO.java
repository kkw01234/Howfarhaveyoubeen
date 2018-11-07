package kr.co.howfarhaveyoubeen.www.handler.dao.googlevision;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import com.google.cloud.vision.v1.*;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.google.protobuf.ByteString;

public class GoogleVisionDAO {
	public static GoogleVisionDAO it;
	public static GoogleVisionDAO getInstance() {
		if(it == null) {
			it = new GoogleVisionDAO();
		}
		return it;
	}
	//OCR 인식-> List 구조로 (JSON 구조)
	public void detectText(String filePath) throws Exception, IOException {
		  List<AnnotateImageRequest> requests = new ArrayList<>();
		  List<EntityAnnotation> labels=null;
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
		    		  System.out.println(annotation.getDescription());
		    	  }
		    }
		  }catch(Exception e) {
			  e.printStackTrace();
		  }
		  
		
		}
}
