/**
 * 
 */
    function errorMassageRepreseNtative(isVali){	    	
	    	if(isVali){
	    		$("#representativeError").addClass('defaultNone');
	        	$("#representativeError").removeClass('representativeVali');
	    	}else{
	    		$("#representativeError").removeClass('defaultNone');
	        	$("#representativeError").addClass('representativeVali'); 
	    	}       
        }