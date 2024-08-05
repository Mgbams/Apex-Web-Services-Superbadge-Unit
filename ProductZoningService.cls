@RestResource(urlMapping='/ProductZoning/*')
global class ProductZoningService {
	@HttpGet
    global static String getFlyZone(){
        String countryCode = 'US';
        String productCode = '';
        String prefixer = '';
        
        RestRequest req  = RestContext.request;
        //productCode = req.requestURI.substringAfterLast('/'); req.params.get('ProductCode');
        productCode = req.params.get('ProductCode');
        System.debug(System.JSON.serializePretty(req));

        RestResponse res = RestContext.response;
        System.debug(System.JSON.serializePretty(res));
        
        Map<String, string> headers = req.headers;
        for (String headerName : headers.keySet()) {
            if (headerName == 'CountryCode') {
                countryCode = headers.get(headerName);
            }
        }
        
        /*switch on countryCode {
                when 'US' {
                    prefixer = 'AMER_';
                }	
                when 'AU' {
                   prefixer = 'APAC_';
                }
                when 'DE' {
                   prefixer = 'EU_';
                }
            	when 'FR' {
                   prefixer = 'EU_';
                }
                when else {
                    prefixer = 'AMER_';
                }
        }*/
        //Product_Geo_Mapping__mdt
        //Country_Code__c
        //Permissible_Fly_Zone__c
        //Product_Family__c
        //Product2
        //Family => Single-Rotor, Multi-Rotor, Fixed-Wing, MALE, HALE
        

        List<Product2> productsList = [SELECT Id, Family FROM Product2 WHERE ProductCode = :productCode];
        String family = '';
        String permissibleFlyZoneResponse = '';
        if (productsList.size() > 0) {
            family = productsList[0].Family;
            /*family = family.contains('-') ? family.replaceAll('-', '_') : family;
            prefixer = prefixer + family;*/
            List<Product_Geo_Mapping__mdt> geomapping = [SELECT Id, Permissible_Fly_Zone__c FROM Product_Geo_Mapping__mdt WHERE Product_Family__c = :family AND Country_Code__c = :countryCode];
            if (geomapping.size() > 0) {
                permissibleFlyZoneResponse = geomapping[0].Permissible_Fly_Zone__c;
            } else {
                permissibleFlyZoneResponse = 'Confirm with the local authorities';
            }
            
        } else {
           permissibleFlyZoneResponse = 'ProductCode is missing or doesn\'t exist';
        }

        return permissibleFlyZoneResponse;
    }
}